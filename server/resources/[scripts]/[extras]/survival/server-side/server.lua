local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Creative = {}
Tunnel.bindInterface("survival",Creative)

local function getRespawnTime()
	local time = GetConvarInt("survival_respawn_time",300)
	if time < 5 then
		time = 5
	end
	return time
end

function Creative.timeToRespawn()
	return getRespawnTime()
end
