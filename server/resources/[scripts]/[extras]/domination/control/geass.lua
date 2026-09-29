-----------------------------------
-- Connection
-----------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

weiS = {}
Tunnel.bindInterface("wei.domination", weiS)
weiC = Tunnel.getInterface("wei.domination")
-----------------------------------
-- Scope vars
-----------------------------------
local disputes = {}
local dominations = {}
local reclaim = {}
local dominationCooldown = {}
local disputeCooldown = {}

local sql = exports['oxmysql']
-----------------------------------
-- Threads
-----------------------------------
CreateThread(function() 
    dominations = sql:query_async('SELECT * FROM dominations WHERE active = 1;')

    local facs = {}
    for k,v in pairs(CC.factions) do
        local members, num = vRP.NumPermission(k)
        if num > 0 then
            for i,j in pairs(members) do
                table.insert(facs, j)
            end
        end
    end

    Wait(1000)
    for k,v in pairs(dominations) do
        dominations[k].coords = json.decode(v.coords)
        dominations[k].coords = vector3(dominations[k].coords[1], dominations[k].coords[2],dominations[k].coords[3])
        dominations[k].color = tonumber(v.color)
        dominations[k].createdAt = nil

        TriggerEvent('RegisterObjectsStart',v.id,json.decode(v.sprayObj))
        
        
        for _, i in pairs(facs) do
            weiC.newBlip(i, v)
        end
    end
    weiC.dataLoad(-1, dominations)
    
        
end)

CreateThread(function() 
    while true do
        for k,v in pairs(disputes) do
            disputes[k].remainingTime = disputes[k].remainingTime - 1
            if disputes[k].remainingTime <= 0 then
                weiS.finishDispute(k)
            end
        end
        Wait(1000)
    end
end)

CreateThread(function() 
    while true do
        for k,v in pairs(reclaim) do
            reclaim[k].time = reclaim[k].time - 1
            if reclaim[k].time <= 0 then
                if reclaim[k].cooldown then
                    reclaim[k] = nil
                else
                    weiS.finishDispute(k,true)
                end
                
            end
        end
        Wait(1000)
    end
end)

CreateThread(function() 
    while true do
        for k,v in pairs(dominationCooldown) do
            dominationCooldown[k] = dominationCooldown[k] - 1
            if dominationCooldown[k] <= 0 then
                dominationCooldown[k] = nil
            end
        end
        Wait(60000)
    end
end)

CreateThread(function() 
    while true do
        for k,v in pairs(disputeCooldown) do
            disputeCooldown[k] = disputeCooldown[k] - 1
            if disputeCooldown[k] <= 0 then
                disputeCooldown[k] = nil
            end
        end
        Wait(60000)
    end
end)
-----------------------------------
-- Functions - verification
-----------------------------------
function weiS.canDominate(src)
    local charId = vRP.Passport(src)

    local fac = weiS.getFaction(charId)
    if not fac then
        TriggerClientEvent("Notify", src, "vermelho", "Voce não faz parte de nenhuma organização.",5000)
        return false
    end

    if dominationCooldown[fac] then
        TriggerClientEvent("Notify", src, "vermelho", "Sua organização já dominou uma área. Espere: "..dominationCooldown[fac]..' minutos para dominar novamente',5000)
        return false
    end

    local inTerritory = weiC.isInTerritory(src)
    if inTerritory then
        TriggerClientEvent("Notify", src, "vermelho", "Essa área já é dominado por: "..inTerritory.faction..'. Remova o Spray deles antes de dominar este local', 10000)
        return false
    end

    local isTerritoryAvailable = weiC.isTerritoryAvailable(src)
    if #isTerritoryAvailable ~= 0 then
        TriggerClientEvent("Notify", src, "vermelho", "Essa área está muito próximo de "..#isTerritoryAvailable..' area(s)' , 5000)
        return false
    end

    local quant = exports.oxmysql:query_async("SELECT COUNT(`id`) AS `quant` FROM `dominations` WHERE `faction` = '"..fac.."' AND `active` = 1")[1].quant
    if quant >= 25 then
        TriggerClientEvent("Notify", src, "vermelho", "Sua facção atingiu o limite de territórios dominados(25)" , 5000)
        return false
    end
    
    return true
end

function weiS.canClaim(src)
    local charId = vRP.Passport(src)

    local fac = weiS.getFaction(charId)
    if not fac then
        TriggerClientEvent("Notify", src, "vermelho", "Voce não faz parte de nenhuma organização.",5000)
        return false
    end

    local inTerritory = weiC.isInTerritory(src)
    if not inTerritory then
        TriggerClientEvent("Notify", src, "vermelho", "Você não está dentro de nenhuma área", 10000)
        return false
    end

    local isInClaimDistance = weiC.isInClaimDistance(src)
    if not isInClaimDistance then
        TriggerClientEvent("Notify", src, "vermelho", "Você não está perto o suficiente do graffite desta área.", 10000)
        return false
    end

    local isProtected = sql:query_async('SELECT * FROM `dominations` WHERE id = '..inTerritory.id)[1].protected
    if isProtected then
        TriggerClientEvent("Notify", src, "vermelho", "Esse território é protegido", 10000)
        return false
    end

    if disputeCooldown[inTerritory.faction] then
        TriggerClientEvent("Notify", src, "vermelho", "Essa organização já foi atacada recentemente. Espere: "..disputeCooldown[inTerritory.faction]..' minutos para atacar novamente',5000)
        return false
    end

    if inTerritory.faction == fac then
        local bool = vRP.Request(src,'Você deseja remover a dominação da sua própria facção?','Sim','Cancelar')
        if bool then
            weiS.deactiveDomination(inTerritory.id)
            vRP.TakeItem(charId,'tinner',1,true)
        end
        return false
    end

    local counter = 0
    for k,v in pairs(vRP.NumPermission(inTerritory.faction)) do
        counter = counter + 1
    end
    if counter < CC.minOnlineDefenders then
        TriggerClientEvent("Notify", src, "vermelho", "Você não pode fazer isso agora.", 10000)
        return false
    end

    counter = 0
    for k,v in pairs(vRP.NumPermission(fac)) do
        local territory = weiC.isInTerritory(v)
        if not territory then goto continue end

        if territory.id == inTerritory.id and weiC.isAlive(v) then
            counter = counter + 1
        end
        ::continue::
    end
    if counter < CC.minAttackersOnArea then
        TriggerClientEvent("Notify", src, "vermelho", "Não há membros suficiente da sua organização dentro desta área para disputá-lo, o mínimo é "..CC.minAttackersOnArea, 10000)
        return false
    end
    if counter > CC.maxMembers then
        TriggerClientEvent("Notify", src, "vermelho", "Há mais membros de sua facção na área do que o permitido, o máximo é "..CC.maxMembers.." | Há: "..counter.." membros na área", 10000)
        return false
    end

    if disputes[inTerritory.id] then
        TriggerClientEvent("Notify", src, "vermelho", "Essa área já está sendo disputado", 10000)
        return false
    end

    for k,v in pairs(disputes) do
        if v.atk.fac == fac then
            TriggerClientEvent("Notify", src, "vermelho", "Sua organização já está atacando alguma área, vá ajudá-los!" , 5000)
            return false
        end
    
        if v.def.fac == fac then
            TriggerClientEvent("Notify", src, "vermelho", "Sua organização já está defendendo alguma área, vá ajudá-los!" , 5000)
            return false
        end
    end

    return vRP.Request(src,'Você deseja disputar esta área? Há '..counter..' membros da sua organização dentro dele. Aqueles que estiverem fora não poderão participar.','Disputar','Arregar')
end
-----------------------------------
-- Functions - get Data
-----------------------------------
function weiS.getFaction(charId)
    for k,v in pairs(CC.factions) do
        if vRP.HasPermission(charId,k) then
            return k, v.spray, v.color
        end
    end
    return false
end

function weiS.getHealth(inim,coords,def)
    local inv = vRP.NumPermission(inim)
     local countInv = 0

    for key, _ in pairs(inv) do 
        local ped = GetPlayerPed(vRP.Passport(vRP.Source(key)))
        local playerCoords = GetEntityCoords(ped)
        local distance = #(playerCoords - vector3(coords["x"],coords["y"],coords["z"]))
        
        if(distance <= CC.sizeBlip) then
            local ped = vRP.GetHealth(vRP.Passport(vRP.Source(key)))
            if(ped <= 101 ) then
                countInv = countInv + 1
            end
        end
    end

     local defender = vRP.NumPermission(def)
     local countDefender = 0

    
    for key, _ in pairs(defender) do 
        local ped = GetPlayerPed(vRP.Passport(vRP.Source(key)))
        local playerCoords = GetEntityCoords(ped)
        local distance = #(playerCoords -vector3(coords["x"],coords["y"],coords["z"]))
        
        if(distance <= CC.sizeBlip) then
            local ped = vRP.GetHealth(vRP.Passport(vRP.Source(key)))
            if(ped <= 101 ) then
                countDefender = countDefender + 1
            end
        end
    end
      
    if countDefender > countInv then
        return true
    end
    return false
end

function weiS.getUsersByPermission(perm)
    return vRP.NumPermission(perm)
end
-----------------------------------
-- Procedures
-----------------------------------
function weiS.dominateTerritory(charId,coords,sprayObj, newId) 
    local fac, spray, color = weiS.getFaction(charId)

    coords = {coords.x,coords.y,coords.z}
    for k,v in pairs(coords) do
        local s = tostring(v)
        local dot = s:find('%.')
        coords[k] = tonumber(s:sub(1,dot+2))
    end
    
    local newRow = {faction = fac, coords = vector3(coords[1],coords[2],coords[3]), color = color, id = tonumber(newId) }
    table.insert(dominations,newRow)
    weiC.dataUpdate(-1,newRow)

    for k,v in pairs(CC.factions) do
        local fac = vRP.NumPermission(k)
        for i, j in pairs(fac) do
            weiC.newBlip(j, newRow)
        end
    end
    
    dominationCooldown[fac] = CC.dominationCooldown

    sql:execute("INSERT INTO dominations (faction,coords,color,sprayObj) VALUES('"..fac.."','"..json.encode(coords).."',"..color..",'"..json.encode(sprayObj).."')")
end

function weiS.initateDispute(charId) 
    local src = vRP.Source(charId)
    local fac = weiS.getFaction(charId)
    local inTerritory = weiC.isInTerritory(src)

    --set dispute settings
    local new = {}

    new.id = sql:query_async("SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'creative' AND TABLE_NAME = 'dominations_disputes';")[1].AUTO_INCREMENT

    new.remainingTime = CC.disputeDuration * 60 + 1
    if tostring(new.ramainingTime):find('%.') then
        new.remainingTime = tonumber(tostring(new.remainingTime):sub(1,tostring(new.remainingTime):find('%.')-1))
    end

    new.atk = {}
    new.atk.fac = fac
    new.atk.count = 0
    new.atk.attackers = {}
    for k,v in pairs(vRP.NumPermission(fac)) do
        local territory = weiC.isInTerritory(v)
        if not territory then goto continue end

        if territory.id == inTerritory.id and weiC.isAlive(v) then
            new.atk.attackers[k] = true
            new.atk.count = new.atk.count + 1
            if new.atk.count == 10 then break end
        end
        ::continue::
    end

    new.def = {}
    new.def.fac = inTerritory.faction
    new.def.count = 0
    new.def.defenders = {}
    new.def.maximum = false
    for k,v in pairs(vRP.NumPermission(inTerritory.faction)) do
        local territory = weiC.isInTerritory(v)
        if not territory then goto next end

        if territory.id == inTerritory.id and weiC.isAlive(v) then
            new.def.defenders[k] = true
            new.def.count = new.def.count + 1
            if new.def.count == 10 then
                new.def.maximum = true
                break
            end
        end
        ::next::
    end

    --register dispute
    disputes[inTerritory.id] = new
    sql:execute("INSERT INTO dominations_disputes (territoryId, attacker, defender) VALUES ("..inTerritory.id..",'"..fac.."','"..inTerritory.faction.."')")
    disputeCooldown[new.def.fac] = CC.disputeCooldown

    --notify attacker and start Attack
    for k,v in pairs(vRP.NumPermission(fac)) do
        TriggerClientEvent('Notify',v,'amarelo','Sua organização está dominando a área, mantenham-se vivos e dentro da área por 15 minutos',20000)
        weiC.updateDispute(v,inTerritory.id,new)
        local territory = weiC.isInTerritory(v)
        if not territory then goto continue end

        if territory.id == inTerritory.id and weiC.isAlive(v) then
            weiC.startAttack(v, inTerritory.id)
        end
        ::continue::
    end

    --notify defenders and start Defense
    for k,v in pairs(vRP.NumPermission(inTerritory.faction)) do
        TriggerClientEvent('Notify',v,'amarelo','Uma área da sua organização está sendo atacado, vá defendê-lo',20000)
        weiC.updateDispute(v,inTerritory.id,new)
        local territory = weiC.isInTerritory(v)
        if not territory then goto continue end

        if territory.id == inTerritory.id and weiC.isAlive(v) then
            weiC.startDefense(v, inTerritory.id)
        end
        ::continue::
    end

    for _,v in pairs(vRP.NumPermission("Police")) do
        async(function()
            TriggerClientEvent("NotifyPushDomination",v,{ code = 10, title = "Conflito entre gangues", x = inTerritory.coords.x, y = inTerritory.coords.y, z = inTerritory.coords.z, size = CC.sizeBlip * 1.5 })
        end)
    end
    for _,v in pairs(vRP.NumPermission("Admin")) do
        async(function()
            TriggerClientEvent("NotifyPushDomination",v,{ code = 10, title = "Conflito entre gangues", x = inTerritory.coords.x, y = inTerritory.coords.y, z = inTerritory.coords.z, size = CC.sizeBlip * 1.5 })
        end)
    end
end

function weiS.checkDispute(territoryId)
    local src = source

    local charId = vRP.Passport(source)
    if disputes[territoryId].def.defenders[charId] ~= nil then return end

    local fac = weiS.getFaction(charId)
    if disputes[territoryId].def.fac ~= fac then return end

    if disputes[territoryId].def.maximum then return end

    disputes[territoryId].def.defenders[charId] = true
    disputes[territoryId].def.count = disputes[territoryId].def.count + 1
    TriggerClientEvent('Notify',src,'amarelo','Você entrou em uma área da sua organização que está sendo atacado. Expulse os invasores!',20000)

    weiC.startDefense(src, territoryId)
    weiS.updateDispute(territoryId)
end

function weiS.attackerOff(territoryId)
    local src = source
    local charId = vRP.Passport(src)
    disputes[territoryId].atk.count = disputes[territoryId].atk.count - 1
    
    disputes[territoryId].atk.attackers[charId] = false

    weiS.updateDispute(territoryId)
    
    if disputes[territoryId].atk.count <= 0 then
        weiS.finishDispute(territoryId)
    end
end

function weiS.defenderOff(territoryId)
    local src = source
    local charId = vRP.Passport(src)
    disputes[territoryId].def.count = disputes[territoryId].def.count - 1

    disputes[territoryId].def.defenders[charId] = false

    weiS.updateDispute(territoryId)
end

function weiS.defenderOffNoElimination(territoryId)
    local src = source
    local charId = vRP.Passport(src)
    disputes[territoryId].def.count = disputes[territoryId].def.count - 1

    disputes[territoryId].def.defenders[charId] = nil

    weiS.updateDispute(territoryId)
end

function weiS.updateDispute(territoryId)
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].atk.fac)) do
        weiC.updateDispute(v,territoryId,disputes[territoryId])
    end

    for k,v in pairs(vRP.NumPermission(disputes[territoryId].def.fac)) do
        weiC.updateDispute(v,territoryId,disputes[territoryId])
    end
end

function weiS.finishDispute(territoryId, reclaimed)
    --clear Client
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].atk.fac)) do
        weiC.finishDispute(v)
        weiC.updateReclaiming(v,false)
    end
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].def.fac)) do
        weiC.updateReclaiming(v,false)
        weiC.finishDispute(v)
    end

    --get Reason and winner
    local reason, winner
    if reclaimed then
        reason = 'Área retomada'
        winner = 'defensores: '..disputes[territoryId].def.fac
        weiS.notifyDisputeDef(territoryId, 'A sua organização retomou a área')
        weiS.notifyDisputeAtk(territoryId, 'A organização inimiga retomou a área')
    elseif disputes[territoryId].remainingTime <= 0 then 
        reason = 'Tempo esgotado'
        if disputes[territoryId].atk.count > disputes[territoryId].def.count then
            winner = 'atacantes: '..disputes[territoryId].atk.fac
            --remove loser spray
            weiS.notifyDisputeAtk(territoryId, 'A sua organização venceu a disputa pela área disputada')
            weiS.notifyDisputeDef(territoryId, 'A sua organização perdeu a disputa e a área disputada')
        else
            winner = 'defensores: '..disputes[territoryId].def.fac
            weiS.notifyDisputeDef(territoryId, 'A sua organização venceu a disputa pela área disputada')
            weiS.notifyDisputeAtk(territoryId, 'A sua organização perdeu a disputa pela área disputada')
        end
    elseif disputes[territoryId].atk.count <= 0 then
        reason = 'Invasores expulsos'
        winner = 'defensores: '..disputes[territoryId].def.fac
        weiS.notifyDisputeDef(territoryId, 'A sua organização expulsou os invasores e defendeu sua área')
        weiS.notifyDisputeAtk(territoryId, 'A sua organização foi expulsa da área disputada')
    end

    
    --Register Dispute end
    sql:execute("UPDATE dominations_disputes SET winner = '"..winner.."',reason = '"..reason.."', finishedAt = CURRENT_TIMESTAMP() WHERE id = "..disputes[territoryId].id.."")

    --clear Server
    disputes[territoryId] = nil
    reclaim[territoryId] = nil

    if winner:sub(1,9) == 'atacantes' then
        weiS.deactiveDomination(territoryId)
    end
end

function weiS.startReclaim(territoryId)
    local src = source
    if reclaim[territoryId] then 
        if not reclaim[territoryId].cooldown then
            TriggerClientEvent('Notify',src,'vermelho','Uma retomada está em progresso',5000)
        else
            TriggerClientEvent('Notify',src,'vermelho','Aguarde: '..reclaim[territoryId].time..' segundos para fazer isso novamente',5000)
        end
        return
    end

    reclaim[territoryId] = {}
    reclaim[territoryId].cooldown = false
    reclaim[territoryId].time = CC.reclaimTime * 60

    for k,v in pairs(vRP.NumPermission(disputes[territoryId].atk.fac)) do
        TriggerClientEvent('Notify',v,'amarelo','Os defensores estão secando o seu Thinner! Vá impedi-los!',10000)
        weiC.updateReclaiming(v,CC.reclaimTime * 60)
    end
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].def.fac)) do
        weiC.updateReclaiming(v,CC.reclaimTime * 60)
        TriggerClientEvent('Notify',v,'amarelo','Você está secando o Thinner Inimigo, se defenda!',10000)
    end
end

function weiS.stopReclaim(territoryId)
    if not reclaim[territoryId] or reclaim[territoryId].cooldown then 
        TriggerClientEvent('Notify',src,'vermelho','Não há nenhuma retomada está em progresso', 5000)
        return
    end

    for k,v in pairs(vRP.NumPermission(disputes[territoryId].atk.fac)) do
        TriggerClientEvent('Notify',v,'amarelo','Os atacantes cancelaram a retomada de área',10000)
        weiC.updateReclaiming(v,false)
    end
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].def.fac)) do
        TriggerClientEvent('Notify',v,'amarelo','A retomada da área foi cancelada',10000)
        weiC.updateReclaiming(v,false)
    end

    reclaim[territoryId].cooldown = true
    reclaim[territoryId].time = CC.reclaimCoodown * 60
end

function weiS.notifyDisputeDef(territoryId, message)
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].def.fac)) do
        TriggerClientEvent('Notify',v,'amarelo',message,10000)
    end
end

function weiS.notifyDisputeAtk(territoryId, message)
    for k,v in pairs(vRP.NumPermission(disputes[territoryId].atk.fac)) do
        TriggerClientEvent('Notify',v,'amarelo',message,10000)
    end
end

function weiS.deactiveDomination(id)
    sql:execute("UPDATE dominations SET `active` = b'0', endedAt = CURRENT_TIMESTAMP() WHERE id = "..id)

    for k,v in pairs(dominations) do
        if v.id == id then
            dominations[k] = nil
        end
    end

    weiC.dataRemove(-1,id)
    TriggerClientEvent("objects:Remover",-1,tostring(id))
    TriggerClientEvent("objects:Remover",-1,id)
end
-----------------------------------
-- Commands
-----------------------------------
RegisterCommand('removespray',function(src,r,c)
    local charId
    charId = vRP.Passport(src)

    if not vRP.HasPermission(charId,'Admin',1) then return end

    local inTerritory = weiC.isInTerritory(src)

    if not vRP.Request(src,'Você deseja remover essa dominação da facção: '..inTerritory.faction,'Sim','Não') then return end

    sql:execute("INSERT INTO dominations_disputes (territoryId, attacker, defender) VALUES ("..inTerritory.id..",'ADM','"..inTerritory.faction.."')")
    sql:execute("UPDATE dominations_disputes SET winner = 'ADM',reason = 'ADM', finishedAt = CURRENT_TIMESTAMP() WHERE id = "..inTerritory.id.."")
    weiS.deactiveDomination(inTerritory.id)
end)
-----------------------------------
-- Event Handlers
-----------------------------------
AddEventHandler("Connect",function(Passport,source)
    local isInFaction = false
    for k,v in pairs(CC.factions) do
        if vRP.HasPermission(Passport,k) then isInFaction = true break end
    end

    for k,v in pairs(dominations) do
	    TriggerClientEvent("objects:Adicionar",source,v.id,json.decode(v.sprayObj))

        if isInFaction then weiC.newBlip(source, v) end
    end

    weiC.dataLoad(source, dominations)
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