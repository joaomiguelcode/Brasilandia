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
Invoke = {}
Tunnel.bindInterface("races",Invoke)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Payments = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoke.Finish(Number,Points)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local vehName = vRPC.VehicleName(source)
		local Consult = vRP.Query("races/Result",{ Race = Number, Passport = Passport })

		if Payments[Passport] then
			local Rand = math.random(Races[Number]["Payment"][1],Races[Number]["Payment"][2])
			vRP.GenerateItem(Passport,"dollarz",Rand,true)

			local Ranking = vRP.Query("races/TopFive",{ Race = Number })
			-- print(parseInt(Ranking[1]["Points"]))
			print(parseInt(Points))
			print(json.encode(Ranking))
			if Ranking[1] then
				if parseInt(Ranking[1]["Points"]) > parseInt(Points) then
					vRP.GenerateItem(Passport,"racetrophy",1,true)
				end
			end

			TriggerEvent("blipsystem:Exit",source)
			Payments[Passport] = nil
		end

		if Consult[1] then
			if parseInt(Points) < parseInt(Consult[1]["Points"]) then
				vRP.Query("races/Records",{ Race = Number, Passport = Passport, Vehicle = VehicleName(vehName), Points = parseInt(Points) })
			end
		else
			local Identity = vRP.Identity(Passport)
			vRP.Query("races/Insert",{ Race = Number, Passport = Passport, Name = Identity["name"].." "..Identity["name2"], Vehicle = VehicleName(vehName), Points = parseInt(Points) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- START
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoke.Start(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Races[Number] then
		if not Races[Number]["Cooldown"][Passport] then
			Races[Number]["Cooldown"][Passport] = os.time()
		end

		if os.time() >= Races[Number]["Cooldown"][Passport] then
			Payments[Passport] = false

			if vRP.InventoryItemAmount(Passport, "credential")[1] > 0 then
				if vRP.TakeItem(Passport,"credential",1) then
					TriggerEvent("blipsystem:Enter",source,"Corredor")
					Races[Number]["Cooldown"][Passport] = os.time() + 3600
					Payments[Passport] = true

					local Service = vRP.NumPermission("Police")
					for Passports,Sources in pairs(Service) do
						async(function()
							TriggerClientEvent("Notify",Sources,"amarelo","Detectamos um corredor clandestino nas ruas.",5000)
							vRPC.PlaySound(Sources,"Beep_Red","DLC_HEIST_HACKING_SNAKE_SOUNDS")
						end)
					end
					
					return Races[Number]["Explosive"]
				end
			end

			return false
		else
			local Cooldown = Races[Number]["Cooldown"][Passport] - os.time()
			TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..Cooldown.."</b> segundos.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANKING
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoke.Ranking(Number)
	local Consult = vRP.Query("races/Ranking",{ Race = Number })
	return Consult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
function Invoke.Cancel()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Payments[Passport] then
			Payments[Passport] = nil
			TriggerEvent("blipsystem:Exit",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Payments[Passport] then
		Payments[Passport] = nil
		TriggerEvent("blipsystem:Exit",source)
	end
end)