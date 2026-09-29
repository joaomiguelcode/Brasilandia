local tratamento = vector3(463.13, -1157.19, 29.55) -- MUDA AQUI SE QUISER
local emTratamento = false

CreateThread(function()
    -- BLIP (CDS no mapa)
    local blip = AddBlipForCoord(tratamento.x, tratamento.y, tratamento.z)
    SetBlipSprite(blip, 61)
    SetBlipColour(blip, 2)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Tratamento")
    EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local distance = #(coords - tratamento)

        if distance <= 10.0 and not emTratamento then
            time = 5

            -- DESENHA MARCADOR VERDE (Aumentado de 1.5 para 3.0)
            DrawMarker(27, tratamento.x, tratamento.y, tratamento.z - 0.97,
                0,0,0, 0,0,0,
                3.0,3.0,1.0,
                0,255,0,150,
                false,false,2,false,nil,nil,false)

            if distance <= 2.5 then
                DrawText3D(tratamento.x, tratamento.y, tratamento.z, "~g~[E] ~w~TRATAMENTO")

                if IsControlJustPressed(0, 38) then -- tecla E
                    emTratamento = true
                    TriggerServerEvent("tratamento:curar")
                    
                    -- Cooldown local para evitar spam (casa com o tempo do server)
                    SetTimeout(5500, function()
                        emTratamento = false
                    end)
                end
            end
        end

        Wait(time)
    end
end)

CreateThread(function()
    while true do
        local time = 1000
        if emTratamento then
            time = 5
            -- Impede movimento e outras ações
            DisableControlAction(0, 21, true) -- Sprint
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 47, true) -- Weapon
            DisableControlAction(0, 58, true) -- Weapon
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 264, true) -- Melee Attack 2
            DisableControlAction(0, 257, true) -- Melee Attack Alternate
            DisableControlAction(0, 140, true) -- Melee Attack Light
            DisableControlAction(0, 141, true) -- Melee Attack Heavy
            DisableControlAction(0, 142, true) -- Melee Attack Alternate
            DisableControlAction(0, 143, true) -- Melee Block
            DisableControlAction(0, 75, true) -- Exit Vehicle
            DisableControlAction(27, 75, true) -- Exit Vehicle
            DisableControlAction(0, 32, true) -- Move Up
            DisableControlAction(0, 33, true) -- Move Down
            DisableControlAction(0, 34, true) -- Move Left
            DisableControlAction(0, 35, true) -- Move Right
            
            -- Opcional: Congelar a posição do ped
            local ped = PlayerPedId()
            if not IsEntityStatic(ped) then
                FreezeEntityPosition(ped, true)
            end
        else
            -- Garante que o player seja descongelado quando o tratamento acabar
            local ped = PlayerPedId()
            if IsEntityPositionFrozen(ped) then
                FreezeEntityPosition(ped, false)
            end
        end
        Wait(time)
    end
end)

-- TEXTO 3D
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextColour(255,255,255,150)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end