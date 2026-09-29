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
Tunnel.bindInterface("survival",Creative)
vSERVER = Tunnel.getInterface("survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Death = false
local timeToRespawn = 300
local DeathTimer = 300
local Cooldown = 0
local NextDeathAnim = 0
local NextHealthSync = 0
local NextVehicleCheck = 0
local DeathAnim = {
	Dict = "misstrevor3_beatup",
	Name = "guard_beatup_exit_dockworker"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHINTERACT
-----------------------------------------------------------------------------------------------------------------------------------------
local function HandleDeathInteract()
	if not Death or not LocalPlayer["state"]["Active"] then
		return
	end

	if LocalPlayer["state"]["Route"] > 900000 then
		TriggerEvent("arena:ResetStreek")
		TriggerEvent("arena:Respawn")
		return
	end

	if DeathTimer <= 0 and Creative.CheckDeath() then
		ExecuteCommand("gg")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+survivalDeathInteract",function()
	HandleDeathInteract()
end,false)

RegisterCommand("-survivalDeathInteract",function()
end,false)

RegisterKeyMapping("+survivalDeathInteract","Interagir enquanto desacordado","keyboard","E")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADDEATHANIM
-----------------------------------------------------------------------------------------------------------------------------------------
local function LoadDeathAnim()
	if not HasAnimDictLoaded(DeathAnim.Dict) then
		RequestAnimDict(DeathAnim.Dict)

		while not HasAnimDictLoaded(DeathAnim.Dict) do
			Wait(1)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTERDEATHSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local function EnterDeathState(Ped)
	local Coords = GetEntityCoords(Ped)
	local Route = LocalPlayer["state"]["Route"]

	Death = true
	timeToRespawn = vSERVER.timeToRespawn() or 300
	DeathTimer = Route < 900000 and timeToRespawn or 5
	Cooldown = GetGameTimer() + 1000
	NextDeathAnim = 0
	NextHealthSync = 0
	NextVehicleCheck = 0

	LoadDeathAnim()
	NetworkResurrectLocalPlayer(Coords["x"],Coords["y"],Coords["z"],GetEntityHeading(Ped),0,false)
	SetPlayerControl(PlayerId(),true,0)
	FreezeEntityPosition(Ped,false)
	vRP.stopAnim(false)
	ClearPedSecondaryTask(Ped)
	ClearPedTasksImmediately(Ped)
	SetPedCanRagdoll(Ped,false)
	SetEntityHealth(Ped,100)
	SetEntityInvincible(Ped,false)
	NetworkSetFriendlyFireOption(false)
	LocalPlayer["state"]["Invincible"] = true

	if Route < 900000 then
		TriggerEvent("hud:RemoveHood")
		TriggerEvent("hud:ScubaRemove")
		TriggerEvent("radio:RadioClean")
		TriggerEvent("inventory:Cancel")
		TriggerEvent("inventory:CleanWeapons")
		TriggerServerEvent("paramedic:bloodDeath")
		TriggerEvent("pma-voice:MutePlayer")
		exports["pma-voice"]:Mute(true)
		MumbleSetActive(false)
	end

	SendNUIMessage({ Action = "Display", Mode = "block" })
	TriggerEvent("inventory:preventWeapon",false)
	TriggerEvent("inventory:Close")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXITDEATHSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local function ExitDeathState(Ped,Health,Arena)
	local Coords = GetEntityCoords(Ped)

	Death = false
	DeathTimer = timeToRespawn
	NextDeathAnim = 0
	NextHealthSync = 0
	NextVehicleCheck = 0

	NetworkResurrectLocalPlayer(Coords["x"],Coords["y"],Coords["z"],GetEntityHeading(Ped),0,false)
	SetPlayerControl(PlayerId(),true,0)
	FreezeEntityPosition(Ped,false)
	vRP.stopAnim(false)
	ClearPedSecondaryTask(Ped)
	ClearPedTasksImmediately(Ped)
	SetPedCanRagdoll(Ped,true)
	NetworkSetFriendlyFireOption(true)
	SetEntityInvincible(Ped,false)
	LocalPlayer["state"]["Invincible"] = false
	LocalPlayer["state"]["Target"] = false
	LocalPlayer["state"]["Commands"] = false
	LocalPlayer["state"]["Cancel"] = false

	if Health then
		SetEntityHealth(Ped,Health)
	end

	if Arena then
		SetPedArmour(Ped,99)
	end

	SendNUIMessage({ Action = "Display", Mode = "none" })
	TriggerServerEvent("bodycam:ForceOff")

	if LocalPlayer["state"]["Route"] < 900000 then
		TriggerEvent("paramedic:Reset")
		exports["pma-voice"]:Mute(false)
		TriggerEvent("pma-voice:DesmutePlayer")
		MumbleSetActive(true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEEPDEATHANIM
-----------------------------------------------------------------------------------------------------------------------------------------
local function KeepDeathAnim(Ped)
	if LocalPlayer["state"]["Bed"] or LocalPlayer["state"]["Rope"] then
		return
	end

	if IsPedInAnyVehicle(Ped) then
		return
	end

	if IsEntityPlayingAnim(Ped,"nm","firemans_carry",3) then
		return
	end

	if GetGameTimer() < NextDeathAnim then
		return
	end

	if not IsEntityPlayingAnim(Ped,DeathAnim.Dict,DeathAnim.Name,3) then
		NextDeathAnim = GetGameTimer() + 1000
		TaskPlayAnim(Ped,DeathAnim.Dict,DeathAnim.Name,8.0,-8.0,-1,1,0,false,false,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLEDEATHCONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
local function DisableDeathControls(Ped)
	DisableAllControlActions(0)
	EnableControlAction(0,1,true)
	EnableControlAction(0,2,true)
	EnableControlAction(0,199,true)
	EnableControlAction(0,200,true)
	EnableControlAction(0,245,true)
	DisablePlayerFiring(Ped,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 500

		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			local Health = GetEntityHealth(Ped)

			if Death then
				if Health > 100 then
					ExitDeathState(Ped,Health)
				end
			elseif Health <= 100 then
				EnterDeathState(Ped)
				KeepDeathAnim(Ped)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1000

		if Death then
			TimeDistance = 1
			DisableDeathControls(PlayerPedId())
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMAINTENANCE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1500

		if Death and LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			local Timer = GetGameTimer()

			if Timer >= NextHealthSync then
				NextHealthSync = Timer + 1500
				if GetEntityHealth(Ped) ~= 100 then
					SetEntityHealth(Ped,100)
				end
			end

			KeepDeathAnim(Ped)

			if Timer >= NextVehicleCheck then
				NextVehicleCheck = Timer + 750

				if IsPedInAnyVehicle(Ped) then
					local Vehicle = GetVehiclePedIsUsing(Ped)
					if Vehicle ~= 0 and GetPedInVehicleSeat(Vehicle,-1) == Ped then
						SetVehicleEngineOn(Vehicle,false,true,true)
					end
				end
			end

			if Timer >= Cooldown then
				Cooldown = Timer + 1000

				if DeathTimer >= 0 then
					DeathTimer = DeathTimer - 1
					SendNUIMessage({ Action = "Message", Message = "Voce esta inconsciente, aguarde <color>"..DeathTimer.." segundos</color> para desistir" })

					if DeathTimer <= 0 then
						if LocalPlayer["state"]["Route"] < 900000 then
							SendNUIMessage({ Action = "Message", Message = "Pressione <color>E</color> para desistir imediatamente" })
						else
							SendNUIMessage({ Action = "Message", Message = "Pressione <color>E</color> para renascer dentro da arena" })
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckDeath()
	return Death and DeathTimer <= 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Respawn()
	local Ped = PlayerPedId()

	ExitDeathState(Ped,200)
	ClearPedBloodDamage(Ped)
	TriggerEvent("paramedic:Reset")
	TriggerEvent("inventory:CleanWeapons")
	LocalPlayer["state"]["Handcuff"] = false
	exports["pma-voice"]:Mute(false)
	TriggerEvent("pma-voice:DesmutePlayer")
	MumbleSetActive(true)

	DoScreenFadeOut(0)
	SetEntityCoords(Ped,361.56,-580.48,29.83)
	Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Revive",function(Health,Arena)
	local Ped = PlayerPedId()

	if Death or GetEntityHealth(Ped) <= 100 then
		ExitDeathState(Ped,Health,Arena)
	else
		if Health then
			SetEntityHealth(Ped,Health)
		end

		if Arena then
			SetPedArmour(Ped,99)
		end

		SetEntityInvincible(Ped,false)
		LocalPlayer["state"]["Invincible"] = false
		LocalPlayer["state"]["Target"] = false
		LocalPlayer["state"]["Commands"] = false
		LocalPlayer["state"]["Cancel"] = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Revive(Health,Arena)
	local Ped = PlayerPedId()

	if Death or GetEntityHealth(Ped) <= 100 then
		ExitDeathState(Ped,Health,Arena)
	else
		if Health then
			SetEntityHealth(Ped,Health)
		end

		if Arena then
			SetPedArmour(Ped,99)
		end

		SetEntityInvincible(Ped,false)
		LocalPlayer["state"]["Invincible"] = false
		LocalPlayer["state"]["Target"] = false
		LocalPlayer["state"]["Commands"] = false
		LocalPlayer["state"]["Cancel"] = false
	end
end
