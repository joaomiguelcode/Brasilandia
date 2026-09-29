-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("taxi",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.paymentService()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.GenerateItem(Passport,"dollars",math.random(500,950),true)
		FamilyExperience(source)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FAMILYEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function FamilyExperience(Source)
    local Player = Player(Source)["state"]
	local Passport = vRP.Passport(Source)
    if Player["Family"] then
        local XpAmount = math.random(25,35)		
		TriggerEvent("us_families:AddXP",Passport,Player["Family"],XpAmount,"Crafting")
    end
end