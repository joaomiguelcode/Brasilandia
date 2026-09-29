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
Tunnel.bindInterface("tablet",Creative)
vCLIENT = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
GlobalState["Cars"] = {}
GlobalState["Bikes"] = {}
GlobalState["Rental"] = {}

local webhookaluguell = "https://discord.com/api/webhooks/1156487595841294427/-Gu1c5YfWl149KbDZFznJOzjBQJExE2aaNAJTQ1kMWeERiuEnZK2BXcG6SpVO-kVMITy"
local webhookcompracarroo = "https://discord.com/api/webhooks/1156487886158430228/rxouG9AADnv3L8mcNxvx8k_HGbCQgnXd3EUjibrsBi23BSSWAcJbsCWyIgpX2nBy1eHS"
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Cars = {}
	local Bikes = {}
	local Rental = {}
	local Vehicles = VehicleGlobal()

	for Index,v in pairs(Vehicles) do
		if v["Mode"] == "cars" then
			Cars[#Cars + 1] = { k = Index, name = v["Name"], price = v["Price"], chest = v["Weight"], tax = v["Price"] * 0.10 }
		elseif v["Mode"] == "bikes" then
			Bikes[#Bikes + 1] = { k = Index, name = v["Name"], price = v["Price"], chest = v["Weight"], tax = v["Price"] * 0.10 }
		elseif v["Mode"] == "rental" then
			Rental[#Rental + 1] = { k = Index, name = v["Name"], price = v["Gems"], chest = v["Weight"], tax = v["Price"] * 0.10 }
		end
	end

	GlobalState:set("Cars",Cars,true)
	GlobalState:set("Bikes",Bikes,true)
	GlobalState:set("Rental",Rental,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Rental(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			local VehiclePrice = VehicleGems(vehName)
			local Text = "Alugar o veículo <b>"..VehicleName(vehName).."</b> por <b>"..VehiclePrice.."</b> Diamantes? Duração: <b>30 dias</b>"

			if vRP.ConsultItem(Passport,"rentalveh",1) then
				Text = "Alugar o veículo <b>"..VehicleName(vehName).."</b> usando o vale?"
			end

			if vRP.Request(source,Text,"Sim, concluír pagamento","Não, mudei de ideia") then
				if vRP.TakeItem(Passport,"rentalveh",1,true) or vRP.PaymentGems(Passport,VehiclePrice) then
					local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
					if vehicle[1] then
						if vehicle[1]["rental"] <= os.time() then
							vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(vehName).."</b> atualizado.",5000)
							else
							vRP.Query("vehicles/rentalVehiclesDays",{ Passport = Passport, vehicle = vehName })
							TriggerClientEvent("Notify",source,"verde","Adicionado <b>30 Dias</b> de aluguel no veículo <b>"..VehicleName(vehName).."</b>.",5000)
						end
					else
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
						TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(vehName).."</b> concluído.",5000)
						-- vRP.SendWebhook(webhookaluguell, "LOGs Aluguel", "**Passaporte: **"..Passport.."\n**Alugou o veículo: **"..VehicleName(vehName).."\n**Valor: **"..VehiclePrice, 10357504)

					end
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
local discountsPerm = {
	{'Premium',2, 0.05},
	{'Premium',3, 0.1},
}
function Creative.Buy(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if VehicleMode(vehName) == "rental" or not VehicleMode(vehName) then
				Active[Passport] = nil
				return
			end

			local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"amarelo","Já possui um <b>"..VehicleName(vehName).."</b>.",3000)
				Active[Passport] = nil
				return
			else
				if VehicleMode(vehName) == "work" then
					if vRP.PaymentFull(Passport,VehiclePrice(vehName)) then
						vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
						vRP.SendWebhook(webhookaluguell, "LOGs Aluguel", "**Passaporte: **"..Passport.."\n**Alugou o veículo: **"..VehicleName(Name).."\n**Valor: **"..VehiclePrice, 10357504)

					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				else
					local VehiclePrice = VehiclePrice(vehName)
					local nwVehiclePrice = VehiclePrice
					for _,v in pairs(discountsPerm) do
						if vRP.HasPermission(Passport,v[1],v[2]) then
							if VehiclePrice - VehiclePrice * v[3] < nwVehiclePrice then
								nwVehiclePrice = VehiclePrice - VehiclePrice * v[3]
							end
						end
					end
					VehiclePrice = nwVehiclePrice
					if vRP.Request(source,"Comprar <b>"..VehicleName(vehName).."</b> por <b>$"..parseFormat(VehiclePrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then

						local playerCars = exports["oxmysql"]:query_async([[
							SELECT COUNT(vehicle) as vehicles FROM vehicles WHERE Passport = ? AND `work` = "false" AND rental = 0
						]], {Passport})[1]["vehicles"]
						local maxCars = exports["oxmysql"]:query_async([[
							SELECT garage from characters WHERE id = ?
						]], {Passport})[1]["garage"]

						if playerCars >= maxCars then
							TriggerClientEvent("Notify",source,"vermelho","Você só pode ter "..maxCars.." carros em sua garagem.",5000)
							Active[Passport] = nil
							return
						end

						if vRP.PaymentFull(Passport,VehiclePrice) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = vehName, plate = vRP.GeneratePlate(), work = "false" })
							TriggerClientEvent("Notify",source,"verde","Compra concluída.",5000)
							vRP.SendWebhook(webhookcompracarroo, "LOGs Compra 2", "**Passaporte: **"..Passport.."\n**Comprou o veículo: **"..VehicleName(vehName).."\n**Valor: **"..parseFormat(VehiclePrice), 10357504)
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					end
				end
			end

			Active[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.startDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not Active[Passport] then
			Active[Passport] = true

			if not exports["hud"]:Wanted(Passport) then
				if vRP.Request(source,"Iniciar o teste por <b>$100</b> dólares?","Sim, iniciar o teste","Não, volto depois") then
					if vRP.PaymentFull(Passport,100) then
						TriggerEvent("vRP:BucketServer",source,"Enter",Passport)
						Active[Passport] = nil

						return true
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end

			Active[Passport] = nil
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.removeDrive()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerEvent("vRP:BucketServer",source,"Exit")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Active[Passport] then
		Active[Passport] = nil
	end
end)