-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local photographing = false
local setupMode = false
local studioCoords = vec4(-784.06, -1025.27, 13.55, 153.08)
local savedCamCoords = nil
local savedCamRot = nil
local webhookURL = "https://discordapp.com/api/webhooks/1486379268970647683/sPvWeewq_M0piwYCo8aZaG8T6I_1mFdII5sNWgeBv9ecEoN8WdHCLWrpbDcT_lGmy7Iv"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUP COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pdm_setup", function()
    setupMode = not setupMode
    if setupMode then
        TriggerEvent("Notify", "Sucesso", "Modo de configuração ativado. Posicione sua câmera e use /pdm_save para salvar o ângulo.", "verde", 5000)
    else
        TriggerEvent("Notify", "Aviso", "Modo de configuração desativado.", "amarelo", 5000)
    end
end)

RegisterCommand("pdm_save", function()
    if not setupMode then
        TriggerEvent("Notify", "Aviso", "Ative o modo de configuração primeiro com /pdm_setup", "amarelo", 5000)
        return
    end

    local camPos = GetGameplayCamCoord()
    local camRot = GetGameplayCamRot(2)
    savedCamCoords = camPos
    savedCamRot = camRot

    TriggerEvent("Notify", "Sucesso", "Ângulo da câmera salvo com sucesso! Use /pdm_start para começar.", "verde", 5000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- START COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pdm_start", function()
    if not savedCamCoords then
        TriggerEvent("Notify", "Aviso", "Você precisa salvar um ângulo de câmera primeiro com /pdm_save", "amarelo", 5000)
        return
    end

    if photographing then
        TriggerEvent("Notify", "Aviso", "Já existe um processo em andamento.", "amarelo", 5000)
        return
    end

    StartPhotography()
end)

RegisterCommand("pdm_fix", function()
    photographing = false
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true, false)
    SetLocalPlayerVisibleLocally(true)
    RenderScriptCams(false, false, 0, true, true)
    DisplayHud(true)
    DisplayRadar(true)
    TriggerEvent("Notify", "Sucesso", "Interface resetada com sucesso!", "verde", 5000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOGIC
-----------------------------------------------------------------------------------------------------------------------------------------
function StartPhotography()
    photographing = true
    local vehicles = vSERVER.VehicleGlobal()
    local list = {}
    for k, v in pairs(vehicles) do table.insert(list, k) end
    table.sort(list)

    local total = #list
    TriggerEvent("Notify", "Sucesso", "Iniciando fotografia de "..total.." veículos. Mantenha as mãos longe do teclado!", "verde", 5000)

    -- Setup env
    local ped = PlayerPedId()
    SetEntityCoords(ped, studioCoords.x, studioCoords.y, studioCoords.z - 5.0) -- Move ped slightly below
    FreezeEntityPosition(ped, true)
    SetEntityVisible(ped, false, false)
    SetLocalPlayerVisibleLocally(false)
    SetEntityInvincible(ped, true)
    
    -- Lighting & Weather
    NetworkOverrideClockTime(12, 00, 00)
    SetWeatherTypeNowPersist("EXTRASUNNY")
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypeNow("EXTRASUNNY")
    SetWeatherTypePersist("EXTRASUNNY")

    -- Clear Area
    ClearAreaOfVehicles(studioCoords.x, studioCoords.y, studioCoords.z, 20.0, false, false, false, false, false)

    -- Hidden HUD
    DisplayHud(false)
    DisplayRadar(false)

    -- Create Fixed Camera
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, savedCamCoords.x, savedCamCoords.y, savedCamCoords.z)
    SetCamRot(cam, savedCamRot.x, savedCamRot.y, savedCamRot.z, 2)
    SetCamFov(cam, 15.0) -- Extreme Zoom (Telephoto lens effect)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)

    local success, err = pcall(function()
        for i = 1, total do
            local model = list[i]
            if not photographing then break end

            print("[PHOTOGRAPHER] Spawning: "..model.." ("..i.."/"..total..")")
            
            local hash = type(model) == "string" and GetHashKey(model) or model
            if IsModelInCdimage(hash) and IsModelAVehicle(hash) then
                RequestModel(hash)
                local timer = 0
                while not HasModelLoaded(hash) and timer < 100 do 
                    Wait(10) 
                    timer = timer + 1
                end

                if HasModelLoaded(hash) then
                    local veh = CreateVehicle(hash, studioCoords.x, studioCoords.y, studioCoords.z, studioCoords.w, false, false)
                    SetVehicleOnGroundProperly(veh)
                    SetEntityInvincible(veh, true)
                    FreezeEntityPosition(veh, true)
                    SetVehicleDirtLevel(veh, 0.0)
                    SetVehicleNumberPlateText(veh, "PHOTO")

                    Wait(1500) -- Wait for model textures and settlement

                    exports["screenshot-basic"]:requestScreenshot({
                        encoding = "jpg",
                        quality = 0.8 -- Slightly better quality since we are using latent transfer
                    }, function(data)
                        if data and type(data) == "string" then
                            print("[PHOTOGRAPHER] Captured JPG: " .. model .. " (Length: " .. #data .. ")")
                            -- 100000 bps = ~100KB per second. Controlled transfer to avoid lag/serialization errors.
                            TriggerLatentServerEvent("pdm:saveVehicleImage", 100000, model, data)
                        else
                            print("[PHOTOGRAPHER] Error: Failed to capture " .. model .. ". Data is " .. type(data))
                        end
                    end)

                    Wait(2000) -- Delay to allow capture and writing

                    DeleteEntity(veh)
                    SetModelAsNoLongerNeeded(hash)
                end
            else
                print("[PHOTOGRAPHER] Error: Invalid model "..model)
            end
        end
    end)

    if not success then
        print("[PHOTOGRAPHER] FATAL ERROR: " .. tostring(err))
    end

    -- Cleanup (Always runs)
    photographing = false
    if DoesCamExist(cam) then
        DestroyCam(cam, false)
    end
    RenderScriptCams(false, false, 0, true, true)
    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true)
    DisplayHud(true)
    DisplayRadar(true)
    TriggerEvent("Notify", "Sucesso", "Processo concluído! Confira seu Discord.", "verde", 5000)
end
