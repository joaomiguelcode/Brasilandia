-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_dismantle", cnVRP)
vCLIENT = Tunnel.getInterface("vrp_dismantle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONVERSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.getUserId = vRP.Passport
vRP.prepare = vRP.Prepare
vRP.getInventoryItemAmount = vRP.InventoryItemAmount
vRP.userPlate = vRP.PassportPlate
vRP.query = vRP.Query
vRP.upgradeStress = vRP.UpgradeStress
vRP.execute = vRP.Query
vRP.giveInventoryItem = vRP.GiveItem
vRP.hasPermission = vRP.HasPermission

vehiclePrice = VehiclePrice
vehicleType = VehicleMode

-- ------- CREATIVE 6 ---------- 
-- vRP.GiveItem = vRP.giveInventoryItem vRP.TakeItem =  vRP.tryGetInventoryItem
--  vRP.Passport = vRP.getUserId vRP.SwapSlot = vRP.swapSlot vRP.Inventory = vRP.userInventory
--   vRP.GenerateItem = vRP.generateItem vRP.CheckDamaged = vRP.checkBroken vRP.PaymentGems = vRP.paymentGems
--    vRP.Identity = vRP.userIdentity vRP.Query = vRP.execute vRP.GiveItem = vRP.generateItem 
--     vRP.PaymentFull =  vRP.paymentFull vRP.InventoryWeight = vRP.inventoryWeight
-- 	 vRP.MaxItens = vRP.checkMaxItens vRP.userInventory = vRP.Inventory
-- 	  vRP.GetWeight = vRP.getWeight vRP.HasService = vRP.hasGroup 
-- 	  ------- CREATIVE 6 ----------

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("desmanche/set","UPDATE vehicles SET dismantle = @dismantle WHERE Passport = @Passport AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itensList = {
	[1] = "plastic",
	[2] = "glass",
	[3] = "copper",
	[4] = "rubber",
	[5] = "aluminum"
}

-- local vehVips = {
-- 	['skyliner34'] = 150000,
-- 	['zx10r'] = 90000,
-- 	['tiger'] = 100000,
-- 	['i8'] = 100000,
-- 	['ferrariitalia'] = 100000,
-- 	['lamborghinihuracan'] = 100000,
-- 	['t20'] = 650000,
-- 	['laferrari15'] = 100000,
-- 	['tyrant'] = 100000,
-- 	['r1250'] = 100000,
-- 	['gtr'] = 100000,
-- 	['brioso'] = 100000,
-- 	['kanjo'] = 100000,
		
-- }

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,"WEAPON_WRENCH")
		if consultItem[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Necessário possuir <b>1x Chave Inglesa</b>.",5000)
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkVehicle()
	local source = source
	local Passport = vRP.getUserId(source)
	local vehicle,vehNet,vehPlate,vehName = vRPC.VehicleList(source,11)
	local vehInfos = vRP.userPlate(vehPlate)
	if vehicle and vehInfos then
		--print(json.encode(vehInfos))
		local vehicles = vRP.Query("vehicles/selectVehicles",{ Passport = vehInfos["Passport"], vehicle = vehName })[1]
		-- local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport["Passport"], vehicle = entity[2] })
		--print(json.encode(vehicles))
		if vehicles then
			if vehicles["dismantle"] == 0 then
				return true, vehicle, vehName, vehiclePrice(vehName), vehInfos["Passport"], vehNet, vehPlate
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
--- PAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod(vehicle,vehPrice,vehName, nuser_id, vehNet, vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	local vehPrice = vehiclePrice(vehName)
	local vehType = vehicleType(vehName)
	if user_id then
		--local activePlayers = vRPclient.activePlayers(source)
		for _, nsource in ipairs(vRP.Players()) do
			async(function()
				TriggerClientEvent("inventory:repairAdmin", nsource, vehNet, vehPlate)
			end)
		end
		
		
		vRP.upgradeStress(user_id,10)
		TriggerClientEvent("garages:Delete", source, vehicle)
		vRP.giveInventoryItem(user_id,"dollarz",parseInt(vehPrice * 0.1),true)
		vRP.giveInventoryItem(user_id,itensList[math.random(#itensList)],math.random(60,120),true)
		vRP.execute("desmanche/set",{ Passport = nuser_id, vehicle = vehName, dismantle = 1 })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
---permissão
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.hasPermission(Permission)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,Permission)
	end
end