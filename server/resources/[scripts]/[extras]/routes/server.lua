-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("routes",cRP)
vCLIENT = Tunnel.getInterface("routes")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local rotas = {
	["Ballas"] = { 
		itens = { 
			{
				name = "Soro fisiologico",
				image = "saline",
				quantidade = 1,
				item = "saline"
			},
			{
				name = "Explosivo",
				image = "explosives",
				quantidade = 1,
				item = "explosives"
			},
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Acetona",
				image = "acetone",
				quantidade = 1,
				item = "acetone"
			}
		}
	},
	["Families"] = { 
		itens = { 
			{
				name = "Soro fisiologico",
				image = "saline",
				quantidade = 1,
				item = "saline"
			},
			{
				name = "Explosivo",
				image = "explosives",
				quantidade = 1,
				item = "explosives"
			},
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Acido Sulfurico",
				image = "sulfuric",
				quantidade = 1,
				item = "sulfuric"
			}
		}
	},
	["Bloods"] = { 
		itens = { 
			{
				name = "Soro fisiologico",
				image = "saline",
				quantidade = 1,
				item = "saline"
			},
			{
				name = "Explosivo",
				image = "explosives",
				quantidade = 1,
				item = "explosives"
			},
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Acetona",
				image = "acetone",
				quantidade = 1,
				item = "acetone"
			}
		}
	},
	["Vagos"] = { 
		itens = { 
			{
				name = "Folha de cocaina",
				image = "cokeleaf",
				quantidade = 1,
				item = "cokeleaf"
			},
			{
				name = "Explosivo",
				image = "explosives",
				quantidade = 1,
				item = "explosives"
			},
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Acido Sulfurico",
				image = "sulfuric",
				quantidade = 1,
				item = "sulfuric"
			}
		}
	},
	["Cosanostra"] = { 
		itens = { 
			{
				name = "Capsula",
				image = "capsula",
				quantidade = 2,
				item = "capsula"
			},
			{
				name = "Projetil",
				image = "projetil",
				quantidade = 2,
				item = "projetil"
			},
			{
				name = "Polvora",
				image = "polvora",
				quantidade = 2,
				item = "polvora"
			}
		}
	},
	["metanfetamina"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 10,
				item = "copper"
			},
			{
				name = "Placa de Metal",
				image = "sheetmetal",
				quantidade = 10,
				item = "sheetmetal"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 10,
				item = "aluminum"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Soro Fisiologico",
				image = "saline",
				quantidade = 2,
				item = "saline"
			},
			{
				name = "Acetona",
				image = "acetone",
				quantidade = 2,
				item = "acetone"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 10,
				item = "glass"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 10,
				item = "plastic"
			}
		}
	},
	["lean"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 10,
				item = "copper"
			},
			{
				name = "Placa de Metal",
				image = "sheetmetal",
				quantidade = 10,
				item = "sheetmetal"
			},
			{
				name = "Soro Fisiologico",
				image = "saline",
				quantidade = 2,
				item = "saline"
			},
			{
				name = "Acido sufurico",
				image = "sulfuric",
				quantidade = 2,
				item = "sulfuric"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 10,
				item = "aluminum"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 10,
				item = "glass"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 10,
				item = "plastic"
			}
		}
	},
	["maconha"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 10,
				item = "copper"
			},
			{
				name = "Placa de Metal",
				image = "sheetmetal",
				quantidade = 10,
				item = "sheetmetal"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 10,
				item = "aluminum"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 10,
				item = "glass"
			},
			{
				name = "Explosivos",
				image = "explosives",
				quantidade = 10,
				item = "explosives"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 10,
				item = "plastic"
			}
		}
	},
	["cocaina"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 10,
				item = "copper"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Placa de Metal",
				image = "sheetmetal",
				quantidade = 10,
				item = "sheetmetal"
			},
			{
				name = "Folha de Cocaina",
				image = "cokeleaf",
				quantidade = 2,
				item = "cokeleaf"
			},
			{
				name = "Acido Sufurico",
				image = "sulfuric",
				quantidade = 2,
				item = "sulfuric"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 10,
				item = "aluminum"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 10,
				item = "glass"
			},
			{
				name = "Explosivos",
				image = "explosives",
				quantidade = 10,
				item = "explosives"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 10,
				item = "plastic"
			}
		}
	},
	["Digitalden"] = { 
		itens = { 
			{
				name = "Explosivos",
				image = "explosives",
				quantidade = 1,
				item = "explosives"
			},
			{
				name = "ChipSet",
				image = "chipset",
				quantidade = 1,
				item = "chipset"
			}
		}
	},
	
	["BurgerShot"] = { 
		itens = { 
			{
				name = "ketchup",
				image = "ketchup",
				quantidade = 3,
				item = "ketchup"
			},
			{
				name = "Gordura de animal",
				image = "animalfat",
				quantidade = 3,
				item = "animalfat"
			},
			{
				name = "Garrafa de leita",
				image = "milkbottle",
				quantidade = 3,
				item = "milkbottle"
			},
			{
				name = "Copo de Café",
				image = "coffee",
				quantidade = 3,
				item = "coffee"
			},
			{
				name = "Filé de Peixe",
				image = "fishfillet",
				quantidade = 3,
				item = "fishfillet"
			},
			{
				name = "Carne de animal",
				image = "meat",
				quantidade = 3,
				item = "meat"
			},	
			{
				name = "Lixo Eletronico",
				image = "techtrash",
				quantidade = 1,
				item = "techtrash"
			}
		}
	},
	["Coiote"] = { 
		itens = { 
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Placa de Metal",
				image = "sheetmetal",
				quantidade = 10,
				item = "sheetmetal"
			}
		}
	},
	["Bratva"] = { 
		itens = { 
			{
				name = "Mola de Arma",
				image = "moladearma",
				quantidade = 1,
				item = "moladearma"
			},
			{
				name = "Corpo de Arma",
				image = "weaponbody",
				quantidade = 1,
				item = "weaponbody"
			}
		}
	},
	["lavagem1"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 10,
				item = "copper"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 10,
				item = "aluminum"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 10,
				item = "glass"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 10,
				item = "rubber"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 10,
				item = "plastic"
			}
		}
	},
	-- ["Tijuana"] = { 
	-- 	itens = { 
	-- 		{
	-- 			name = "Cobre",
	-- 			image = "copper",
	-- 			quantidade = 10,
	-- 			item = "copper"
	-- 		},
	-- 		{
	-- 			name = "Aluminio",
	-- 			image = "aluminum",
	-- 			quantidade = 10,
	-- 			item = "aluminum"
	-- 		},
	-- 		{
	-- 			name = "Vidro",
	-- 			image = "glass",
	-- 			quantidade = 10,
	-- 			item = "glass"
	-- 		},
	-- 		{
	-- 			name = "Borracha",
	-- 			image = "rubber",
	-- 			quantidade = 10,
	-- 			item = "rubber"
	-- 		},
			
	-- 		{
	-- 			name = "Plastico",
	-- 			image = "plastic",
	-- 			quantidade = 10,
	-- 			item = "plastic"
	-- 		}
	-- 	}
	-- },
	["Tijuana"] = { 
		itens = { 
			{
				name = "Corpo de Arma",
				image = "weaponbody",
				quantidade = 1,
				item = "weaponbody"
			},
			{
				name = "Mola de arma",
				image = "moladearma",
				quantidade = 1,
				item = "moladearma"
			},
			{
				name = "aluminum",
				image = "aluminum",
				quantidade = 5,
				item = "aluminum"
			},
			{
				name = "Cobre",
				image = "copper",
				quantidade = 5,
				item = "copper"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 1,
				item = "rubber"
			}
		}
	},
	["Mechanic"] = { 
		itens = { 
			{
				name = "Cobre",
				image = "copper",
				quantidade = 15,
				item = "copper"
			},
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 15,
				item = "aluminum"
			},
			{
				name = "Vidro",
				image = "glass",
				quantidade = 15,
				item = "glass"
			},
			{
				name = "Borracha",
				image = "rubber",
				quantidade = 15,
				item = "rubber"
			},
			
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 15,
				item = "plastic"
			}
		}
	},
	["Thelost"] = { 
		itens = { 
			{
				name = "Capsula",
				image = "capsula",
				quantidade = 2,
				item = "capsula"
			},
			{
				name = "Projetil",
				image = "projetil",
				quantidade = 2,
				item = "projetil"
			},
			{
				name = "Polvora",
				image = "polvora",
				quantidade = 2,
				item = "polvora"
			}
		}
	},
	["Desmanche"] = { 
		itens = { 
			{
				name = "Aluminio",
				image = "aluminum",
				quantidade = 3,
				item = "aluminum"
			},
			{
				name = "Couro",
				image = "leather",
				quantidade = 3,
				item = "leather"
			},
			{
				name = "Lona",
				image = "tarp",
				quantidade = 1,
				item = "tarp"
			},
			{
				name = "Placa de Transito",
				image = "roadsigns",
				quantidade = 10,
				item = "roadsigns"
			},
			{
				name = "Chapa de Metal",
				image = "sheetmetal",
				quantidade = 3,
				item = "sheetmetal"
			},
			{
				name = "Plastico",
				image = "plastic",
				quantidade = 3,
				item = "plastic"
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSAO 
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission(permissao)
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		if vRP.HasGroup(user_id,permissao) then
			return true
		else
			TriggerClientEvent("Notify",source,"vermelho","Você não possui acesso.",5000)
			return false
		end						
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT 
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPayment(currentRoute, position)
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		for key,value in pairs(rotas[currentRoute].itens) do
			if ((key - 1) == tonumber(position)) then
				if (vRP.InventoryWeight(user_id) + (itemWeight(value.item) * parseInt(value.quantidade))) <= vRP.GetWeight(user_id) then
					vRP.GenerateItem(user_id, value.item, tonumber(value.quantidade),true)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Mochila</b> cheia.",8000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETITEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getItems(routes)
	return rotas[routes].itens
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("routes:selectRoute", function(currentRoute, position)
AddEventHandler("routes:selectRoute")
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		for key,value in pairs(rotas[currentRoute].itens) do
			if ((key - 1) == tonumber(position)) then
				TriggerClientEvent("routes:startRoute", source, currentRoute, value.name)		
			end
		end
	end
end)