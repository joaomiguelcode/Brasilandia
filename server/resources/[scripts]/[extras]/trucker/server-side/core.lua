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
Tunnel.bindInterface("trucker",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
local Trucker = {}
local webhookcaminhao = "https://discord.com/api/webhooks/1156489468967133194/VdMtJbjVq4r4_kVOZ_Dqu1ywclO_DXDxEdHLWsTE8Yz-BQ2Fv_UvdPU3DwQiBIzl1F-I"

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkExist()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Trucker[Passport] then
			Trucker[Passport] = os.time()
		end

		if os.time() >= Trucker[Passport] then
			return true
		else
			local truckerTimers = parseInt(Trucker[Passport] - os.time())
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..MinimalTimers(truckerTimers).."</b> para trabalhar novamente.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
local Delivery = {
	["vehicles"] = {
		{ ["item"] = "dollars", ["min"] = 3300, ["max"] = 4400 },
	},
	["diesel"] = {
		{ ["item"] = "dollars", ["min"] = 4250, ["max"] = 5350 },
	},
	["fuel"] = {
		{ ["item"] = "dollars", ["min"] = 4400, ["max"] = 5500 },
	},
	["wood"] = {
		{ ["item"] = "dollars", ["min"] = 4800, ["max"] = 5980 },
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasPermission(Passport,"Premium") or vRP.HasGroup(Passport,"Premium")  then
			Trucker[Passport] = os.time() + 21600
		else
			Trucker[Passport] = os.time() + 86400
		end

		for k,v in pairs(Delivery[Service]) do
			local Rand = math.random(v["min"],v["max"])
			vRP.GenerateItem(Passport,v["item"],Rand,true)
			vRP.SendWebhook(webhookcaminhao, "LOGs Trucker", "**Passaporte: **"..Passport.."\n**Conclui a entrega e recebeu: **"..Rand.." "..v["item"], 10357504)

		end
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