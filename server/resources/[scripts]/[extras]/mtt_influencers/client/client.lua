 -----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("mtt_influencers")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showNUI = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- ABRIR CARTEIRA (disparado pelo server após validar permissão do comando /influencers)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mtt_influencers:openCarteira")
AddEventHandler("mtt_influencers:openCarteira", function()
	if showNUI then return end
	showNUI = true
	SetNuiFocus(true, true)
	SendNUIMessage({ action = "openUI", mode = "carteira" })
	local data = vSERVER.getDashboardData()
	if data then
		SendNUIMessage({
			action = "updateData",
			pontosTotais = data.pontosTotais or 0,
			pontosValidados = data.pontosValidados or 0,
			codigoCriador = data.codigoCriador or "",
			saldo = data.saldo or 0,
			ultimoSaque = data.ultimoSaque,
			metaPontos = data.metaPontos or Config.META_POINTS,
			valorPorPonto = data.valorPorPonto or Config.VALUE_PER_POINT,
			resgateGemas = data.resgateGemas or Config.RESGATE_GEMAS or 50
		})
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO RESGATAR (interface de resgate de benefícios) — só permite se account_id > RESGATE_MIN_ACCOUNT_ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("resgatar", function()
	if not vSERVER.canResgate() then
		TriggerEvent("Notify", "vermelho", "Você não está elegível para resgatar benefícios.", 5000)
		return
	end
	if not showNUI then
		showNUI = true
		SetNuiFocus(true, true)
		SendNUIMessage({ action = "openUI", mode = "resgate" })
		local data = vSERVER.getDashboardData()
		if data then
			SendNUIMessage({
				action = "updateData",
				pontosTotais = data.pontosTotais or 0,
				pontosValidados = data.pontosValidados or 0,
				codigoCriador = data.codigoCriador or "",
				saldo = data.saldo or 0,
				ultimoSaque = data.ultimoSaque,
				metaPontos = data.metaPontos or Config.META_POINTS,
				valorPorPonto = data.valorPorPonto or Config.VALUE_PER_POINT,
				resgateGemas = data.resgateGemas or Config.RESGATE_GEMAS or 50
			})
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE NUI (padrão elevator: só libera foco, NÃO envia mensagem de volta ao NUI)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Fechamento apenas via NUI: o frontend escuta ESC e chama este callback (igual ao painel)
RegisterNUICallback("closeUI", function(data, cb)
	showNUI = false
	SetNuiFocus(false, false)
	cb("ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SALVAR CÓDIGO DO CRIADOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveCodigoCriador", function(data, cb)
	local codigo = type(data and data.codigo) == "string" and data.codigo:match("^([%w]+)$") and data.codigo:sub(1, 10) or ""
	cb("ok")
	local success = vSERVER.saveCodigoCriador(codigo)
	SendNUIMessage({ action = "codigoCriadorResult", success = success })
	if success and codigo ~= "" then
		SendNUIMessage({ action = "updateData", codigoCriador = codigo })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESGATAR CÓDIGO (usuário digita código do influencer)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resgatarCodigo", function(data, cb)
	local codigo = type(data and data.codigo) == "string" and data.codigo:match("^([%w]+)$") and data.codigo:sub(1, 10) or ""
	cb("ok")
	local success = vSERVER.resgatarCodigo(codigo)
	SendNUIMessage({ action = "resgateResult", success = success })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SOLICITAR SAQUE (backend: vSERVER.requestWithdraw)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestWithdraw", function(data, cb)
	local amount = tonumber(data and data.amount)
	local pixKeyType = (data and data.pixKeyType) and tostring(data.pixKeyType):lower() or nil
	local pixKeyValue = (data and data.pixKeyValue) and tostring(data.pixKeyValue):match("^%s*(.-)%s*$") or nil
	cb("ok")
	if amount and amount > 0 then
		local success = vSERVER.requestWithdraw(amount, pixKeyType, pixKeyValue)
		SendNUIMessage({ action = "saqueResult", success = success })
		if success then
			local refresh = vSERVER.getDashboardData()
			if refresh then
				SendNUIMessage({
					action = "updateData",
					pontosTotais = refresh.pontosTotais or 0,
					pontosValidados = refresh.pontosValidados or 0,
					codigoCriador = refresh.codigoCriador or "",
					saldo = refresh.saldo or 0,
					ultimoSaque = refresh.ultimoSaque,
					metaPontos = refresh.metaPontos or Config.META_POINTS,
					valorPorPonto = refresh.valorPorPonto or Config.VALUE_PER_POINT
				})
			end
		end
	end
end)
