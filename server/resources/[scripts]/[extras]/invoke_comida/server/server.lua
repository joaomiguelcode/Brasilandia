-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("invoke_comida",cRP)
vCLIENT = Tunnel.getInterface("invoke_comida")

function cRP.removeItem(Full, Slot)
    local Passport = vRP.Passport(source)
    if vRP.TakeItem(Passport,Full,1,true,Slot) then
        return true
    end

    return false
end