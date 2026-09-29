local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local Server = {}
Tunnel.bindInterface("mtt_detran", Server)
local vCLIENT = Tunnel.getInterface("mtt_detran")

local function uid(src)
    return vRP.getUserId(src)
end

local function loadCnh(user_id)
    local raw = vRP.getUData(user_id, "mtt_detran:cnh")
    if raw and raw ~= "" then
        local ok, parsed = pcall(json.decode, raw)
        if ok and type(parsed) == "table" then
            return parsed
        end
    end
    return { has = false, points = 0, revoked = false }
end

local function saveCnh(user_id, data)
    vRP.setUData(user_id, "mtt_detran:cnh", json.encode(data or {}))
end

local function identityPayload(user_id)
    local identity = vRP.getUserIdentity(user_id) or {}
    return {
        user_id = user_id,
        name = identity.name or "",
        firstname = identity.firstname or "",
        age = identity.age or 0,
        phone = identity.phone or "",
        registration = identity.registration or ""
    }
end

local function hasPolicePerm(user_id)
    if vRP.hasPermission and vRP.hasPermission(user_id, "Police") then
        return true
    end
    if vRP.hasPermission and vRP.hasPermission(user_id, "Admin") then
        return true
    end
    return false
end

function Server.getPlayerData(args)
    local src = source
    local user_id = uid(src)
    if not user_id then return {} end
    local cnh = loadCnh(user_id)
    return {
        identity = identityPayload(user_id),
        cnh = cnh
    }
end

function Server.lookupCnh(args)
    local src = source
    local user_id = uid(src)
    if not user_id then return {} end
    if not hasPolicePerm(user_id) then return {} end
    local target = tonumber(args and args.id) or 0
    if target <= 0 then return {} end
    local cnh = loadCnh(target)
    return {
        identity = identityPayload(target),
        cnh = cnh
    }
end

function Server.manageCnh(args)
    local src = source
    local user_id = uid(src)
    if not user_id then return { ok = false } end
    if not hasPolicePerm(user_id) then return { ok = false } end
    local target = tonumber(args and args.id) or 0
    if target <= 0 then return { ok = false } end
    local action = args and args.action or ""
    local amount = tonumber(args and args.amount) or 0
    local cnh = loadCnh(target)
    if action == "create" then
        cnh.has = true
        cnh.revoked = false
    elseif action == "revoke" then
        cnh.revoked = true
    elseif action == "restore" then
        cnh.revoked = false
    elseif action == "add_points" then
        cnh.points = math.max(0, (cnh.points or 0) + amount)
    elseif action == "remove_points" then
        cnh.points = math.max(0, (cnh.points or 0) - amount)
    elseif action == "reset_points" then
        cnh.points = 0
    else
        return { ok = false }
    end
    saveCnh(target, cnh)
    return { ok = true, identity = identityPayload(target), cnh = cnh }
end

function Server.startExam()
    local src = source
    local user_id = uid(src)
    if not user_id then return true end
    local item = Config and Config.EXAM_ENTRY_ITEM or "detranprova"
    local hasCount = nil
    if vRP.getInventoryItemAmount then
        local okAmt, count = pcall(vRP.getInventoryItemAmount, user_id, item)
        if okAmt then hasCount = tonumber(count) or 0 end
    end
    if hasCount ~= nil and hasCount < 1 then
        return false, "no_item"
    end
    local removed = false
    if vRP.tryGetInventoryItem then
        local okTry, res = pcall(vRP.tryGetInventoryItem, user_id, item, 1)
        removed = okTry and res == true
    elseif vRP.removeInventoryItem then
        local okRem = pcall(vRP.removeInventoryItem, user_id, item, 1)
        removed = okRem and true or false
    end
    if hasCount == nil and not removed then
        removed = true
    end
    if hasCount ~= nil and hasCount >= 1 and not removed then
        removed = true
    end
    local bucket = user_id
    if type(SetPlayerRoutingBucket) == "function" then
        pcall(SetPlayerRoutingBucket, src, bucket)
    end
    return true
end

function Server.resetBucket()
    local src = source
    if type(SetPlayerRoutingBucket) == "function" then
        pcall(SetPlayerRoutingBucket, src, 0)
    end
end

function Server.finishExam(passed)
    local src = source
    local user_id = uid(src)
    if not user_id then return end
    if passed then
        local item = Config and Config.EXAM_REWARD_ITEM or "laudoaprovado"
        if vRP.giveInventoryItem then pcall(vRP.giveInventoryItem, user_id, item, 1) end
        local cnh = loadCnh(user_id)
        cnh.has = true
        cnh.revoked = false
        cnh.theory = true
        saveCnh(user_id, cnh)
    end
end

RegisterCommand("detran", function(source, args, raw)
    if source <= 0 then return end
    vCLIENT.openGcnh(source)
end)

function Server.startPracticeExam()
    local src = source
    local user_id = uid(src)
    if not user_id then return true end
    local item = Config and Config.PRACTICE_ENTRY_ITEM or "laudoaprovado"
    local hasCount = nil
    if vRP.getInventoryItemAmount then
        local okAmt, count = pcall(vRP.getInventoryItemAmount, user_id, item)
        if okAmt then hasCount = tonumber(count) or 0 end
    end
    if hasCount ~= nil and hasCount < 1 then
        return false, "no_item"
    end
    local removed = false
    if vRP.tryGetInventoryItem then
        local okTry, res = pcall(vRP.tryGetInventoryItem, user_id, item, 1)
        removed = okTry and res == true
    elseif vRP.removeInventoryItem then
        local okRem = pcall(vRP.removeInventoryItem, user_id, item, 1)
        removed = okRem and true or false
    end
    if hasCount == nil and not removed then
        removed = true
    end
    if hasCount ~= nil and hasCount >= 1 and not removed then
        removed = true
    end
    local bucket = user_id + 10000
    if type(SetPlayerRoutingBucket) == "function" then
        pcall(SetPlayerRoutingBucket, src, bucket)
    end
    return true
end

function Server.finishPracticeExam(passed)
    local src = source
    local user_id = uid(src)
    if not user_id then return end
    if passed then
        local cnh = loadCnh(user_id)
        cnh.has = true
        cnh.revoked = false
        cnh.practical = true
        saveCnh(user_id, cnh)
    end
end

