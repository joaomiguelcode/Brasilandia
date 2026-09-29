-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_dismantle",cnVRP)
vSERVER = Tunnel.getInterface("vrp_dismantle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inService = false
local timeDismantle = GetGameTimer()

local DismantleCoords = {
	{ 480.28,-1316.43,29.2, "Admin" }
	-- { 1624.38,3576.95,35.15, "Admin" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 3000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(DismantleCoords) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 7 then
					timeDistance = 4
					dwText("~g~E~w~ PARA DESMANCHAR",0.93)
					if IsControlJustPressed(1,38) and timeDismantle <= GetGameTimer() then
						if vSERVER.hasPermission(v[4]) then
							if vSERVER.checkItem() then 
								timeDismantle = GetGameTimer() + 3000
								local dismantle,vehicle,vehName,vehPrice,id,vehNet,vehPlate = vSERVER.checkVehicle()
								if dismantle then
									if vehicle then
										TriggerEvent("Progress","Desmanchando",39000)
										TaskTurnPedToFaceEntity(ped,vehicle,10)
										Wait(1000)
										SetEntityInvincible(ped,true)
										FreezeEntityPosition(ped,true)
										LocalPlayer["state"]["Buttons"] = true 
										LocalPlayer["state"]["Commands"] = true
										FreezeEntityPosition(vehicle,true)
										vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

										for i = 0,5 do
											Wait(3000)
											SetVehicleDoorBroken(vehicle,i,false)
										end

										for i = 0,7 do
											Wait(3000)
											SetVehicleTyreBurst(vehicle,i,1,1000.01)
										end

										vRP.removeObjects()
										SetEntityInvincible(ped,false)
										FreezeEntityPosition(ped,false)
										LocalPlayer["state"]["Buttons"] = false
										LocalPlayer["state"]["Commands"] = false
										vSERVER.paymentMethod(vehicle,vehPrice,vehName,id,vehNet, vehPlate)
									end
								else
									TriggerEvent("Notify","vermelho","Não existe nenhum carro próximo",3000)
								end
							end
						else
							TriggerEvent("Notify","vermelho","Você não tem permissão para isso",3000)
						end
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(listX,listY,listZ))
			if distance <= 2.5 then
				timeDistance = 4
				dwText("~g~E~w~  PARA PEGAR UMA LISTA DE CARROS",0.90)
				if IsControlJustPressed(1,38) and distance <= 1.1 then
					startthreaddesmanche()
					vSERVER.acessList()
					inService = true
				end
			end
		end
		Wait(timeDistance)
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end