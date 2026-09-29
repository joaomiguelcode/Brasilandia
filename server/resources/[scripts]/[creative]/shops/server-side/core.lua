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
Tunnel.bindInterface("shops",Creative)
vCLIENT = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookshops = "https://discord.com/api/webhooks/1156486903957291008/kDLRZk8l3ebBLg2QKlV1LeptKyZHlyGOq75AXW_3bVPdNOJlLvp9RQwJv3Xsr3eZU9wO"
local webhookshopsvendas = "https://discord.com/api/webhooks/1156486964099424286/DZoUax3g5akjOLd_A_e0AgWpJ6-MvPG76RqjGpQeSbCRAoGcrXTXGbcsno6SRwkzpcOQ"
local webhooklojapremium = "https://discord.com/api/webhooks/1156487140507668520/-z3ZINFk6ABBM4W0d4m6PcFxpYpBJ05WhgpEcsXo3nitPbz1Fbb7KQsbUn8EIxLKTDx4"
local shops = {
	-- ["Identity"] = {
	-- 	["mode"] = "Buy",
	-- 	["type"] = "Cash",
	-- 	["List"] = {
	-- 		["identity"] = 200
	-- 	}
	-- },
	["Identity2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["fidentity"] = 5000
		}
	},
	["Maconha"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["tableweed"] = 100000,
			["weedclone"] = 5000,
			["repairkit02"] = 20000 
		}
	},
	["Roupaspecas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["chapeu"] = 150,
			["jaqueta"] = 210,
			["camisa"] = 150,
			["calca"] = 210,
			["sapato"] = 175,
			["mao"] = 125,
			["mascara"] = 315,     
			["oculos"] = 80
		}
	},

	["Departament"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["postit"] = 50,
			["notepad"] = 30,
			["water"] = 50,
			["cigarette"] = 10,
			["lighter"] = 175,
			["rose"] = 25,
			["sal"] = 15,     
			["sandwich"] = 80,
			["soap"] = 325,
			["sugar"] = 15,        
			["energetico"] = 1000,
			["backpack"] = 2000,
			["bread"] = 20,
			["ziplock"] = 20
		}
	},
	["Mechanic2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Mechanic",
		["List"] = {
			["toolbox"] = 400,
			["WEAPON_CROWBAR"] = 800,
			["WEAPON_WRENCH"] = 800,
			["kitlimpeza"] = 50
		}
	},
	["Mechanic68"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
			["minPerm"] = {
				["perm"] = "Mechanic68",
				["min"] = 1
			},
		["List"] = {
			["tyres"] = 450,
			["toolbox"] = 800,
			["advtoolbox"] = 1500,
			["WEAPON_CROWBAR"] = 2500,
			["WEAPON_WRENCH"] = 1500,
			["kitlimpeza"] = 450
		}
	},
	["Mechanic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
			["minPerm"] = {
				["perm"] = "Mechanic",
				["min"] = 1
			},
		["List"] = {
			["tyres"] = 450,
			["toolbox"] = 800,
			["advtoolbox"] = 1500,
			["WEAPON_CROWBAR"] = 2500,
			["WEAPON_WRENCH"] = 1500,
			["kitlimpeza"] = 450
		}
	},
	["MechanicPaleto"] = {
		["mode"] = "Buy",
		["type"] = "Cash",

		-- ["minPerm"] = {
		-- 	perm = "Mechanic",
		-- 	min = 3
		-- },
		["List"] = {
			["tyres"] = 450,
			["toolbox"] = 800,
			["advtoolbox"] = 1500,
			["WEAPON_CROWBAR"] = 2500,
			["WEAPON_WRENCH"] = 1500,
			["kitlimpeza"] = 450
		}
	},
	["Fuel"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["WEAPON_PETROLCAN"] = 250
		}
	},
	["Oxy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["oxy"] = 35
		}
	},
	["Paramedic"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["List"] = {
			["badge02"] = 1,
			["defibrillator"] = 10,
			["medicbag"] = 10,
			["medicbed"] = 25,
			["medkit1"] = 10,
			["gdtkit"] = 50,
			["adrenaline"] = 1500,
			["bandage"] = 100,
			["gauze"] = 100,
			["medkit"] = 500,
			["sinkalmy"] = 10,
			["ritmoneury"] = 30,
			["analgesic"] = 20
		}
	},
	["Tequila"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Tequila",
		["List"] = {
			["absolut"] = 150,
			["dewars"] = 150,
			["hennessy"] = 150,
			["chandon"] = 150,
			["soda"] = 150,
			["cola"] = 150,
		}
	},
	["Pharmacy"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["bandage"] = 300,
			["gauze"] = 200,
			["medkit"] = 600,
			["sinkalmy"] = 30,
			["ritmoneury"] = 70,
			["analgesic"] = 50,
			["adrenaline"] = 2500
		}
	},

	["Megamall"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["pliers"] = 150,
			["dices"] = 20,
			["notepad"] = 30,
			["GADGET_PARACHUTE"] = 1000,
			["postit"] = 100,
			["tyres"] = 800,
			["teddy"] = 150,
			["suitcase"] = 275,
			["firecracker"] = 150,
			["fenda"] = 150,
			["terra"] = 50,
			["vazo"] = 50,
			["rope"] = 350,
			["kitlimpeza"] = 450
		}
	},
	["Ammunation"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["WEAPON_HATCHET"] = 975,
			["WEAPON_BAT"] = 975,
			["WEAPON_BATTLEAXE"] = 975,
			["WEAPON_GOLFCLUB"] = 975,
			["WEAPON_HAMMER"] = 975,
			["WEAPON_MACHETE"] = 975,
			["WEAPON_POOLCUE"] = 975,
			["WEAPON_KNUCKLE"] = 975,
			["WEAPON_KATANA"] = 1975,
			["WEAPON_FLASHLIGHT"] = 975,
			["pickaxe"] = 525,
			["WEAPON_KARAMBIT"] = 1200,
		}
	},
	["Premium"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["List"] = {
			["premium1"] = 50,
			["premium2"] = 100,
			["premium3"] = 270,
			["premiumplate"] = 25,
			["newchars"] = 50,
			["slotgaragem"] = 50,
			["chip"] = 60,

			
			-- ["cachorrinhoazul"] = 25,
			-- ["cachorrinhobeje"] = 25,
			-- ["mochilacouro"] = 25,
			-- ["mochilacouropreta"] = 25,
			-- ["mochilaoriental"] = 25,
			-- ["mochilaenergetico"] = 25,
			-- ["mochilamilitar"] = 25,
			["bolsapreta"] = 25,
		}
	},
	["Hunting"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["meat"] = 10,
			["leather"] = 10,
			["animalfat"] = 30
		}
	},
	["Information"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["folhetopd"] = 1000,
			--["folhetopinxar"] = 5000,
			["identity"] = 1000,
			["autorizacao"] = 500
			--["tabletorg"] = 2000,
			--["folhetolavagem"] = 1000
		}
	},
	["Frutas"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["acerola"] = 5,
			["guarana"] = 5,
			["passion"] = 5,
			["tomato"] = 5,
			["orange"] = 5,
			["alface"] = 5,
			["potato"] = 5,
			["grape"] = 5,
			["tange"] = 5,
			["apple"] = 5,
			["strawberry"] = 5
		}
	},
	["Reciclagem1"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["reciclavel"] = 10,
		}
	},
	["Digital"] = {
		["mode"] = "Buy",
		["item"] = 'reciclavel',
		['Digital'] = true,
		["type"] = "Consume",
		["perm"] = "Digitalden",
		["List"] = {
			["smarthwatch"] = {need = 40, recieve = 80},
			["phone"] = {need = 40, recieve = 80},
			["camera"] = {need = 40, recieve = 240},
			["xbox"] = {need = 40, recieve = 160}, 
			["playstation"] = {need = 40, recieve = 160},
			["smartphone"] = {need = 40, recieve = 160}


		}
	},

	

	["Pawnshop3"] = {
		["mode"] = "Buy",
		["item"] = 'reciclavel',
		['Digital'] = true,
		["type"] = "Consume",
		["perm"] = "Pawnshop",
		["List"] = {
			["goldring"] = {need = 10, recieve = 30},
			["bracelet"] = {need = 10, recieve = 40},
			["brincodeouro"] = {need = 10, recieve = 30},
			["correntedeouro"] = {need = 10, recieve = 30}, 
			["watch"] = {need = 10, recieve = 30}

		}
	},

	["Fishing"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["octopus"] = 30,
			["carp"] = 10,
			["horsefish"] = 10,
			["tilapia"] = 10,
			["codfish"] = 10,
			["catfish"] = 10,
			["pirarucu"] = 10,
			["pacu"] = 10,
		}
	},
	["Hunting2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["switchblade"] = 250,
			["WEAPON_MUSKET"] = 250,
			["WEAPON_MUSKET_AMMO"] = 5,
			["WEAPON_STONE_HATCHET"] = 500,
			["racaosilvestre"] = 5,
			["PA"] = 500,
			["registro"] = 1000,

		}
	},
	["Fishing2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["bait"] = 5,
			["scuba"] = 1500,
			["fishingrod"] = 500
		}
	},
	["Minerador"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["coal"] = 15,
			["sulfur"] = 20,
			["aluminum"] = 15,
			["copper"] = 15
		},
	},
	["coffeeMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["coffee"] = 900
		}
	},
	["sodaMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["cola"] = 900,
			["soda"] = 900
		}
	},
	["donutMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["donut"] = 900,
			["chocolate"] = 900
		}
	},
	["burgerMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hamburger"] = 900
		}
	},
	["Ilegal"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["moladearma"] = 10000,
			["capsula"] = 10,
		}
	},
	["Refeitorio"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["sandwich"] = 60,
			["water"] = 60		
		}
	},
	["hotdogMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hotdog"] = 900
		}
	},
	["Chihuahua"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["hotdog"] = 900,
			["hamburger"] = 900,
			["coffee"] = 1500,
			["cola"] = 1500,
			["soda"] = 1500
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["water"] = 500
		}
	},
	["Police"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["List"] = {
			["vest"] = 400,
			["gsrkit"] = 20,
			["gdtkit"] = 20,
			["barrier"] = 20,
			["handcuff"] = 500,
			["WEAPON_COMBATPISTOL"] = 1000,
			["WEAPON_NIGHTSTICK"] = 200,
			["WEAPON_PISTOL_POLICE"] = 2,
			["badge01"] = 1,
			["megaphone"] = 50,
			["WEAPON_FLASHLIGHT"] = 300,
			["WEAPON_STUNGUN"] = 525,
			["energetico"] = 20,
			["rope"] = 150,
			["radio"] = 800,
			["scuba"] = 200,
			["pliers"] = 50,
			["WEAPON_SMG"] = 775,
			-- ["WEAPON_PUMPSHOTGUN"] = 775,
			-- ["WEAPON_CARBINERIFLE"] = 775,
			-- ["WEAPON_CARBINERIFLE_MK2"] = 925,


			["WEAPON_SMG_AMMO"] = 5,
			--["WEAPON_RIFLE_AMMO"] = 6,
			--["WEAPON_SHOTGUN_AMMO"] = 5,

			["WEAPON_SMOKEGRENADE"] = 75,
			["attachsFlashlight"] = 1750,
			["attachsCrosshair"] = 1750,
			["attachsSilencer"] = 1750,
			["attachsMagazine"] = 1750,
			["attachsGrip"] = 1750,

		}
	},
	["Pawnshop2"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
 			 ["bracelet"] = 40,
			 ["brincodeouro"] = 25,
			 ["correntedeouro"] = 25,
			 ["watch"] = 40,
			 ["goldring"] = 50,
			 ["diamond"] = 3000,
		}
	},

	["Pawnshop4"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["perm"] = "Pawnshop",
		["List"] = {
			["bracelet"] = 40,
			["brincodeouro"] = 25,
			["correntedeouro"] = 25,
			["watch"] = 40,
			["goldring"] = 50,
			["diamond"] = 3000,
		}
	},
	["Digitalden1"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["perm"] = "Digitalden",
		["List"] = {
 			 ["camera"] = 100,
			 ["phone"] = 30,
			 ["playstation"] = 70,
			 ["smarthwatch"] = 30,
			 ["xbox"] = 70,
			 ["smartphone"] = 70,
		}
	},
	["Digitaldenpublico"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
 			 ["camera"] = 50,
			 ["phone"] = 15,
			 ["playstation"] = 35,
			 ["smarthwatch"] = 15,
			 ["xbox"] = 35,
			 ["smartphone"] = 35,
		}
	},
	["Corrida"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
 			 ["credential"] = 1000,
		}
	},
	["Digitalden2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["minPerm"] = {
			["perm"] = "Digitalden",
			["min"] = 1
		},
		["List"] = {
 			 ["cellphone"] = 1100,
			 ["repairkit04"] = 400,
			 ["vape"] = 1300,
			 ["tabletorg"] = 2000,
			 ["pendrive"] = 350,
		}
	},
	["Pawnshop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["minPerm"] = {
			["perm"] = "Pawnshop",
			["min"] = 1
		},
		["List"] = {
 			 ["radio"] = 1500,
			 ["scanner"] = 800,
			 ["repairkit03"] = 900,
			 ["rope"] = 350,
		
		}
	},
	["Megamall2"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["List"] = {
			["teddy"] = 20,
			["pliers"] = 40,
			["binoculars"] = 50,
			["switchblade"] = 60,
			["WEAPON_BAT"] = 80,
		}
	},
	["Dominacao"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["List"] = {
			["sprays02"] = 120000,
			["tinner"] = 50000

		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = { "James","John","Robert","Michael","William","David","Richard","Charles","Joseph","Thomas","Christopher","Daniel","Paul","Mark","Donald","George","Kenneth","Steven","Edward","Brian","Ronald","Anthony","Kevin","Jason","Matthew","Gary","Timothy","Jose","Larry","Jeffrey","Frank","Scott","Eric","Stephen","Andrew","Raymond","Gregory","Joshua","Jerry","Dennis","Walter","Patrick","Peter","Harold","Douglas","Henry","Carl","Arthur","Ryan","Roger","Joe","Juan","Jack","Albert","Jonathan","Justin","Terry","Gerald","Keith","Samuel","Willie","Ralph","Lawrence","Nicholas","Roy","Benjamin","Bruce","Brandon","Adam","Harry","Fred","Wayne","Billy","Steve","Louis","Jeremy","Aaron","Randy","Howard","Eugene","Carlos","Russell","Bobby","Victor","Martin","Ernest","Phillip","Todd","Jesse","Craig","Alan","Shawn","Clarence","Sean","Philip","Chris","Johnny","Earl","Jimmy","Antonio" }
local nameFemale = { "Mary","Patricia","Linda","Barbara","Elizabeth","Jennifer","Maria","Susan","Margaret","Dorothy","Lisa","Nancy","Karen","Betty","Helen","Sandra","Donna","Carol","Ruth","Sharon","Michelle","Laura","Sarah","Kimberly","Deborah","Jessica","Shirley","Cynthia","Angela","Melissa","Brenda","Amy","Anna","Rebecca","Virginia","Kathleen","Pamela","Martha","Debra","Amanda","Stephanie","Carolyn","Christine","Marie","Janet","Catherine","Frances","Ann","Joyce","Diane","Alice","Julie","Heather","Teresa","Doris","Gloria","Evelyn","Jean","Cheryl","Mildred","Katherine","Joan","Ashley","Judith","Rose","Janice","Kelly","Nicole","Judy","Christina","Kathy","Theresa","Beverly","Denise","Tammy","Irene","Jane","Lori","Rachel","Marilyn","Andrea","Kathryn","Louise","Sara","Anne","Jacqueline","Wanda","Bonnie","Julia","Ruby","Lois","Tina","Phyllis","Norma","Paula","Diana","Annie","Lillian","Emily","Robin" }
local userName2 = { "Smith","Johnson","Williams","Jones","Brown","Davis","Miller","Wilson","Moore","Taylor","Anderson","Thomas","Jackson","White","Harris","Martin","Thompson","Garcia","Martinez","Robinson","Clark","Rodriguez","Lewis","Lee","Walker","Hall","Allen","Young","Hernandez","King","Wright","Lopez","Hill","Scott","Green","Adams","Baker","Gonzalez","Nelson","Carter","Mitchell","Perez","Roberts","Turner","Phillips","Campbell","Parker","Evans","Edwards","Collins","Stewart","Sanchez","Morris","Rogers","Reed","Cook","Morgan","Bell","Murphy","Bailey","Rivera","Cooper","Richardson","Cox","Howard","Ward","Torres","Peterson","Gray","Ramirez","James","Watson","Brooks","Kelly","Sanders","Price","Bennett","Wood","Barnes","Ross","Henderson","Coleman","Jenkins","Perry","Powell","Long","Patterson","Hughes","Flores","Washington","Butler","Simmons","Foster","Gonzales","Bryant","Alexander","Russell","Griffin","Diaz","Hayes" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestPerm(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if exports["hud"]:Wanted(Passport,source) then
			return false
		end

		--print(Type,shops[Type])
		if shops[Type]["perm"] ~= nil then
			if not vRP.HasService(Passport,shops[Type]["perm"]) then
				return false
			end
		end

		if shops[Type]["minPerm"] then
			local Service, Amount = vRP.NumPermission(shops[Type]["minPerm"].perm)
			if Amount >= shops[Type]["minPerm"].min  then
				TriggerClientEvent("Notify",source,"vermelho","Você não pode fazer isso agora",5000)
				return false
			end
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestShop(name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local shopSlots = 20
		local inventoryShop = {}
		for k,v in pairs(shops[name]["List"]) do
			inventoryShop[#inventoryShop + 1] = { key = k, price = parseInt(v), name = itemName(k), index = itemIndex(k), peso = itemWeight(k), economy = parseFormat(itemEconomy(k)), max = itemMaxAmount(k), desc = itemDescription(k) }
		end

		local inventoryUser = {}
		local inventory = vRP.Inventory(Passport)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end

		if parseInt(#inventoryShop) > 20 then
			shopSlots = parseInt(#inventoryShop)
		end

		return inventoryShop,inventoryUser,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),shopSlots
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.getShopType(Type)
    return shops[Type]["mode"]
end---------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionShops(Type,Item,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if shops[Type] then
			if Amount <= 0 then Amount = 1 end

			local inventory = vRP.Inventory(Passport)
			if (inventory[tostring(Slot)] and inventory[tostring(Slot)]["item"] == Item) or not inventory[tostring(Slot)] then
				if shops[Type]["mode"] == "Buy" then
					if vRP.MaxItens(Passport,Item,Amount) then
						TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
						vCLIENT.updateShops(source,"requestShop")
						return
					end

					if (vRP.InventoryWeight(Passport) + itemWeight(Item) * Amount) <= vRP.GetWeight(Passport) then
						if shops[Type]["type"] == "Cash" then
							if shops[Type]["List"][Item] then
								if vRP.PaymentFull(Passport,shops[Type]["List"][Item] * Amount) then
									if Item == "identity" or string.sub(Item,1,5) == "badge" then
										vRP.GiveItem(Passport,Item.."-"..Passport,Amount,false,Slot)
									elseif Item == "fidentity" then
										local Identity = vRP.Identity(Passport)
										if Identity then
											if Identity["sex"] == "M" then
												vRP.Query("fidentity/NewIdentity",{ name = nameMale[math.random(#nameMale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											else
												vRP.Query("fidentity/NewIdentity",{ name = nameFemale[math.random(#nameFemale)], name2 = userName2[math.random(#userName2)], blood = math.random(4) })
											end

											local Identity = vRP.Identity(Passport)
											local consult = vRP.Query("fidentity/GetIdentity")
											if consult[1] then
												vRP.GiveItem(Passport,Item.."-"..consult[1]["id"],Amount,false,Slot)
											end
										end
									else
										vRP.GenerateItem(Passport,Item,Amount,false,Slot)

										if Item == "WEAPON_PETROLCAN" then
											vRP.GenerateItem(Passport,"WEAPON_PETROLCAN_AMMO",4500,false)
										end
									end

									TriggerClientEvent("sounds:Private",source,"cash",0.1)
									vRP.SendWebhook(webhookshops, "LOGs Compras Shops", "**Passaporte: **"..Passport.."\n**Comprou: **"..Amount.."x "..Item, 46080)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						elseif shops[Type]["type"] == "Consume" then
							if shops[Type]["Digital"] then
								if vRP.TakeItem(Passport,Item,parseInt(shops[Type]["List"][Item]['need'] * Amount)) then
									vRP.GenerateItem(Passport,'reciclavel',shops[Type]["List"][Item]['recieve'],false,Slot)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>"..Item.."</b> insuficiente.",5000)
								end
							else
								if vRP.TakeItem(Passport,shops[Type]["item"],parseInt(shops[Type]["List"][Item] * Amount)) then
									vRP.GenerateItem(Passport,Item,Amount,false,Slot)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(shops[Type]["item"]).."</b> insuficiente.",5000)
								end
							end
						elseif shops[Type]["type"] == "Premium" then
							if vRP.PaymentGems(Passport,shops[Type]["List"][Item] * Amount) then
								TriggerClientEvent("sounds:Private",source,"cash",0.1)
								vRP.GenerateItem(Passport,Item,Amount,false,Slot)
								TriggerClientEvent("Notify",source,"verde","Comprou <b>"..Amount.."x "..itemName(Item).."</b> por <b>"..shops[Type]["List"][Item] * Amount.." Gemas</b>.",5000)
								vRP.SendWebhook(webhooklojapremium, "LOGs Loja Premium", "**Passaporte: **"..Passport.."\n**Comprou: **x"..Amount.." "..itemName(Item), 10357504)
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				elseif shops[Type]["mode"] == "Sell" then
					local splitName = splitString(Item,"-")

					if shops[Type]["List"][splitName[1]] then
						local itemPrice = shops[Type]["List"][splitName[1]]

						if itemPrice > 0 then
							if vRP.CheckDamaged(Item) then
								TriggerClientEvent("Notify",source,"vermelho","Itens danificados não podem ser vendidos.",5000)
								vCLIENT.updateShops(source,"requestShop")
								return
							end
						end

						if shops[Type]["type"] == "Cash" then
							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								if itemPrice > 0 then
									if Type == "Hunting" or Type == "Fishing" then
										FamilyExperience(source)
									end
									vRP.GenerateItem(Passport,"dollars",parseInt(itemPrice * Amount),false)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)
									vRP.SendWebhook(webhookshopsvendas, "LOGs Shops Vendas", "**Passaporte: **"..Passport.."\n**Vendeu ao NPC: **"..Amount.."x "..Item.."\n**E recebeu: **"..parseInt(itemPrice * Amount).." dólares limpos", 10357504)
								end
							end
						elseif shops[Type]["type"] == "Consume" then
							if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
								if itemPrice > 0 then
									vRP.GenerateItem(Passport,shops[Type]["item"],parseInt(itemPrice * Amount),false)
									TriggerClientEvent("sounds:Private",source,"cash",0.1)


									if shops[Type]["type"] == "meat" then
										if vRP.TakeItem(Passport,Item,Amount,true,Slot) then
											if itemPrice > 0 then
												vRP.GenerateItem(Passport,"water",parseInt(itemPrice * Amount),false)
												TriggerClientEvent("sounds:Private",source,"cash",0.1)
											end
										end
									end
									
									
								end
							end
						end
					end
				end
			end
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FAMILYEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function FamilyExperience(Source)
    local Player = Player(Source)["state"]
	local Passport = vRP.Passport(Source)
    if Player["Family"] then
        local XpAmount = math.random(25,35)		
		TriggerEvent("us_families:AddXP",Passport,Player["Family"],XpAmount,"Crafting")
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			vCLIENT.updateShops(source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local inventory = vRP.Inventory(Passport)
		if inventory[tostring(Slot)] and inventory[tostring(Target)] and inventory[tostring(Slot)]["item"] == inventory[tostring(Target)]["item"] then
			if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
				vRP.GiveItem(Passport,Item,Amount,false,Target)
			end
		else
			vRP.SwapSlot(Passport,Slot,Target)
		end

		vCLIENT.updateShops(source,"requestShop")
	end
end)