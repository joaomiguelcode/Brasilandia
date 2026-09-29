
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------
--Durateston Connection------------------------------------------------------------------
-----------------------------------------------------------------------------------------
CLIENT = {}
Tunnel.bindInterface(GetCurrentResourceName(),CLIENT)
SMudarID = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
function CLIENT.OpenSistem(typeUpdate)
    SendNUIMessage({ Action = "Open", name = "Default"})
    SetNuiFocus(true,true)
end
---------------------------------------------------------
--------------Obter Informações do Jogador Pelo Id ------
---------------------------------------------------------
RegisterNUICallback("getPlayerInfoById",function(data,cb)
    cb(SMudarID.getPlayerInfo(data.id))
end)


RegisterNUICallback("UpdateId",function(data,cb)    
    print(json.encode(data))
    cb(SMudarID.UpdateID(data.old_id,data.new_id))
end)


RegisterNUICallback("Close",function(data,cb)
    SetNuiFocus(false,false)
    cb("ok")
end)
