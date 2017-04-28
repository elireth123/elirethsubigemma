local AIO = AIO or require("AIO")
assert(not RE_ClientLib, "RE_ClientLib is already loaded. Possibly different versions!")
-- RE_ClientLib main table
RE_ClientLib =
{
    -- RE_ClientLib flavour functions
    unpack = unpack,
}

local RE_ClientLib = RE_ClientLib

if not AIO.AddAddon() then
   --
   -- Algunos marcos de trabajo
   --
   StaticPopupDialogs ["RE_NPCDICE"] = 
   {
	   text = "Dados NPC - Valor",
	   button1 = "OK" ,
	   button2 = "Cancelar" ,
	   hideOnEscape = true,
	   OnShow = function (self, data)
		self.editBox:SetWidth(100)
		self:SetWidth(350)
		self:SetPoint("CENTER")
	   end,
	   OnAccept = function (self, data, data2)
		   local MyMax = self.editBox:GetText()
           RT( 1, tonumber(MyMax))
	   end,	
	   hasEditBox = true,
	   timeout			= 0,
	   whileDead		= 1,
	   hideOnEscape	= 1,
   }
   StaticPopupDialogs ["RE_DANO"] = 
   {
	   text = "Daño - Introducir valor (negativo para sanidad)",
	   button1 = "OK" ,
	   button2 = "Cancelar" ,
	   hideOnEscape = true,
	   OnShow = function (self, data)
		self.editBox:SetWidth(100)
		self:SetWidth(350)
		self:SetPoint("CENTER")
	   end,
	   OnAccept = function (self, data, data2)
		   local MyVal = tonumber(self.editBox:GetText())
		   local MyLife = TRP2RE["RE_Vida"] - MyVal
           TRP2RE["RE_Vida"] = MyLife
           TRP2RE_UpdateBars()
		   RESendMsg("CATTR#" .. UnitName("player") .. ".RE_Vida." .. tostring(MyLife) )
		   if MyVal < 0 then
		      print ("|cff00ffff [RE]:|c00ffff00 Recibido " .. tostring(MyVal*-1) .. " de sanación")
	       else
		      print ("|cff00ffff [RE]:|c00ffff00 Recibido " .. tostring(MyVal) .. " de daño")
		   end
	   end,	
	   hasEditBox = true,
	   timeout			= 0,
	   whileDead		= 1,
	   hideOnEscape	= 1,
   }
   StaticPopupDialogs ["RE_CANSANCIO"] = 
   {
	   text = "Cansancio - Introducir valor (negativo para descanso)",
	   button1 = "OK" ,
	   button2 = "Cancelar" ,
	   hideOnEscape = true,
	   OnShow = function (self, data)
		self.editBox:SetWidth(100)
		self:SetWidth(350)
		self:SetPoint("CENTER")
	   end,
	   OnAccept = function (self, data, data2)
		   local MyVal = tonumber(self.editBox:GetText())
		   local MyMana = TRP2RE["RE_Mana"] - MyVal
		   TRP2RE["RE_Mana"] = MyMana
           TRP2RE_UpdateBars()
		   RESendMsg("CATTR#" .. UnitName("player") .. ".RE_Mana." .. tostring(MyMana) )
		   if MyVal < 0 then
		      print ("|cff00ffff [RE]:|c00ffff00 Recibido " .. tostring(MyVal*-1) .. " de descanso")
	       else
		      print ("|cff00ffff [RE]:|c00ffff00 Recibido " .. tostring(MyVal) .. " de cansancio")
		   end
	   end,	
	   hasEditBox = true,
	   timeout			= 0,
	   whileDead		= 1,
	   hideOnEscape	= 1,
   }
   --
   -- Funciones varias de utilidad
   --
   function PG (text)
      RESendMsg ( "PRTXT"  .. "#" .. UnitName("player") .. "#" .. text )
   end
   function LT ( Player, Attr, Value)
      RESendMsg ( "CATTR" .. "#" .. tostring(Player) .. "." .. tostring(Attr) .. "." .. tostring(Value))
   end
   function RD (MyMin, MyMax)
      MyRnd = random (MyMin, MyMax)
      PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 tira los dados y obtiene " .. MyRnd .. " (" ..MyMin .. "-" .. MyMax .. ")")
      return MyRnd
   end
   function RD_Fuerza (MyMin, MyMax)
      MyRnd = random (MyMin, MyMax)
      PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 tira dados de fuerza y obtiene " .. MyRnd .. " (" ..MyMin .. "-" .. MyMax .. ")")
	  PG ( "|cff00ffff[" .. UnitName("Player") .. "]|cffffff00 Suma un total de " .. tostring(MyRnd + TRP2RE["RE_Fisico"]) ) 
	  
      return MyRnd
   end
   function RT (MyMin, MyMax)
      if UnitName("Target") == nil then
         print ("Debes seleccionar un objetivo primero")
         return
      end
      MyRnd = random (MyMin, MyMax)
      PG ( "|cffffff00" .. UnitName("Target") .. " tira los dados y obtiene " .. MyRnd .. " (" .. MyMin .. "-" .. MyMax .. ")")
      return MyRnd
   end
   
   --
   -- Funcion para gestionar turnos
   --
   function RE_RolIFC ()
      local AceGUI = LibStub("AceGUI-3.0")
      local ABText = AceGUI:Create("Frame")

      ABText:SetCallback("OnClose",function(widget) 
                          AceGUI:Release(widget) end)
      ABText:SetTitle("Rol Errante - Interfaz de rol - " .. AllFlds[2])
      ABText:SetPoint("TOP", -250, -50)
      ABText:SetWidth(320)
      ABText:SetHeight(450)
      ABText:SetLayout("Flow")
	  
      local TX1 = AceGUI:Create("EditBox")
      TX1:SetWidth(380)
      TX1:SetText  ("")
	  TX1:SetLabel ("Acción (emote)")
	  TX1:DisableButton(true)
      ABText:AddChild (TX1)  
	  
	  local CK1 = AceGUI:Create("CheckBox")
	  CK1:SetLabel ("Emote por banda")
	  CK1:SetType ("checkbox")
	  CK1:SetValue ()
   end	
   --
 -- Frames de menu y comprobación de versiones de Addons
 --

    REAddMenuFrame = CreateFrame("Frame", "REAddMenuFrame", UIParent, "UIDropDownMenuTemplate")
    REAddMenuFrame:SetPoint("TOPLEFT", UIParent, 120, 50)
    if ( not IsAddOnLoaded("totalRP2")) then
       print ( "|cff00ffff [RE]:|cffff0000 ATENCION!!!" )
       print ( "|cff00ffff [RE]:|c00ffff00 No tienes TRP2 activado, por favor activalo para poder entrar en el rol")
       return
    end
    if ( TRP2_version ~= "2000" ) then
       print ( "|cff00ffff [RE]:|cffff0000 ATENCION!!!" )
       print ( "|cff00ffff [RE]:|c00ffff00 Tu version de TRP2 (" .. TRP2_version ..") no es compatible con este servidor" )
       print ( "|cff00ffff [RE]:|c00ffff00 Rol Errante usa una versión especifica de TRP2 para el desarrollo del rol." )
       print ( "|cff00ffff [RE]:|c00ffff00 Actualízalo, o bien habla con un GM para solucionar el tema." )
       return
   end
   --
   -- Boton de acceso al menu:
   --
   REFich_frame = CreateFrame ("Button", "REFich", UIParent,"UIPanelButtonTemplate" )
   REFich_frame:SetPoint("TOPLEFT", 80, 0)
   REFich_frame:SetWidth(80)
   REFich_frame:SetHeight(20)
   REFich_frame:SetText("RE-Menu")
   REFich_frame:SetScript("OnClick", function() RE_Menu() end)
   
   RE_RPMode = 0
   function RE_Menu ()
      local REAddMenu
      REAddMenu = {
        { text = "Actualizar ficha", func = function() RESendMsg( "REFIC#" .. UnitName("player")); end},
        { text = "Ficha de rol", func = function() TRP2REAddFicha(); end},
	    -- { text = "Daño", func = function()
	    --                          StaticPopup_Show ("RE_DANO")
	    --                         end},
	    -- { text = "Cansancio", func = function()
	    --                          StaticPopup_Show ("RE_CANSANCIO")
	    --                         end},
	    { text = "Interfaz de rol", func = function()
	                             TRP2RERolIfc()
	                            end},
	    { text = "Mostrar/Ocultar barras HP/MP", func = function() 
	  	                                          if IsBarShow == true then
	  											     MyHPBar:Hide()
	  											     MyMPBar:Hide()
	  												 IsBarShow = false
	  											  else
	  											     MyHPBar:Show()
	  											     MyMPBar:Show()
	  												 IsBarShow = true
	  											  end	 
                                                 end},
	  										   
	    -- { text = "Modo rol ON/OFF", func = function()
	    --                          RE_ToggleRolMode()
	    --                         end},
      }
      if UnitName("Target") ~= nil and UnitIsPlayer ("Target") then
        table.insert ( REAddMenu, { text = "Ver ficha de " .. UnitName("Target"), 
	       func = function() RESendMsg( "REFCC#" .. UnitName("Target")); end})
      end
      if UnitName("Target") ~= nil and not UnitIsPlayer ("Target") then
        table.insert ( REAddMenu, { text = UnitName("Target") .. " tira dados ", 
	       func = function() StaticPopup_Show ("RE_NPCDICE"); end})
      end
      EasyMenu(REAddMenu, REAddMenuFrame, REAddMenuFrame, 0 , -30, "MENU")
    end
 
   function BindFrameToWorldFrame(frame)
	local scale = UIParent:GetEffectiveScale();
	frame:SetParent(WorldFrame);
	frame:SetScale(scale);
   end

   function BindFrameToUIParent(frame)
	frame:SetParent(UIParent);
	frame:SetScale(1);
   end
   
   function EnableRPMode()
	BindFrameToWorldFrame(GameTooltip);
	BindFrameToWorldFrame(ChatFrame1EditBox);
	BindFrameToWorldFrame(ChatFrameMenuButton);
	BindFrameToWorldFrame(ChatMenu);
	BindFrameToWorldFrame(REFich_frame);
	BindFrameToWorldFrame(MyHPBar);
	BindFrameToWorldFrame(MyMPBar);
	BindFrameToWorldFrame(REAddMenuFrame);
	for i = 1, 7 do
		BindFrameToWorldFrame(getglobal("ChatFrame" .. i));
		BindFrameToWorldFrame(getglobal("ChatFrame" .. i .. "Tab"));
	end
	RE_RPMode = 1;
	CloseAllWindows();
	UIParent:Hide();
   end

   function DisableRPMode()
	BindFrameToUIParent(GameTooltip);
	GameTooltip:SetFrameStrata("TOOLTIP");
	BindFrameToUIParent(ChatFrame1EditBox);
	ChatFrame1EditBox:SetFrameStrata("DIALOG");
	BindFrameToUIParent(ChatFrameMenuButton);
	ChatFrameMenuButton:SetFrameStrata("DIALOG");
	BindFrameToUIParent(ChatMenu);
	ChatMenu:SetFrameStrata("DIALOG");
	BindFrameToUIParent(RPButtonButton);
	for i = 1, 7 do
		BindFrameToUIParent(getglobal("ChatFrame" .. i));
		BindFrameToUIParent(getglobal("ChatFrame" .. i .. "Tab"));
	end
	RE_RPMode = 0;
	UIParent:Show();
   end
   
   function RE_ToggleRolMode()
	if (RE_RPMode == 0) then
		EnableRPMode();
	else
		print("Presiona [Esc] para salir del modo rol");
	end
   end      
else
   PrintInfo("RE Libraries loaded")   
end