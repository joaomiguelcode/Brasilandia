local talkingList = {}

local cacheData = {}

-- Initialize lib if not available
if not lib then
    lib = exports.ox_lib
end

local function cache(key, cb)
    if cacheData[key] then
        return cacheData[key]
    end

    cacheData[key] = cb()
    return cacheData[key]
end

cacheData.serverId = GetPlayerServerId(PlayerId())

local function addTalking(serverId)
	print("[HUD Radio] Adding talking for serverId:", serverId)

    if talkingList[serverId] then return print("[HUD Radio] Already talking for serverId:", serverId) end

	talkingList[serverId] = true

	local identity = cache("playerIdentity:" .. serverId, function()
		print("[HUD Radio] Getting player identity:", serverId)
		return vSERVER.getPlayerIdentity(serverId)
	end)

	if not talkingList[serverId] then return print("[HUD Radio] Removed from talking list while getting identity:", serverId) end

	local data = {
		id = serverId,
		player = { id = identity[1], name = identity[2] .. " " .. identity[3] }
	}
	print("[HUD Radio] Data to send for talking:", data)

	SendNUIMessage({
		typeId = "set:hud:talk",
		payload = data
	})
end

local function removeTalking(serverId)
	print("[HUD Radio] Removing talking for serverId:", serverId)

	talkingList[serverId] = nil

	SendNUIMessage({
		typeId = "remove:hud:talk",
		payload = { id = serverId }
	})
end

AddEventHandler("pma-voice:radioActive", function(talking)
	if talking then
		addTalking(cacheData.serverId)
	else
		removeTalking(cacheData.serverId)
	end
end)

RegisterNetEvent("pma-voice:setTalkingOnRadio", function(serverId, talking)
	if not serverId then return end

	if not talking then
		removeTalking(serverId)
		return
	end

	addTalking(serverId)
end)

AddStateBagChangeHandler("radio", "player:" .. cacheData.serverId, function(_, _, frequency)
	Wait(50)
	for serverId in pairs(talkingList) do
		removeTalking(serverId)
	end
end)
