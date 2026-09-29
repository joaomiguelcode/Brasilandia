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
Tunnel.bindInterface("lscustoms",Creative)


local webhookbennys1 = "https://discord.com/api/webhooks/1156480704079732798/bQk9EgG6hjeSDzcrJ2YFx3ic1qfctuI-8AoCGhMgcqSxq1L7I4WuNF6EuGRkaotHhuzn"
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkPermission(perm)
	local source = source
	local Passport = vRP.Passport(source)

	if perm then
		if vRP.HasPermission(Passport,perm) then
			return true
		else
			TriggerClientEvent('Notify',source,'vermelho','Você não tem permissão',5000)
			return false
		end
	end

	local Vehicle,Network,Plate = vRPC.VehicleList(source,1)
	local query = exports["oxmysql"]:query_async([[
		SELECT tunning from vehicles where plate = ?
	]], { Plate })

	if query[1] then

		if Passport then
			if exports["hud"]:Wanted(Passport,source) then
				return false
			end

			if query[1]["tunning"] == 1 then

				exports["oxmysql"]:execute_async([[
					UPDATE `vehicles` SET `tunning` = 0 where plate = ?
				]], { Plate })

				return true
			else
				TriggerClientEvent("Notify", source, "vermelho", "Esse carro não está pronto para ser tunado", 5000)
				return false
			end
		end
	else
		TriggerClientEvent("Notify", source, "vermelho", "Esse carro não está pronto para ser tunado", 5000)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:attemptPurchase")
AddEventHandler("lscustoms:attemptPurchase",function(type,mod)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if type == "engines" or type == "brakes" or type == "transmission" or type == "suspension" or type == "shield" then
			local Price = vehicleCustomisationPrices[type][mod]

			if vRP.PaymentFull(Passport,Price) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
				vRP.SendWebhook(webhookbennys1, "LOGs Bennys1", "**Passaporte: **"..Passport.."\n**Tunou seu veículo por: **"..Price, 10357504)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		else
			if vRP.PaymentFull(Passport,vehicleCustomisationPrices[type]) then
				TriggerClientEvent("lscustoms:purchaseSuccessful",source)
				vRP.SendWebhook(webhookbennys1, "LOGs Bennys2", "**Passaporte: **"..Passport.."\n**Tunou seu veículo por: **"..vehicleCustomisationPrices[type], 10357504)
			else
				TriggerClientEvent("lscustoms:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("lscustoms:updateVehicle")
AddEventHandler("lscustoms:updateVehicle",function(Mods,Plate,vehName)
	local Passport = vRP.PassportPlate(Plate)
	if Passport then
		vRP.Query("entitydata/SetData",{ dkey = "Mods:"..Passport["Passport"]..":"..vehName, dvalue = json.encode(Mods) })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local inVehicle = {}
RegisterServerEvent("lscustoms:inVehicle")
AddEventHandler("lscustoms:inVehicle",function(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Network then
			if inVehicle[Passport] then
				inVehicle[Passport] = nil
			end
		else
			inVehicle[Passport] = { Network,Plate }
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if inVehicle[Passport] then
		Wait(1000)
		TriggerEvent("garages:deleteVehicle",inVehicle[Passport][1],inVehicle[Passport][2])
		inVehicle[Passport] = nil
	end
end)

function inactivePlayer(source)
	Player(source)["state"]["Cancel"] = true
	Player(source)["state"]["Commands"] = true
end

function activePlayer(source)
	Player(source)["state"]["Cancel"] = false
	Player(source)["state"]["Commands"] = false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- preparar
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("preparar",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Bennys") or vRP.HasGroup(Passport,"LSCustoms") then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,3)
			local query = exports["oxmysql"]:query_async([[
				SELECT tunning from vehicles where plate = ?
			]], { Plate })
			
			if query[1] then
				if query[1]["tunning"] == 1 then
					TriggerClientEvent("Notify", source, "vermelho", "Esse carro já está preparado para receber tunagens.", 5000)
					return
				end

				
				if Vehicle then

					vRPC._playAnim(source, false, {"mini@repair", "fixing_a_player"}, true)
					inactivePlayer(source)
					TriggerClientEvent("Progress",source,"Aplicando",10000)
					Wait(10000)
					activePlayer(source)
					vRPC._stopAnim(source, false)
					exports["oxmysql"]:execute_async([[
						UPDATE `vehicles` SET `tunning` = 1 where plate = ?
					]], { Plate })

					TriggerClientEvent("Notify", source, "verde", "Carro preparado para receber tunagens.", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Carro de americano não pode ser tunado.", 5000)
			end

		end
	end
end)