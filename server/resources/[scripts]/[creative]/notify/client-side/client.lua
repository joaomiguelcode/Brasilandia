-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("notify")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Shortcuts = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer)
	SendNUIMessage({ css = css, mensagem = mensagem, timer = timer, notify = true })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWSHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function showShortcuts()
	if not Shortcuts then
		SendNUIMessage({ shortcuts = true, shorts = vSERVER.Shortcuts() })
		Shortcuts = true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDESHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function hideShortcuts()
	SendNUIMessage({ shortcuts = false })
	Shortcuts = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHORTCUTS COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+shortcuts",showShortcuts)
RegisterCommand("-shortcuts",hideShortcuts)
RegisterKeyMapping("+shortcuts","Visualizar atalhos.","keyboard","TAB")

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO DE TESTE: /testnotify [tipo]
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("testnotify",function(source,args)
	local tipo = args[1] and string.lower(args[1]) or nil

	if tipo == "verde" then
		TriggerEvent("Notify","verde","Ação realizada com <b>sucesso</b>!",5000)
	elseif tipo == "vermelho" then
		TriggerEvent("Notify","vermelho","Você não possui <b>permissão</b> para isso.",5000)
	elseif tipo == "amarelo" then
		TriggerEvent("Notify","amarelo","<b>Atenção:</b> Esta área é monitorada.",5000)
	elseif tipo == "azul" then
		TriggerEvent("Notify","azul","Novo <b>chamado de emergência</b> recebido.",5000)
	elseif tipo == "locked" then
		TriggerEvent("Notify","locked","Veículo <b>trancado</b> com sucesso.",4000)
	elseif tipo == "unlocked" then
		TriggerEvent("Notify","unlocked","Veículo <b>destrancado</b> com sucesso.",4000)
	elseif tipo == "hunger" then
		TriggerEvent("Notify","hunger","Você está começando a sentir <b>fome</b>.",4500)
	elseif tipo == "thirst" then
		TriggerEvent("Notify","thirst","Você está começando a sentir <b>sede</b>.",4500)
	elseif tipo == "blood" then
		TriggerEvent("Notify","blood","Você está sofrendo de <b>sangramento</b>.",4500)
	elseif tipo == "default" then
		TriggerEvent("Notify","default","Notificação informativa padrão do servidor.",5000)
	else
		-- Demonstração completa de todos os tipos em sequência
		TriggerEvent("Notify","verde","Compra efetuada com <b>sucesso</b> no valor de $1.500.",5000)
		Citizen.Wait(600)
		TriggerEvent("Notify","vermelho","Ocorreu um erro ao tentar acessar o cofre.",5000)
		Citizen.Wait(600)
		TriggerEvent("Notify","azul","Central informou que você recebeu um chamado.",5000)
		Citizen.Wait(600)
		TriggerEvent("Notify","locked","Veículo <b>trancado</b>.",4000)
		Citizen.Wait(600)
		TriggerEvent("Notify","hunger","Você precisa comer alguma coisa.",4500)
	end
end)