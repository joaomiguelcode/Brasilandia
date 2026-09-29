-----------------------------------------------------------------------------------------------------------------------------------------
-- CONECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vServer = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- TerminalTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local TerminalTable = {
	["1"] = { 895.14,-962.59,35.55 }    
}
CreateThread(function()
	for Number,v in pairs(TerminalTable) do
		exports["target"]:AddCircleZone("TerminalTable:"..Number,vec3(v[1],v[2],v[3]),0.5,{
			name = "TerminalTable:"..Number,
			heading = 3374176
		},{
			Distance = 1.0,
			options = {
				{
					event = "TerminalTablePerm",
					label = "Lavar",
					tunnel = "server"
				}
			}
		})
	end
end)
local inFocus = false
local lastExecutionTime = 0
RegisterNetEvent("TerminalTableOpen")
AddEventHandler("TerminalTableOpen", function()
	if not inFocus and GetEntityHealth(PlayerPedId()) >= 101 then
		local currentTime = GetGameTimer()

		if currentTime - lastExecutionTime >= 60000 then
			inFocus = true
			lastExecutionTime = currentTime

			local Ped = PlayerPedId()
			ExecuteCommand("a digitar")

			SetNuiFocus(true, true)
			TransitionToBlurred(1000)
			SetCursorLocation(0.5, 0.5)

			SendNUIMessage({ action = "showTerminal" })
		else
			local timeRemaining = 60 - math.floor((currentTime - lastExecutionTime) / 1000)
			TriggerEvent("Notify", "amarelo","Existe um processo seu em execução. Aguarde " .. timeRemaining .. " segundos.", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("_close",function(data, cb)
	if data.money == nil then data.money = 0 end
	
	local money = tonumber(data.money)
	local moneyInt = math.floor(money)
	
	if moneyInt >= 1 then
		vServer._checkMoney(data.money)
	end

	closeNui()
	cb({})
end)
function closeNui()
	SetNuiFocus(false,false)
	TransitionFromBlurred(1000)
	SetCursorLocation(0.5,0.5)
	
	local Ped = PlayerPedId()
	ClearPedTasks(Ped)

	inFocus = false
end