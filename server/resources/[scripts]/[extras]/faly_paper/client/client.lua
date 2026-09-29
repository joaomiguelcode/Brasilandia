-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("faly_paper",cRP)
vSERVER = Tunnel.getInterface("faly_paper")


RegisterNetEvent("faly_paper:open_paper")
AddEventHandler("faly_paper:open_paper", function(paperId)
    vRP._createObjects("amb@medic@standing@timeofdeath@base","base","prop_notepad_01",49,60309)
    if cfg.papers[paperId] then
        SendNUIMessage({action="open", paper=cfg.papers[paperId]})
    end
    SetNuiFocus(true, true)
end)

RegisterNUICallback("close", function()
    vRP._removeObjects("one")
    SetNuiFocus(false, false)
end)
