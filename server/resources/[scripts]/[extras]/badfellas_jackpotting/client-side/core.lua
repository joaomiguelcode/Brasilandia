-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Badfellas = {}
Tunnel.bindInterface("badfellas_jackpotting",Badfellas)
vSERVER = Tunnel.getInterface("badfellas_jackpotting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Badfellas.startRobbery()
	if Config.base == "creative_network" then
		TriggerEvent("Progress","Injetando Pendrive",2000)

		--vRP.CreateObjects(Config.animationBaseDict,Config.animationBaseName,Config.animationBaseObject,50,28422)

		TriggerEvent("mhacking:show")
		TriggerEvent("mhacking:start",5,20,successHacking)
	end
end

function successHacking(success, remainingtime)
	local ped = PlayerPedId()
	if Config.base == "creative_network" then
		if success then
			TriggerEvent('mhacking:hide')
			TriggerEvent("Progress","Injetando Malware",20000)

			SetTimeout(3000,function()
				TriggerEvent("Progress","Cancelando",1000)
				FreezeEntityPosition(ped, false)
				activePlayer()
				vSERVER.Payment()
				vRP.removeObjects("one")
			end)
		else
			TriggerEvent('mhacking:hide')

			SetTimeout(3000,function()
				TriggerEvent("Progress","Cancelando",1000)
				activePlayer()
				FreezeEntityPosition(ped, false)
				vRP.removeObjects("one")
			end)
		end
	end
end

function inactivePlayer(source)
	LocalPlayer["state"]["Cancel"] = true
	LocalPlayer["state"]["Commands"] = true
end

function activePlayer(source)
	LocalPlayer["state"]["Cancel"] = false
	LocalPlayer["state"]["Commands"] = false
end