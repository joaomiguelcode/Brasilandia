-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("bus",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Payment(Selected)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Active[Passport] and Locations[Selected] then
		Active[Passport] = true

		local Coords = vRP.GetEntityCoords(source)
		if not Selected or not vRPC.LastVehicle(source,"bus") or #(Coords - Locations[Selected]) > 25 then
			exports["megazord"]:Discord("**Passaporte:** "..Passport.."\n**Função:** Payment do Motorista",source)
		end

		local Experience = vRP.GetExperience(Passport,"Driver")
		local Level = ClassCategory(Experience)
		local Valuation = 30

		if Level == 2 or Level == 3 or Level == 5 then
			Valuation = Valuation + 10
		elseif Level == 6 or Level == 7 or Level == 8 then
			Valuation = Valuation + 15
		elseif Level == 9 or Level == 10 then
			Valuation = Valuation + 20
		end

		local Buffs = exports["inventory"]:Buffs("Dexterity",Passport)
		if Buffs and Buffs > os.time() then
			Valuation = Valuation + (Valuation * 0.1)
		end

		if exports["party"]:DoesExist(Passport) then
			local Members = exports["party"]:Room(Passport,source,10)
			if parseInt(#Members) >= 4 then
				Valuation = Valuation + (Valuation * 0.1)
			end
		end

		exports["vrp"]:Payments(source,Passport,"Motorista",Valuation)
		vRP.GenerateItem(Passport,"dollars",Valuation,true)
		vRP.PutExperience(Passport,"Driver",1)

		Active[Passport] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)