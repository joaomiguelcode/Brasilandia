-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLASSES DOS VEICULOS
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
	0: Compactos
	1: Sedãs
	2: SUVs
	3: Cupês
	4: Muscle
	5: Clássicos Esportivos
	6: Esportivos
	7: Superesportivos
	8: Motocicletas
	9: Off-road
	10: Industrial
	11: Utilitário
	12: Vans
	13: Bicicletas
	14: Barcos
	15: Helicópteros
	16: Aviões
	17: Serviço
	18: Emergência
	19: Militar
	20: Comercial
	21: Trens
	22: Fórmula 1
]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {
	flameSize = 0.7,
	BlacklistedCars = { "voltic" },
	BlacklistedCarsClass = { 10, 13, 14, 15, 16, 17, 18, 21 },
	MaxDistance = 25.0,
	RequestTime = 10,
	MaxNitroTime = 6,
	explosionSpeed = 110,
	RedNotify = "vermelho",
	GreenNotify = "verde",
	AudioVolume = 30.0,
	InstallDist = 2.5,
	AthlonItem = "athlon",
	RPM = 0.5,
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
	Functions = {
		getUserId = function(source)
			return vRP.Passport(source)
		end,

		request = function(source, title, text, time)
			return vRP.Request(source, title, text, time)
		end,

		prepare = function(name, query)
			return vRP.Prepare(name, query)
		end,

		query = function(name, body)
			return vRP.Query(name, body)
		end,

		notifyS = function(source, status, title, text, time)
			TriggerClientEvent("Notify", source, status, title, text, time)
		end,

		notifyC = function(status, text, title, time)
			TriggerEvent("Notify", status, text, title, time)
		end,

		tryGetInventoryItem = function(id, itemIndex, amount)
			return vRP.tryGetInventoryItem(id, itemIndex, amount)
		end
	}
}