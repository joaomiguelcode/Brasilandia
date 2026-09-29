---@diagnostic disable-next-line: deprecated
local Tunnel = module("vrp", "lib/Tunnel")
---@diagnostic disable-next-line: deprecated

-- Initialize lib if not available
if not lib then
    lib = exports.ox_lib
end

local src = {}
---@diagnostic disable-next-line: undefined-field
Tunnel.bindInterface("request", src)

local requests = {}
local requestList = {}

---@param message string @The message to display in the request
---@param acceptButton string? @Default is "Sim"
---@param rejectButton string? @Default is "Não"
---@param title string? @Default is "Confirmação"
---@param time number? @Default is 30000 (30 seconds)
---@return boolean @Returns true if accepted, false if denied. False also if the request times out.
function src.Function(message, acceptButton, rejectButton, title, time)
    acceptButton = acceptButton or "Aceitar"
    rejectButton = rejectButton or "Recusar"
	title = title or "Confirmação"
	time = (time or 30) * 1000

	local id = lib.string.random(".........")

    requests[id] = {
		message = message,
		acceptButton = acceptButton,
		rejectButton = rejectButton,
        time = time,

		promise = promise.new()
    }
    requestList[#requestList+1] = id

	-- Validate data before sending to NUI
	if not id or not title or not message then
		lib.print.debug("Invalid request data:", {id = id, title = title, message = message})
		return false
	end

	SendNUIMessage({
        typeId = 'set:notify:addRequest',
        payload = {
            id = id or "",
            title = title or "Confirmação",
			text = message or "",
			time = time or 30000,
            acceptButtonLabel = "Aceitar (Y)",
            rejectButtonLabel = "Recusar (N)",
		}
	})

	SetTimeout(time, function()
		denyRequest(id)
	end)

	return Citizen.Await(requests[id].promise)
end

local function removeRequest(id)
	local request = requests[id]
	if not request then return end

    requests[id] = nil
    for i, v in ipairs(requestList) do
        if v == id then
            table.remove(requestList, i)
            break
        end
    end

	SendNUIMessage({
        typeId = 'set:notify:removeRequest',
		payload = id,
	})
end
RegisterNetEvent("hud:removeRequest", removeRequest)

function acceptRequest(id)
    if not id then return end

    local request = requests[id]
	if not request then return end

	request.promise:resolve(true)

    removeRequest(id)
end

function denyRequest(id)
    if not id then return end

    local request = requests[id]
	if not request then return end

	request.promise:resolve(false)

	removeRequest(id)
end

RegisterKeyMapping("hud_request_accept", "Solicitação - Aceitar", "keyboard", "Y")
RegisterKeyMapping("hud_request_deny", "Solicitação - Negar", "keyboard", "N")

RegisterCommand("hud_request_accept", function()
	acceptRequest(requestList[1])
end, false)

RegisterCommand("hud_request_deny", function()
	denyRequest(requestList[1])
end, false)
