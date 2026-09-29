-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("shops",Creative)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SendNUIMessage({ action = "hideNUI" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop",function(Data,Callback)
	local inventoryShop,inventoryUser,invPeso,invMaxpeso,shopSlots = vSERVER.requestShop(Data["shop"])
	if inventoryShop then
		Callback({ inventoryShop = inventoryShop, inventoryUser = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso, shopSlots = shopSlots })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionShops",function(Data,Callback)
	vSERVER.functionShops(Data["shop"],Data["item"],Data["amount"],Data["slot"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(Data,Callback)
	TriggerServerEvent("shops:populateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(Data,Callback)
	TriggerServerEvent("shops:updateSlot",Data["item"],Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	-- Prefeitura
	-- { -545.03,-204.19,38.22,"Identity",false,2.75 },
	{ 2328.68,2569.68,46.67,"Identity2",false,2.75 },
	--- loja de roupas
	{ 79.9,-1393.33,29.37,"Roupaspecas",true },
	{ 1689.21,4822.5,42.06,"Roupaspecas",true },
	{ 2.04,6516.02,31.88,"Roupaspecas",true },

	-- Lojas de Departamento
	{ 24.89,-1346.91,29.49,"Departament",true },
	{ 2556.86,381.26,108.61,"Departament",true },
	{ 161.21,6641.69,31.69,"Departament",true },
	{ 1164.82,-323.63,69.2,"Departament",true },
	{ -706.16,-914.55,19.21,"Departament",true },
	{ -47.39,-1758.63,29.42,"Departament",true },
	{ 373.11,326.81,103.56,"Departament",true },
	{ -3242.74,1000.46,12.82,"Departament",true },
	{ 1728.43,6415.42,35.03,"Departament",true },
	{ 548.71,2670.8,42.16,"Departament",true },
	{ 1960.21,3740.66,32.33,"Departament",true },
	{ 2677.8,3279.95,55.23,"Departament",true },
	{ 1697.35,4923.46,42.0,"Departament",true },
	{ -1819.55,793.51,138.08,"Departament",true },
	{ 1392.03,3606.1,34.98,"Departament",true },
	{ -2966.41,391.59,15.05,"Departament",true },
	{ -3039.57,584.75,7.9,"Departament",true },
	{ 1134.33,-983.09,46.4,"Departament",true },
	{ 1165.26,2710.79,38.15,"Departament",true },
	{ -1486.77,-377.56,40.15,"Departament",true },
	{ -1221.42,-907.91,12.32,"Departament",true },

	--Ammunations
	
	{ 1693.19,3759.97,34.69,"Ammunation",false },
	{ 22.04,-1106.76,29.79,"Ammunation",false },
	{ 1692.28,3760.94,34.6,"Ammunation",false },
	{ 253.79,-50.5,69.94,"Ammunation",false },
	{ 842.41,-1035.28,28.19,"Ammunation",false },
	{ -331.62,6084.93,31.46,"Ammunation",false },
	{ -662.29,-933.62,21.82,"Ammunation",false },
	{ -1304.17,-394.62,36.7,"Ammunation",false },
	{ -1118.95,2699.73,18.55,"Ammunation",false },
	{ 2567.98,292.65,108.73,"Ammunation",false },
	{ -3173.51,1088.38,20.84,"Ammunation",false },
	{ 22.59,-1105.54,29.79,"Ammunation",false },
	{  810.22,-2158.99,29.62,"Ammunation",false },
	{  -330.8,6083.89,31.46,"Ammunation",false },

	

	-- Loja de Roupas
	-- { -1127.26,-1439.35,5.22,"Clothes",false },
	-- { 78.26,-1388.91,29.37,"Clothes",false },
	-- { -706.73,-151.38,37.41,"Clothes",false },
	-- { -166.69,-301.55,39.73,"Clothes",false },
	-- { -817.5,-1074.03,11.32,"Clothes",false },
	-- { -1197.33,-778.98,17.32,"Clothes",false },
	-- { -1447.84,-240.03,49.81,"Clothes",false },
	-- { -0.07,6511.8,31.88,"Clothes",false },
	-- { 1691.6,4818.47,42.06,"Clothes",false },
	-- { 123.21,-212.34,54.56,"Clothes",false },
	-- { 621.24,2753.37,42.09,"Clothes",false },
	-- { 1200.68,2707.35,38.22,"Clothes",false },
	-- { -3172.39,1055.31,20.86,"Clothes",false },
	-- { -1096.53,2711.1,19.11,"Clothes",false },
	-- { 422.7,-810.25,29.49,"Clothes",false },


	{ -59.39,-802.95,44.23,"Information",false,2.75 },
	{ 1590.7,3592.57,38.77,"Information",false,2.75 },
	
	{ -1083.15,-245.88,37.76,"Premium",false,2.75 },
	{ 1520.78,3780.21,34.82	,"Fishing",false },
	{ 1524.71,3783.6,34.88,"Fishing2",true,2.25 },
	{ -678.17,5838.69,17.32,"Hunting2",false },
	{ 1140.36,-1530.01,35.03,"Pharmacy",false },
	{ -253.71,6327.33,32.42,"Pharmacy",false },
	{ 1135.75,-1542.89,35,"Paramedic",false },
	{ -254.98,6326.58,32.42,"Paramedic",false },
	{ 1826.79,3674.3,34.27,"Paramedic",false },
	
	{ 482.4,-995.2,30.68,"Police",false },
	{ -428.47,5994.86,31.71,"Police",false },
	{ 1841.2,3691.8,34.26,"Police",false },
	{ -344.91,-367.1,20.22,"Police",false },
	{ -407.55,-382.68,25.09,"Police",false },
	{ -1214.66,-2276.01,14.57,"Police",false },

	
	{ 174.52,-1319.09,29.35,"Pawnshop",false },
	{ 174.74,-1322.14,29.35,"Pawnshop2",false },
	{ 156.69,-1314.19,29.35,"Pawnshop3",false },
	{ 160.69,-1314.13,29.35,"Pawnshop4",false },
	{ -1286.54,-290.08,36.82,"Mechanic",false },
	--{ 101.54,6623.58,31.78,"MechanicPaleto",false },
	{ 948.25,-972.39,39.83,"Mechanic2",false },
	{ 2748.23,3472.53,55.67,"Megamall",false },
	{ -57.23,6523.5,31.49,"Megamall",false },
	{ 46.65,-1749.74,29.62,"Megamall",false },
	-- { 256.65,-257.26,54.0,"Megamall",false },
	-- { 1133.2,-473.12,66.76,"Digital",false },
	--{ 962.43,-961.18,39.85,"pneu",false },
	---{ 962.63,-966.36,39.94,"pneu",false },
	{109.42,-1797.59,27.08,"Megamall2", false},
	{-91.43,6514.57,32.1, "Megamall2", false},

	-- NPC de Frutas e Caçador
	{ 1087.65,6509.91,21.06,"Frutas",false },
	{ -70.02,6261.9,31.46,"Hunting",false },

	-- NPC Minerador
	{ 2833.28,2794.96,57.96,"Minerador",false },
	{ -349.54,-1569.89,25.22,"Reciclagem1",false },
	{ 1780.92,2559.57,45.67,"Refeitorio",false },
	
	--{ 1130.33,-472.54,66.71,"Digitalden1",false },
	{ 1132.79,-473.02,66.76,"Digitalden2",false },
	
	{ 1134.65,-469.76,66.71,"Digitaldenpublico",false },	
	{ 2341.27,3127.97,48.21,"Corrida",false },
	{ -1568.66,-3224.46,26.34,"Maconha",false },
	-- { 1337.54,4384.17,44.33,"Maconha",false },

	-- { -562.86,289.22,82.36,"Tequila",false },
	-- { -568.5,276.92,78.06,"Tequila",false },

	--{ 787.22, 4178.28, 41.77,"Ilegal",false },
	{ 1178.51,2647.31,37.79,"Mechanic68",false },
	{ 452.92,-1305.32,30.11,"Dominacao",false },
	{ -2175.29,4294.67,49.05,"Dominacao",false },
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem",function(shopId)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm(List[shopId][4]) then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = List[shopId][4], type = vSERVER.getShopType(List[shopId][4]) })

			if List[shopId][5] then
				TriggerEvent("sounds:Private","shop",0.5)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "coffeeMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "sodaMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "donutMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "burgerMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "hotdogMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "Chihuahua", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		SendNUIMessage({ action = "showNUI", name = "waterMachine", type = "Buy" })
		SetNuiFocus(true,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag",function()
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.requestPerm("Paramedic") then
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showNUI", name = "Paramedic", type = "Buy" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Fuel",function()
	SendNUIMessage({ action = "showNUI", name = "Fuel", type = "Buy" })
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number,v in pairs(List) do
		exports["target"]:AddCircleZone("Shops:"..Number,vec3(v[1],v[2],v[3]),1.10,{
			name = "Shops:"..Number,
			heading = 3374176
		},{
			shop = Number,
			Distance = v[6] or 1.05,
			options = {
				{
					event = "shops:openSystem",
					label = "Abrir",
					tunnel = "shop"
				}
			}
		})
	end

	-- exports['target']:AddCircleZone('Clothe:Trasher',vec3(-325.85,-1540.1,31.04),0.5,{
	-- 	name = 'Clothe:Trasher',
	-- 	heading = 3374176
	-- },{
	-- 	shop = 'Clothe:Trasher',
	-- 	Distance = 1.75,
	-- 	options = {
	-- 		{
	-- 			event = "changeClothesTrasher",
	-- 			label = 'Mudar de Roupas',
	-- 			tunnel = 'shop'
	-- 		}
	-- 	}
	-- })
end)

-- function isMale(ped)
-- 	if IsPedModel(ped, 'mp_m_freemode_01') then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

-- local clothesToChange = {
-- 	male = {
-- 		["pants"] = { item = 47, texture = 1 },
-- 		["arms"] = { item = 63, texture = 0 },
-- 		["tshirt"] = { item = 59, texture = 0 },
-- 		["torso"] = { item = 56, texture = 0 },
-- 		["vest"] = { item = 0, texture = 0 },
-- 		["shoes"] = { item = 25, texture = 0 },
-- 		["mask"] = { item = 0, texture = 0 },
-- 		["backpack"] = { item = 0, texture = 0 },
-- 		["hat"] = { item = 8, texture = 0 },
-- 		["glass"] = { item = 0, texture = 0 },
-- 		["ear"] = { item = -1, texture = 0 },
-- 		["watch"] = { item = -1, texture = 0 },
-- 		["bracelet"] = { item = -1, texture = 0 },
-- 		["accessory"] = { item = 0, texture = 0 },
-- 		["decals"] = { item = 0, texture = 0 }


-- 	},
-- 	female = {
-- 		["pants"] = { item = 136, texture = 2 },
-- 		["arms"] = { item = 73, texture = 0 },
-- 		["tshirt"] = { item = 36, texture = 0 },
-- 		["torso"] = { item = 83, texture = 0 },
-- 		["vest"] = { item = 0, texture = 0 },
-- 		["shoes"] = { item = 26, texture = 0 },
-- 		["mask"] = { item = 0, texture = 0 },
-- 		["backpack"] = { item = 0, texture = 0 },
-- 		["hat"] = { item = -1, texture = 0 },
-- 		["glass"] = { item = 0, texture = 0 },
-- 		["ear"] = { item = -1, texture = 0 },
-- 		["watch"] = { item = -1, texture = 0 },
-- 		["bracelet"] = { item = -1, texture = 0 },
-- 		["accessory"] = { item = 0, texture = 0 },
-- 		["decals"] = { item = 0, texture = 0 }


-- 	}
-- }

-- AddEventHandler('changeClothesTrasher',function()
-- 	if isMale(PlayerPedId()) then
-- 		TriggerEvent('skinshop:Apply',clothesToChange.male)
-- 	else
-- 		TriggerEvent('skinshop:Apply',clothesToChange.female)
-- 	end
-- end)

-- exports('trasherClothes',function()
-- 	if isMale(PlayerPedId()) then
-- 		return clothesToChange.male
-- 	else
-- 		return clothesToChange.female
-- 	end
-- end)
