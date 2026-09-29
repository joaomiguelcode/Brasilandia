-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Bed"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:BedDeitar")
AddEventHandler("target:BedDeitar",function()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local Object = GetClosestObjectOfType(Coords,1.0,-935625561,0,0,0)
	if DoesEntityExist(Object) then
		Coords = GetEntityCoords(Object)
		SetEntityCoords(Ped,Coords,false,false,false,false)
		SetEntityHeading(Ped,GetEntityHeading(Object) - 180.0)
		vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
		AttachEntityToEntity(Ped,Object,11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
		LocalPlayer["state"]["Bed"] = Object
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:BedPickup")
AddEventHandler("target:BedPickup",function(Selected)
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local Ped = PlayerPedId()
		if GetEntityHealth(Ped) > 100 then
			local uObject = NetworkGetEntityFromNetworkId(Selected[3])
			local objectControl = NetworkRequestControlOfEntity(uObject)
			while not objectControl do
				objectControl = NetworkRequestControlOfEntity(uObject)
				Wait(1)
			end

			AttachEntityToEntity(uObject,Ped,11816,0.0,1.25,-0.15,0.0,0.0,0.0,false,false,false,false,2,true)
			LocalPlayer["state"]["Bed"] = Selected[1]
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:UPBED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:UpBed")
AddEventHandler("target:UpBed",function()
	if LocalPlayer["state"]["Bed"] then
		DetachEntity(PlayerPedId(),false,false)
		FreezeEntityPosition(LocalPlayer["state"]["Bed"],true)
		DetachEntity(LocalPlayer["state"]["Bed"],false,false)
		LocalPlayer["state"]["Bed"] = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:BedDestroy")
AddEventHandler("target:BedDestroy",function(Selected)
	if not LocalPlayer["state"]["Commands"] and LocalPlayer["state"]["Paramedic"] then
		TriggerServerEvent("DeleteObject",Selected[3])
	end
end)