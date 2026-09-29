local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local elevadores = nil

RegisterNetEvent("MaraltoElevadores/Threads/main/start")
AddEventHandler("MaraltoElevadores/Threads/main/start",function(e)
    elevadores = e
    Citizen.Wait(50)
    startThread()
end)

function startThread()
    Citizen.CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            if not IsPedInAnyVehicle(ped) then
                local x,y,z = table.unpack(GetEntityCoords(ped))
                for k,v in pairs(elevadores) do
                    for k2,v2 in pairs(v.blips) do
                        local x2,y2,z2 = table.unpack(v2)
                        if GetDistanceBetweenCoords(x,y,z,x2,y2,z2,true) <= 6.5 then
                            sleep = 1
                            DrawMarker(30,x2,y2,z2-0.45,0,0,0,0.0,0,0,0.3,0.3,0.3,255,255,255,180,0,0,0,1)
                            if GetDistanceBetweenCoords(x,y,z,x2,y2,z2,true) <= 1.2 then
                                if IsControlJustPressed(0,38) then
                                    TriggerEvent("MaraltoElevadores/Elevators/open",k)
                                end
                            end
                        end
                    end
                end
            end
           Citizen.Wait(sleep)
        end
    end)
end