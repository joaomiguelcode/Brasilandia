-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("races")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Saved = 0
local Objects = {}
local Race = 1
local Markers = {}
local Checkpoint = 1
local Rankings = false
local ExplodeTimers = false
local ExplodeCooldown = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRACES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)

	for _,Info in pairs(Races) do
		local Blip = AddBlipForCoord(Info["Init"]["x"],Info["Init"]["y"],Info["Init"]["z"])
		SetBlipSprite(Blip,38)
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,4)
		SetBlipScale(Blip,0.6)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Circuito")
		EndTextCommandSetBlipName(Blip)
	end

	while true do
		local TimeDistance = 999
		if not LocalPlayer["state"]["TestDrive"] then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Vehicle = GetPlayersLastVehicle()

			if LocalPlayer["state"]["Races"] then
				TimeDistance = 1
				local Points = GetGameTimer() - Saved

				if ExplodeTimers and GetGameTimer() >= ExplodeCooldown then
					ExplodeTimers = ExplodeTimers - 1
					ExplodeCooldown = GetGameTimer() + 1000
				end

				SendNUIMessage({ name = "Progress", payload = { Points,ExplodeTimers } })

				if not IsPedInAnyVehicle(Ped) or GetPedInVehicleSeat(Vehicle,-1) ~= Ped or (ExplodeTimers and ExplodeTimers <= 0) then
					StopCircuit()
				end

				local Distance = #(Coords - Races[Race]["Coords"][Checkpoint])
				if Distance <= 500 then
					TimeDistance = 1

					if Checkpoint >= #Races[Race]["Coords"] then
						DrawMarker(22,Races[Race]["Coords"][Checkpoint]["x"],Races[Race]["Coords"][Checkpoint]["y"],Races[Race]["Coords"][Checkpoint]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,GetEntityHeading(Ped) - 90,7.5,7.5,5.0,245,10,70,100,0,0,0,1)
					else
						DrawMarker(22,Races[Race]["Coords"][Checkpoint]["x"],Races[Race]["Coords"][Checkpoint]["y"],Races[Race]["Coords"][Checkpoint]["z"] + 3.0,0.0,0.0,0.0,0.0,180.0,0.0,7.5,7.5,5.0,245,10,70,100,0,0,0,1)
					end

					DrawMarker(1,Races[Race]["Coords"][Checkpoint]["x"],Races[Race]["Coords"][Checkpoint]["y"],Races[Race]["Coords"][Checkpoint]["z"] - 3.0,0.0,0.0,0.0,0.0,0.0,0.0,15.0,15.0,10.0,255,255,255,50,0,0,0,0)

					if Distance <= 15 then
						if Checkpoint >= #Races[Race]["Coords"] then
							SendNUIMessage({ name = "Display", payload = { false } })
							vSERVER.Finish(Race,Points)

							CleanCircuit()

							Saved = 0
							Checkpoint = 1
							ExplodeTimers = false
							LocalPlayer["state"]:set("Races",false,false)
							SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Race) } })
							Race = 1

							SetTimeout(5000,function()
								SendNUIMessage({ name = "Ranking", payload = { false } })
							end)
						else
							if DoesBlipExist(Markers[Checkpoint]) then
								RemoveBlip(Markers[Checkpoint])
								Markers[Checkpoint] = nil
							end

							Checkpoint = Checkpoint + 1
							SetBlipRoute(Markers[Checkpoint],true)
							SendNUIMessage({ name = "Checkpoint" })
						end
					end
				end
			else
				if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
					for Number,v in pairs(Races) do
						local Distance = #(Coords - v["Init"])
						if Distance <= 25 and GetPedInVehicleSeat(Vehicle,-1) == Ped then
							DrawMarker(23,v["Init"]["x"],v["Init"]["y"],v["Init"]["z"] - 0.35,0.0,0.0,0.0,0.0,0.0,0.0,10.0,10.0,10.0,245,10,70,100,0,0,0,0)
							TimeDistance = 1

							if Distance <= 5 then
								if IsControlJustPressed(1,47) then
									if not Rankings then
										Rankings = true
										SendNUIMessage({ name = "Ranking", payload = { true,vSERVER.Ranking(Number) } })
									else
										Rankings = false
										SendNUIMessage({ name = "Ranking", payload = { false } })
									end
								end

								if IsControlJustPressed(1,38) then
									ExplodeTimers = vSERVER.Start(Number)
									SendNUIMessage({ name = "Display", payload = { true,#Races[Number]["Coords"],ExplodeTimers } })

									if ExplodeTimers then
										ExplodeCooldown = GetGameTimer() + 1000
									end

									Saved = GetGameTimer()
									Race = Number
									Checkpoint = 1

									LocalPlayer["state"]:set("Races",true,false)
									InitCircuit()
								end
							else
								if Rankings then
									Rankings = false
									SendNUIMessage({ name = "Ranking", payload = { false } })
								end
							end
						end
					end
				else
					if Rankings then
						Rankings = false
						SendNUIMessage({ name = "Ranking", payload = { false } })
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function InitCircuit()
	LoadModel("prop_beachflag_01")
	LoadModel("prop_offroad_tyres02")

	for Number = 1,#Races[Race]["Coords"] do
		Markers[Number] = AddBlipForCoord(Races[Race]["Coords"][Number]["x"],Races[Race]["Coords"][Number]["y"],Races[Race]["Coords"][Number]["z"])
		SetBlipSprite(Markers[Number],1)
		SetBlipColour(Markers[Number],6)
		SetBlipScale(Markers[Number],0.85)
		SetBlipRoute(Markers[Checkpoint],true)
		SetBlipAsShortRange(Markers[Number],true)

		local Prop = "prop_offroad_tyres02"
		if Number == #Races[Race]["Coords"] then
			Prop = "prop_beachflag_01"
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanCircuit()
	for _,v in pairs(Markers) do
		if DoesBlipExist(v) then
			RemoveBlip(v)
		end
	end

	for _,v in pairs(Objects) do
		if DoesEntityExist(v) then
			DeleteEntity(v)
		end
	end

	Markers = {}
	Objects = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCIRCUIT
-----------------------------------------------------------------------------------------------------------------------------------------
function StopCircuit()
	SendNUIMessage({ name = "Display", payload = { false } })
	LocalPlayer["state"]:set("Races",false,false)
	vSERVER.Cancel()
	CleanCircuit()

	if ExplodeTimers then
		ExplodeTimers = false

		SetTimeout(3000,function()
			local Vehicle = GetPlayersLastVehicle()

			if Vehicle == 0 then
				local Ped = PlayerPedId()
				local Coords = GetEntityCoords(Ped)

				AddExplosion(Coords,2,0.5,false,false,false)
			else
				NetworkExplodeVehicle(Vehicle,true,false,true)
			end
		end)
	end
end