-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.ClosestVehicle(Radius)
	local Selected = false
	local Ped = PlayerPedId()
	local Radius = Radius + 0.0001
	local Coords = GetEntityCoords(Ped)
	local GamePool = GetGamePool("CVehicle")

	for _,Entity in pairs(GamePool) do
		local EntityCoords = GetEntityCoords(Entity)
		local EntityDistance = #(Coords - EntityCoords)

		if EntityDistance < Radius then
			Selected = Entity
			Radius = EntityDistance
		end
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleList(Radius)
	local Vehicle = nil
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Vehicle = GetVehiclePedIsUsing(Ped)
	else
		Vehicle = tvRP.ClosestVehicle(Radius)
	end

	if IsEntityAVehicle(Vehicle) then
		local Network = VehToNet(Vehicle)
		local Class = GetVehicleClass(Vehicle)
		local Model = GetEntityArchetypeName(Vehicle)
		local Plate = GetVehicleNumberPlateText(Vehicle)

		return Vehicle,Network,Plate,Model,Class
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleName()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)

		return GetEntityArchetypeName(Vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.VehicleModel(Vehicle)
	return GetEntityArchetypeName(Vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LASTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.LastVehicle(Name)
	local Vehicle = GetLastDrivenVehicle()
	if DoesEntityExist(Vehicle) and Name == GetEntityArchetypeName(Vehicle) then
		return true
	end

	return false
end