-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("chest",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Open = {}

local Webhooks = {
	["Personal"] = {
		"https://discord.com/api/webhooks/1156158629188210718/nbud5TYAqEtzXJkoAhiWlxBYrLHchs0zAMOtQ9LHmpI2Q7KhKGpxkoI4krDy6H-yFmMd",
	
	},
	["Evidences"] = {
		"https://discord.com/api/webhooks/1156158973595107339/q-x6bLlu2TMUxEs9u_s9xlPKLD8eYfS3Uk8DVME9j3-0VEYd4yU7YIoSMGqOBl3b0KBy",
		
	},
	["Police"] = {
		"https://discord.com/api/webhooks/1156159404341727252/bOQyjIxmLLkCljZk-KzbdM6fyN-5mqpr_LCf2wxdHNUx2wGX5yjym2Pei89dzKm6DBxe",
	
	},
	["Mechanic"] = {
		"https://discord.com/api/webhooks/1156159711830355998/bvFlSb4t0ofzU7ZTqzvXwqNku8UEk9XP_hA4pJBt65rofySXLWZ73BJJLYAmpARbbgtc",
	
	},
	["Ballas"] = {
		"https://discord.com/api/webhooks/1156159995763757147/YL3znsrcQ6W649U6zmOIBZOzAjRl9dk2L94oLTTKwni9RX5EtX9ctI9AOdtX7XHfwayv",
	},
	["Families"] = {
		"https://discord.com/api/webhooks/1156160522157305856/Rtp6hG7lHR83JM0oz-A0Xd-9fcY8EGmHLiBgYp4kxa3wH2VU-M7VQyuW_OKoB3INv4ei"
	},
	["Vagos"] = {
		"https://discord.com/api/webhooks/1156160875409985587/1WF9Txn9StJDGjbqIh615eplHhcafOAMFQlcanPaPP0sPogCBCkPMDLpmMjVW_gHS3Nk",

	},
	["Bennys"] = {
		"https://discord.com/api/webhooks/1156161690438750228/cl3Kvjk12cTb8j8s_VpJTS_ejt3iEzsyxarFjwTB19r1qe-olVt3A_VSR-jRKjcdXYa9",
	
	},
	["Yakuza"] = {
		"https://discord.com/api/webhooks/1167862134013706240/WY8iKsgZBNY5KwDck6whOUXVxcd6p29fjJSGHHgB1oXcS4xNn_E0lCu84pobreHNHB4B",
	},
	["BurgerShot"] = {
		"https://discord.com/api/webhooks/1156162084359376936/XioylfQz9OoOfV633i9eJpI1xF2hznRpuy8znCavB7bSxjQg4ns6b0Ov1c_I6O44Q2pT",
		
	},
	["Digitalden"] = {
		"https://discord.com/api/webhooks/1156163554613923890/IyOgGy7eBtUbhIbupEbhArOsGrGHZ9MdC7Kn7X0-V1De9eqhj5O3L3H6-CGDNCEr4mV6",
		
	},
	["Pawnshop"] = {
		"https://discord.com/api/webhooks/1156164857180201073/i98tXJU_pLhfSRymmoyU_c-6HMlE-LlQ-f3VdjnPsNE0sKBt6uP5jrdasfncdfVMFVjh",
		
	},
	["Yellow"] = {
		"https://discord.com/api/webhooks/1156173052212678657/6ZcJVpvgjQssfBdcRc3DtL_PNUJ_kVI46bRCq_z_cMcxO1a2qdi1uN_JJoz3zsT1na3T",
		
	},
	["Cosanostra"] = {
		"https://discord.com/api/webhooks/1156173599221227591/p0ptg1vwK777QJP8rDiz2AIL2ZXvvGRHX82voNffsDTkCOaTmmDtsEjh9K0vlmbmqjIr",
		
	},
	["Bloods"] = {
		"https://discord.com/api/webhooks/1156173780176093255/_eIaveO5V6UasJzbbvpnvo7I80pC5N84NEYukm9nckJPXmAxm8xt9-LRjxxWAB0mfCkJ",

	},
	["Uwucoffee"] = {
		"https://discord.com/api/webhooks/1156176055749587055/mGsOSXoDeQSztZ3gFtQqrEUMaNHKL-xTt71pxUIk-MvSLgy3WeZ5ecnjY2XPinmizbTb",
		
	},
	["Mechanic68"] = {
		"https://discord.com/api/webhooks/1156176294065741854/vdqBwyTv22-6SVRqYDOu1K5aKrsWtoh85NdwYotSZEHQE5do2v_w80MHj1ea2V274bDA",
		
	},
	["Mafia"] = {
		"https://discord.com/api/webhooks/1156177462007431270/2hN3QM_qOHQ4Svyghrj6bkQ3-K_HOR-2EEEbbqcYSK6odyGmVUYqoBIEiW71fFyBlp8N",
		
	},
	["LSCustoms"] = {
		"https://discord.com/api/webhooks/1156177591896653844/d1s3KJ1CQJs9KPBXyEMxXlcSt8fyR7R-Np2asoLsK128zQyEQ5yqyIvrcwZOMZuAhCPY"
	},
	

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Permissions(Name,Mode,weight)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Mode == "Personal" then
			Open[Passport] = { ["Name"] = "Personal:"..Passport, ["Weight"] = 50, ["Logs"] = false, ["Save"] = true }
			return true
		elseif Mode == "Evidences" and vRP.HasService(Passport,"Police") then
			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Keyboard then
				Open[Passport] = { ["Name"] = "Evidences:"..Keyboard[1], ["Weight"] = 50, ["Logs"] = false, ["Save"] = true }
				return true
			end
		elseif Mode == "Custom" then
			Open[Passport] = { ["Name"] = Name, ["Weight"] = 50, ["Logs"] = true, ["Save"] = false }
			return true
		elseif Mode == "SNT" then
			Open[Passport] = { ["Name"] = Name, ["Weight"] = weight, ["Save"] = true }
			return true
		else
			if Name == "trayPwnshp"  or Name == "trayUwuCoff"  or Name == "trayPrls1"  or Name == "trayPrls2" or Name == "trayTql1" or Name == "trayTql2" or Name == "trayShot" or Name == "trayDigital" or Name == "trayPawn" or Name == "trayBlaze" or Name == "trayDigital" then
				Open[Passport] = { ["Name"] = Name, ["Weight"] = 200, ["Logs"] = false, ["Save"] = true }
				return true
			end

			local Consult = vRP.Query("chests/GetChests",{ name = Name })
			if Consult[1] and vRP.HasService(Passport,Consult[1]["perm"]) then
				Open[Passport] = { ["Name"] = Name, ["Weight"] = Consult[1]["weight"], ["Logs"] = Consult[1]["logs"], ["Save"] = true }
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Chest()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		local Inventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			Inventory[Index] = v
		end

		local Chest = {}
		local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
		for Index,v in pairs(Result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = Index

			local Split = splitString(v["item"],"-")
			if Split[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - Split[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			Chest[Index] = v
		end

		return Inventory,Chest,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local OpenItens = {
	["mechanicpass"] = {
		["Open"] = "Mechanic",
		["Table"] = {
			{ ["Item"] = "advtoolbox", ["Amount"] = 1 },
			{ ["Item"] = "toolbox", ["Amount"] = 2 },
			{ ["Item"] = "tyres", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["uwucoffeepass"] = {
		["Open"] = "Uwucoffee",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["pizzathispass"] = {
		["Open"] = "PizzaThis",
		["Table"] = {
			{ ["Item"] = "nigirizushi", ["Amount"] = 3 },
			{ ["Item"] = "sushi", ["Amount"] = 3 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["burgershotpass"] = {
		["Open"] = "BurgerShot",
		["Table"] = {
			{ ["Item"] = "hamburger2", ["Amount"] = 1 },
			{ ["Item"] = "cookedmeat", ["Amount"] = 2 },
			{ ["Item"] = "cookedfishfillet", ["Amount"] = 1 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	},
	["paramedicpass"] = {
		["Open"] = "Paramedic",
		["Table"] = {
			{ ["Item"] = "gauze", ["Amount"] = 3 },
			{ ["Item"] = "medkit", ["Amount"] = 1 },
			{ ["Item"] = "analgesic", ["Amount"] = 4 },
			{ ["Item"] = "dollars", ["Amount"] = 200 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Store(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if itemBlock(Item) then
			TriggerClientEvent("chest:Update",source,"Refresh")

			return true
		end

		if OpenItens[Item] and OpenItens[Item]["Open"] == Open[Passport]["Name"] then
			if vRP.TakeItem(Passport,Item,1) then
				for _,v in pairs(OpenItens[Item]["Table"]) do
					vRP.GenerateItem(Passport,v["Item"],v["Amount"])
				end
			end

			TriggerClientEvent("chest:Update",source,"Refresh")

			return true
		end

		if vRP.StoreChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Open[Passport]["Weight"],Slot,Target,true) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

			for k,v in pairs(Webhooks) do
				if string.find(Open[Passport]["Name"], k) then
					for _,webhook in pairs(v) do
						vRP.SendWebhook(webhook, "LOGs BAÚ GUARDOU", "**Passaporte: **"..Passport.."\n**Guardou: **x"..Amount.." "..Item.."\n**Baú: **"..Open[Passport]["Name"], 7065707)
					end
				end
			end

			if Open[Passport]["Logs"] then
				TriggerEvent("Discord",Open[Passport]["Name"],"**Passaporte:** "..Passport.."\n**Guardou:** "..Amount.."x "..itemName(Item),3042892)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Take(Item,Slot,Amount,Target)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeChest(Passport,"Chest:"..Open[Passport]["Name"],Amount,Slot,Target,true) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		else
			local Result = vRP.GetSrvData("Chest:"..Open[Passport]["Name"],Open[Passport]["Save"])
			TriggerClientEvent("chest:Update",source,"Update",vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Result),Open[Passport]["Weight"])

			if string.sub(Open[Passport]["Name"],1,9) == "Helicrash" and vRP.ChestWeight(Result) <= 0 then
				TriggerClientEvent("chest:Close",source)
				exports["helicrash"]:Box()
			end
			
			for k,v in pairs(Webhooks) do
				if string.find(Open[Passport]["Name"], k) then
					for _,webhook in pairs(v) do
						vRP.SendWebhook(webhook, "LOGs BAÚ RETIROU", "**Passaporte: **"..Passport.."\n**Retirou: **x"..Amount.." "..Item.."\n**Baú: **"..Open[Passport]["Name"], 16726610)
					end
				end
			end

			if Open[Passport]["Logs"] then
				TriggerEvent("Discord",Open[Passport]["Name"],"**Passaporte:** "..Passport.."\n**Retirou:** "..Amount.."x "..itemName(Item),9317187)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport and Open[Passport] then
		if Amount <= 0 then Amount = 1 end

		if vRP.Update(Passport,"Chest:"..Open[Passport]["Name"],Slot,Target,Amount) then
			TriggerClientEvent("chest:Update",source,"Refresh")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("chest:Upgrade")
AddEventHandler("chest:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasService(Passport,Name) then
			if vRP.Request(source,"Aumentar <b>50Kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.PaymentFull(Passport,10000) then
					vRP.Query("chests/UpdateChests",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Open[Passport] then
		Open[Passport] = nil
	end
end)