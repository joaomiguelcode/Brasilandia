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
Tunnel.bindInterface("transferencia",Creative)
vSERVER = Tunnel.getInterface("transferencia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("PlayerVehicle",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { x = -30.54, y = -1104.85, z = 26.42,    
		["1"] = { 0,0,-20,0 },
	},
}
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
						DrawText3D(v["x"],v["y"],v["z"] - 0.3,"~r~[E]~w~     Transferir Veículo")
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
					if Distance <= 2.0 then
						TimeDistance = 1
						-- DrawMarker(1,v["x"],v["y"],v["z"] - 1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.00,1.00,1.00,30,144,255,50,0,0,0,10)

						if IsControlJustPressed(1,38) then
							local Vehicles = vSERVER.Vehicles(Number)
							if Vehicles then
							exports["dynamic"]:AddButton("Seja bem-vindo a <B>Premium Mortorsports Deluxy</B>!","Escolha qual veículo deseja transferir","",false,false)

								if parseInt(#Vehicles) > 0 then
									for _,v in pairs(Vehicles) do
										
										exports["dynamic"]:AddButton("Transferência","Clique para transferir a outra pessoa.","garages:Transfer",v["Model"],v["Model"],true)
										exports["dynamic"]:SubMenu(v["name"],"Transferir este veículo.",v["Model"])

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
