local AIO = AIO or require("AIO")
local RE_ClientLib = RE_ClientLib or require("RE_ClientLib")

local HandleREMsg

if AIO.AddAddon() then
   --
   -- Estamos en el server, con esta funcion manejaremos los mensajes hacia el server
   -- 
   -- Definimos varias cabeceras:
   -- REFIC -> Peticion de la ficha
   function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        t={} 
        local i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
   end
   function SendMsgGroup ( player, msg )
       local MyGrp = player:GetGroup()
	   if MyGrp == nil then
	      AIO.Msg():Add("REMsg", msg ):Send(player)
		  return
	   end
       local GrPj = MyGrp:GetMembers()
	   local NumGrPj = MyGrp:GetMembersCount()
       PrintInfo("[DEBUG]SendAddonMsgGroup:847[" .. tostring(MyGrp) .. "][" .. tostring(NumGrPj) .."]")
	   for LoopVar=1,NumGrPj do
	      AIO.Msg():Add("REMsg", msg ):Send(GrPj[LoopVar])
          PrintInfo("[DEBUG]SendMsgGroup:31[" .. tostring(GrPj[LoopVar]:GetAccountName()) .. "]Sending")
	   end   
   end   
   function HandleREMsg(player, msg)
      local RE_Table = mysplit ( msg , "#" )
      RE_Head = RE_Table[1]
      RE_Body = RE_Table[2]

      --
      -- Peticion de ficha
      -- Se hace una query a la tabla RE_Attr donde tenemos atributos y luego a RE_Hab de donde sacamos las habilidades
      -- luego se envia la peticion al cliente
      --
      if RE_Head == "REFIC" then
          PrintInfo ( player:GetAccountName() .. " pide ficha para [" .. RE_Body .. "]" )
          MyResult = CharDBQuery( "SELECT RE_pj, RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa from RE_Atributos where RE_pj ='" .. RE_Body .. "';" )
          if (MyResult == nil ) then
		     PrintInfo ( "NOFIC#" .. RE_Body .. "#" .. player:GetAccountName())
             AIO.Msg():Add("REMsg", "NOFIC#" .. RE_Body .. "#" .. player:GetAccountName()):Send(player)
             return
          end
          local RE_Attr = MyResult:GetString( 0 ) .. "#"
                                          .. MyResult:GetString( 1 ) .. "."
                                          .. MyResult:GetString( 2 ) .. "."
                                          .. MyResult:GetString( 3 ) .. "."
                                          .. MyResult:GetString( 4 ) .. "."
                                          .. MyResult:GetString( 5 ) .. "."
                                          .. MyResult:GetString( 6 ) .. "."
                                          .. MyResult:GetString( 7 ) .. "."
                                          .. MyResult:GetString( 8 ) .. "."
          MyResult = CharDBQuery( "SELECT RE_ID, RE_Valor from RE_Habilidades_pj where RE_pj ='" .. RE_Body .. "';" )
          if ( MyResult ~= nil ) then
             local NumRows = MyResult:GetRowCount()
             for i = 1,NumRows do
                RE_Attr = RE_Attr .. "#" 
                          .. MyResult:GetString( 0 )  .. "."
                          .. MyResult:GetString( 1 )  
                MyResult:NextRow()
             end
          end
          AIO.Msg():Add("REMsg", "REFIC#" .. RE_Attr .. "#" .. player:GetAccountName()):Send(player)
      elseif RE_Head == "REFCC" then
          PrintInfo ( player:GetAccountName() .. " pide ficha para [" .. RE_Body .. "]" )
          MyResult = CharDBQuery( "SELECT RE_pj, RE_Fisico, RE_Destreza, RE_Inteligencia, RE_Percepcion, RE_Mana, RE_Vida, RE_Iniciativa, RE_Defensa from RE_Atributos where RE_pj ='" .. RE_Body .. "';" )
          if (MyResult == nil ) then
	         PrintInfo ( "NOFIC#" .. RE_Body )
             AIO.Msg():Add("REMsg", "NOFIC#" .. RE_Body .. "#" .. player:GetAccountName()):Send(player)
             return
          end
          local RE_Attr = MyResult:GetString( 0 ) .. "#"
                                          .. MyResult:GetString( 1 ) .. "."
                                          .. MyResult:GetString( 2 ) .. "."
                                          .. MyResult:GetString( 3 ) .. "."
                                          .. MyResult:GetString( 4 ) .. "."
                                          .. MyResult:GetString( 5 ) .. "."
                                          .. MyResult:GetString( 6 ) .. "."
                                          .. MyResult:GetString( 7 ) .. "."
                                          .. MyResult:GetString( 8 ) .. "."
          MyResult = CharDBQuery( "SELECT RE_ID, RE_Valor from RE_Habilidades_pj where RE_pj ='" .. RE_Body .. "';" )
          if ( MyResult ~= nil ) then
             local NumRows = MyResult:GetRowCount()
             for i = 1,NumRows do
                RE_Attr = RE_Attr .. "#" 
                          .. MyResult:GetString( 0 )  .. "."
                          .. MyResult:GetString( 1 )  
                MyResult:NextRow()
             end
          end										  
         AIO.Msg():Add("REMsg", "REFCC#" .. RE_Attr .. "#" .. player:GetAccountName()):Send(player)
      elseif RE_Head == "LDHAB" then -- Carga de tabla de Habilidades
	     MyResult = CharDBQuery( "SELECT RE_ID, RE_Nombre, RE_Efecto, RE_Atributo, RE_Code, RE_Mana from RE_Habilidades")
         if ( MyResult ~= nil ) then
             local NumRows = MyResult:GetRowCount()
			 local UpdHab = ""
             for i = 1,NumRows do
                UpdHab = "LDHAB#" 
                          .. MyResult:GetString( 0 )  .. "."
                          .. MyResult:GetString( 1 )  .. "."
                          .. MyResult:GetString( 2 )  .. "."
                          .. MyResult:GetString( 3 )  .. "."
                          .. MyResult:GetString( 4 )  .. "."
                          .. MyResult:GetString( 5 )
				AIO.Msg():Add("REMsg", UpdHab):Send(player)	  
                MyResult:NextRow()
             end
          end		 
 	  elseif RE_Head == "CATTR" then -- Modificacion de atributo ingame
	     PrintInfo("[CATTR]:[" .. RE_Body .. "]")
	     local MyTable = mysplit ( RE_Body , "." )
		 local MyPlayer = MyTable[1]
		 local MyAttr = MyTable[2]
		 local MyVal = MyTable[3]
		 MyResult = CharDBQuery("UPDATE RE_Attr set " .. MyAttr .. " = " .. tostring(MyVal) .. " WHERE RE_pj = '" .. MyPlayer .. "';")
		 PrintInfo("MOD " .. MyPlayer .."'s " .. MyAttr .. "[" .. tostring(MyVal) .."]:" .. tostring(MyResult))
		 
	  elseif RE_Head == "PRTXT" then 
	     SendMsgGroup(player, msg)
	  else
	     PrintInfo("[INFO]HandleREMsg:114 Unhandled Message:[" .. msg .."]")
	  end
           
   end
   PrintInfo("RE Loaded ...")
else
  
   --
   -- Estamos en el cliente
   --
   
   
   local senttime
   local REFich_frame
   
   assert(not RESendMsg, "RE.lua: RESendMsg is already defined")
   --
   -- Funcion de manejo de mensajes
   --
   function HandleREMsg(player, msg)
      local RE_Head, RE_Pj, RE_Body = strsplit ( "#", tostring(msg) )
      local RE_AllFlds = { strsplit ( "#", tostring(msg) )}
      if (not IsAddOnLoaded("totalRP2")) then
         print("|cff00ffff [RE]:|c00ffff00 Se ha recibido información importante para el rol pero no se puede actualizar porque no tienes activo el TRP2, activalo por favor!!")
         return
      end
      if (RE_Head == "REFIC") then -- Ficha propia
         TRP2RE_Ficha ( RE_AllFlds ) 
         print("|cff00ffff [RE]:|cffffffff Ficha de " .. RE_Pj .. " actualizada")
      elseif (RE_Head == "REFCC") then 
         TRP2REQueryFicha ( RE_AllFlds ) -- Ficha de otro pj
      elseif (RE_Head == "NOFIC") then 
        print ( "|cff00ffff [RE]:|cffff0000 ATENCION!!!" )
        print ( "|cff00ffff [RE]:|c00ffff00 No se ha encontrado informacion sobre la ficha de este pj." )
        print ( "|cff00ffff [RE]:|c00ffff00 Puede que tu ficha no haya sido aprobada. Por favor habla con un miembro del staff para solucionarlo." )
		if RE_Pj == UnitName("player") then
           REFich_frame:Hide()
		   DisableAddOn("totalRP2", RE_Pj)
		   message("[Rol Errante] ATENCION!!!\n|c00ffff00No se ha encontrado informacion sobre la ficha de este pj. Ver detalles en chat")
   		   StaticPopup_Show ("RE_NOFICH")

		end
      elseif (RE_Head == "PRTXT") then -- Imprime texto
	     print (RE_Body)
      elseif (RE_Head == "LDHAB") then -- Actualiza tabla habilidades
	     if TRP2RE["GlobalHab"] == nil then
		    TRP2RE["GlobalHab"] = {}
		 end
         local RE_ID, RE_Nombre, RE_Efecto, RE_Atributo, RE_Code, RE_Mana = strsplit ( ".", RE_AllFlds[2] )	
         if TRP2RE["GlobalHab"][RE_ID] == nil then
		    TRP2RE["GlobalHab"][RE_ID] = {}
		 end
		 TRP2RE["GlobalHab"][RE_ID]["RE_Nombre"] = RE_Nombre
		 TRP2RE["GlobalHab"][RE_ID]["RE_Efecto"] = RE_Efecto
		 TRP2RE["GlobalHab"][RE_ID]["RE_Atributo"] = RE_Atributo
		 TRP2RE["GlobalHab"][RE_ID]["RE_Code"] = RE_Code
		 TRP2RE["GlobalHab"][RE_ID]["RE_Mana"] = RE_Mana
	  end	 
    end
    -- Funcion de envio de mensaje
    function RESendMsg( Msg )
        senttime = time()
        AIO.Msg():Add("REMsg", Msg):Send()
    end
 RESendMsg( "LDHAB#" .. UnitName("player"))
 RESendMsg( "REFIC#" .. UnitName("player"))
end

AIO.RegisterEvent("REMsg", HandleREMsg)
