-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Display = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(GlobalState["Doors"]) do
		if IsDoorRegisteredWithSystem(Number) then
			RemoveDoorFromSystem(Number)
		end

		AddDoorToSystem(Number,v["Hash"],v["Coords"],false,false,true)

		DoorSystemSetOpenRatio(Number,0.0,false,false)
		DoorSystemSetAutomaticRate(Number,2.0,false,false)
		DoorSystemSetDoorState(Number,v["Lock"] and 1 or 0,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS:DOORSUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:Update")
AddEventHandler("doors:Update",function(Number,Status)
	DoorSystemSetOpenRatio(Number,0.0,false,false)
	DoorSystemSetAutomaticRate(Number,2.0,false,false)
	DoorSystemSetDoorState(Number,Status and 1 or 0,true)

	if GlobalState["Doors"][Number]["Other"] ~= nil then
		local Second = GlobalState["Doors"][Number]["Other"]
		DoorSystemSetDoorState(Second,Status and 1 or 0,true)
	end

	if Display[Number] then
		SendNUIMessage({ Action = "Doors", Status = true, Text = Status and "Trancado" or "Destrancado" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for Number,v in pairs(GlobalState["Doors"]) do
				local Distance = #(Coords - v["Coords"])
				if Distance <= v["Distance"] then
					TimeDistance = 1

					if not Display[Number] then
						SendNUIMessage({ Action = "Doors", Status = true, Text = v["Lock"] and "Trancado" or "Destrancado" })
						Display[Number] = true
					end

					if IsControlJustPressed(1,38) then
						vSERVER.DoorsPermission(Number)
					end
				else
					if Display[Number] then
						SendNUIMessage({ Action = "Doors", Status = false })
						Display[Number] = nil
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)