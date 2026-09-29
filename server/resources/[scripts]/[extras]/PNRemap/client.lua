-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("PNRemap")
vCLIENT = {}
Tunnel.bindInterface("PNRemap",vCLIENT)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Particle = "veh_xs_vehicle_mods"
local Exhausts = { "exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5", "exhaust_6", "exhaust_7", "exhaust_8", "exhaust_9", "exhaust_10", "exhaust_11", "exhaust_12", "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16" }
local FxName = "veh_backfire"
local FxGroup = "core"
local IsCutting = false
local CuttingVehicles = {}
local LastUpdate = 0
local UpdateInterval = 150
local PanelOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISNETWORKIDVALID
-----------------------------------------------------------------------------------------------------------------------------------------
local function IsNetworkIdValid(NetworkId)
	if not NetworkId or NetworkId == 0 then
		return false
	end

	if not NetworkDoesNetworkIdExist(NetworkId) then
		return false
	end

	local Entity = NetToVeh(NetworkId)
	return Entity and Entity ~= 0 and DoesEntityExist(Entity)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAFENETTOVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local function SafeNetToVeh(NetworkId)
	if not IsNetworkIdValid(NetworkId) then
		return nil
	end

	return NetToVeh(NetworkId)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISVEHICLEBLACKLISTED
-----------------------------------------------------------------------------------------------------------------------------------------
local function IsVehicleBlacklisted(Vehicle)
	if not Vehicle or Vehicle == 0 or not DoesEntityExist(Vehicle) then
		return true
	end

	local VehicleModel = GetEntityModel(Vehicle)
	for _,v in pairs(Config.BlacklistedCars) do
		if GetHashKey(v) == VehicleModel then
			return true
		end
	end

	local VehicleClass = GetVehicleClass(Vehicle)
	for _,v in pairs(Config.BlacklistedCarsClass) do
		if v == VehicleClass then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local function RemoveVehicle(NetworkId)
	for i = #CuttingVehicles, 1, -1 do
		if CuttingVehicles[i] and CuttingVehicles[i].NetworkId == tonumber(NetworkId) then
			table.remove(CuttingVehicles, i)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCLIENT.REMOVECUTTINGVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vCLIENT.RemoveCuttingVehicle(NetworkId)
	RemoveVehicle(NetworkId)

	local Vehicle = SafeNetToVeh(NetworkId)
	if Vehicle then
		SetVehicleNitroEnabled(Vehicle, false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCLIENT.SETVEHICLECUTTING
-----------------------------------------------------------------------------------------------------------------------------------------
function vCLIENT.SetVehicleCutting(NetworkId, State, Type)
	if not IsNetworkIdValid(NetworkId) then
		return false
	end

	if State then
		for _,v in pairs(CuttingVehicles) do
			if v.NetworkId == tonumber(NetworkId) then
				v.State = State
				v.Type = Type
				return true
			end
		end

		local Vehicle = SafeNetToVeh(NetworkId)
		if Vehicle then
			table.insert(CuttingVehicles, {
				State = State,
				Type = Type,
				NetworkId = tonumber(NetworkId)
			})
			return true
		end
	else
		return RemoveVehicle(NetworkId)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCLIENT.REMOVECAMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vCLIENT.RemoveCams()
	RenderScriptCams(false, 1, 1500, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCLOSESTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local function GetClosestVehicle(Coords)
	local Vehicles = GetGamePool("CVehicle")
	local ClosestDistance = -1
	local ClosestVehicle = -1

	for i = 1, #Vehicles do
		local Vehicle = Vehicles[i]
		if DoesEntityExist(Vehicle) then
			local VehicleCoords = GetEntityCoords(Vehicle)
			local Distance = #(VehicleCoords - Coords)

			if ClosestDistance == -1 or ClosestDistance > Distance then
				ClosestVehicle = Vehicle
				ClosestDistance = Distance
			end
		end
	end

	return ClosestVehicle, ClosestDistance
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIFPOSSIBLEINSTALLREMAP
-----------------------------------------------------------------------------------------------------------------------------------------
local function CheckIfPossibleInstallRemap(Vehicle)
	if not Vehicle or Vehicle == 0 or not DoesEntityExist(Vehicle) then
		return false
	end

	return not IsVehicleBlacklisted(Vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCLIENT.INSTALLREMAP
-----------------------------------------------------------------------------------------------------------------------------------------
function vCLIENT.InstallRemap()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local ClosestVehicle, ClosestDistance = GetClosestVehicle(Coords)

	if ClosestDistance < Config.InstallDist then
		if CheckIfPossibleInstallRemap(ClosestVehicle) then
			local Plate = GetVehicleNumberPlateText(ClosestVehicle)
			if not vSERVER.CheckIfVehicleAsRemap(Plate) then
				local NetworkId = VehToNet(ClosestVehicle)
				if NetworkId and NetworkId ~= 0 then
					return vSERVER.RequestInstallRemap(NetworkId)
				end
			end
			Config.Functions.notifyC(Config.RedNotify, "Erro ao instalar central!", "O veículo já possui a Central ATHLON!", 5000)
			return
		end
		Config.Functions.notifyC(Config.RedNotify, "Erro ao instalar central!", "Não é possivel instalar a Central nesse tipo de veículo!", 5000)
		return
	end
end

function vCLIENT.InstallRemapFree()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local ClosestVehicle, ClosestDistance = GetClosestVehicle(Coords)

	if ClosestDistance < Config.InstallDist then
		if CheckIfPossibleInstallRemap(ClosestVehicle) then
			local Plate = GetVehicleNumberPlateText(ClosestVehicle)
			if not vSERVER.CheckIfVehicleAsRemap(Plate) then
				local NetworkId = VehToNet(ClosestVehicle)
				if NetworkId and NetworkId ~= 0 then
					return vSERVER.ForceInstallRemap(NetworkId)
				end
			end
			Config.Functions.notifyC(Config.RedNotify, "Erro ao instalar central!", "O veículo já possui a Central ATHLON!", 5000)
			return
		end
		Config.Functions.notifyC(Config.RedNotify, "Erro ao instalar central!", "Não é possivel instalar a Central nesse tipo de veículo!", 5000)
		return
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYSYNCSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
local function PlaySyncSound(Coords, DisMax, AudioFile, AudioVol)
	local Ped = PlayerPedId()
	local EntityCoords = GetEntityCoords(Ped)
	local Distance = #(EntityCoords - Coords)

	if Distance > DisMax then
		return
	end

	local DistanceRatio = math.max(0.1, Distance / DisMax)
	local AdjustedVolume = AudioVol / DistanceRatio
	AdjustedVolume = math.max(0.0, math.min(1.0, AdjustedVolume))

	SendNUIMessage({
		transactionType = "playSound",
		transactionFile = tostring(AudioFile),
		transactionVolume = AdjustedVolume
	})
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD CUTTING
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CuttingStartTime = 0
	local EventSend = false

	while true do
		local TimeDistance = 500
		local Ped = PlayerPedId()
		local Vehicle = GetVehiclePedIsIn(Ped, false)

		if Vehicle and Vehicle ~= 0 and DoesEntityExist(Vehicle) then
			local Driver = GetPedInVehicleSeat(Vehicle, -1)

			if Driver == Ped then
				if not IsVehicleBlacklisted(Vehicle) then
					TimeDistance = 50
					local RPM = GetVehicleCurrentRpm(Vehicle)
					local CurrentTime = GetGameTimer()
					local CanUpdate = (CurrentTime - LastUpdate) >= UpdateInterval

					if not IsControlPressed(1, 71) and not IsControlPressed(1, 72) then
						if RPM >= Config.RPM then
							if not IsCutting and CanUpdate then
								LastUpdate = CurrentTime
								IsCutting = true
								local NetworkId = VehToNet(Vehicle)
								if NetworkId and NetworkId ~= 0 then
									vSERVER._SetVehicleCutting(NetworkId, true, "default")
								end
								SetVehicleTurboPressure(Vehicle, 25)
							end
						elseif RPM < Config.RPM and IsCutting then
							if CanUpdate then
								LastUpdate = CurrentTime
								IsCutting = false
								local NetworkId = VehToNet(Vehicle)
								if NetworkId and NetworkId ~= 0 then
									vSERVER._SetVehicleCutting(NetworkId, false, "remove")
								end
								SetVehicleTurboPressure(Vehicle, 0)
							end
						end
					elseif (IsControlPressed(1, 71) and IsControlPressed(1, 72)) or (IsControlPressed(1, 71) and IsControlPressed(1, 76)) then
						if not IsCutting then
							CuttingStartTime = CurrentTime
							IsCutting = true
							EventSend = false
						else
							local ElapsedTime = CurrentTime - CuttingStartTime
							if ElapsedTime >= (1000 * Config.MaxNitroTime) and not EventSend and CanUpdate then
								EventSend = true
								LastUpdate = CurrentTime
								local NetworkId = VehToNet(Vehicle)
								if NetworkId and NetworkId ~= 0 then
									vSERVER._SetVehicleCutting(NetworkId, true, "nitro")
								end
								SetVehicleTurboPressure(Vehicle, 25)
							end
						end
					elseif IsControlPressed(1, 71) and not IsControlPressed(1, 72) and not IsControlPressed(1, 76) and IsCutting then
						if CanUpdate then
							LastUpdate = CurrentTime
							IsCutting = false
							local NetworkId = VehToNet(Vehicle)
							if NetworkId and NetworkId ~= 0 then
								vSERVER._SetVehicleCutting(NetworkId, false, "remove")
							end
						end
					end
				end
			end
		else
			if IsCutting then
				IsCutting = false
				EventSend = false
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD EFFECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 250
		local Ped = PlayerPedId()
		local PlayerCoords = GetEntityCoords(Ped)
		local ToRemove = {}

		for k, v in pairs(CuttingVehicles) do
			local NetworkId = v.NetworkId

			if not IsNetworkIdValid(NetworkId) then
				ToRemove[#ToRemove + 1] = NetworkId
			else
				local Vehicle = SafeNetToVeh(NetworkId)

				if Vehicle and DoesEntityExist(Vehicle) then
					local VehCoords = GetEntityCoords(Vehicle)
					local Distance = #(PlayerCoords - VehCoords)

					if Distance <= Config.MaxDistance then
						local IsEngineRunning = GetIsVehicleEngineRunning(Vehicle)
						local Driver = GetPedInVehicleSeat(Vehicle, -1)

						if IsEngineRunning and Driver and Driver ~= 0 then
							if v.Type == "nitro" then
								RemoveNamedPtfxAsset(Particle)
								RequestNamedPtfxAsset(Particle)
								RequestPtfxAsset(Particle)
								SetVehicleNitroEnabled(Vehicle, v.State)
								PlaySyncSound(VehCoords, Config.MaxDistance, math.random(0, 3), Config.AudioVolume)
							else
								for _, Bone in pairs(Exhausts) do
									local BoneIndex = GetEntityBoneIndexByName(Vehicle, Bone)
									if BoneIndex ~= -1 then
										UseParticleFxAssetNextCall(FxGroup)
										PlaySyncSound(VehCoords, Config.MaxDistance, math.random(0, 3), Config.AudioVolume)
										local StartParticle = StartParticleFxLoopedOnEntityBone(FxName, Vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, BoneIndex, Config.flameSize, 0.0, 0.0, 0.0)
										StopParticleFxLooped(StartParticle, true)
									end
								end
							end
						end
					end
				else
					ToRemove[#ToRemove + 1] = NetworkId
				end
			end
		end

		for _, NetworkId in ipairs(ToRemove) do
			RemoveVehicle(NetworkId)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD CLEANUP
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(5000)

		local ToRemove = {}
		for _, v in pairs(CuttingVehicles) do
			if not IsNetworkIdValid(v.NetworkId) then
				ToRemove[#ToRemove + 1] = v.NetworkId
			end
		end

		for _, NetworkId in ipairs(ToRemove) do
			RemoveVehicle(NetworkId)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VCLIENT.SYNCFLAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vCLIENT.SyncFlames(Vehicle, Enabled)
	if not Vehicle or Vehicle == 0 or not DoesEntityExist(Vehicle) then
		return
	end

	RemoveNamedPtfxAsset(Particle)
	if Enabled then
		SetVehicleBoostActive(Vehicle, true)
	end
	RequestNamedPtfxAsset(Particle)
	RequestPtfxAsset(Particle)
	SetVehicleNitroEnabled(Vehicle, Enabled)
end

RegisterCommand("pnremap", function()
	vCLIENT.InstallRemapFree()
end)

local function CloseAthlonPanel()
	PanelOpen = false
	SetNuiFocus(false, false)
	SendNUIMessage({ transactionType = "hidePanel" })
end

local function OpenAthlonPanel()
	PanelOpen = true
	SetNuiFocus(true, true)
	SendNUIMessage({ transactionType = "showPanel" })
end

RegisterNUICallback("closePanel", function(_, cb)
	CloseAthlonPanel()
	if cb then
		cb({})
	end
end)

RegisterCommand("pnpainel", function()
	local Ped = PlayerPedId()
	local Vehicle = GetVehiclePedIsIn(Ped, false)
	if Vehicle == 0 then
		Config.Functions.notifyC(Config.RedNotify, "Painel ATHLON", "Entre em um veículo para abrir o painel.", 5000)
		return
	end

	if PanelOpen then
		CloseAthlonPanel()
	else
		OpenAthlonPanel()
	end
end)

CreateThread(function()
	while true do
		local TimeDistance = 1000

		if PanelOpen then
			TimeDistance = 200
			local Ped = PlayerPedId()
			local Vehicle = GetVehiclePedIsIn(Ped, false)

			if Vehicle ~= 0 and DoesEntityExist(Vehicle) then
				local RPM = math.floor(GetVehicleCurrentRpm(Vehicle) * 100)
				local Turbo = GetVehicleTurboPressure(Vehicle) or 0.0
				local Speed = math.floor(GetEntitySpeed(Vehicle) * 3.6)
				local Gear = GetVehicleCurrentGear(Vehicle)
				local NetworkId = VehToNet(Vehicle)
				local HasNitro = false

				for _,v in pairs(CuttingVehicles) do
					if v.NetworkId == tonumber(NetworkId) and v.Type == "nitro" and v.State then
						HasNitro = true
						break
					end
				end

				SendNUIMessage({
					transactionType = "panelData",
					rpmPercent = RPM,
					turbo = Turbo,
					speed = Speed,
					gear = Gear > 0 and Gear or "N",
					nitro = HasNitro,
					status = IsCutting and "ACTIVE" or "READY"
				})
			else
				CloseAthlonPanel()
			end
		end

		Wait(TimeDistance)
	end
end)
