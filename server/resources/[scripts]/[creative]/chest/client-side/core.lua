-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Chests = {
	-- Polícia
	{ ["Name"] = "Police", ["Coords"] = vec3(-389.35,-338.28,32.4), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(-426.61,5996.77,31.71), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(1852.0,3697.47,34.26), ["Mode"] = "1" },
	{ ["Name"] = "Police", ["Coords"] = vec3(1844.33,2574.23,46.02), ["Mode"] = "1" },
	{ ["Name"] = "Police2", ["Coords"] = vec3(1548.33,827.15,82.13), ["Mode"] = "1" },

	{ ["Name"] = "Policiacivil", ["Coords"] = vec3(1791.2,3605.7,36.5), ["Mode"] = "1" },
	

	

	--Mecanicas
	{ ["Name"] = "Bennys", ["Coords"] = vec3(-197.43,-1320.44,31.09), ["Mode"] = "2" },
	{ ["Name"] = "Mechanic", ["Coords"] = vec3(-592.19,-922.52,23.88), ["Mode"] = "2" },

	-- Hospitais
	{ ["Name"] = "Paramedic-2", ["Coords"] = vec3(1831.18,3678.51,34.27), ["Mode"] = "2" }, --- Shandy Shores
	{ ["Name"] = "Paramedic", ["Coords"] = vec3(1141.53,-1545.28,35.03), ["Mode"] = "2" }, --- HP SUL

	-- Restaurantes
	{ ["Name"] = "BurgerShot", ["Coords"] = vec3(-1203.2,-896.05,13.88), ["Mode"] = "2" },
	{ ["Name"] = "Hornys", ["Coords"] = vec3(1249.34,-351.62,69.27), ["Mode"] = "2" },

	-- Ilegal Sul
	{ ["Name"] = "Ballas", ["Coords"] = vec3(94.17,-1982.87,20.44), ["Mode"] = "2" },
	{ ["Name"] = "Families", ["Coords"] = vec3(-222.02,-1626.14,38.11), ["Mode"] = "2" },
	{ ["Name"] = "Vagos", ["Coords"] = vec3(799.03,-2295.37,31.21), ["Mode"] = "2" },
	{ ["Name"] = "Bloods", ["Coords"] = vec3(952.32,-1476.64,33.78), ["Mode"] = "2" },

	--Ilegal Norte

	{ ["Name"] = "Thelost", ["Coords"] = vec3(2517.35,4106.18,35.59), ["Mode"] = "2" },
	{ ["Name"] = "Tijuana", ["Coords"] = vec3(-35.93,2890.07,51.58), ["Mode"] = "2" },
	{ ["Name"] = "Cosanostra", ["Coords"] = vec3(-1866.85,2065.64,135.44), ["Mode"] = "2" },
	{ ["Name"] = "Bratva", ["Coords"] = vec3(1988.23,3048.06,50.5), ["Mode"] = "2" },
	{ ["Name"] = "Coiote", ["Coords"] = vec3(2328.45,2572.4,46.67), ["Mode"] = "2" },
	

	-- Bandejas
	{ ["Name"] = "trayShot", ["Coords"] = vec3(-1193.14,-894.48,13.88), ["Mode"] = "3" },
	{ ["Name"] = "trayPrls1", ["Coords"] = vec3(-1195.22,-893.98,13.88), ["Mode"] = "3" },
	{ ["Name"] = "trayPrls2", ["Coords"] = vec3(-584.8,-1062.01,22.34), ["Mode"] = "3" },
	{ ["Name"] = "trayTql1", ["Coords"] = vec3(-584.8,-1059.46,22.34), ["Mode"] = "3" },
	{ ["Name"] = "trayTql2", ["Coords"] = vec3(-564.2,285.62,85.5), ["Mode"] = "3" },

	{ ["Name"] = "Digitalden", ["Coords"] = vec3(1129.01,-474.32,66.71), ["Mode"] = "2" },
	{ ["Name"] = "Digitalden-ilegal", ["Coords"] = vec3(-578.58,229.81,74.88), ["Mode"] = "2" },
	{ ["Name"] = "Pawnshop", ["Coords"] = vec3(157.75,-1316.18,29.35), ["Mode"] = "2" },
	{ ["Name"] = "Mechanic68", ["Coords"] = vec3(1189.7,2636.52,38.39), ["Mode"] = "2" },
	{ ["Name"] = "Uwucoffee", ["Coords"] = vec3(-590.41,-1067.82,22.9), ["Mode"] = "2" },
	{ ["Name"] = "LSCustoms", ["Coords"] = vec3(-350.19,-128.68,38.91), ["Mode"] = "2" },
	{ ["Name"] = "Yakuza", ["Coords"] = vec3(-1019.85,-1490.42,-3.34), ["Mode"] = "2" },


	

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELS
-----------------------------------------------------------------------------------------------------------------------------------------
local Labels = {
	["1"] = {
		{
			event = "chest:Open",
			label = "Compartimento Geral",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Open",
			label = "Compartimento Pessoal",
			tunnel = "shop",
			service = "Personal"
		},{
			event = "chest:Open",
			label = "Compartimento Evidências",
			tunnel = "shop",
			service = "Evidences"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["2"] = {
		{
			event = "chest:Open",
			label = "Abrir",
			tunnel = "shop",
			service = "Normal"
		},{
			event = "chest:Upgrade",
			label = "Aumentar",
			tunnel = "server"
		}
	},
	["3"] = {
		{
			event = "chest:Open",
			label = "Balcão",
			tunnel = "shop",
			service = "Normal"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Name,v in pairs(Chests) do
		exports["target"]:AddCircleZone("Chest:"..Name,v["Coords"],1.0,{
			name = "Chest:"..Name,
			heading = 3374176
		},{
			Distance = 1.7,
			shop = v["Name"],
			options = Labels[v["Mode"]]
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('chest:Open')
AddEventHandler("chest:Open",function(Name,Init,weight)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(Name,Init,weight) then
			SetNuiFocus(true,true)
			SendNUIMessage({ Action = "Open" })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Take",function(Data,Callback)
	vSERVER.Take(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Store",function(Data,Callback)
	vSERVER.Store(Data["item"],Data["slot"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Update",function(Data,Callback)
	vSERVER.Update(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chest",function(Data,Callback)
	local Inventory,Chest,invPeso,invMaxpeso,chestPeso,chestMaxpeso = vSERVER.Chest()
	if Inventory then
		Callback({ Inventory = Inventory, Chest = Chest, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Update")
AddEventHandler("chest:Update",function(Action,invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ Action = Action, invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:Close")
AddEventHandler("chest:Close",function(Action)
	SendNUIMessage({ Action = "Close" })
	SetNuiFocus(false,false)
end)