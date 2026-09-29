-----------------------------------
-- Connection
-----------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

weiC = {}
Tunnel.bindInterface("wei.domination",weiC)
weiS = Tunnel.getInterface("wei.domination")
-----------------------------------
-- Scope Vars
-----------------------------------
local DominatedLoc = {}
local blipsCreated = {}
local disputes = {}
local disputing = false
local isReclaiming = false
local inTerritory = false
local showBlips = true
-----------------------------------
-- Threads
-----------------------------------
CreateThread(function() 
    while true do
        if inTerritory then
            Wait(Threads.inTerritory())
        else
            Wait(Threads.offTerritory())
        end
    end
end)
-----------------------------------
-- Functions
-----------------------------------
newBlip = function(data)
    if DoesBlipExist(blipsCreated[data.id]) then
        return
    end
    local blip = AddBlipForRadius(data.coords, CC.sizeBlip)
    SetBlipColour(blip, data.color)
    SetBlipDisplay(blip, 2)
    SetBlipAlpha(blip, 128)
    blipsCreated[data.id] = blip
end

removeBlip = function(removeeId) 
    if not DoesBlipExist(blipsCreated[removeeId]) then
        return
    end
    RemoveBlip(blipsCreated[removeeId])
    blipsCreated[removeeId] = nil

    if inTerritory.id == removeeId then inTerritory = false end
end

draw2d = function(text,x,y,r,g,b,scale)
	SetTextFont(0)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,255)
    SetTextOutline(1)
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end

secsToTime = function(secs)
    local sec = secs/60
    sec = tostring(sec)

    local mins = tonumber(sec:sub(1,sec:find('%.')-1))
    secs = secs - mins * 60

    if tostring(secs):find('%.') then
        secs = tostring(secs)
        secs = tonumber(secs:sub(1,secs:find('%.')-1))
    end

    if tostring(mins):len() == 1 then
        mins = '0'..mins
    end
    if tostring(secs):len() == 1 then
        secs = '0'..secs
    end
    
    return mins..':'..secs
end
-----------------------------------
-- Threads - functions
-----------------------------------
Threads = { 
    inTerritory = function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local wait = 1500

        local distance = Vdist(coords, inTerritory.coords)
        if distance <= CC.sizeBlip then goto nxt end

        inTerritory = false
        wait = 0

        ::nxt::
        return wait
    end,
    offTerritory = function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local wait = 1500
        for k, v in pairs(DominatedLoc) do
            local distance = Vdist(coords, v.coords)
            if distance > CC.sizeBlip then goto continue end
            
            if disputes[v.id] then
                weiS.checkDispute(v.id)
            end
            inTerritory = v
            wait = 0
            goto finale

            ::continue::
        end
        ::finale::
        return wait
    end
}
-----------------------------------
-- External Functions
-----------------------------------
weiC.dataLoad = function(dominations) 
    DominatedLoc = dominations
end

weiC.dataUpdate = function(newData) 
    table.insert(DominatedLoc, newData)
end

weiC.newBlip = function(data)
    newBlip(data)
end

weiC.dataRemove = function(removeeId)
    for k,v in pairs(DominatedLoc) do
        if v.id == removeeId then
            DominatedLoc[k] = nil
        end
    end

    removeBlip(removeeId)
end

weiC.updateDispute = function(territoryId,dispute) 
    disputes[territoryId] = dispute
    SetBlipFlashes(blipsCreated[territoryId],true)
end

weiC.isTerritoryAvailable = function() 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local inTerritoryRange = {}
    for k,v in pairs(DominatedLoc) do
        local distance = Vdist(coords - v.coords)
        if distance > CC.sizeBlip * 2 - CC.blipOverlapping then goto continue end
        
        table.insert(inTerritoryRange,v)

        ::continue::
    end
    return inTerritoryRange
end

weiC.isInClaimDistance = function() 
    local ped = PlayerPedId()
    local pedCds = GetEntityCoords(ped)
    
    if Vdist(pedCds,inTerritory.coords) > CC.claimDistance then
        return false
    end

    return true
end

weiC.updateReclaiming = function(value)
    isReclaiming = value
end

weiC.isInTerritory = function() 
    return inTerritory
end

weiC.isAlive = function()
    return GetEntityHealth(PlayerPedId()) > 101
end

weiC.startAttack = function(territoryId)
    disputing = territoryId

    --Check if the player is not away from disputed Territory
    CreateThread(function()
        while disputing do
            Wait(1000)
            if inTerritory then goto continue end
            
            TriggerEvent('Notify','amarelo','Você saiu da área em disputa, volte em 10 segundos ou será desconsiderado da disputa',10000)
            Wait(10000)
            if not inTerritory then
                TriggerEvent('Notify','vermelho','Você saiu da área em disputa por mais de 10 segundos e foi desconsiderado. Saia do local imediatamente!',10000)
                weiS.attackerOff(disputing)
                disputing = false
            end
            ::continue::
        end
    end)

    --Check if the player is dead
    CreateThread(function()
        while disputing do
            Wait(1000)
            if GetEntityHealth(PlayerPedId()) <= 101 then
                TriggerEvent('Notify','vermelho','Você foi abatido e desconsiderado da disputa.',10000)
                weiS.attackerOff(disputing)
                disputing = false
            end

            ::continue::
        end
    end)

    --Count Time Passed
    CreateThread(function()
        while disputing do
            disputes[disputing].remainingTime = disputes[disputing].remainingTime - 1
            Wait(1000)
        end
    end)

    --Draw Timer
    CreateThread(function()
        while disputing do
            draw2d('Tempo restante: '..secsToTime(disputes[disputing].remainingTime),0.1,0.2,255,255,255,0.45)
            Wait(0)
        end
    end)

    --Stop reclaim
    CreateThread(function()
        while disputing do
            local t = 1000
            local ped = PlayerPedId()
            local pedCds = GetEntityCoords(ped)
            
            if not isReclaiming then goto continue end
            
            if Vdist(pedCds, inTerritory.coords) > 3 then goto continue end
            t = 0
            draw2d('Pressione [E] para cancelar a retomada de área',0.5,0.8,255,255,255,0.35)

            if not IsControlJustPressed(0, 38) then goto continue end
            
            weiS.stopReclaim(disputing)
            t = 1000

            ::continue::
            Wait(t)
        end
    end)

    --Count reclaim Timer
    CreateThread(function()
        while disputing do
            if isReclaiming then
                repeat
                    isReclaiming = isReclaiming - 1
                    if isReclaiming <= 0 then isReclaiming = false end
                    Wait(1000)
                until not isReclaiming
            end
            Wait(1000)
        end
    end)

    --Draw reclaim Timer
    CreateThread(function()
        while disputing do
            if isReclaiming then
                repeat
                    draw2d('Tempo até a retomada: '..secsToTime(isReclaiming),0.1,0.23,255,255,255,0.45)
                    Wait(0)
                until not isReclaiming
            end
            Wait(1000)
        end
    end)
end

weiC.startDefense = function(territoryId)
    disputing = territoryId

    --Check if the player is not away from disputed Territory
    CreateThread(function()
        while disputing do
            Wait(2000)
            if inTerritory then goto continue end
            
            TriggerEvent('Notify','amarelo','Você saiu da área em disputa, volte em 10 segundos ou será desconsiderado da disputa',10000)
            Wait(10000)
            if not inTerritory then
                TriggerEvent('Notify','vermelho','Você saiu da área em disputa por mais de 10 segundos e foi desconsiderado. Saia do local imediatamente!',10000)
                weiS.defenderOffNoElimination(disputing)
                disputing = false
            end
            ::continue::
        end
    end)

    --Check if the player is dead
    CreateThread(function()
        while disputing do
            Wait(1000)
            if GetEntityHealth(PlayerPedId()) <= 101 then
                TriggerEvent('Notify','vermelho','Você foi abatido e desconsiderado da disputa',10000)
                weiS.defenderOff(disputing)
                disputing = false
            end

            ::continue::
        end
    end)

    --Count Time Passed
    CreateThread(function()
        while disputing do
            disputes[disputing].remainingTime = disputes[disputing].remainingTime - 1
            Wait(1000)
        end
    end)

    --Draw Timer
    CreateThread(function()
        while disputing do
            draw2d('Tempo restante: '..secsToTime(disputes[disputing].remainingTime),0.1,0.2,255,255,255,0.45)
            Wait(0)
        end
    end)

    --Start reclaim
    CreateThread(function()
        while disputing do
            local t = 1000
            local ped = PlayerPedId()
            local pedCds = GetEntityCoords(ped)

            if isReclaiming then goto continue end

            if Vdist(pedCds, inTerritory.coords) > 3 then goto continue end
            t = 0
            draw2d('Pressione [E] para recuperar controle da área',0.5,0.8,255,255,255,0.35)

            if not IsControlJustPressed(0, 38) then goto continue end
            
            weiS.startReclaim(disputing)
            t = 1000

            ::continue::
            Wait(t)
        end
    end)

    --Count reclaim Timer
    CreateThread(function()
        while disputing do
            if isReclaiming then
                repeat
                    isReclaiming = isReclaiming - 1
                    if isReclaiming <= 0 then isReclaiming = false end
                    Wait(1000)
                until not isReclaiming
            end
            Wait(1000)
        end
    end)

    --Draw reclaim Timer
    CreateThread(function()
        while disputing do
            if isReclaiming then
                repeat
                    draw2d('Tempo até a retomada: '..secsToTime(isReclaiming),0.1,0.23,255,255,255,0.45)
                    Wait(0)
                until not isReclaiming
            end
            Wait(1000)
        end
    end)
end

weiC.finishDispute = function()
    disputes[disputing] = nil
    SetBlipFlashes(blipsCreated[disputing], false)
    disputing = false
end
-----------------------------------
-- Commands
-----------------------------------
RegisterCommand('areas', function()
    showBlips = not showBlips
    local display
    if showBlips then
        display = 2
    else
        display = 0
    end
    for k,v in pairs(blipsCreated) do
        SetBlipDisplay(v,display)
    end
end)
-----------------------------------
-- Exporting
-----------------------------------
execS = function(func,...)
    return weiS[func](...)
end
exports('server',execS)

execC = function(func,...)
    return weiC[func](...)
end
exports('client',execC)