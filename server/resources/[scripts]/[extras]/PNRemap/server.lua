local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

local vCLIENT = Tunnel.getInterface("PNRemap")
local vSERVER = {}
Tunnel.bindInterface("PNRemap",vSERVER)

local StorageKey = "PNRemapPlates"

local function NormalizePlate(Plate)
	return tostring(Plate or ""):upper():gsub("%s+","")
end

local function LoadPlatesFromStorage()
	local Encoded = GetResourceKvpString(StorageKey)
	if not Encoded or Encoded == "" then
		return {}
	end

	local Ok, Decoded = pcall(json.decode, Encoded)
	if not Ok or type(Decoded) ~= "table" then
		return {}
	end

	return Decoded
end

local function SavePlatesToStorage(Plates)
	local Ok, Encoded = pcall(json.encode, Plates)
	if Ok and Encoded then
		SetResourceKvp(StorageKey, Encoded)
	end
end

local function GetRemapPlates()
	local Plates = GlobalState["PNRemapPlates"]
	if type(Plates) ~= "table" then
		Plates = LoadPlatesFromStorage()
		GlobalState:set("PNRemapPlates",Plates,true)
	end
	return Plates
end

function vSERVER.CheckIfVehicleAsRemap(Plate)
	local NormalizedPlate = NormalizePlate(Plate)
	if NormalizedPlate == "" then
		return false
	end

	local Plates = GetRemapPlates()
	return Plates[NormalizedPlate] == true
end

function vSERVER.RequestInstallRemap(NetworkId)
	local source = source
	local Passport = Config.Functions.getUserId(source)
	if not Passport then
		return false
	end

	local Entity = NetworkGetEntityFromNetworkId(tonumber(NetworkId) or 0)
	if not Entity or Entity == 0 or not DoesEntityExist(Entity) then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","Veículo inválido.",5000)
		return false
	end

	local Plate = NormalizePlate(GetVehicleNumberPlateText(Entity))
	if Plate == "" then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","Placa inválida.",5000)
		return false
	end

	if vSERVER.CheckIfVehicleAsRemap(Plate) then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","O veículo já possui a Central ATHLON.",5000)
		return false
	end

	local Accepted = Config.Functions.request(source,"Central ATHLON","Deseja instalar a Central ATHLON neste veículo?",Config.RequestTime)
	if not Accepted then
		return false
	end

	if not Config.Functions.tryGetInventoryItem(Passport,Config.AthlonItem,1) then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","Você não possui a Central ATHLON.",5000)
		return false
	end

	local Plates = GetRemapPlates()
	Plates[Plate] = true
	GlobalState:set("PNRemapPlates",Plates,true)
	SavePlatesToStorage(Plates)

	Config.Functions.notifyS(source,Config.GreenNotify,"Sucesso","Central ATHLON instalada com sucesso.",5000)
	return true
end

function vSERVER.ForceInstallRemap(NetworkId)
	local source = source
	local Passport = Config.Functions.getUserId(source)
	if not Passport then
		return false
	end

	local Entity = NetworkGetEntityFromNetworkId(tonumber(NetworkId) or 0)
	if not Entity or Entity == 0 or not DoesEntityExist(Entity) then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","Veículo inválido.",5000)
		return false
	end

	local Plate = NormalizePlate(GetVehicleNumberPlateText(Entity))
	if Plate == "" then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","Placa inválida.",5000)
		return false
	end

	if vSERVER.CheckIfVehicleAsRemap(Plate) then
		Config.Functions.notifyS(source,Config.RedNotify,"Erro","O veículo já possui a Central ATHLON.",5000)
		return false
	end

	local Plates = GetRemapPlates()
	Plates[Plate] = true
	GlobalState:set("PNRemapPlates",Plates,true)
	SavePlatesToStorage(Plates)

	Config.Functions.notifyS(source,Config.GreenNotify,"Sucesso","Central ATHLON instalada com sucesso.",5000)
	return true
end

function vSERVER.SetVehicleCutting(NetworkId,State,Type)
	local Players = GetPlayers()
	for i = 1, #Players do
		local Player = Players[i]
		vCLIENT.SetVehicleCutting(Player,NetworkId,State,Type)
	end
end

AddEventHandler("onResourceStart", function(ResourceName)
	if ResourceName ~= GetCurrentResourceName() then
		return
	end

	local Plates = LoadPlatesFromStorage()
	GlobalState:set("PNRemapPlates",Plates,true)
end)

