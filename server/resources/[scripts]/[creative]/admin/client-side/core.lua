-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("admin",Creative)
vSERVER = Tunnel.getInterface("admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVISIBLABLES
-----------------------------------------------------------------------------------------------------------------------------------------
LocalPlayer["state"]["Spectate"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,Distance)
	ClearAreaOfVehicles(x,y,z,Distance + 0.0,false,false,false,false,false)
	ClearAreaOfEverything(x,y,z,Distance + 0.0,false,false,false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
local unGlitch = GetGameTimer()
AddEventHandler('entityDamaged',function(entity,attacker,weapon,fatal)
    if weapon == GetHashKey("WEAPON_STUNGUN") and unGlitch <= GetGameTimer() then
        if DoesEntityExist(entity) then
            unGlitch = GetGameTimer() + 350
            Wait(350)
vSERVER.TxtEntity(GetEntityModel(entity),GetEntityCoords(entity),GetEntityRotation(entity),GetEntityHeading(entity))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportWay()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		Ped = GetVehiclePedIsUsing(Ped)
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(GetBlipInfoIdCoord(waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(Ped,x,y,height,false,false,false)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(Ped) do
			Wait(1)
		end

		Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(Ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(Ped) do
		Wait(1)
	end

	SetEntityCoordsNoOffset(Ped,x,y,z,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr",function(source,Message)
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetVehiclePedIsUsing(Ped)
		if GetPedInVehicleSeat(Vehicle,-1) == Ped and not IsEntityInAir(Vehicle) then
			local speed = GetEntitySpeed(Vehicle) * 3.6

			if speed >= 10 then
				if not Message[1] then
					SetEntityMaxSpeed(Vehicle,GetVehicleEstimatedMaxSpeed(Vehicle))
					TriggerEvent("Notify","amarelo","Controle de cruzeiro desativado.",3000)
				else
					if parseInt(Message[1]) > 10 then
						SetEntityMaxSpeed(Vehicle,0.28 * Message[1])
						TriggerEvent("Notify","verde","Controle de cruzeiro ativado.",3000)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.teleportLimbo()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	local _,xCoords = GetNthClosestVehicleNode(Coords["x"],Coords["y"],Coords["z"],1,0,0,0)

	SetEntityCoordsNoOffset(Ped,xCoords["x"],xCoords["y"],xCoords["z"] + 1,false,false,false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning",function()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local vehicle = GetVehiclePedIsUsing(Ped)

		SetVehicleModKit(vehicle,0)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11) - 1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12) - 1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13) - 1,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15) - 1,false)
		ToggleVehicleMod(vehicle,18,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)

		LocalPlayer["state"]["Spectate"] = true
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		LocalPlayer["state"]["Spectate"] = false
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RockstarEditor
-----------------------------------------------------------------------------------------------------------------------------------------

-- RegisterCommand("editor", function()
--     -- if not vSERVER.checkPerm(editorPermissao) then return end
--     ActivateRockstarEditor()
-- end)

RegisterCommand("clip", function(source , args)
    -- if not vSERVER.checkPerm(editorPermissao) then return end
    StartRecording(1)
end)

RegisterCommand("saveclip", function(source , args)
    -- if not vSERVER.checkPerm(editorPermissao) then return end
    StopRecordingAndSaveClip()
end)

RegisterCommand("delclip", function(source , args)
    -- if not vSERVER.checkPerm(editorPermissao) then return end
    StopRecordingAndDiscardClip()
end)

RegisterNetEvent("syncarea")
AddEventHandler("syncarea",function(x,y,z,distance)
	ClearAreaOfVehicles(x,y,z,distance + 0.0,false,false,false,false,false)
	ClearAreaOfEverything(x,y,z,distance + 0.0,false,false,false,false)
end)

-- local oldCam = nil
-- local oldVehCam = nil

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if IsPedInAnyVehicle(PlayerPedId()) then
-- 			if IsPlayerFreeAiming(PlayerId()) then
-- 				if oldCam == nil then
-- 					oldCam = GetFollowPedCamViewMode()
-- 				end
-- 				if oldVehCam == nil then
-- 					oldVehCam = GetFollowVehicleCamViewMode()
-- 				end
-- 				SetFollowVehicleCamViewMode(4)
-- 				SetFollowPedCamViewMode(4)
-- 			else
-- 				if oldCam ~= nil then
-- 					SetFollowPedCamViewMode(oldCam)
-- 					oldCam = nil
-- 				end
-- 				if oldVehCam ~= nil then
-- 					SetFollowVehicleCamViewMode(oldVehCam)
-- 					oldVehCam = nil
-- 				end
-- 			end
-- 		else
-- 			if oldCam ~= nil then
-- 				SetFollowPedCamViewMode(oldCam)
-- 				oldCam = nil
-- 			end
-- 			if oldVehCam ~= nil then
-- 				SetFollowVehicleCamViewMode(oldVehCam)
-- 				oldVehCam = nil
-- 			end
-- 		end

-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			vSERVER.buttonTxt()
-- 		end
-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTONMAKERACE
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	while true do
-- 		if IsControlJustPressed(1,38) then
-- 			local Ped = PlayerPedId()
-- 			local vehicle = GetVehiclePedIsUsing(Ped)
-- 			local vehCoords = GetEntityCoords(vehicle)
-- 			local leftCoords = GetOffsetFromEntityInWorldCoords(vehicle,5.0,0.0,0.0)
-- 			local rightCoords = GetOffsetFromEntityInWorldCoords(vehicle,-5.0,0.0,0.0)

-- 			vSERVER.raceCoords(vehCoords,leftCoords,rightCoords)
-- 		end

-- 		Wait(1)
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:INITSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:initSpectate")
AddEventHandler("admin:initSpectate",function(source)
	if not NetworkIsInSpectatorMode() then
		local Pid = GetPlayerFromServerId(source)
		local Ped = GetPlayerPed(Pid)

		LocalPlayer["state"]["Spectate"] = true
		NetworkSetInSpectatorMode(true,Ped)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:RESETSPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:resetSpectate")
AddEventHandler("admin:resetSpectate",function()
	if NetworkIsInSpectatorMode() then
		NetworkSetInSpectatorMode(false)
		LocalPlayer["state"]["Spectate"] = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local debugProp = false
RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug",function()
	debugProp = not debugProp
    if debugProp then
        TriggerEvent('chatME',"DEBUG ON")
		Citizen.CreateThread( function()

			while debugProp do 
				Citizen.Wait(1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
	
				local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
				local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
				local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
				local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 
	
				local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
				local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
				local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
				local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    
	
				local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
				currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	
				drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
				drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
				drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
				drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
				
				
				DrawLine(pos,forPos, 255,0,0,115)
				DrawLine(pos,backPos, 255,0,0,115)
	
				DrawLine(pos,LPos, 255,255,0,115)
				DrawLine(pos,RPos, 255,255,0,115)
	
				DrawLine(forPos,forPos2, 255,0,255,115)
				DrawLine(backPos,backPos2, 255,0,255,115)
	
				DrawLine(LPos,LPos2, 255,255,255,115)
				DrawLine(RPos,RPos2, 255,255,255,115)
	
				local nearped = getNPC()
	
				local veh = GetVehicle()
	
				local nearobj = GetObject()
	
				if IsControlJustReleased(0, 38) then
					if inFreeze then
						inFreeze = false
						--TriggerEvent("DoShortHudText",'Freeze Disabled',3)
						vRP.notify("Freeze Disabled")
					else
						inFreeze = true             
						--TriggerEvent("DoShortHudText",'Freeze Enabled',3)
						vRP.notify("Freeze Enabled")
					end
				end
			end
		end)
    else
        TriggerEvent('chatME',"DEBUG OFF")
    end
end)


function drawTxtS(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

local inFreeze = false

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
           -- FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end


local UseFps = false
RegisterCommand("fps",function()
	if UseFps then
		UseFps = false
		SetTimecycleModifier()
		ClearTimecycleModifier()
		ClearExtraTimecycleModifier()

		TriggerEvent("Notify","Otimização","Sistema desativado.","amarelo",5000)
	else
		UseFps = true
		local Ped = PlayerPedId()

		ClearBrief()
		ClearFocus()
		ClearPrints()
		ClearHdArea()
		ClearGpsFlags()
		SetRainLevel(0.0)
		SetWindSpeed(0.0)
		ClearSmallPrints()
		ClearReplayStats()
		ClearPedWetness(Ped)
		ClearPedEnvDirt(Ped)
		ClearAllBrokenGlass()
		ClearOverrideWeather()
		ClearAllHelpMessages()
		DisableScreenblurFade()
		ClearPedBloodDamage(Ped)
		ResetPedVisibleDamage(Ped)
		LeaderboardsReadClearAll()
		LeaderboardsClearCacheData()
		SetTimecycleModifier("yell_tunnel_nodirect")

		TriggerEvent("Notify","Otimização","Sistema ativado.","amarelo",5000)
	end
end)

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local veh
		local vehType
		if not IsPedInAnyVehicle(ped,true) then goto keepWaiting end

		veh = GetVehiclePedIsEntering(ped)
		if veh == 0 then goto keepWaiting end

		vehType = vSERVER.getVehType(NetworkGetNetworkIdFromEntity(veh))
		if vehType ~= 'heli' and vehType ~= 'plane' then goto keepWaiting end

		if not vSERVER.hasPerm('Police') and not vSERVER.hasPerm('Paramedic') then
			vSERVER.globalLeaveVehicle(NetworkGetNetworkIdFromEntity(ped),NetworkGetNetworkIdFromEntity(veh))
		end

		::keepWaiting::
		Wait(750)
	end
end)

local vehTypeDamage = {
	automobile = 1.5,
	bike = 1.0,
	boat = 1.5,
	heli = 1.5,
	plane = 1.5,
	submarine = 1.5,
	trailer = 1.5,
	train = 1.5
}

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local veh = GetVehiclePedIsIn(ped)
		if veh ~= 0 then
			SetVehicleDamageModifier(veh,vehTypeDamage[vSERVER.getVehType(NetworkGetNetworkIdFromEntity(veh))])
			SetPlayerVehicleDamageModifier(PlayerId(),vehTypeDamage[vSERVER.getVehType(NetworkGetNetworkIdFromEntity(veh))])
		end
		Wait(1000)
	end
end)