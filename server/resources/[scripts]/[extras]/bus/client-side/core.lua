-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("bus")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Blip = nil
local Selected = 1
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("bus:Init")
AddEventHandler("bus:Init",function()
	if Active then
		if DoesBlipExist(Blip) then
			RemoveBlip(Blip)
			Blip = nil
		end

		exports["target"]:LabelText("WorkBus","Trabalhar")
		TriggerEvent("Notify","Sucesso","Trabalho finalizado.","verde",5000)
		Active = false
	else
		exports["target"]:LabelText("WorkBus","Finalizar")
		TriggerEvent("Notify","Sucesso","Trabalho iniciado.","verde",5000)
		Active = true
		MakeBlips()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Active then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				if GetEntityArchetypeName(Vehicle) == "bus" then
					local Coords = GetEntityCoords(Ped)
					local Distance = #(Coords - Locations[Selected])

					if Distance <= 200 then
						TimeDistance = 1

						DrawMarker(22,Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,65,130,226,100,0,0,0,1)
						DrawMarker(1,Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"] - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

						if Distance <= 10 then
							vSERVER.Payment(Selected)

							if Selected >= #Locations then
								Selected = 1
							else
								Selected = Selected + 1
							end

							MakeBlips()
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
function MakeBlips()
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		Blip = nil
	end

	Blip = AddBlipForCoord(Locations[Selected]["x"],Locations[Selected]["y"],Locations[Selected]["z"])
	SetBlipSprite(Blip,1)
	SetBlipDisplay(Blip,4)
	SetBlipAsShortRange(Blip,true)
	SetBlipColour(Blip,77)
	SetBlipScale(Blip,0.75)
	SetBlipRoute(Blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Motorista")
	EndTextCommandSetBlipName(Blip)
end