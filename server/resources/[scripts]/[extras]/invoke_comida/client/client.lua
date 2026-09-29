-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("invoke_comida", cRP)
vSERVER = Tunnel.getInterface("invoke_comida")

local Zones = {
    ["Zona1"] = PolyZone:Create({
        vector2(-1724.26, 4609.48),
        vector2(-610.2, 5582.73),
        vector2(-539.9, 5706.65),
        vector2(1469.48, 4555.03),
        vector2(-785.24, 3224.19),
    }, { name = "Zona1", debugPoly = false})
}

local time = 0

RegisterNetEvent("invoke_comida:spawn")
AddEventHandler("invoke_comida:spawn", function(Full, Slot)
    local coords = GetEntityCoords(PlayerPedId())
    for _, v in pairs(Zones) do
        if v:isPointInside(coords) then
            if checkCanSpawn() then
                if vSERVER.removeItem(Full, Slot) then
                    vRP._playAnim(false, { "amb@world_human_gardener_plant@female@base", "base_female" }, true)
                    LocalPlayer["state"]["Cancel"] = true
                    LocalPlayer["state"]["Commands"] = true
                    Wait(5000)
                    vRP._stopAnim(false)
                    LocalPlayer["state"]["Cancel"] = false
                    LocalPlayer["state"]["Commands"] = false
                    TriggerEvent("Notify", "amarelo",
                    "Escutei um barulho estranho... acho que um animal está se aproximando.", 5000)
                    SpawnNewAnimal()
                end
            end
        end
    end
end)

local cooldown = 60 * 1000
function checkCanSpawn()
    if GetGameTimer() - time > cooldown then
        time = GetGameTimer()
        return true
    else
        local remaining = (cooldown - (GetGameTimer() - time)  ) / 1000
        TriggerEvent("Notify", "amarelo", "Você deve esperar "..string.format("%.0f", remaining).." segundos para fazer isso novamente." )
        return false
    end
end

AddRelationshipGroup("npcAnimal")
function SpawnNewAnimal()
    local pPed = PlayerPedId()
    local coords = GetEntityCoords(pPed)
    local model = cfg.peds[math.random(#cfg.peds)]

    local spawnDistance = 100

    local randX = math.random(spawnDistance * -1, spawnDistance)
    local randY = math.random(spawnDistance * -1, spawnDistance)
    if math.abs(randX) < 20 then randX = randX * 4 end
    if math.abs(randY) < 20 then randY = randY * 4 end

    local ground, posZ = GetGroundZFor_3dCoord(coords.x + randX, coords.y + randY, coords.z, 1) --set Z pos as on ground

    coords = vector3(coords.x + randX, coords.y + randY, posZ)

    if ground then
        local ped = SpawnPed(model, coords)
        local blip = AddBlipForEntity(ped)
        SetBlipAsFriendly(blip, false) -- this makes the blip show up as an enemy
        -- TaskGoToEntity(ped, pPed, -1, 4.0, 2.0, 1073741824, 0)
        -- SetPedAlertness(ped, 3)

        SetEntityAsMissionEntity(ped,true,true)
        SetEntityAsNoLongerNeeded(ped)
        
        SetPedCombatAttributes(ped, 17, true)
        SetPedCombatAttributes(ped, 46, true)
        SetPedCombatAttributes(ped, 5, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedRelationshipGroupHash(ped, GetHashKey("npcAnimal"))
        TaskCombatPed(ped, pPed, 0, 16)
        SetPedCombatAttributes(ped, 46, true)
        SetPedFleeAttributes(ped, 0, 0)
        SetPedAsEnemy(ped, true)
        SetPedMaxHealth(ped, 200)
        SetPedAlertness(ped, 3)
        SetPedCombatRange(ped, 3)
        SetPedConfigFlag(ped, 224, true)
        SetPedCombatMovement(ped, 3)
        SetEntityCanBeDamagedByRelationshipGroup(ped, false, "npcAnimal")

        SetPedAsNoLongerNeeded(ped)
        SetEntityAsNoLongerNeeded(ped)
    end
end

function SpawnPed(pedModel, coords)
    local myPed, myPedNet = vRPS.CreatePed(pedModel, coords.x, coords.y, coords.z, 3374176, 4)

    if myPed then
        while not NetworkDoesNetworkIdExist(myPedNet) do
            Wait(100)
        end

        if NetworkDoesNetworkIdExist(myPedNet) then
            local ped = NetworkGetEntityFromNetworkId(myPedNet)

            local spawnPassenger = 0
            while not DoesEntityExist(ped) and spawnPassenger <= 1000 do
                ped = NetworkGetEntityFromNetworkId(myPedNet)
                spawnPassenger = spawnPassenger + 1
                Wait(1)
            end

            while not NetworkHasControlOfEntity(ped) do
                NetworkRequestControlOfEntity(ped)
                Wait(1)
            end

            return ped
        end
    end
    return nil
end

function LoadModel(Hash)
    if IsModelInCdimage(Hash) and IsModelValid(Hash) then
        RequestModel(Hash)
        while not HasModelLoaded(Hash) do
            RequestModel(Hash)
            Wait(1)
        end

        return true
    end

    return false
end
