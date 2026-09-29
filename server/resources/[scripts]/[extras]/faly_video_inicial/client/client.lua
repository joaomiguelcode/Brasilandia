-- RegisterCommand("ttt", function()
--     TriggerEvent("faly_video_inicial:start")
-- end)

RegisterNetEvent("faly_video_inicial:start")
AddEventHandler("faly_video_inicial:start", function()
    TriggerServerEvent("faly_video_inicial:check")
end)

RegisterNetEvent("faly_video_inicial:play")
AddEventHandler("faly_video_inicial:play", function()
    SendNUIMessage({Action = "Open"})
    SetNuiFocus(true, true)
end)

RegisterNUICallback("Close", function()
    TriggerServerEvent("faly_video_inicial:seen")
    SetNuiFocus(false, false)
end)