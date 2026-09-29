-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = "Santos"
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Open")
AddEventHandler("tablet:Open",function(Select)
	if LocalPlayer["state"]["Route"] < 900000 then
		local Ped = PlayerPedId()
		if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and GetEntityHealth(Ped) > 100 then
			Open = Select
			SetNuiFocus(true,true)
			SetCursorLocation(0.5,0.5)
			SendNUIMessage({ action = "Open" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "Close" })

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Carros",function(Data,Callback)
	Callback({ result = GlobalState["Cars"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Motos",function(Data,Callback)
	Callback({ result = GlobalState["Bikes"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALUGUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Aluguel",function(Data,Callback)
	Callback({ result = GlobalState["Rental"] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	vSERVER.Buy(Data["name"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENTAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rental",function(Data,Callback)
	vSERVER.Rental(Data["name"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLET:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("tablet:Update")
AddEventHandler("tablet:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVEABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehDrive = nil
local benDrive = false
local benCoords = { 0.0,0.0,0.0 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive",function(Data,Callback)
	if vSERVER.startDrive() then
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "Close" })

		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		benCoords = { Coords["x"],Coords["y"],Coords["z"] }

		LocalPlayer["state"]["Race"] = true
		LocalPlayer["state"]["Commands"] = true
		TriggerEvent("Notify","azul","Teste iniciado, para finalizar saia do veículo.",5000)

		Wait(1000)

		vehCreate(Data["name"])

		Wait(1000)

		SetPedIntoVehicle(Ped,vehDrive,-1)
		benDrive = true
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vehCreate(vehName)
	if LoadModel(vehName) then
		if Open == "Santos" then
			vehDrive = CreateVehicle(vehName,-53.28,-1110.93,26.47,68.04,false,false)
		elseif Open == "Sandy" then
			vehDrive = CreateVehicle(vehName,1209.74,2713.49,37.81,175.75,false,false)
		end

		SetModelAsNoLongerNeeded(vehName)
		SetEntityInvincible(vehDrive,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if benDrive then
			TimeDistance = 1
			DisableControlAction(1,69,false)

			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				Wait(1000)

				benDrive = false
				vSERVER.removeDrive()
				LocalPlayer["state"]["Race"] = false
				LocalPlayer["state"]["Commands"] = false
				SetEntityCoords(Ped,benCoords[1],benCoords[2],benCoords[3],false,false,false,false)

				if DoesEntityExist(vehDrive) then
					DeleteEntity(vehDrive)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local initVehicles = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Vehicles = {
	{
		["Coords"] = vec3(125.9,-157.18,54.51),
		["heading"] = 325.99,
		["Model"] = "panameramansory",
		["Distance"] = 100
	},{
		["Coords"] = vec3(134.33,-160.27,54.51),
		["heading"] = 331.66,
		["Model"] = "laferrari",
		["Distance"] = 100
	},{
		["Coords"] = vec3(141.92,-163.21,54.51),
		["heading"] = 334.49,
		["Model"] = "rmodrs6r",
		["Distance"] = 100
	},{
		["Coords"] = vec3(117.43,-153.94,54.58),
		["heading"] = 133.23,
		["Model"] = "bmwz4",
		["Distance"] = 100
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for k,v in pairs(Vehicles) do
			local Distance = #(Coords - v["Coords"])
			if Distance <= v["Distance"] then
				if not initVehicles[k] then
					if LoadModel(v["Model"]) then
						local Color = math.random(112)
						initVehicles[k] = CreateVehicle(v["Model"],v["Coords"],v["heading"],false,false)
						SetVehicleNumberPlateText(initVehicles[k],"PDMSPORT")
						SetVehicleColours(initVehicles[k],Color,Color)
						FreezeEntityPosition(initVehicles[k],true)
						SetVehicleDoorsLocked(initVehicles[k],2)
						SetModelAsNoLongerNeeded(v["Model"])
					end
				end
			else
				if initVehicles[k] then
					if DoesEntityExist(initVehicles[k]) then
						DeleteEntity(initVehicles[k])
						initVehicles[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)