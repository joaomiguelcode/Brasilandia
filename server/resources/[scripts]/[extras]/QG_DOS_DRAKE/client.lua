local cds = nil

-- Solicitar coordenadas ao iniciar
CreateThread(function()
    TriggerServerEvent("prova:getCds")
end)

RegisterNetEvent("prova:setCds")
AddEventHandler("prova:setCds", function(data)
    cds = data
end)

RegisterNetEvent("prova:abrir")
AddEventHandler("prova:abrir", function(perguntas, min_acertos)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        perguntas = perguntas,
        min_acertos = min_acertos
    })
end)

-- Thread de interação nas coordenadas
CreateThread(function()
    while true do
        local idle = 1000
        if cds then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local distance = #(coords - vector3(cds.x, cds.y, cds.z))

            if distance <= 5.0 then
                idle = 5
                DrawMarker(21, cds.x, cds.y, cds.z - 0.6, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 244, 67, 54, 150, 1, 1, 2, 0)
                
                if distance <= 1.2 then
                    DrawText3D(cds.x, cds.y, cds.z, "~r~[E]~w~ INICIAR PROVA")
                    if IsControlJustPressed(0, 38) then -- Tecla E
                        TriggerServerEvent("prova:iniciar")
                    end
                end
            end
        end
        Wait(idle)
    end
end)

-- Função para desenhar texto 3D
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

RegisterNUICallback("finalizar", function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent("prova:finalizar", data.acertos)
    cb("ok")
end)

RegisterNUICallback("fechar", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)