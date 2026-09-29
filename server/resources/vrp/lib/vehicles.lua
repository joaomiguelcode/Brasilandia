-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPATIBILIDADE: VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
local content = LoadResourceFile("vrp", "config/Vehicle.lua")
if content then
	local fn, err = load(content)
	if fn then
		fn()
	else
		print("^1[vRP] Erro ao carregar config/Vehicle.lua: " .. tostring(err) .. "^7")
	end
end

if not vehicleName and VehicleName then
	vehicleName = VehicleName
end
if not vehicleChest and VehicleChest then
	vehicleChest = VehicleChest
end
if not vehiclePrice and VehiclePrice then
	vehiclePrice = VehiclePrice
end
if not vehicleMode and VehicleMode then
	vehicleMode = VehicleMode
end
if not vehicleGems and VehicleGems then
	vehicleGems = VehicleGems
end
