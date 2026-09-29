-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("pdm",src)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local VehicleGlobal = {}
local Discount = 0
local TestDriveUsers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function src.VehicleGlobal()
	return VehicleGlobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Discount()
	return Discount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Check(Vehicle)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.requestMyVehicles()
	local source = source
	local Passport = vRP.Passport(source)
	local myVehicles = {}
	if Passport then
		local vehicles = vRP.Query("vehicles/UserVehicles", { Passport = Passport })
		for _, v in ipairs(vehicles) do
			if VehicleGlobal[v.vehicle] then
				table.insert(myVehicles, {
					spawn = v.vehicle,
					name = VehicleGlobal[v.vehicle].name,
					price = VehicleGlobal[v.vehicle].price,
					type = VehicleGlobal[v.vehicle].type or "NORMAL",
					trunk = VehicleGlobal[v.vehicle].trunk or 0
				})
			end
		end
	end
	return myVehicles
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Buy(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and VehicleGlobal[Vehicle] then
		local vehicleData = VehicleGlobal[Vehicle]
		local Price = vehicleData.price
		local Stock = vehicleData.stock or 0
		
		if Stock <= 0 and vehicleData.stock then
			return false, "Veículo sem estoque!"
		end
		
		if Discount > 0 then
			Price = math.ceil(Price * (1 - Discount / 100))
		end
		
		-- Verifica se o jogador já possui o veículo
		local check = vRP.Query("vehicles/selectVehicles", { Passport = Passport, vehicle = Vehicle })
		if check[1] then
			return false, "Você já possui este veículo em sua garagem!"
		end
		
		-- Pagamento real
		if vRP.PaymentFull(Passport, Price) then
			-- Atualiza estoque se aplicável
			if vehicleData.stock then
				VehicleGlobal[Vehicle].stock = Stock - 1
			end
			
			-- Adiciona veículo ao jogador na garagem
			vRP.Query("vehicles/addVehicles", { 
				Passport = Passport, 
				vehicle = Vehicle, 
				plate = vRP.GeneratePlate(), 
				work = "false" 
			})
			
			TriggerClientEvent("Notify",source,"Sucesso","Compra efetuada com sucesso! Veículo adicionado à sua garagem.","verde",5000)
			return true, "Veículo comprado com sucesso!"
		else
			return false, "Dinheiro insuficiente!"
		end
	end
	return false, "Veículo não encontrado!"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Remove()
	-- Placeholder
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	-- Exemplo de veículos para teste
	VehicleGlobal["adder"] = { name = "adder", price = 1000000, type = "sports" }
	VehicleGlobal["t20"] = { name = "t20", price = 2000000, type = "super" }
	VehicleGlobal["zentorno"] = { name = "zentorno", price = 2500000, type = "super", stock = 1 }
	Citizen.Wait(3900)
	print("[PDM] Sistema inicializado com veículos de exemplo")
end)
