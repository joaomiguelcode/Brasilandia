-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("faly_pagamento",cRP)
vSERVER = Tunnel.getInterface("faly_pagamento")

RegisterNetEvent("pagamento:cobrar")
AddEventHandler("pagamento:cobrar", function(id)
    local location = cfg.locations[id]
    vSERVER.handlePayment(location)
end)

RegisterCommand("cobrar",function()
    local hasAnyPerm = vSERVER.hasAnyPerm()
    if not hasAnyPerm then return end
    vSERVER.handlePayment(hasAnyPerm)    
end)

Citizen.CreateThread(function()
    for k,v in pairs(cfg.locations) do
        exports['target']:AddCircleZone('TradeLoc:'..k,vec3(v["cds"][1], v["cds"][2], v["cds"][3]),0.5,{
            name = 'TradeLoc:'..k,
            heading = 3374176
        },{
            Distance = 1.75,
            shop = k,
            options = {
                {
                    event = "pagamento:cobrar",
                    label = v.label,
                    tunnel = 'shop'
                }
            }
        })
    end
end)