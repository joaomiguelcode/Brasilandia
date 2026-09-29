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
local Cooldown = GetGameTimer()
local nextDeathAnimTry = 0
local wasInRagdoll = false  -- Rastreia se estava em ragdoll no frame anterior
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999

		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()
			if GetEntityHealth(Ped) <= 100 then
			if not Death then
				Death = true
				wasInRagdoll = false  -- Reseta o estado de ragdoll

				timeToRespawn = vSERVER.timeToRespawn() or 300

				local Coords = GetEntityCoords(Ped)
				NetworkResurrectLocalPlayer(Coords,0.0)

				NetworkSetFriendlyFireOption(false)
				LocalPlayer["state"]["Invincible"] = true
				SetEntityInvincible(Ped,false)
				SetEntityHealth(Ped,100)

				-- Carrega o dicionário de animação uma única vez
				if not HasAnimDictLoaded("misstrevor3_beatup") then
					RequestAnimDict("misstrevor3_beatup")
				end

				if LocalPlayer["state"]["Route"] < 900000 then
					DeathTimer = timeToRespawn

					TriggerEvent("hud:RemoveHood")
					TriggerEvent("hud:ScubaRemove")
					TriggerEvent("radio:RadioClean")
					TriggerEvent("inventory:Cancel") 
					TriggerEvent("inventory:CleanWeapons")
					TriggerServerEvent("paramedic:bloodDeath")
					TriggerEvent("pma-voice:MutePlayer")
					exports["pma-voice"]:Mute(true)
					MumbleSetActive(false)
				else
					DeathTimer = 5
				end

				SendNUIMessage({ Action = "Display", Mode = "block" })
				TriggerEvent("inventory:preventWeapon",false)
				-- vRP.playAnim(false,{"dead","dead_a"},true)
				vRP.playAnim(false,{"misstrevor3_beatup","guard_beatup_exit_dockworker"},true)
				TriggerEvent("inventory:Close")
			else
				-- Se vida foi restaurada (ex: good/revive) mas a thread ainda tinha Death = true, sai do estado de morte
				if GetEntityHealth(Ped) > 100 then
					Death = false
					DeathTimer = timeToRespawn
					wasInRagdoll = false
					ClearPedTasks(Ped)
					NetworkSetFriendlyFireOption(true)
					LocalPlayer["state"]["Target"] = false
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					if LocalPlayer["state"]["Route"] < 900000 then
						TriggerEvent("paramedic:Reset")
						exports["pma-voice"]:Mute(false)
						TriggerEvent("pma-voice:DesmutePlayer")
						MumbleSetActive(true)
					end
				else
				TimeDistance = 1  -- Precisa ser 1 para desabilitar controles constantemente
				
				-- Garante que o ped mantém HP 100
				SetEntityHealth(Ped,100)

				-- Desabilita controles (necessário a cada frame)
				DisableControlAction(1,18,true)
				DisableControlAction(1,22,true)
				DisableControlAction(1,24,true)
				DisableControlAction(1,25,true)
				DisableControlAction(1,68,true)
				DisableControlAction(1,70,true)
				DisableControlAction(1,91,true)
				DisableControlAction(1,69,true)
				DisableControlAction(1,75,true)
				DisableControlAction(1,140,true)
				DisableControlAction(1,142,true)
				DisableControlAction(1,257,true)
				DisablePlayerFiring(Ped,true)

				-- Detecta se está em ragdoll AGORA
				local isCurrentlyRagdoll = IsPedRagdoll(Ped)
				
				-- Detecta se SAIU do ragdoll (estava em ragdoll mas não está mais)
				local justExitedRagdoll = wasInRagdoll and not isCurrentlyRagdoll
				
				-- Atualiza o estado para o próximo frame
				wasInRagdoll = isCurrentlyRagdoll

				-- Mantém a animação
				-- Verifica periodicamente OU quando acabou de sair do ragdoll
				local shouldCheckAnim = GetGameTimer() >= nextDeathAnimTry or justExitedRagdoll
				
				if shouldCheckAnim then
					if not justExitedRagdoll then
						nextDeathAnimTry = GetGameTimer() + 500  -- Próxima verificação em 500ms
					else
						nextDeathAnimTry = GetGameTimer() + 100  -- Se saiu do ragdoll, verifica mais rápido
					end
					
					-- Verifica se deve aplicar a animação
					if HasAnimDictLoaded("misstrevor3_beatup")
						and not LocalPlayer["state"]["Bed"]
						and not LocalPlayer["state"]["Rope"]
						and not IsPedInAnyVehicle(Ped)
						and not IsEntityPlayingAnim(Ped,"nm","firemans_carry",3)
						and not isCurrentlyRagdoll
					then
						-- Se acabou de sair do ragdoll, FORÇA sem verificar
						-- Caso contrário, só aplica se não estiver tocando
						local needsAnim = justExitedRagdoll or not IsEntityPlayingAnim(Ped,"misstrevor3_beatup","guard_beatup_exit_dockworker",3)
						
						if needsAnim then
							-- Ressuscita se necessário (após atropelamento)
							if GetEntityHealth(Ped) ~= 100 then
								NetworkResurrectLocalPlayer(GetEntityCoords(Ped),0.0)
								SetEntityHealth(Ped,100)
							end
							
							-- Se acabou de sair do ragdoll, limpa tasks completamente
							if justExitedRagdoll then
								ClearPedTasksImmediately(Ped)
							end
							
							-- Aplica a animação
							TaskPlayAnim(Ped,"misstrevor3_beatup","guard_beatup_exit_dockworker",8.0,-8.0,-1,1,0,false,false,false)
						end
					end
				end

					if IsPedInAnyVehicle(Ped) then
						local Vehicle = GetVehiclePedIsUsing(Ped)
						if GetPedInVehicleSeat(Vehicle,-1) == Ped then
							SetVehicleEngineOn(Vehicle,false,true,true)
						end
					end

					if LocalPlayer["state"]["Route"] > 900000 and IsControlJustPressed(1,38) then
						TriggerEvent("arena:ResetStreek")
						TriggerEvent("arena:Respawn")
					end

					-- Verificar tecla E para desistir (fora da arena)
					if LocalPlayer["state"]["Route"] < 900000 and DeathTimer <= 0 and IsControlJustPressed(1,38) then
						if Creative.CheckDeath() then
							ExecuteCommand("gg")
						end
					end

					if GetGameTimer() >= Cooldown then
						Cooldown = GetGameTimer() + 1000

						if DeathTimer >= 0 then
							DeathTimer = DeathTimer - 1
							SendNUIMessage({ Action = "Message", Message = "Você está inconsciente, aguarde <color>"..DeathTimer.." segundos</color> para desistir" })

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
	if Death and DeathTimer <= 0 then
		return true
	end

	return false
end

-- RegisterNetEvent("survival:SetDeath:Client")
-- AddEventHandler("survival:SetDeath:Client",function(source)
-- 	Wait(1500)
-- 	DeathTimer = 0
-- end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Respawn()
	Death = false
	DeathTimer = timeToRespawn
	wasInRagdoll = false  -- Reseta o estado de ragdoll

	ClearPedTasks(PlayerPedId())
	NetworkSetFriendlyFireOption(true)
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),200)
	SetEntityInvincible(PlayerPedId(),false)
	LocalPlayer["state"]["Invincible"] = false

	TriggerServerEvent("alc:camstatus", false) -- bodycam
	TriggerEvent("paramedic:Reset")
	TriggerEvent("inventory:CleanWeapons")
	LocalPlayer["state"]["Handcuff"] = false
	exports["pma-voice"]:Mute(false)
	TriggerEvent("pma-voice:DesmutePlayer")
	MumbleSetActive(true)

	DoScreenFadeOut(0)
	SetEntityCoords(PlayerPedId(),361.56,-580.48,29.83)
	SendNUIMessage({ Action = "Display", Mode = "none" })
	Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Revive",function(Health,Arena)
	local Ped = PlayerPedId()

	SetEntityHealth(Ped,Health)
	SetEntityInvincible(Ped,false)
	LocalPlayer["state"]["Invincible"] = false

	if Arena then
		SetPedArmour(Ped,99)
	end

	-- Limpa estados que bloqueiam controles (mira, mapa, trocar roupa, etc.)
	LocalPlayer["state"]["Target"] = false
	LocalPlayer["state"]["Commands"] = false
	LocalPlayer["state"]["Cancel"] = false

	if Death then
		Death = false
		DeathTimer = timeToRespawn
		wasInRagdoll = false  -- Reseta o estado de ragdoll

		ClearPedTasks(Ped)
		NetworkSetFriendlyFireOption(true)

		SendNUIMessage({ Action = "Display", Mode = "none" })

		if LocalPlayer["state"]["Route"] < 900000 then
			TriggerEvent("paramedic:Reset")
			exports["pma-voice"]:Mute(false)
			TriggerEvent("pma-voice:DesmutePlayer")
			MumbleSetActive(true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Revive(Health,Arena)
	exports["survival"]:Revive(Health,Arena)
end