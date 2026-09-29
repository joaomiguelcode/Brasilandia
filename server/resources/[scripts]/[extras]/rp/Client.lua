RegisterNetEvent("2step:ToggleAntiLag")
RegisterNetEvent("bk_flames")

local activated = false
local antilag = false
local AntilagDisplay = false

-- ✅ Função de Notificação Global
function Notificar(tipo)
    local notif = Config.Notificacoes[tipo]
    if notif then
        TriggerEvent("Notify", notif.Cor, notif.Mensagem, Config.Tempo)
    else
        print("❌ Notificação não encontrada na Config: "..tostring(tipo))
    end
end

-- 🔥 Ativador/Desativador do Antilag
AddEventHandler("2step:ToggleAntiLag", function()
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleModel = GetEntityModel(vehicle)
        local isVehicleAllowed = false

        for _, allowedVehicle in pairs(Config.Veiculos) do
            if GetHashKey(allowedVehicle) == vehicleModel then
                isVehicleAllowed = true
                break
            end
        end

        if isVehicleAllowed then
            if not antilag then
                antilag = true
                Notificar("Ativado")
            else
                antilag = false
                Notificar("Desativado")
            end
        else
            Notificar("VeiculoNaoAutorizado")
        end
    else
        Notificar("SemVeiculo")
    end
end)

-- 🔥 Loop Principal (Controla 2Step e AntiLag)
Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed(-1)
        if IsControlPressed(1, Config.Control) then
            if IsPedInAnyVehicle(ped) then
                local pedVehicle = GetVehiclePedIsIn(ped)
                local vehiclePos = GetEntityCoords(pedVehicle)
                local RPM = GetVehicleCurrentRpm(pedVehicle)

                if GetPedInVehicleSeat(pedVehicle, -1) == ped then
                    local vehicleModel = GetEntityModel(pedVehicle)
                    local BackFireDelay = math.random(100, 500)

                    for _, cars in pairs(Config.Veiculos) do
                        if GetHashKey(cars) == vehicleModel then
                            if RPM > 0.3 and RPM < 0.5 then
                                TriggerServerEvent("bk_flames", VehToNet(pedVehicle))
                                AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
                                activated = true
                                Wait(BackFireDelay)
                            else
                                activated = false
                            end
                        end
                    end
                end
            else
                activated = false
            end
        else
            activated = false

            if not IsControlPressed(1, 71) and not IsControlPressed(1, 72) then
                if antilag then
                    if IsPedInAnyVehicle(ped) then
                        local pedVehicle = GetVehiclePedIsIn(ped)
                        local vehiclePos = GetEntityCoords(pedVehicle)
                        local RPM = GetVehicleCurrentRpm(pedVehicle)
                        local AntiLagDelay = math.random(25, 200)

                        if GetPedInVehicleSeat(pedVehicle, -1) == ped then
                            local vehicleModel = GetEntityModel(pedVehicle)

                            for _, cars in pairs(Config.Veiculos) do
                                if GetHashKey(cars) == vehicleModel then
                                    if RPM > 0.75 then
                                        TriggerServerEvent("bk_flames", VehToNet(pedVehicle))
                                        AddExplosion(vehiclePos.x, vehiclePos.y, vehiclePos.z, 61, 0.0, true, true, 0.0, true)
                                        SetVehicleTurboPressure(pedVehicle, 25.0)
                                        AntilagDisplay = true
                                        Wait(AntiLagDelay)
                                    else
                                        AntilagDisplay = false
                                    end
                                end
                            end
                        end
                    else
                        AntilagDisplay = false
                        antilag = false
                    end
                end
            else
                AntilagDisplay = false
            end
        end

        if IsControlJustReleased(1, Config.Control) then
            if IsPedInAnyVehicle(ped, true) then
                SetVehicleTurboPressure(GetVehiclePedIsIn(ped), 25.0)
            end
        end

        Wait(0)
    end
end)

-- 🔥 Desenhar Texto na Tela (Desativado mas funcional se quiser ativar)
Citizen.CreateThread(function()
    while true do
        if activated then
            --DrawHudText("2Step", {0, 255, 85, 255}, 0.92, 0.88, 0.7, 0.7, 6)
        end
        if AntilagDisplay then
            --DrawHudText("Anti-Lag", {0, 255, 85, 255}, 0.92, 0.88, 0.7, 0.7, 6)
        end
        Wait(0)
    end
end)

-- 🔥 Partículas Backfire (Exaustão)
AddEventHandler("bk_flames", function(c_veh)
    local Particulas = Config.Particulas
    local flame_locations = {
        "exhaust",
        "exhaust_2",
        "exhaust_3",
        "exhaust_4"
    }

    for _, bone in pairs(flame_locations) do
        UseParticleFxAssetNextCall(Particulas.particle_asset)
        local createdPart = StartParticleFxLoopedOnEntityBone(
            Particulas.particle,
            NetToVeh(c_veh),
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            GetEntityBoneIndexByName(NetToVeh(c_veh), bone),
            Particulas.particle_size,
            false, false, false
        )
        StopParticleFxLooped(createdPart, 1)
    end
end)

-- 🔤 Desenho de texto (HUD Opcional)
function DrawHudText(text, colour, x, y, scaleX, scaleY, font)
    SetTextFont(font)
    SetTextProportional(7)
    SetTextScale(scaleX, scaleY)
    local r, g, b, a = table.unpack(colour)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
