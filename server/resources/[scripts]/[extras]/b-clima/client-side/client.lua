local nui_aberta = false

-- Abre a NUI e define o foco
RegisterNetEvent('clima:open')
AddEventHandler('clima:open', function()
    nui_aberta = true
    SetNuiFocus(true, true)
    SendNUIMessage({ type = "toggleNUI", display = true })
end)

-- Manipula o fechamento da NUI
RegisterNUICallback("toggleNUI", function(data, cb)
    if data.display then
        SetNuiFocus(true, true) -- Define o foco na NUI
        SendNUIMessage({ type = "toggleNUI", display = true }) -- Mostra a NUI
    else
        SetNuiFocus(false, false) -- Remove o foco da NUI
        SendNUIMessage({ type = "toggleNUI", display = false }) -- Oculta a NUI
        nui_aberta = false
    end
    cb('ok')
end)

-- Callback para a NUI receber o horário e clima selecionados
RegisterNUICallback('applyTime', function(data, cb)
    local hour = tonumber(data.time)
    local minute = tonumber(data.minute) or 0
    local weather = data.weather
    local blackout = tonumber(data.blackout) or 0

    if hour and hour >= 0 and hour <= 23 then
        -- Envia as alterações para o servidor
        TriggerServerEvent('clima:updateSettings', hour, minute, weather, blackout)
        cb({status = 'success'})
    else
        cb({status = 'error', message = 'Horário inválido.'})
    end
end)

-- Recebe eventos do servidor para alterar o horário, clima e blackout
RegisterNetEvent('clima:updateTime')
AddEventHandler('clima:updateTime', function(hour, minute)
    -- Define o horário do jogo
    NetworkOverrideClockTime(hour, minute, 0)
end)

RegisterNetEvent('clima:updateWeather')
AddEventHandler('clima:updateWeather', function(weather)
    -- Define o clima do jogo
    SetWeatherTypeNowPersist(weather)
    SetWeatherTypeOvertimePersist(weather, 15.0)
end)

RegisterNetEvent('clima:updateBlackout')
AddEventHandler('clima:updateBlackout', function(blackout)
    -- Define o blackout do jogo
    SetBlackout(blackout > 0)
end)
