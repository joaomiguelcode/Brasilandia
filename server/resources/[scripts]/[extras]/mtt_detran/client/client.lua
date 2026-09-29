local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- Conexão com o server via Tunnel
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("mtt_detran")
Detran = {}
Tunnel.bindInterface("mtt_detran", Detran)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Variáveis locais
-----------------------------------------------------------------------------------------------------------------------------------------
local showNUI = false
local inExam = false
local coordsBeforeExam = nil
local inPractice = false
local practiceVeh = 0
local practiceIdx = 1
local practiceBlips = {}
local currentRouteBlip = 0

local function clearPracticeBlips()
	if currentRouteBlip ~= 0 and DoesBlipExist(currentRouteBlip) then
		SetBlipRoute(currentRouteBlip, false)
		if not Config.PRACTICE_SHOW_ALL_BLIPS then
			RemoveBlip(currentRouteBlip)
		end
	end
	currentRouteBlip = 0
	for i, b in ipairs(practiceBlips) do
		if b and DoesBlipExist(b) then
			RemoveBlip(b)
		end
	end
	practiceBlips = {}
end

local function createAllPracticeBlips()
	if not Config.PRACTICE_SHOW_ALL_BLIPS then return end
	for i, cp in ipairs(Config.PRACTICE_CHECKPOINTS) do
		local blip = AddBlipForCoord(cp.x, cp.y, cp.z)
		SetBlipSprite(blip, Config.PRACTICE_BLIP_SPRITE or 1)
		SetBlipColour(blip, Config.PRACTICE_BLIP_COLOR or 3)
		SetBlipScale(blip, Config.PRACTICE_BLIP_SCALE or 0.8)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Checkpoint " .. i)
		EndTextCommandSetBlipName(blip)
		practiceBlips[i] = blip
	end
end

local function setRouteToIndex(idx)
	if currentRouteBlip ~= 0 and DoesBlipExist(currentRouteBlip) then
		SetBlipRoute(currentRouteBlip, false)
		if not Config.PRACTICE_SHOW_ALL_BLIPS then
			RemoveBlip(currentRouteBlip)
		end
	end
	local cp = Config.PRACTICE_CHECKPOINTS[idx]
	if not cp then return end
	if Config.PRACTICE_SHOW_ALL_BLIPS then
		currentRouteBlip = practiceBlips[idx]
	else
		currentRouteBlip = AddBlipForCoord(cp.x, cp.y, cp.z)
		SetBlipSprite(currentRouteBlip, Config.PRACTICE_BLIP_SPRITE or 1)
		SetBlipColour(currentRouteBlip, Config.PRACTICE_BLIP_COLOR or 3)
		SetBlipScale(currentRouteBlip, (Config.PRACTICE_BLIP_SCALE or 0.9))
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Checkpoint " .. idx)
		EndTextCommandSetBlipName(currentRouteBlip)
	end
	if currentRouteBlip and currentRouteBlip ~= 0 then
		SetBlipRoute(currentRouteBlip, true)
		if SetBlipRouteColour then
			SetBlipRouteColour(currentRouteBlip, Config.PRACTICE_ROUTE_COLOUR or 3)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI: abrir/fechar interface
-----------------------------------------------------------------------------------------------------------------------------------------
local function openNUI(data)
	if showNUI then return end
	showNUI = true
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "open", data = data or {} })
end

local function closeNUI()
	if not showNUI then return end
	showNUI = false
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "close" })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Open GCNH UI (called by server command)
-----------------------------------------------------------------------------------------------------------------------------------------
function Detran.openGcnh()
	openNUI({ mode = "gcnh" })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Callbacks NUI (recebidos do front React)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(_, cb)
	if inExam then
		local ped = PlayerPedId()
		ClearPedTasks(ped)
		if coordsBeforeExam and coordsBeforeExam.x then
			SetEntityCoords(ped, coordsBeforeExam.x, coordsBeforeExam.y, coordsBeforeExam.z, false, false, false, false)
			coordsBeforeExam = nil
		end
		vSERVER.resetBucket()
		inExam = false
		TriggerEvent("Notify", "amarelo", "Prova abandonada.", 5000)
	end
	closeNUI()
	cb("ok")
end)

local ALLOWED_NUI_METHODS = { getPlayerData = true, lookupCnh = true, manageCnh = true }
RegisterNUICallback("callback", function(data, cb)
	if type(data) ~= "table" or not data.method or not ALLOWED_NUI_METHODS[data.method] then
		cb({})
		return
	end
	local method = vSERVER[data.method]
	if type(method) ~= "function" then
		cb({})
		return
	end
	local ok, result = pcall(method, data.args or {})
	if not ok then
		cb({})
		return
	end
	cb(result or {})
end)

RegisterNUICallback("finishExam", function(data, cb)
	if not inExam then
		cb("ok")
		return
	end
	local passed = type(data) == "table" and data.passed == true
	vSERVER.finishExam(passed)
	closeNUI()
	local ped = PlayerPedId()
	ClearPedTasks(ped)
	if coordsBeforeExam and coordsBeforeExam.x then
		SetEntityCoords(ped, coordsBeforeExam.x, coordsBeforeExam.y, coordsBeforeExam.z, false, false, false, false)
		coordsBeforeExam = nil
	end
	vSERVER.resetBucket()
	inExam = false
	if passed then
		TriggerEvent("Notify", "verde", "Você foi aprovado na prova teórica", 5000)
	else
		TriggerEvent("Notify", "vermelho", "Você foi reprovado na prova teórica", 5000)
	end
	cb("ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Start exam (called by target)
-----------------------------------------------------------------------------------------------------------------------------------------
local function startExamHandler()
	if inExam then
		TriggerEvent("Notify", "amarelo", "Você já está em uma prova.", 5000)
		return
	end

	local ok, reason = vSERVER.startExam()
	if not ok and reason ~= nil then
		if reason == "no_item" then
			TriggerEvent("Notify", "vermelho", "Você precisa do laudo para iniciar a prova.", 5000)
		else
			TriggerEvent("Notify", "vermelho", "Não foi possível iniciar a prova.", 5000)
		end
		return
	end
	if not ok and reason == nil then
		ok = true
	end

	DoScreenFadeOut(Config.FADE_DURATION)
	while not IsScreenFadedOut() do
		Wait(50)
	end

	local ped = PlayerPedId()
	local x, y, z = GetEntityCoords(ped)
	coordsBeforeExam = { x = x, y = y, z = z }

	local seat = Config.EXAM_SEAT
	local cx, cy, cz = seat["Coords"]["x"], seat["Coords"]["y"], seat["Coords"]["z"]
	local heading = seat["Heading"] or 268.22

	SetEntityCoords(ped, cx, cy, cz, false, false, false, false)
	SetEntityHeading(ped, heading)
	Wait(100)

	TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", cx, cy, cz, heading + 1.0, -1, true, true)
	Wait(Config.SIT_WAIT_MS)

	DoScreenFadeIn(Config.FADE_DURATION)
	inExam = true
	TriggerEvent("Notify", "verde", "Você iniciou a prova", 5000)
	Wait(1000)
	openNUI({ mode = "prova" })
end

RegisterNetEvent("mtt_detran:iniciarProva", startExamHandler)

local function startPracticeHandler()
	if inPractice or inExam then
		TriggerEvent("Notify", "amarelo", "Você já está em uma prova.", 5000)
		return
	end
	local ok, reason = vSERVER.startPracticeExam()
	if not ok and reason == "no_item" then
		TriggerEvent("Notify", "vermelho", "Você precisa do laudo aprovado.", 5000)
		return
	end
	DoScreenFadeOut(Config.FADE_DURATION)
	while not IsScreenFadedOut() do
		Wait(50)
	end
	local ped = PlayerPedId()
	local x, y, z = GetEntityCoords(ped)
	coordsBeforeExam = { x = x, y = y, z = z }
	local spawn = Config.PRACTICE_SPAWN
	local cx, cy, cz = spawn["Coords"]["x"], spawn["Coords"]["y"], spawn["Coords"]["z"]
	local heading = spawn["Heading"] or 0.0
	SetEntityCoords(ped, cx, cy, cz, false, false, false, false)
	SetEntityHeading(ped, heading)
	local model = GetHashKey(Config.PRACTICE_VEHICLE or "blista")
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
	practiceVeh = CreateVehicle(model, cx, cy, cz, heading, true, false)
	SetVehicleOnGroundProperly(practiceVeh)
	SetPedIntoVehicle(ped, practiceVeh, -1)
	SetModelAsNoLongerNeeded(model)
	DoScreenFadeIn(Config.FADE_DURATION)
	inPractice = true
	practiceIdx = 1
	TriggerEvent("Notify", "verde", "Prova prática iniciada", 5000)
	clearPracticeBlips()
	createAllPracticeBlips()
	setRouteToIndex(practiceIdx)
	CreateThread(function()
		while inPractice do
			local cp = Config.PRACTICE_CHECKPOINTS[practiceIdx]
			if not cp then break end
			DrawMarker(1, cp.x, cp.y, cp.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 1.0, 0, 150, 255, 150, false, false, 2, nil, nil, false)
			if not IsPedInAnyVehicle(PlayerPedId(), false) or GetVehiclePedIsIn(PlayerPedId(), false) ~= practiceVeh then
				TriggerEvent("Notify", "vermelho", "Permaneça no veículo da prova.", 5000)
				inPractice = false
				break
			end
			if not DoesEntityExist(practiceVeh) or GetEntityHealth(practiceVeh) <= 0 then
				TriggerEvent("Notify", "vermelho", "Veículo danificado. Prova encerrada.", 5000)
				inPractice = false
				break
			end
			local px, py, pz = table.unpack(GetEntityCoords(ped))
			if #(vec3(px, py, pz) - cp) <= 4.0 then
				practiceIdx = practiceIdx + 1
				setRouteToIndex(practiceIdx)
			end
			Wait(0)
		end
		inPractice = false
		local passed = true
		clearPracticeBlips()
		if DoesEntityExist(practiceVeh) then
			DeleteVehicle(practiceVeh)
			practiceVeh = 0
		end
		if coordsBeforeExam and coordsBeforeExam.x then
			SetEntityCoords(ped, coordsBeforeExam.x, coordsBeforeExam.y, coordsBeforeExam.z, false, false, false, false)
			coordsBeforeExam = nil
		end
		vSERVER.finishPracticeExam(passed)
		vSERVER.resetBucket()
		if passed then
			TriggerEvent("Notify", "verde", "Você foi aprovado na prova prática", 5000)
		else
			TriggerEvent("Notify", "vermelho", "Você foi reprovado na prova prática", 5000)
		end
	end)
end

RegisterNetEvent("mtt_detran:iniciarProvaPratica", startPracticeHandler)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Target: start exam at driving school
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(2000)
	exports["target"]:AddCircleZone("mtt_detran:iniciar", vec3(-828.22, -809.1, 19.14), 1.5, {
		name = "Detran",
		heading = 0
	}, {
		Distance = 1.5,
		options = {
			{
				event = "mtt_detran:iniciarProva",
				label = "Iniciar Prova Téorica",
				tunnel = "client"
			},
			{
				event = "mtt_detran:iniciarProvaPratica",
				label = "Iniciar Prova Prática",
				tunnel = "client"
			}
		}
	})
end)
