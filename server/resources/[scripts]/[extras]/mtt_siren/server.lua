RegisterNetEvent('sirene:SetSirenState_s')
AddEventHandler('sirene:SetSirenState_s', function(newstate)
    local src = source
    TriggerClientEvent('sirene:SetSirenState_c', -1, src, newstate)
end)

RegisterNetEvent('sirene:SetHornState_s')
AddEventHandler('sirene:SetHornState_s', function(newstate)
    local src = source
    TriggerClientEvent('sirene:SetHornState_c', -1, src, newstate)
end)

RegisterNetEvent('sirene:SetPialState_s')
AddEventHandler('sirene:SetPialState_s', function(newstate)
    local src = source
    TriggerClientEvent('sirene:SetPialState_c', -1, src, newstate)
end)

RegisterNetEvent('sirene:SetLightsState_s')
AddEventHandler('sirene:SetLightsState_s', function(newstate)
    local src = source
    TriggerClientEvent('sirene:SetLightsState_c', -1, src, newstate)
end)

RegisterNetEvent('sirene:SetPriorityState_s')
AddEventHandler('sirene:SetPriorityState_s', function(newstate)
    local src = source
    TriggerClientEvent('sirene:SetPriorityState_c', -1, src, newstate)
end)

RegisterNetEvent('sirene:SetGiroflexMode_s')
AddEventHandler('sirene:SetGiroflexMode_s', function(mode, _target, apply)
    local src = source
    TriggerClientEvent('sirene:SetGiroflexMode_c', -1, src, mode)
    if apply then
        TriggerClientEvent('sirene:ApplyGiroflexMode_c', -1, mode)
    end
end)

RegisterNetEvent('sirene:TogMuteSiren_s')
AddEventHandler('sirene:TogMuteSiren_s', function()
    local src = source
    TriggerClientEvent('sirene:TogMuteSiren_c', -1, src)
end)

RegisterNetEvent('sirene:PassengerRequestGiroflexToggle_s')
AddEventHandler('sirene:PassengerRequestGiroflexToggle_s', function(driverServerId, newState)
    if type(driverServerId) == 'number' then
        TriggerClientEvent('sirene:DriverExecuteGiroflexToggle_c', driverServerId, newState)
    end
end)

RegisterNetEvent('sirene:PassengerRequestGiroflexMode_s')
AddEventHandler('sirene:PassengerRequestGiroflexMode_s', function(driverServerId, newMode)
    if type(driverServerId) == 'number' then
        TriggerClientEvent('sirene:DriverExecuteGiroflexMode_c', driverServerId, newMode)
    end
end)

RegisterNetEvent('sirene:PassengerRequestDesligarTudo_s')
AddEventHandler('sirene:PassengerRequestDesligarTudo_s', function(driverServerId)
    if type(driverServerId) == 'number' then
        TriggerClientEvent('sirene:DriverExecuteDesligarTudo_c', driverServerId)
    end
end)

RegisterNetEvent('sirene:PassengerRequestPrioridade_s')
AddEventHandler('sirene:PassengerRequestPrioridade_s', function(driverServerId, novoEstado)
    if type(driverServerId) == 'number' then
        TriggerClientEvent('sirene:DriverExecutePrioridade_c', driverServerId, novoEstado)
    end
end)
