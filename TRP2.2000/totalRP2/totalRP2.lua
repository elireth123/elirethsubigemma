-------------------------------------------------------------------
--                          Total RP 2
--            A roleplay addon for World of Warcraft
-- Created by Sylvain "Telkostrasz" Cossement (up to version 1.017)
--   Licence : CC BY-NC-SA (http://creativecommons.org/licenses/)
-------------------------------------------------------------------

TRP2_Libs = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceSerializer-3.0")
-------------------------------------------------------------------------
-- Añadido para Rol Errante (c) Subigemma (version 2000) 
-------------------------------------------------------------------------
if TRP2RE == nil then
   TRP2RE = {}
end	  
MyHPBar = CreateFrame("StatusBar", nil, UIParent)
MyHPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
MyHPBar:GetStatusBarTexture():SetHorizTile(true)
MyHPBar:SetWidth(200)
MyHPBar:SetHeight(12)
MyHPBar:SetPoint("TOPLEFT", 230, 0)
MyHPBar:SetStatusBarColor(0,1,1)
MyHPBar.HPVal = MyHPBar:CreateFontString(nil, "OVERLAY")
MyHPBar.HPVal:SetPoint("LEFT", MyHPBar, "LEFT", -50, 0)
MyHPBar.HPVal:SetFont("Fonts\\FRIZQT__.TTF", 10, "MONOCHROME")
MyHPBar.HPVal:SetJustifyH("LEFT")
MyHPBar:SetMinMaxValues(0, 100)
MyHPBar:SetValue(0)
MyHPBar.HPVal:SetShadowOffset(1, -1)
MyHPBar.HPVal:SetTextColor(1, 1, 1)

MyMPBar = CreateFrame("StatusBar", nil, UIParent)
MyMPBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
MyMPBar:GetStatusBarTexture():SetHorizTile(true)
MyMPBar:SetMinMaxValues(0, 100)
MyMPBar:SetValue(0)
MyMPBar:SetWidth(200)
MyMPBar:SetHeight(12)
MyMPBar:SetPoint("TOPLEFT", 230, -12)
MyMPBar:SetStatusBarColor(1,0,1)
MyMPBar.MPVal = MyMPBar:CreateFontString(nil, "OVERLAY")
MyMPBar.MPVal:SetPoint("LEFT", MyMPBar, "LEFT", -50, 0)
MyMPBar.MPVal:SetFont("Fonts\\FRIZQT__.TTF", 10, "MONOCHROME")
MyMPBar.MPVal:SetJustifyH("LEFT")
MyMPBar.MPVal:SetShadowOffset(1, -1)
MyMPBar.MPVal:SetTextColor(1, 1, 1)
HPShow=false;
MPShow=false;

StaticPopupDialogs ["RE_NOFICH"] = 
{
	text = "Atencion!!\n|c00ffff00No se ha encontrado informacion sobre la ficha de este pj. Ver detalles en chat",
	button1 = "OK" ,
	button2 = nil ,
	hideOnEscape = true,
	OnShow = function (self, data)
		self:SetWidth(350)
		self:SetPoint("CENTER")
	end,	
	OnAccept = function (self, data, data2)
	   ReloadUI()
	end,	
	hasEditBox = false,	
	timeout			= 0,
	whileDead		= 1,
	hideOnEscape	= 1,
}

StaticPopupDialogs ["RE_RD"] = 
{
	text = "Toque de atencion",
	button1 = "OK" ,
	button2 = "Cancelar" ,
	hideOnEscape = true,
	OnShow = function (self, data)
		self.editBox:SetWidth(100)
		self:SetWidth(350)
		self:SetPoint("TOP")
	end,
	OnAccept = function (self, data, data2)
		local TxtEmote = self.editBox:GetText()
        SendAddonMessage("GSIADD", 
	    "SHALRT:" .. UnitName("player") ..":" 
	           .. UnitName("target") .. ":"
			   .. "3:4:5:"
               .. TxtEmote, "WHISPER", UnitName("target") )	
	end,	
	hasEditBox = true,	
	timeout			= 0,
	whileDead		= 1,
	hideOnEscape	= 1,
}

local function HPToggle (self, button)
   if HPShow == true then 
      self.HPVal:Hide()
      HPShow = false
   else
      self.HPVal:Show()
      HPShow = true
   end 
end
function TRP2RE_F ()
   return 1
end
function TRP2RE_UpdateBars()
   MyHPBar:SetMinMaxValues(-1*2*TRP2RE["RE_Fisico"], 100)
   MyHPBar:SetValue(TRP2RE["RE_Vida"])
   if TRP2RE["RE_Vida"] < 0 then
      MyHPBar:SetStatusBarColor(1,0,0)
   else
      MyHPBar:SetStatusBarColor(0,1,1)
   end
   MyHPBar.HPVal:SetText("Vida:" .. tostring(TRP2RE["RE_Vida"]))
   MyMPBar:SetMinMaxValues(-1*2*TRP2RE["RE_Fisico"], 100)
   MyMPBar:SetValue(TRP2RE["RE_Mana"])
   MyMPBar.MPVal:SetText("Mana:" .. tostring(TRP2RE["RE_Mana"]))
end
function TRP2RE_Ficha ( AllFlds )
   local RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa, Buff = strsplit ( ".", AllFlds[3] )
   if TRP2RE == nil then
      TRP2RE = {}
   end	  
   TRP2RE["Habilidades"] = nil
   TRP2RE["RE_pj"] = UnitName ("player")
   TRP2RE["RE_Fisico"] = tonumber(RE_Fisico)
   TRP2RE["RE_Destreza"] = tonumber(RE_Destreza)
   TRP2RE["RE_Inteligencia"] = tonumber(RE_Inteligencia)
   TRP2RE["RE_Percepcion"] = tonumber(RE_Percepcion)
   TRP2RE["RE_Mana"] = tonumber(RE_Mana)
   TRP2RE["RE_Vida"] = tonumber(RE_Vida)
   TRP2RE["RE_Iniciativa"] = tonumber(RE_Iniciativa)
   TRP2RE["RE_Defensa"] = tonumber(RE_Defensa)
   MyHPBar:SetMinMaxValues(-1*2*TRP2RE["RE_Fisico"], 100)
   MyHPBar:SetValue(TRP2RE["RE_Vida"])
   if TRP2RE["RE_Vida"] < 0 then
      MyHPBar:SetStatusBarColor(1,0,0)
   else
      MyHPBar:SetStatusBarColor(0,1,1)
   end
   MyHPBar.HPVal:SetText("Vida:" .. tostring(TRP2RE["RE_Vida"]))
   MyMPBar:SetMinMaxValues(-1*2*TRP2RE["RE_Fisico"], 100)
   MyMPBar:SetValue(TRP2RE["RE_Mana"])
   MyMPBar.MPVal:SetText("Mana:" .. tostring(TRP2RE["RE_Mana"]))
   
   if TRP2RE["Habilidades"] == nil then
      TRP2RE["Habilidades"] = {}
   end	  
   for LoopVar = 4, table.getn(AllFlds) - 1 do
      local RE_ID, RE_Valor = strsplit ( ".", AllFlds[LoopVar] )
      TRP2RE["Habilidades"][RE_ID] = RE_Valor
   end
   
end
function TRP2REAddFicha ()
   local AceGUI = LibStub("AceGUI-3.0")
   local ABText = AceGUI:Create("Frame")
   ABText:SetCallback("OnClose",function(widget) 
                                AceGUI:Release(widget) end)

   HabStr = ""
   if ( TRP2RE["Habilidades"] ~= nil ) then
      for MyKey,MyValue in pairs(TRP2RE["Habilidades"]) do
	     HabStr = HabStr .. "\n|c00ffff00" .. TRP2RE["GlobalHab"][MyKey]["RE_Nombre"] .. 
		          "  : " .. MyValue .. " |c00cccccc(" .. TRP2RE["GlobalHab"][MyKey]["RE_Efecto"] .. ") - [" .. 
				  TRP2RE["GlobalHab"][MyKey]["RE_Atributo"] .. "]"
	  end
   end
   ABText:SetTitle("Rol Errante - Ficha de rol - " .. UnitName("player"))
   ABText:SetPoint("TOP", -250, -50)
   ABText:SetWidth(420)
   ABText:SetHeight(450)
   ABText:SetLayout("Flow")
   local LB1 = AceGUI:Create("Label")
   LB1:SetWidth(380)
   LB1:SetText  ("--- PUNTOS DE ATRIBUTO ---\nFisico: " .. tostring(TRP2RE["RE_Fisico"]) 
                .. " Destreza:" .. tostring(TRP2RE["RE_Destreza"])
                .. " Inteligencia:" .. tostring(TRP2RE["RE_Inteligencia"])
                .. " Percepción:" .. tostring(TRP2RE["RE_Percepcion"])
                .. "\n\n--- VALORES DE COMBATE ---\nMana:" .. tostring(TRP2RE["RE_Mana"])
                .. " Vida:" .. tostring(TRP2RE["RE_Vida"])
                .. " Iniciativa:" .. tostring(TRP2RE["RE_Iniciativa"])
                .. " Defensa:" .. tostring(TRP2RE["RE_Defensa"])
				.. "\n\n--- HABILIDADES ---" .. HabStr
				)
   ABText:AddChild (LB1)
end
function TRP2REQueryFicha ( AllFlds )
   local RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa, Buff = strsplit ( ".", AllFlds[3] )
   local HabStr = ""
   for LoopVar = 4, table.getn(AllFlds) - 1 do
      local RE_ID, RE_Valor = strsplit ( ".", AllFlds[LoopVar] )
      HabStr = HabStr .. "\n|c00ffff00" .. TRP2RE["GlobalHab"][RE_ID]["RE_Nombre"] .. "  : " 
	           .. RE_Valor .. "    |c00cccccc(" .. TRP2RE["GlobalHab"][RE_ID]["RE_Efecto"] ..") - [" 
			   .. TRP2RE["GlobalHab"][RE_ID]["RE_Atributo"] .."]"
   end
   
   local AceGUI = LibStub("AceGUI-3.0")
   local ABText = AceGUI:Create("Frame")
   ABText:SetCallback("OnClose",function(widget) 
                       AceGUI:Release(widget) end)
   ABText:SetTitle("Rol Errante - Ficha de rol - " .. AllFlds[2])
   ABText:SetPoint("TOP", -250, -50)
   ABText:SetWidth(420)
   ABText:SetHeight(450)
   ABText:SetLayout("Flow")
   local LB1 = AceGUI:Create("Label")
   LB1:SetWidth(380)
   LB1:SetText  ("--- PUNTOS DE ATRIBUTO ---\nFisico: " .. tostring(RE_Fisico) 
                .. " Destreza:" .. tostring(RE_Destreza)
                .. " Inteligencia:" .. tostring(RE_Inteligencia)
                .. " Percepción:" .. tostring(RE_Percepcion)
                .. "\n\n--- VALORES DE COMBATE ---\nMana:" .. tostring(RE_Mana)
                .. " Vida:" .. tostring(RE_Vida)
                .. " Iniciativa:" .. tostring(RE_Iniciativa)
                .. " Defensa:" .. tostring(RE_Defensa)
				.. "\n\n--- HABILIDADES ---" .. HabStr
				)
   ABText:AddChild (LB1)                                
end
function TRP2REMakeEmote ( Text, IsRaid, IsAst )
   local MyEnv = "EMOTE"
   local MyText = Text
   if IsAst == true then
      MyText = "*" .. Text .. "*"
	  MyEnv = "SAY"
   end  
   if IsRaid == true then 
      MyText = "*" .. Text .. "*"
      if UnitInRaid("player") ~= nil then
         MyEnv = "RAID"
	  else
	     MyEnv = "PARTY"
	  end
   end	  
   -- print ("TRP2REMakeEmote:" .. MyEnv)
   SendChatMessage(MyText, MyEnv)
end

function TRP2RERolIfc()
   local AceGUI = LibStub("AceGUI-3.0")
   local ABText = AceGUI:Create("Frame")
   local TX1 = AceGUI:Create("EditBox")
   local TX2 = AceGUI:Create("EditBox")
   local TX3 = AceGUI:Create("EditBox")
   local TX4 = AceGUI:Create("EditBox")
   local CK1 = AceGUI:Create("CheckBox")
   local CK2 = AceGUI:Create("CheckBox")

   if TRP2RE["DImpmin"] == nil then
      TRP2RE["DImpmin"] = 1
   end
   if TRP2RE["DImpmax"] == nil then
      TRP2RE["DImpmax"] = 10
   end
   if TRP2RE["DHurmin"] == nil then
      TRP2RE["DHurmin"] = 1
   end
   if TRP2RE["DHurmax"] == nil then
      TRP2RE["DHurmax"] = 6
   end
   if TRP2RE["TX1Emote"] == nil then
      TRP2RE["TX1Emote"] = ""
   end
   if TRP2RE["TX2Emote"] == nil then
      TRP2RE["TX2Emote"] = ""
   end
   if TRP2RE["TX3Emote"] == nil then
      TRP2RE["TX3Emote"] = ""
   end
   if TRP2RE["TX4Emote"] == nil then
      TRP2RE["TX4Emote"] = ""
   end
   
   ABText:SetCallback("OnClose",function(widget) 
                       AceGUI:Release(widget) end)
   ABText:SetTitle("Rol Errante - Interfaz de rol - ")
   ABText:SetStatusText("TRP2 - v"..TRP2_version .." - GSI 2017" )
   ABText:SetPoint("TOP", -250, -50)
   ABText:SetWidth(320)
   ABText:SetHeight(450)
   ABText:SetLayout("Flow")

   TX1:SetLabel ( "Emotes (situarse en la casilla y presionar [Enter])")
   TX1:SetCallback ("OnEnterPressed", function() 
                                           TRP2RE["TX1Emote"] = TX1:GetText()
	                                       TRP2REMakeEmote(TX1:GetText(), CK1:GetValue(), CK2:GetValue())
										   end)
   TX1:SetText(TRP2RE["TX1Emote"])
   TX1:SetWidth(300)
   ABText:AddChild (TX1)
   
   TX2:SetCallback ("OnEnterPressed", function() 
                                          TRP2RE["TX2Emote"] = TX2:GetText()
                                          TRP2REMakeEmote(TX2:GetText(), CK1:GetValue(), CK2:GetValue())
										  end)
   TX2:SetText(TRP2RE["TX2Emote"])
   TX2:SetWidth(300)
   ABText:AddChild (TX2) 
   TX3:SetCallback ("OnLeave", function() 
                                          TRP2RE["TX3Emote"] = TX3:GetText()
										  end)

   TX3:SetCallback ("OnEnterPressed", function() 
                                          TRP2RE["TX3Emote"] = TX3:GetText()
                                          TRP2REMakeEmote(TX3:GetText(), CK1:GetValue(), CK2:GetValue())
										  end)
   TX3:SetText(TRP2RE["TX3Emote"])
   TX3:SetWidth(300)
   ABText:AddChild (TX3) 

   TX4:SetCallback ("OnLeave", function() 
                                          TRP2RE["TX4Emote"] = TX4:GetText()
										  end)
   TX4:SetCallback ("OnEnterPressed", function() 
                                          TRP2RE["TX4Emote"] = TX4:GetText()
                                          TRP2REMakeEmote(TX4:GetText(), CK1:GetValue(), CK2:GetValue())
										  end)
   TX4:SetText(TRP2RE["TX4Emote"])
   TX4:SetWidth(300)
   ABText:AddChild (TX4) 

--   if UnitInParty("player") ~= nil then 
--      CK1:SetLabel("Emote por grupo")   
--      ABText:AddChild (CK1)
--   end
   CK1:SetLabel("Emote por banda")   
   CK1:SetValue(false)   
   if UnitInRaid("player") ~= nil then 
      ABText:AddChild (CK1)
   end
  
   CK2:SetLabel("Usar asteriscos")   
   ABText:AddChild (CK2)

   local BTNC = AceGUI:Create("Button")
   BTNC:SetText ( "Limpiar emotes")
   BTNC:SetWidth(150)
   BTNC:SetCallback("OnClick", function() 
							   TX1:SetText("")
							   TX2:SetText("")
							   TX3:SetText("")
							   TX4:SetText("")
                               end)
   ABText:AddChild (BTNC)
   
   local LB1 = AceGUI:Create("Label")
   LB1:SetWidth(300)
   LB1:SetText ( "Dados:")
   ABText:AddChild (LB1)

   local TXDMIN = AceGUI:Create("EditBox")
   TXDMIN:SetLabel ( "Min.")
   TXDMIN:SetText(tostring(TRP2RE["DImpmin"]))
   TXDMIN:SetCallback("OnLeave", function() TRP2RE["DImpmin"] = tonumber(TXDMIN:GetText()) end)
   TXDMIN:SetWidth(50)
   TXDMIN:DisableButton(true)
   ABText:AddChild (TXDMIN)

   local TXDMAX = AceGUI:Create("EditBox")
   TXDMAX:SetLabel ( "Max.")
   TXDMAX:SetText(tostring(TRP2RE["DImpmax"]))
   TXDMAX:SetCallback("OnLeave", function() TRP2RE["DImpmax"] = tonumber(TXDMAX:GetText()) end)
   TXDMAX:SetWidth(50)
   TXDMAX:DisableButton(true)
   ABText:AddChild (TXDMAX)

   local BTN1 = AceGUI:Create("Button")
   BTN1:SetText ( "Lanzar")
   BTN1:SetWidth(80)
   BTN1:SetCallback("OnClick", function() RandomRoll (tonumber(TXDMIN:GetText()),tonumber(TXDMAX:GetText()))  end)
   ABText:AddChild (BTN1)

   local LB2 = AceGUI:Create("Label")
   LB2:SetWidth(100)
   LB2:SetText ( "")
   ABText:AddChild (LB2)

   local TXIMIN = AceGUI:Create("EditBox")
   TXIMIN:SetLabel ( "Min.")
   TXIMIN:SetText(tostring(TRP2RE["DHurmin"]))
   TXIMIN:SetCallback("OnLeave", function() TRP2RE["DHurmin"] = tonumber(TXIMIN:GetText()) end)
   TXIMIN:SetWidth(50)
   TXIMIN:DisableButton(true)
   ABText:AddChild (TXIMIN)

   local TXIMAX = AceGUI:Create("EditBox")
   TXIMAX:SetLabel ( "Max.")
   TXIMAX:SetText(tostring(TRP2RE["DHurmax"]))
   TXIMAX:SetCallback("OnLeave", function() TRP2RE["DHurmax"] = tonumber(TXIMAX:GetText()) end)
   TXIMAX:SetWidth(50)
   TXIMAX:DisableButton(true)
   ABText:AddChild (TXIMAX)

   local BTN2 = AceGUI:Create("Button")
   BTN2:SetText ( "Lanzar")
   BTN2:SetWidth(80)
   BTN2:SetCallback("OnClick", function() RandomRoll (tonumber(TXIMIN:GetText()),tonumber(TXIMAX:GetText()))  end)
   ABText:AddChild (BTN2)
end

-------------------------------------------------------------------------
-- (version 2000) 
-------------------------------------------------------------------------
function TRP2_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("CHAT_MSG_CHANNEL");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("WORLD_MAP_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
end

TRP2_UPDATERTAB = {};

function TRP2_OnEvent(self,event,...)
	local arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12 = ...;
	if(event=="ADDON_LOADED" and arg1=="totalRP2") then
		-- Chargement sécurisé
		local arg1,errorCall = TRP2_PCall(function() 
			TRP2_OnLoaded();
		end,nil,nil,nil,nil,nil,nil,nil,true);
		if (not IsAddOnLoaded("AIO_Client")) then
			message("Esta version de Total RP2 necesita el Addon AIO Cliente activo para funcionar.\n Por favor activaloy reinicia el Wow");
		end
		if errorCall then
			message("Total RP 2\nAn error occured during the loading of the addon. The addon won't work correctly !");
		end

	elseif event=="CHAT_MSG_ADDON" then
		if arg1 == TRP2_COMM_PREFIX then
			if TRP2_EstIgnore(arg2) or arg2 == TRP2_Joueur or not TRP2_GetConfigValueFor("ActivateExchange",true) then
				return;
			end
			if arg2 == nil or arg4 == nil then
			   return
			end
			TRP2_receiveMessage(arg2,arg4);
		end
	elseif event=="CHAT_MSG_CHANNEL_NOTICE" then
		if arg1 == "YOU_JOINED" then
			TRP2_SePresenterSurLeChan();
		end
	-- elseif event=="PLAYER_ENTERING_WORLD" then
	--	RegisterAddonMessagePrefix(TRP2_COMM_PREFIX);
	elseif(event=="UPDATE_MOUSEOVER_UNIT") then
		local nom,royaume = UnitName("mouseover");
		if nom and nom ~= UNKNOWN and TRP2_EstDansLeReg(nom) and CheckInteractDistance("mouseover", 4) and not royaume and UnitIsPlayer("mouseover") and nom~=TRP2_Joueur and UnitFactionGroup("mouseover") == UnitFactionGroup("player") then
			if not TRP2_UPDATERTAB[nom] or time() - TRP2_UPDATERTAB[nom] > 1 then -- Optimisation (1 sec)
				TRP2_UPDATERTAB[nom] = time();
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
				TRP2_MSP_Request(nom); -- MSP compatibility
			end
		end
		if TRP2_GetConfigValueFor("UseBroadcast",true) then
			if GetChannelName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2"))) == 0 then
				JoinChannelByName(string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")));
			else -- Case of ReloadUI()
				TRP2_SePresenterSurLeChan();
			end
		end
		TRP2_MouseOverTooltip("mouseover");
		TRP2_UpdateRegistre();
	elseif(event=="PLAYER_TARGET_CHANGED") then
		local nom,royaume = UnitName("target");
		TRP2_TargetButton:Hide();
		TRP2_AuraTargetFrame:Hide();
		if nom and nom ~= UNKNOWN then -- Si on a une cible
			TRP2_PlacerIconeCible(nom);
			if not TRP2_EstDansLeReg(nom) and not royaume and UnitIsPlayer("target") and nom~=TRP2_Joueur and UnitFactionGroup("target") == UnitFactionGroup("player") then
				TRP2_MSP_Request(nom); -- MSP compatibility
				TRP2_SecureSendAddonMessage("GTVN",TRP2_SendVernNum(),nom); -- Send VerNumTab avec request des VerNum adverses
			end
		end
		--TRP2_debug(UnitCreatureFamily("target"));
	elseif(event=="CHAT_MSG_CHANNEL") then
		--Spécifique au Module Registre
		if string.lower(arg9) == string.lower(TRP2_GetConfigValueFor("ChannelToUse","xtensionxtooltip2")) then
			desaoulage = string.gsub(arg1, "%.%.%.hips %!", "");
			TRP2_ReceiveMessageChannel(arg1,arg2);
		end
	elseif(event=="PLAYER_REGEN_DISABLED") then -- Marche uniquement quand aggro.
		if TRP2_GetConfigValueFor("CloseOnCombat",false) then
			TRP2MainFrame:Hide();
			TRP2_CreationFrame:Hide();
		end
	elseif(event=="COMBAT_LOG_EVENT") then -- Prise de dégats
		TRP2_GererDegats(...);
	elseif event=="WORLD_MAP_UPDATE" then
		if not TRP2_GetConfigValueFor("bDontUseCoord",false) and TRP2_GetWorldMap():IsVisible() and TRP2_GetWorldMap().TRP2_Zone ~= TRP2_GetCurrentMapZone() then
			wipe(TRP2_PlayersPosition);
			for _,v in pairs(TRP2_MINIMAPBUTTON) do
				v:Hide();
			end
			wipe(TRP2_MINIMAPBUTTON);
		end
	end
end

function TRP2_GetWorldMap()
	if getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame")) then
		return getglobal(TRP2_GetConfigValueFor("WorldMapToUse","WorldMapFrame"));
	end
	return WorldMapFrame;
end

function TRP2_GossipFrame_OnEvent(self, event, ...)
	if ( event == "GOSSIP_SHOW" ) then
		if ( not GossipFrame:IsShown() ) then
			ShowUIPanel(self);
			if ( not self:IsShown() ) then
				CloseGossip();
				return;
			end
		end
		GossipFrameUpdate();
	elseif ( event == "GOSSIP_CLOSED" ) then
		HideUIPanel(self);
	end
end

function TRP2_test()
	TRP2_DebugScripterFrameScrollEditBox:SetText("");
	TRP2_DebugScripterFrameScrollEditBox:Insert("---- Continent 6 ----\n");
	for k,v in pairs({ GetMapZones(6)}) do
		TRP2_DebugScripterFrameScrollEditBox:Insert("\""..v.."\", -- "..k.."\n");
	end
	--print("huhu |cffffffff|Htotalrp2:Telkostrasz|h[Texte]|h|r");
	
end

function TRP2_OnLoaded()
	-- Configuration load
	TRP2_Set_Module_Configuration();
	-- Locale detection
	if not TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] then
		if GetLocale() == "frFR" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 1;
		elseif GetLocale() == "esES" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 3;
		elseif GetLocale() == "deDE" then
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 4;
		else
			TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"] = 2;
		end
	end
	-- Saving variables load
	TRP2_Set_Module_PlayerInfos();
	TRP2_Set_Module_Registre();
	TRP2_Set_Module_Inventaire();
	TRP2_Set_Module_Quests();
	TRP2_Set_Module_Document();
	TRP2_Set_Module_Packages();
	-- Data base and guide
	TRP2_LoadDataBase();
	TRP2_LoadGuide();
	-- Localization
	TRP2_SetLocalisation();
	-- UI loading;
	TRP2_InitialisationUI();
	TRP2_Localisation_SetUI();
	-- Welcoming message
	TRP2_Afficher(TRP2_LOC_ACCUEIL);
	-- Fichier export
	if not TRP2_Module_Interface["bHasWelcomed"] then
		TRP2_Module_Interface["bHasWelcomed"] = true;
		if TRP2_Guide_OpenPage then
			TRP2_Guide_OpenPage("Welcome");
		end
	end
	if TRP2_Module_Interface["bHasExport"] then
		TRP2_Module_Interface["bHasExport"] = nil;
		StaticPopupDialogs["TRP2_JUST_TEXT"].text = TRP2_CTS(TRP2_ENTETE..TRP2_LOC_EXPORTWIN);
		TRP2_ShowStaticPopup("TRP2_JUST_TEXT");
	end
	-- MSP support
	TRP2_MSP_InitialLoad();
	-- Si tout s'est bien passé, on charge le onUpdate général
	TRP2_DebugSynchronizedFrame:Show();
	
	if TRP2_GetConfigValueFor("DebugMode",false) then
		UIParentLoadAddOn("Blizzard_DebugTools");
		TRP2_Afficher("TRP2 : Debug mode activated");
	end
end

function TRP2_LoadDataBase()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	--Auras
	if _G["TRP2_LoadDBAuras_"..langue] ~= nil then
		_G["TRP2_LoadDBAuras_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the states database. The addon won't work correctly.");
		return;
	end
	--Document
	if _G["TRP2_LoadDBDocuments_"..langue] ~= nil then
		_G["TRP2_LoadDBDocuments_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the documents database. The addon won't work correctly.");
		return;
	end
	--Items
	if _G["TRP2_LoadDBItems_"..langue] ~= nil then
		_G["TRP2_LoadDBItems_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the items database. The addon won't work correctly.");
		return;
	end
	--Quests
	if _G["TRP2_LoadDBQuests_"..langue] ~= nil then
		_G["TRP2_LoadDBQuests_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the quests database. The addon won't work correctly.");
		return;
	end
end

function TRP2_LoadGuide()
	local langue = TRP2_Module_Configuration[TRP2_Royaume][TRP2_Joueur]["Langue"];
	if _G["TRP2_LoadGuide_"..langue] ~= nil then
		_G["TRP2_LoadGuide_"..langue]();
	else
		message("Total RP 2\nAn error occured during the loading of the guidebook. The addon won't work correctly.");
		return;
	end
end