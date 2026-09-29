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
Tunnel.bindInterface("vendacarros",Creative)
vSERVER = Tunnel.getInterface("vendacarros")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("PlayerVehicle",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Searched = nil
local Hotwired = false
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { x = 2347.97, y = 3131.44, z = 48.21,
		["1"] = { 60.44,-866.47,30.23,340.16 },
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle)
	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0,5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle,i)
		end

		for i = 0,5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle,i)
		end

		for i = 0,7 do
			local Status = false

			if GetTyreHealth(Vehicle,i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		if DecorExistOn(Vehicle,"PlayerVehicle") then
			DecorRemove(Vehicle,"PlayerVehicle")
		end

		vSERVER.Delete(VehToNet(Vehicle),GetEntityHealth(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),GetVehicleFuelLevel(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle))
	end
end)


-- THREAD DRAWNMAKER GARAGEM
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number,v in pairs(Garages) do
					local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
					if Distance <= 8.0 then
						TimeDistance = 1
						DrawText3D(v["x"],v["y"],v["z"] - 0.3,"~r~[E]~w~     Vender Veículo")
						-- DrawMarker(1,v["x"],v["y"],v["z"] - 1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,1.0,1.0,153,39,44,50,0,1,0,0)
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.50,0.50)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)

		local width = string.len(text) / 160 * 0.55
		DrawRect(_x,_y + 0.0165,width,0.04,15,15,15,55)
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number,v in pairs(Garages) do
					local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
					if Distance <= 5.0 then
						TimeDistance = 1
						-- DrawMarker(1,v["x"],v["y"],v["z"] - 1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.00,1.00,1.00,30,144,255,50,0,0,0,10)

						if IsControlJustPressed(1,38) then
							local Vehicles = vSERVER.Vehicles(Number)
							if Vehicles then

								if parseInt(#Vehicles) > 0 then
									for _,v in pairs(Vehicles) do
										exports["dynamic"]:AddButton("Vender","Clique para o vender o veículo.","garages:Sell",v["Model"],v["Model"],true)
										exports["dynamic"]:SubMenu(v["name"],"Todas as funções do veículo.",v["Model"])
									end
								end

								exports["dynamic"]:openMenu()
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)