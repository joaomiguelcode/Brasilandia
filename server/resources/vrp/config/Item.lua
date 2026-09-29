-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["chapeu"] = {
		["Index"] = "chapeu",
		["Name"] = "Chapéu",
		["Description"] = "Item nessario para remover e equipar Chapéu.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["jaqueta"] = {
		["Index"] = "jaqueta",
		["Name"] = "Jaqueta",
		["Description"] = "Item nessario para remover e equipar Jaqueta.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["camisa"] = {
		["Index"] = "camisa",
		["Name"] = "Camisa",
		["Description"] = "Item nessario para remover e equipar Camisa.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["calca"] = {
		["Index"] = "calca",
		["Name"] = "Calças",
		["Description"] = "Item nessario para remover e equipar Calças.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["sapato"] = {
		["Index"] = "sapato",
		["Name"] = "Sapato",
		["Description"] = "Item nessario para remover e equipar Sapato.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["mao"] = {
		["Index"] = "mao",
		["Name"] = "Luva",
		["Description"] = "Item nessario para remover e equipar Luva.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["mascara"] = {
		["Index"] = "mascara",
		["Name"] = "Mascara",
		["Description"] = "Item nessario para remover e equipar Mascara.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},
	["oculos"] = {
		["Index"] = "oculos",
		["Name"] = "Óculos",
		["Description"] = "Item nessario para remover e equipar Óculos.",
		["Type"] = "Usável",
		["Weight"] = 0.10,
		["Max"] = 1
	},


	
	["creditcard"] = {
		["Index"] = "creditcard",
		["Name"] = "Cartão de Crédito",
		["Type"] = "Comum",
		["Weight"] = 0.25
	},
	["diagram"] = {
		["Index"] = "diagram",
		["Name"] = "Diagrama",
		["Type"] = "Comum",
		["Weight"] = 0.75
	},
	["propertys"] = {
		["Index"] = "propertys",
		["Name"] = "Cartão de Segurança",
		["Type"] = "Comum",
		["Weight"] = 0.35
	},
	["bennys"] = {
		["Index"] = "bennys",
		["Name"] = "Ticket Bennys",
		["Type"] = "Comum",
		["Durability"] = 0.005,
		["Weight"] = 3.25
	},
	["megaphone"] = {
		["Index"] = "megaphone",
		["Name"] = "Megafone",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 3.25
	},
	["sprays01"] = {
		["Index"] = "sprays",
		["Name"] = "Spray",
		["Type"] = "Usável",
		["Weight"] = 0.75
	},
	["sprays02"] = {
		["Index"] = "sprays",
		["Name"] = "Spray de tinta",
		["Description"] = "Spray para pintura de superfícies.",
		["Type"] = "Usável",
		["Weight"] = 0.75
	},
	["backpack"] = {
		["Index"] = "backpack",
		["Name"] = "Mochila",
		["Description"] = "Mochila inicial 50kl adicionais.",
		["Type"] = "Usável",
		["Weight"] = 0.75
	},
	["tinner"] = {
		["Index"] = "tinner",
		["Name"] = "Thinner",
		["Description"] = "Solvente para remoção de tinta.",
		["Type"] = "Usável",
		["Weight"] = 0.75
	},
	["enginea"] = {
		["Index"] = "enginea",
		["Name"] = "Motor",
		["Type"] = "Usável",
		["Weight"] = 9.25
	},
	["engineb"] = {
		["Index"] = "engineb",
		["Name"] = "Motor",
		["Type"] = "Usável",
		["Weight"] = 10.25
	},
	["enginec"] = {
		["Index"] = "enginec",
		["Name"] = "Motor",
		["Type"] = "Usável",
		["Weight"] = 11.25
	},
	["engined"] = {
		["Index"] = "engined",
		["Name"] = "Motor",
		["Type"] = "Usável",
		["Weight"] = 12.25
	},
	["enginee"] = {
		["Index"] = "enginee",
		["Name"] = "Motor",
		["Type"] = "Usável",
		["Weight"] = 13.25
	},
	["transmissiona"] = {
		["Index"] = "transmissiona",
		["Name"] = "Transmissão",
		["Type"] = "Usável",
		["Weight"] = 9.25
	},
	["transmissionb"] = {
		["Index"] = "transmissionb",
		["Name"] = "Transmissão",
		["Type"] = "Usável",
		["Weight"] = 10.25
	},
	["transmissionc"] = {
		["Index"] = "transmissionc",
		["Name"] = "Transmissão",
		["Type"] = "Usável",
		["Weight"] = 11.25
	},
	["transmissiond"] = {
		["Index"] = "transmissiond",
		["Name"] = "Transmissão",
		["Type"] = "Usável",
		["Weight"] = 12.25
	},
	["transmissione"] = {
		["Index"] = "transmissione",
		["Name"] = "Transmissão",
		["Type"] = "Usável",
		["Weight"] = 13.25
	},
	["brakea"] = {
		["Index"] = "brakea",
		["Name"] = "Freios",
		["Type"] = "Usável",
		["Weight"] = 7.25
	},
	["brakeb"] = {
		["Index"] = "brakeb",
		["Name"] = "Freios",
		["Type"] = "Usável",
		["Weight"] = 8.25
	},
	["brakec"] = {
		["Index"] = "brakec",
		["Name"] = "Freios",
		["Type"] = "Usável",
		["Weight"] = 9.25
	},
	["braked"] = {
		["Index"] = "braked",
		["Name"] = "Freios",
		["Type"] = "Usável",
		["Weight"] = 10.25
	},
	["brakee"] = {
		["Index"] = "brakee",
		["Name"] = "Freios",
		["Type"] = "Usável",
		["Weight"] = 11.25
	},
	["suspensiona"] = {
		["Index"] = "suspensiona",
		["Name"] = "Suspensão",
		["Type"] = "Usável",
		["Weight"] = 7.25
	},
	["suspensionb"] = {
		["Index"] = "suspensionb",
		["Name"] = "Suspensão",
		["Type"] = "Usável",
		["Weight"] = 8.25
	},
	["suspensionc"] = {
		["Index"] = "suspensionc",
		["Name"] = "Suspensão",
		["Type"] = "Usável",
		["Weight"] = 9.25
	},
	["suspensiond"] = {
		["Index"] = "suspensiond",
		["Name"] = "Suspensão",
		["Type"] = "Usável",
		["Weight"] = 10.25
	},
	["suspensione"] = {
		["Index"] = "suspensione",
		["Name"] = "Suspensão",
		["Type"] = "Usável",
		["Weight"] = 11.25
	},
	["dismantle"] = {
		["Index"] = "dismantle",
		["Name"] = "Contrato",
		["Description"] = "Ativando o mesmo você assume a responsabilidade com o <b>Lester</b> de desmanchar um veículo.",
		["Type"] = "Usável",
		["Weight"] = 0.75,
		["Max"] = 3
	},
	["repairkit01"] = {
		["Index"] = "repairkit01",
		["Name"] = "Kit de Reparos - Comum",
		["Type"] = "Comum",
		["Weight"] = 3.25,
	},
	["repairkit02"] = {
		["Index"] = "repairkit02",
		["Name"] = "Kit de Reparos",
		["Type"] = "Comum",
		["Weight"] = 3.75,
	},
	["repairkit03"] = {
		["Index"] = "repairkit03",
		["Name"] = "Bateria AA",
		["Type"] = "Comum",
		["Weight"] = 1.25,
	},
	["repairkit04"] = {
		["Index"] = "repairkit04",
		["Name"] = "Power Bank",
		["Type"] = "Comum",
		["Weight"] = 1.75,
	},
	["bolsapreta"] = {
		["Index"] = "bolsapreta",
		["Name"] = "Mochila Premium",
		["Description"] = "Aumenta mochila para 150KL.",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["mochilaenergetico"] = {
		["Index"] = "mochilaenergetico",
		["Name"] = "Mochila Energetico",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["mochilamilitar"] = {
		["Index"] = "mochilamilitar",
		["Name"] = "Mochila Militar",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["mochilaoriental"] = {
		["Index"] = "mochilaoriental",
		["Name"] = "Mochila Oriental",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["mochilacouropreta"] = {
		["Index"] = "mochilacouropreta",
		["Name"] = "Mochila de Couro Preta",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["mochilacouro"] = {
		["Index"] = "mochilacouro",
		["Name"] = "Mochila de Couro",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["cachorrinhobeje"] = {
		["Index"] = "cachorrinhobeje",
		["Name"] = "Mochila Cachorinho Beje",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["cachorrinhoazul"] = {
		["Index"] = "cachorrinhoazul",
		["Name"] = "Mochila Cachorrinho Azul",
		["Type"] = "Usável",
		["Weight"] = 5.25,
	},
	["paper"] = {
		["Index"] = "paper",
		["Name"] = "Papel",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["rentalveh"] = {
		["Index"] = "rentalveh",
		["Name"] = "Aluguel de Veículo",
		["Description"] = "Leve até a concessionária para usa-lo.",
		["Type"] = "Usável",
		["Weight"] = 0.15,
	},
	["mushroomteaplus"] = {
		["Index"] = "mushroomtea",
		["Name"] = "Chá de Cogumelo",
		["Description"] = "Aumenta a mochila em 10Kg.",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["paramedicpass"] = {
		["Index"] = "medicbag",
		["Name"] = "Vale - Médico",
		["Description"] = "Leve até um médico para troca-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["luckywheelpass"] = {
		["Index"] = "luckywheelpass",
		["Name"] = "Vale - Roda da Fortuna",
		["Description"] = "Leve até o cassino para usa-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["mechanicpass"] = {
		["Index"] = "mechanicpass",
		["Name"] = "Vale - Mecânico",
		["Description"] = "Leve até um mecânico para troca-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["uwucoffeepass"] = {
		["Index"] = "foodpass",
		["Name"] = "Vale - Uwu Café",
		["Description"] = "Leve até o restaurante para troca-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["pizzathispass"] = {
		["Index"] = "foodpass",
		["Name"] = "Vale - Pizza This",
		["Description"] = "Leve até o restaurante para troca-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["burgershotpass"] = {
		["Index"] = "foodpass",
		["Name"] = "Vale - BurgerShot",
		["Description"] = "Leve até o restaurante para troca-lo.",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["c4"] = {
		["Index"] = "c4",
		["Name"] = "Bomba Caseira",
		["Type"] = "Usável",
		["Weight"] = 2.75,
		["Max"] = 3,
	},
	["geode"] = {
		["Index"] = "geode",
		["Name"] = "Geodo",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["pickaxe"] = {
		["Index"] = "pickaxe",
		["Name"] = "Picareta",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 2.25,
	},
	["suitcase"] = {
		["Index"] = "suitcase",
		["Name"] = "Maleta",
		["Type"] = "Usável",
		["Weight"] = 1.0,
	},
	["badge01"] = {
		["Index"] = "badge01",
		["Name"] = "Distintivo",
		["Description"] = "<green>San Andreas Police Department</green>",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["badge02"] = {
		["Index"] = "badge02",
		["Name"] = "Distintivo",
		["Description"] = "<green>Emergency Medical Services</green>",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["badge03"] = {
		["Index"] = "badge01",
		["Name"] = "Distintivo",
		["Description"] = "<green>Department of Justice</green>",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["mushroomtea"] = {
		["Index"] = "mushroomtea",
		["Name"] = "Chá de Cogumelo",
		["Description"] = "Tempo pedalando reduzido para <green>10 minutos</green> por <green>60 minutos</green>, lembrando que o efeito passa desconectando da cidade.",
		["Durability"] = 1,
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["filedepeixe"] = {
		["Index"] = "filedepeixe",
		["Name"] = "Filé de pescada com fritas",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.65,
	},
	["bife"] = {
		["Index"] = "bife",
		["Name"] = "Bife com fritas",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.65,
		["Max"] = 10,
	},
	["milkshake"] = {
		["Index"] = "milkshake",
		["Name"] = "Milk Shake",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.8555,
		["Scape"] = true,
		["Max"] = 10,
	},
	["cappuccino"] = {
		["Index"] = "cappuccino",
		["Name"] = "Cappuccino",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.65,
		["Scape"] = true,
		["Max"] = 10,
	},
	["credential"] = {
		["Index"] = "credential",
		["Name"] = "Credencial",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["racetrophy"] = {
		["Index"] = "racetrophy",
		["Name"] = "Troféu",
		["Type"] = "Comum",
		["Weight"] = 7.25,
	},
	["scanner"] = {
		["Index"] = "scanner",
		["Name"] = "Scanner",
		["Repair"] = "repairkit02",
		["Description"] = "Busque tesouros na parte molhada da praia de Vespucci.",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 4.75,
	},
	["nitro"] = {
		["Index"] = "nitro",
		["Name"] = "Nitro",
		["Type"] = "Usável",
		["Weight"] = 7.25,
	},
	["postit"] = {
		["Index"] = "postit",
		["Name"] = "Post-It",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["attachsFlashlight"] = {
		["Index"] = "attachsFlashlight",
		["Name"] = "Lanterna Tatica",
		["Type"] = "Usável",
		["Weight"] = 1.15,
	},
	["attachsCrosshair"] = {
		["Index"] = "attachsCrosshair",
		["Name"] = "Mira Holográfica",
		["Type"] = "Usável",
		["Weight"] = 1.15,
	},
	["attachsSilencer"] = {
		["Index"] = "attachsSilencer",
		["Name"] = "Silenciador",
		["Type"] = "Usável",
		["Weight"] = 1.15,
	},
	["attachsMagazine"] = {
		["Index"] = "attachsMagazine",
		["Name"] = "Pente Estendido",
		["Type"] = "Usável",
		["Weight"] = 1.15,
	},
	["attachsGrip"] = {
		["Index"] = "attachsGrip",
		["Name"] = "Empunhadura",
		["Type"] = "Usável",
		["Weight"] = 1.15,
	},
	["cheese"] = {
		["Index"] = "cheese",
		["Name"] = "Queijo",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["silk"] = {
		["Index"] = "silk",
		["Name"] = "Seda",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["tablecoke"] = {
		["Index"] = "tablecoke",
		["Name"] = "Mesa de Criação",
		["Description"] = "Utilizada para criação de Cocaína.",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 12.75,
	},
	["tablemeth"] = {
		["Index"] = "tablemeth",
		["Name"] = "Mesa de Criação",
		["Description"] = "Utilizada para criação de Metanfetamina.",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 12.75,
	},
	["tableweed"] = {
		["Index"] = "tableweed",
		["Name"] = "Mesa de Criação",
		["Description"] = "Utilizada para criação de Baseados.",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 12.75,
	},
	["tablelean"] = {
		["Index"] = "leantable",
		["Name"] = "Mesa de Criação",
		["Description"] = "Utilizada para criação de Lean.",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 12.75
	},
	["tableecstasy"] = {
		["Index"] = "tableecstasy",
		["Name"] = "Mesa de Criação",
		["Description"] = "Utilizada para criação de Ecstasy.",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 12.75
	},
	["campfire"] = {
		["Index"] = "campfire",
		["Name"] = "Fogueira",
		["Type"] = "Usável",
		["Weight"] = 5.75,
	},
	["barrier"] = {
		["Index"] = "barrier",
		["Name"] = "Barreira",
		["Type"] = "Usável",
		["Weight"] = 1.75,
	},
	["medicbag"] = {
		["Index"] = "medicbag",
		["Name"] = "Bolsa Médica",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 2.75,
	},
	["medicbed"] = {
		["Index"] = "medicbed",
		["Name"] = "Maca Médica",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 7.25,
	},
	["techtrash"] = {
		["Index"] = "techtrash",
		["Name"] = "Circuito Eletronico",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["chipset"] = {
		["Index"] = "chipset",
		["Name"] = "Chipset",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["antena"] = {
		["Index"] = "antena",
		["Name"] = "Antena de Wireless quebrada.",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["tarp"] = {
		["Index"] = "tarp",
		["Name"] = "Lona",
		["Type"] = "Comum",
		["Weight"] = 0.65,
	},
	["sheetmetal"] = {
		["Index"] = "sheetmetal",
		["Name"] = "Chapa de Metal",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["roadsigns"] = {
		["Index"] = "roadsigns",
		["Name"] = "Placas de Trânsito",
		["Type"] = "Comum",
		["Weight"] = 0.65,
	},
	["leather"] = {
		["Index"] = "leather",
		["Name"] = "Couro",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["lean"] = {
		["Index"] = "lean",
		["Name"] = "Lean",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	
	},
	["ecstasy"] = {
		["Index"] = "Ecstasy",
		["Name"] = "ecstasy",
		["Type"] = "Usável",
		["Weight"] = 0.50,
		
	},
	["explosives"] = {
		["Index"] = "explosives",
		["Name"] = "Explosivos",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["animalfat"] = {
		["Index"] = "animalfat",
		["Name"] = "Gordura Animal",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["fidentity"] = {
		["Index"] = "identity",
		["Name"] = "Passaporte",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["identity"] = {
		["Index"] = "identity",
		["Name"] = "Passaporte",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["blocksignal"] = {
		["Index"] = "blocksignal",
		["Name"] = "Bloqueador de Sinal",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["weaponbody"] = {
		["Index"] = "weaponbody",
		["Name"] = "Corpo de Arma",
		["Description"] = "Utilizado na fabricação de armas.",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["triggerpistol"] = {
		["Index"] = "triggerpistol",
		["Name"] = "Gatilho de Pistola",
		["Type"] = "Comum",
		["Weight"] = 0.05,
	},
	["triggersmg"] = {
		["Index"] = "triggerpistol",
		["Name"] = "Gatilho de SMG",
		["Type"] = "Comum",
		["Weight"] = 0.05,
	},
	["triggerrifle"] = {
		["Index"] = "triggerpistol",
		["Name"] = "Gatilho de Rifle",
		["Type"] = "Comum",
		["Weight"] = 0.05,
	},
	["cotton"] = {
		["Index"] = "cotton",
		["Name"] = "Algodão",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["plaster"] = {
		["Index"] = "plaster",
		["Name"] = "Esparadrapo",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["sulfuric"] = {
		["Index"] = "sulfuric",
		["Name"] = "Ácido Sulfúrico",
		["Type"] = "Usável",
		["Weight"] = 0.55,
	},
	["saline"] = {
		["Index"] = "saline",
		["Name"] = "Soro Fisiológico",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["defibrillator"] = {
		["Index"] = "defibrillator",
		["Name"] = "Desfibrilador",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 3,
		["Weight"] = 3.75,
	},
	["alcohol"] = {
		["Index"] = "alcohol",
		["Name"] = "Álcool",
		["Type"] = "Comum",
		["Weight"] = 0.65,
	},
	["kitupgrade"] = {
		["Index"] = "kitupgrade",
		["Name"] = "kit upgrade",
		["Type"] = "Usável",
		["Weight"] = 7.25,
		["Description"] = "Kit instalação de Suspensão a AR e Neon.",
	},
	["tabletorg"] = {
		["Index"] = "tabletorg",
		["Name"] = "Tablet de orgs",
		["Description"] = "Utilizado para acessar o sistema de organizações.",
		["Type"] = "Usável",
		["Durability"] = 5,
		["Weight"] = 0.25,
	},
	["macbook"] = {
		["Index"] = "macbook",
		["Name"] = "Notebook de Piloto Clandestino",
		["Description"] = "Notebook especial para corrida clandestina.",
		["Type"] = "Usável",
		["Durability"] = 3,
		["Weight"] = 7.25,
	},
	["syringe"] = {
		["Index"] = "syringe",
		["Name"] = "Seringa",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["syringe01"] = {
		["Index"] = "syringe2",
		["Name"] = "Seringa A+",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["syringe02"] = {
		["Index"] = "syringe2",
		["Name"] = "Seringa B+",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["syringe03"] = {
		["Index"] = "syringe2",
		["Name"] = "Seringa A-",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["syringe04"] = {
		["Index"] = "syringe2",
		["Name"] = "Seringa B-",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["burgershot1"] = {
		["Index"] = "burgershot1",
		["Name"] = "Copo de Suco",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 1,
	},
	["burgershot2"] = {
		["Index"] = "burgershot2",
		["Name"] = "Caixa de Lanche",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 1,
	},
	["burgershot3"] = {
		["Index"] = "burgershot3",
		["Name"] = "Combo",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 2,
	},
	["burgershot4"] = {
		["Index"] = "burgershot3",
		["Name"] = "Combo + Brinquedo",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 2,
	},
	["pizzathis1"] = {
		["Index"] = "pizzathis1",
		["Name"] = "Copo de Suco",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 1,
	},
	["espetinhodepeixe"] = {
		["Index"] = "espetinhodepeixe",
		["Name"] = "espetinho de peixe",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 10,
		["Durability"] = 1,
	},
	["pizzathis3"] = {
		["Index"] = "pizzathis3",
		["Name"] = "Combo",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 2,
	},
	["Moquecadepeixe"] = {
		["Index"] = "Moquecadepeixe",
		["Name"] = "Moqueca de peixe",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 10,
		["Durability"] = 1,

	},
	["beanmachine1"] = {
		["Index"] = "beanmachine1",
		["Name"] = "Copo de Suco",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 1,
	},
	["beanmachine2"] = {
		["Index"] = "beanmachine2",
		["Name"] = "Caixa de Lanche",
		["Type"] = "Comum",
		["Weight"] = 0.25,
		["Max"] = 1,
	},
	["beanmachine3"] = {
		["Index"] = "beanmachine3",
		["Name"] = "Combo",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 2,
	},
	["beanmachine4"] = {
		["Index"] = "beanmachine3",
		["Name"] = "Combo + Brinquedo",
		["Type"] = "Comum",
		["Weight"] = 1.25,
		["Max"] = 2,
	},
	["spikestrip"] = {
		["Index"] = "spikestrip",
		["Name"] = "Spike",
		["Type"] = "Usável",
		["Weight"] = 5.0,
	},
	["wheelchair"] = {
		["Index"] = "wheelchair",
		["Name"] = "Cadeira de Rodas",
		["Type"] = "Usável",
		["Weight"] = 7.25,
		["Block"] = true,
	},
	["vehkey"] = {
		["Index"] = "vehkey",
		["Name"] = "Chave Cópia",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["evidence01"] = {
		["Index"] = "evidence01",
		["Name"] = "Evidência",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["evidence02"] = {
		["Index"] = "evidence02",
		["Name"] = "Evidência",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["evidence03"] = {
		["Index"] = "evidence03",
		["Name"] = "Evidência",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["evidence04"] = {
		["Index"] = "evidence04",
		["Name"] = "Evidência",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["card01"] = {
		["Index"] = "card01",
		["Name"] = "Cartão Comum",
		["Description"] = "Roubar Lojas de Departamento.",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 0.25,
	},
	["card02"] = {
		["Index"] = "card02",
		["Name"] = "Cartão In-Comum",
		["Description"] = "Roubar Lojas de Armas.",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 0.25,
	},
	["card03"] = {
		["Index"] = "card03",
		["Name"] = "Cartão Épico",
		["Description"] = "Roubar Bancos Fleeca.",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 0.25,
	},
	["card04"] = {
		["Index"] = "card04",
		["Name"] = "Cartão Raro",
		["Description"] = "Roubar Barbearias.",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 0.25,
	},
	["card05"] = {
		["Index"] = "card05",
		["Name"] = "Cartão Lendário",
		["Description"] = "Roubar Bancos.",
		["Repair"] = "repairkit01",
		["Type"] = "Comum",
		["Durability"] = 7,
		["Weight"] = 0.25,
	},
	["gemstone"] = {
		["Index"] = "gemstone",
		["Name"] = "Gemstone",
		["Type"] = "Usável",
		["Weight"] = 0.15,
	},
	["radio"] = {
		["Index"] = "radio",
		["Name"] = "Rádio",
		["Type"] = "Usável",
		["Repair"] = "repairkit03",
		["Durability"] = 7,
		["Weight"] = 1.75,
	},
	["vest"] = {
		["Index"] = "vest",
		["Name"] = "Colete Policial",
		["Type"] = "Usável",
		["Durability"] = 10,
		["Weight"] = 3.75,
		["Max"] = 1,
	},
	["vest2"] = {
		["Index"] = "vest2",
		["Name"] = "Colete a prova de balas",
		["Type"] = "Usável",
		["Durability"] = 10,
		["Weight"] = 3.75,
		["Max"] = 1,
	},
	["bandage"] = {
		["Index"] = "bandage",
		["Name"] = "Bandagem",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 3,
	},
	["medkit"] = {
		["Index"] = "medkit",
		["Name"] = "Kit Médico",
		["Type"] = "Usável",
		["Weight"] = 0.75,
		["Max"] = 1,
	},
	["medkit1"] = {
		["Index"] = "medkit1",
		["Name"] = "Kit Médico Profissional",
		["Type"] = "Usável",
		["Weight"] = 0.75
	},
	["kitlimpeza"] = {
		["Index"] = "kitlimpeza",
		["Name"] = "Kit de Limpeza Veicular",
		["Description"] = "Com apenas uma garrafa de água, seu carro novo de novo!",
		["Type"] = "Usável",
		["Weight"] = 0.25
	},
	["pouch"] = {
		["Index"] = "pouch",
		["Name"] = "Malote",
		["Type"] = "Comum",
		["Weight"] = 1.25,
	},
	["woodlog"] = {
		["Index"] = "woodlog",
		["Name"] = "Tora de Madeira",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["fishingrod"] = {
		["Index"] = "fishingrod",
		["Name"] = "Vara de Pescar",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 2.75,
	},
	["switchblade"] = {
		["Index"] = "switchblade",
		["Name"] = "Canivete",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Description"] = "Utilizada para remoção de carne.",
		["Durability"] = 7,
		["Weight"] = 0.75,
	},
	["octopus"] = {
		["Index"] = "octopus",
		["Name"] = "Polvo",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["shrimp"] = {
		["Index"] = "shrimp",
		["Name"] = "Camarão",
		["Type"] = "Comum",
		["Weight"] = 0.50,
	},
	["carp"] = {
		["Index"] = "carp",
		["Name"] = "Carpa",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["codfish"] = {
		["Index"] = "codfish",
		["Name"] = "Bacalhau",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["catfish"] = {
		["Index"] = "catfish",
		["Name"] = "Bagre",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["goldenfish"] = {
		["Index"] = "goldenfish",
		["Name"] = "Dourado",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["horsefish"] = {
		["Index"] = "horsefish",
		["Name"] = "Cavala",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["tilapia"] = {
		["Index"] = "tilapia",
		["Name"] = "Tilápia",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["pacu"] = {
		["Index"] = "pacu",
		["Name"] = "Pacu",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["pirarucu"] = {
		["Index"] = "pirarucu",
		["Name"] = "Pirarucu",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["tambaqui"] = {
		["Index"] = "tambaqui",
		["Name"] = "Tambaqui",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["bait"] = {
		["Index"] = "bait",
		["Name"] = "Isca",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["animalpelt"] = {
		["Index"] = "animalpelt",
		["Name"] = "Pele Animal",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["weedclone"] = {
		["Index"] = "weedclone",
		["Name"] = "Semente de Maconha",
		["Type"] = "Usável",
		["Weight"] = 0.15
	},
	["ziplock"] = {
		["Index"] = "ziplock",
		["Name"] = "Saquinho",
		["Type"] = "Comum",
		["Weight"] = 0.15
	},
	["weedleaf"] = {
		["Index"] = "weedleaf",
		["Name"] = "Flor de Cannabis",
		["Type"] = "Comum",
		["Weight"] = 0.30
	},
	["joint"] = {
		["Index"] = "joint",
		["Name"] = "Porção de maconha",
		["Type"] = "Usável",
		["Weight"] = 0.45,
		
	},
	["baseado"] = {
		["Index"] = "baseado",
		["Name"] = "Cigarro da Blazeit",
		["Type"] = "Usável",
		["Weight"] = 0.45,
	
	},
	["codeine"] = {
		["Index"] = "codeine",
		["Name"] = "Codeína",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["amphetamine"] = {
		["Index"] = "amphetamine",
		["Name"] = "Anfetamina",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["cocaine"] = {
		["Index"] = "cocaine",
		["Name"] = "Cocaína",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	
	},
	["cokeleaf"] = {
		["Index"] = "cokeleaf",
		["Name"] = "Folha de Coca",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["meth"] = {
		["Index"] = "meth",
		["Name"] = "Metanfetamina",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	
	},
	["acetone"] = {
		["Index"] = "acetone",
		["Name"] = "Acetona",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["drugtoy"] = {
		["Index"] = "drugtoy",
		["Name"] = "Brinquedo",
		["Type"] = "Comum",
		["Weight"] = 0.50,
	},
	["racao"] = {
		["Index"] = "racao",
		["Name"] = "Ração animal",
		["Type"] = "Usável",
		["Weight"] = 0.50,
	},
	["rolepass"] = {
		["Index"] = "rolepass",
		["Name"] = "Rolepass",
		["Type"] = "Usável",
		["Weight"] = 0.15,
	},
	["premium1"] = {
		["Index"] = "premium1",
		["Name"] = "Premium Bronze",
		["Description"] = "<green>Duração de 30 dias, Salario de $5500, Preset premium adicional, isento taxa de garagem</green>",
		["Type"] = "Usável",
		["Weight"] = 0.15,
		['Block'] = true
	},
	["premium2"] = {
		["Index"] = "premium2",
		["Name"] = "Premium Silver",
		["Description"] = "<green>Duração de 30 dias, Salario de $7500, Preset premium adicional, isento taxa de garagem, 1 vaga na garagem, 1 placa personalizada.</green>",
		["Type"] = "Usável",
		["Weight"] = 0.15,
		['Block'] = true
	},
	["premium3"] = {
		["Index"] = "premium3",
		["Name"] = "Premium Gold",
		["Description"] = "<green>Duração de 30 dias, Salario de $9500, Preset premium adicional, isento taxa de garagem, 2 vaga na garagem, 2 placa personalizada, 1 chip, 50 gemas, 1 Mochila de Couro.</green>",
		["Type"] = "Usável",
		["Weight"] = 0.15,
		['Block'] = true
	},
	["premiumplate"] = {
		["Index"] = "platepremium",
		["Name"] = "Placa Premium",
		["Type"] = "Usável",
		["Description"] = "Personaliza a placa do veículo.",
		["Weight"] = 0.75,
	},
	["newchars"] = {
		["Index"] = "newchars",
		["Name"] = "+1 Personagem",
		["Type"] = "Usável",
		["Description"] = "Limite de personagem em +1.",
		["Weight"] = 0.25,
		['Block'] = true
	},
	["namechange"] = {
		["Index"] = "namechange",
		["Name"] = "Troca de Nome",
		["Type"] = "Usável",
		["Description"] = "Troca o nome do personagem.",
		["Weight"] = 0.25,
		['Blocked'] = true
	},
	["milkbottle"] = {
		["Index"] = "milkbottle",
		["Name"] = "Garrafa de Leite",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Scape"] = true,
		["Max"] = 5,
	},
	["guarananatural"] = {
		["Index"] = "guarananatural",
		["Name"] = "Guaraná Natural",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["water"] = {
		["Index"] = "water",
		["Name"] = "Água",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Scape"] = true,
		["Max"] = 10,
	},
	["emptybottle"] = {
		["Index"] = "emptybottle",
		["Name"] = "Garrafa Vazia",
		["Type"] = "Comum",
		["Weight"] = 0.15,
		["Scape"] = true,
		["Max"] = 10,
	},
	["coffee"] = {
		["Index"] = "coffee",
		["Name"] = "Copo de Café",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 10,
		["Durability"] = 1,		
	},
	["energetico"] = {
		["Index"] = "energetico",
		["Name"] = "Energetico",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 3,
	},
	["coffeemilk"] = {
		["Index"] = "coffeemilk",
		["Name"] = "Café com Leite",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.35,
		["Max"] = 10,		
	},
	["cola"] = {
		["Index"] = "cola",
		["Name"] = "eCola",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,
	},
	["tacos"] = {
		["Index"] = "tacos",
		["Name"] = "Tacos",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,		
	},
	["fries"] = {
		["Index"] = "fries",
		["Name"] = "Batata Frita",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,		
	},
	["soda"] = {
		["Index"] = "soda",
		["Name"] = "Sprunk",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,		
	},
	["apple"] = {
		["Index"] = "apple",
		["Name"] = "Maça",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["orange"] = {
		["Index"] = "orange",
		["Name"] = "Laranja",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["strawberry"] = {
		["Index"] = "strawberry",
		["Name"] = "Morango",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["coffee2"] = {
		["Index"] = "coffee2",
		["Name"] = "Grão de Café",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["grape"] = {
		["Index"] = "grape",
		["Name"] = "Uva",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["tange"] = {
		["Index"] = "tange",
		["Name"] = "Tangerina",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["banana"] = {
		["Index"] = "banana",
		["Name"] = "Banana",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["guarana"] = {
		["Index"] = "guarana",
		["Name"] = "Guaraná",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["acerola"] = {
		["Index"] = "acerola",
		["Name"] = "Acerola",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["potato"] = {
		["Index"] = "potato",
		["Name"] = "Batata",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["alface"] = {
		["Index"] = "alface",
		["Name"] = "Alface",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["passion"] = {
		["Index"] = "passion",
		["Name"] = "Maracujá",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["tomato"] = {
		["Index"] = "tomato",
		["Name"] = "Tomate",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["fenda"] = {
		["Index"] = "fenda",
		["Name"] = "Chave de fenda",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["sugar"] = {
		["Index"] = "sugar",
		["Name"] = "Açucar",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},

	-- Uwucoffee
	["cupcake"] = {
		["Index"] = "cupcake",
		["Name"] = "Cupcake",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Max"] = 10,
	},
	["cookies"] = {
		["Index"] = "cookies",
		["Name"] = "Cookies",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["applelove"] = {
		["Index"] = "applelove",
		["Name"] = "Maça do Amor",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["bolochocolate"] = {
		["Index"] = "bolochocolate",
		["Name"] = "Bolo de Chocolate",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["paodequeijo"] = {
		["Index"] = "paodequeijo",
		["Name"] = "Pão de Queijo",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["donut"] = {
		["Index"] = "donut",
		["Name"] = "Donuts",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,
	},
	["tortasalgada"] = {
		["Index"] = "tortasalgada",
		["Name"] = "Torta Salgada",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,
	},
	["chagelado"] = {
		["Index"] = "chagelado",
		["Name"] = "Chá Gelado",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["frappuccino"] = {
		["Index"] = "frappuccino",
		["Name"] = "Frappuccino",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["orangejuice"] = {
		["Index"] = "orangejuice",
		["Name"] = "Suco de Laranja",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["tangejuice"] = {
		["Index"] = "tangejuice",
		["Name"] = "Suco de Tangerina",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["grapejuice"] = {
		["Index"] = "grapejuice",
		["Name"] = "Suco de Uva",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,		
	},
	["strawberryjuice"] = {
		["Index"] = "strawberryjuice",
		["Name"] = "Suco de Morango",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["bananajuice"] = {
		["Index"] = "bananajuice",
		["Name"] = "Suco de Banana",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["acerolajuice"] = {
		["Index"] = "acerolajuice",
		["Name"] = "Suco de Acerola",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["passionjuice"] = {
		["Index"] = "passionjuice",
		["Name"] = "Suco de Maracujá",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["sal"] = {
		["Index"] = "sal",
		["Name"] = "Sal do Himalaia",
		["Type"] = "Comum",
		["Weight"] = 0.1,
	},
	["ketchup"] = {
		["Index"] = "ketchup",
		["Name"] = "Ketchup",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["cannedsoup"] = {
		["Index"] = "cannedsoup",
		["Name"] = "Sopa em Lata",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
	},
	["canofbeans"] = {
		["Index"] = "canofbeans",
		["Name"] = "Lata de Feijão",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
	},
	["meat"] = {
		["Index"] = "meat",
		["Name"] = "Carne Animal",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["meat2"] = {
		["Index"] = "meat2",
		["Name"] = "Carne de Soja",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["fishfillet"] = {
		["Index"] = "fishfillet",
		["Name"] = "Filé de Peixe",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["marshmallow"] = {
		["Index"] = "marshmallow",
		["Name"] = "Marshmallow",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Scape"] = true,
		["Max"] = 10,
	},
	["cookedfishfillet"] = {
		["Index"] = "cookedfishfillet",
		["Name"] = "Filé de Pescada com Fritas",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["cookedmeat"] = {
		["Index"] = "cookedmeat",
		["Name"] = "Carne Animal Cozida",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["hamburger"] = {
		["Index"] = "hamburger",
		["Name"] = "Hambúrguer de Carne",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Max"] = 10,
	},
	["hamburger2"] = {
		["Index"] = "hamburger2",
		["Name"] = "Hambúrguer de Soja",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["onionrings"] = {
		["Index"] = "onionrings",
		["Name"] = "Anéis de Cebola",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 10,
	},
	["chickenfries"] = {
		["Index"] = "chickenfries",
		["Name"] = "Frango Frito",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["pizzamozzarella"] = {
		["Index"] = "pizzamozzarella",
		["Name"] = "Pizza de Muçarela",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 10,
	},
	["pizzamushroom"] = {
		["Index"] = "pizzamushroom",
		["Name"] = "Pizza de Cogumelo",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 3,
	},
	["pizzabanana"] = {
		["Index"] = "pizzabanana",
		["Name"] = "Pizza de Banana",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 3,
	},
	["pizzachocolate"] = {
		["Index"] = "pizzachocolate",
		["Name"] = "Pizza de Chocolate",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.75,
		["Scape"] = true,
		["Max"] = 3,
	},
	["calzone"] = {
		["Index"] = "calzone",
		["Name"] = "Calzone",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 3,
	},
	["hotdog"] = {
		["Index"] = "hotdog",
		["Name"] = "Hot-Dog",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.45,
		["Max"] = 10,
	},
	["donut"] = {
		["Index"] = "donut",
		["Name"] = "Rosquinha",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,
	},
	["plate"] = {
		["Index"] = "plate",
		["Name"] = "Placa",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["lockpick"] = {
		["Index"] = "lockpick",
		["Name"] = "Lockpick de Alumínio",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 3,
		["Weight"] = 1.25,
	},
	["lockpickadv"] = {
		["Index"] = "lockpickadv",
		["Name"] = "Lockpick Ilegal",
		["Description"] = "Utilizada para roubar casas.",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 3,
		["Weight"] = 1.25,
	},
	["toolbox"] = {
		["Index"] = "toolbox",
		["Name"] = "Ferramentas Básicas",
		["Type"] = "Usável",
		["Weight"] = 2.25,
		["Max"] = 10,
	},
	["advtoolbox"] = {
		["Index"] = "toolbox",
		["Name"] = "Ferramentas Avançadas",
		["Type"] = "Usável",
		["Weight"] = 3.25,
		["Charges"] = 3,
		["Max"] = 1,
	},
	["notepad"] = {
		["Index"] = "notepad",
		["Name"] = "Bloco de Notas",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["tyres"] = {
		["Index"] = "tyres",
		["Name"] = "Pneu",
		["Type"] = "Usável",
		["Weight"] = 2.75,
		["Max"] = 4,
	},
	["cellphone"] = {
		["Index"] = "cellphone",
		["Name"] = "Celular",
		["Repair"] = "repairkit04",
		["Type"] = "Comum",
		["Durability"] = 1,
		["Weight"] = 0.75,
	},
	["scuba"] = {
		["Index"] = "scuba",
		["Name"] = "Roupa de Mergulho",
		["Type"] = "Usável",
		["Durability"] = 14,
		["Weight"] = 4.75,
	},
	["handcuff"] = {
		["Index"] = "handcuff",
		["Name"] = "Algemas",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 10,
		["Weight"] = 1.25,
	},
	["rope"] = {
		["Index"] = "rope",
		["Name"] = "Cordas",
		["Repair"] = "repairkit01",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 1.75,
	},
	["hood"] = {
		["Index"] = "hood",
		["Name"] = "Capuz",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 7,
		["Weight"] = 1.75,
	},
	["plastic"] = {
		["Index"] = "plastic",
		["Name"] = "Plástico",
		["Type"] = "Comum",
		["Weight"] = 0.080,
	},
	["glass"] = {
		["Index"] = "glass",
		["Name"] = "Vidro",
		["Type"] = "Comum",
		["Weight"] = 0.065,
	},
	["registro"] = {
		["Index"] = "registro",
		["Name"] = "Registro Agropecuário",
		["Description"] = "Obrigatório porta-lo durante qualquer atividade de pesca, caça ou agricultura.",
		["Type"] = "Comum",
		["Weight"] = 0.02,
		["Durability"] = 7
	},
	["bread"] = {
		["Index"] = "bread",
		["Name"] = "Pão",
		["Type"] = "Comum",
		["Weight"] = 0.1,
	},
	["moladearma"] = {
		["Index"] = "moladearma",
		["Name"] = "Mola para armamentos",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["capsula"] = {
		["Index"] = "capsula",
		["Name"] = "Capsula Balística",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["projetil"] = {
		["Index"] = "projetil",
		["Name"] = "Projétil Balístico",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["rubber"] = {
		["Index"] = "rubber",
		["Name"] = "Borracha",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["aluminum"] = {
		["Index"] = "aluminum",
		["Name"] = "Alumínio",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["copper"] = {
		["Index"] = "copper",
		["Name"] = "Cobre",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["ritmoneury"] = {
		["Index"] = "ritmoneury",
		["Name"] = "Ritmoneury",
		["Type"] = "Usável",
		["Weight"] = 0.75,
		["Max"] = 5,
	},
	["sinkalmy"] = {
		["Index"] = "sinkalmy",
		["Name"] = "Sinkalmy",
		["Type"] = "Usável",
		["Weight"] = 0.75,
		["Max"] = 5,
	},
	["cigarette"] = {
		["Index"] = "cigarette",
		["Name"] = "Cigarro",
		["Type"] = "Usável",
		["Weight"] = 0.15,
		["Max"] = 20,
	},
	["lighter"] = {
		["Index"] = "lighter",
		["Name"] = "Isqueiro",
		["Repair"] = "repairkit01",
		["Durability"] = 7,
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["vape"] = {
		["Index"] = "vape",
		["Name"] = "Vape",
		["Repair"] = "repairkit02",
		["Type"] = "Usável",
		["Durability"] = 14,
		["Weight"] = 0.75,
	},
	["dollars"] = {
		["Index"] = "dollars",
		["Name"] = "Dólares",
		["Type"] = "Comum",
		["Weight"] = 0.0,
	},
	["dollarz"] = {
		["Index"] = "dollarz",
		["Name"] = "Rolo de notas",
		["Description"] = "Recomendamos que não deposite em sua conta.",
		["Type"] = "Comum",
		["Weight"] = 0.0,
	},
	["dollarx"] = {
		["Index"] = "dollarx",
		["Name"] = "Dinheiro marcado",
		["Description"] = "Proveniente de atos ilícitos.",
		["Type"] = "Comum",
		["Weight"] = 0.0,
	},
	["battery"] = {
		["Index"] = "battery",
		["Name"] = "Pilhas",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["elastic"] = {
		["Index"] = "elastic",
		["Name"] = "Elástico",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["plasticbottle"] = {
		["Index"] = "plasticbottle",
		["Name"] = "Garrafa Plástica",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["glassbottle"] = {
		["Index"] = "glassbottle",
		["Name"] = "Garrafa de Vidro",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["reciclavel"] = {
		["Index"] = "reciclavel",
		["Name"] = "Material Reciclável",
		["Description"] = "Utilizado para troca na reciclagem.",
		["Type"] = "Comum",
		["Weight"] = 0.20,
	},
	["metalcan"] = {
		["Index"] = "metalcan",
		["Name"] = "Lata de Metal",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["chocolate"] = {
		["Index"] = "chocolate",
		["Name"] = "Chocolate",
		["Type"] = "Usável",
		["Weight"] = 0.15,
		["Scape"] = true,
		["Max"] = 10,
	},
	["nigirizushi"] = {
		["Index"] = "nigirizushi",
		["Name"] = "Nigirizushi",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 0.65,
		["Scape"] = true,
		["Max"] = 5,
		["Economy"] = 75
	},
	["sushi"] = {
		["Index"] = "sushi",
		["Name"] = "Sushi",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 0.65,
		["Scape"] = true,
		["Max"] = 5,
		["Economy"] = 75
	},

	["quiche"] = {
		["Index"] = "quiche",
		["Name"] = "Esfirra de frango",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 5,
		["Economy"] = 75
	},
	["redvelvet"] = {
		["Index"] = "redvelvet",
		["Name"] = "Bolo de Morango",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 5,
		["Economy"] = 75
	},
	["sorvete"] = {
		["Index"] = "sorvete",
		["Name"] = "Sorvete",
		["Type"] = "Usável",
		["Durability"] = 2,
		["Weight"] = 0.55,
		["Scape"] = true,
		["Max"] = 5,
		["Economy"] = 75
	},
	
	["sandwich"] = {
		["Index"] = "sandwich",
		["Name"] = "Sanduiche",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.25,
		["Max"] = 10,
	},
	["rose"] = {
		["Index"] = "rose",
		["Name"] = "Rosa",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["teddy"] = {
		["Index"] = "teddy",
		["Name"] = "Teddy",
		["Type"] = "Usável",
		["Weight"] = 1.25,
	},
	["absolut"] = {
		["Index"] = "absolut",
		["Name"] = "Absolut",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
	},
	["chandon"] = {
		["Index"] = "chandon",
		["Name"] = "Chandon",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
	},
	["dewars"] = {
		["Index"] = "dewars",
		["Name"] = "Dewars",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
	},
	["hennessy"] = {
		["Index"] = "hennessy",
		["Name"] = "Hennessy",
		["Type"] = "Usável",
		["Durability"] = 1,
		["Weight"] = 0.55,
	},
	["goldbar"] = {
		["Index"] = "goldbar",
		["Name"] = "Barra de Ouro",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["binoculars"] = {
		["Index"] = "binoculars",
		["Name"] = "Binóculos",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["camera"] = {
		["Index"] = "camera",
		["Name"] = "Câmera",
		["Type"] = "Usável",
		["Weight"] = 1.25,
	},
	["WEAPON_HATCHET"] = {
		["Index"] = "hatchet",
		["Name"] = "Machado",
		["Type"] = "Armamento",
		["Repair"] = "repairkit01",
		["Durability"] = 7,
		["Weight"] = 1.75,
	},
	["WEAPON_BAT"] = {
		["Index"] = "bat",
		["Name"] = "Bastão de Beisebol",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.75,
	},
	["WEAPON_KATANA"] = {
		["Index"] = "katana",
		["Name"] = "Katana",
		["Type"] = "Armamento",
		["Repair"] = "repairkit01",
		["Durability"] = 3,
		["Weight"] = 1.75,
	},
	["WEAPON_KARAMBIT"] = {
		["Index"] = "karambit",
		["Name"] = "Karambit",
		["Type"] = "Armamento",
		["Repair"] = "repairkit01",
		["Durability"] = 7,
		["Weight"] = 1.25,
	},
	["PA"] = {
		["Index"] = "PA",
		["Name"] = "Pá",
		["Type"] = "Armamento",
		["Description"] = "Utilizada na agicultura",
		["Durability"] = 3,
		["Weight"] = 1.25,
	},
	["WEAPON_BATTLEAXE"] = {
		["Index"] = "battleaxe",
		["Name"] = "Machado de Batalha",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.75,
	},
	["WEAPON_CROWBAR"] = {
		["Index"] = "crowbar",
		["Name"] = "Pé de Cabra",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.35,
	},
	["WEAPON_GOLFCLUB"] = {
		["Index"] = "golfclub",
		["Name"] = "Taco de Golf",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.65,
	},
	["WEAPON_HAMMER"] = {
		["Index"] = "hammer",
		["Name"] = "Martelo",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.45,
	},
	["WEAPON_MACHETE"] = {
		["Index"] = "machete",
		["Name"] = "Facão",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.35,
	},
	["WEAPON_POOLCUE"] = {
		["Index"] = "poolcue",
		["Name"] = "Taco de Sinuca",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.25,
	},
	["WEAPON_STONE_HATCHET"] = {
		["Index"] = "stonehatchet",
		["Name"] = "Tesoura",
		["Description"] = "Utilizada no pomar",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.55,
	},
	["WEAPON_WRENCH"] = {
		["Index"] = "wrench",
		["Name"] = "Chave Inglesa",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.45,
	},
	["WEAPON_KNUCKLE"] = {
		["Index"] = "knuckle",
		["Name"] = "Soco Inglês",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.15,
	},
	["WEAPON_FLASHLIGHT"] = {
		["Index"] = "flashlight",
		["Name"] = "Lanterna",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.15,
	},
	["WEAPON_NIGHTSTICK"] = {
		["Index"] = "nightstick",
		["Name"] = "Cassetete",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Durability"] = 7,
		["Weight"] = 1.15,
	},
	["WEAPON_PISTOL"] = {
		["Index"] = "m1911",
		["Name"] = "M1911",
		["Repair"] = "repairkit02",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 2.25,
	},
	["WEAPON_PISTOL_MK2"] = {  --------- NOME DE SPAWN
		["Index"] = "fiveseven", ----- NOME DA IMAGEM CHAMADA NO PASTA IMAGE
		["Name"] = "FN Five Seven",---- NOME FANTASIA 
		["Type"] = "Armamento",  -----------
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 8.25,
	},
	["WEAPON_COMPACTRIFLE"] = {
		["Index"] = "akcompact",
		["Name"] = "AK Compact",
		["Repair"] = "repairkit03",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 14,
		["Weight"] = 4.25,
	},
	["WEAPON_APPISTOL"] = {
		["Index"] = "kochvp9",
		["Name"] = "Koch Vp9",
		["Repair"] = "repairkit03",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 2.75,
	},
	["WEAPON_HEAVYPISTOL"] = {
		["Index"] = "atifx45",
		["Name"] = "FX45",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 10.25,
	},
	["WEAPON_MACHINEPISTOL"] = {
		["Index"] = "tec9",
		["Name"] = "Tec-9",
		["Type"] = "Armamento",
		["Repair"] = "repairkit03",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 3.25,
	},
	["WEAPON_MICROSMG"] = {
		["Index"] = "uzi",
		["Name"] = "Uzi",
		["Type"] = "Armamento",
		["Repair"] = "repairkit03",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 4.25,
	},
	["WEAPON_NAILGUN"] = {
		["Index"] = "nailgun",
		["Name"] = "Arma de Prego",
		["Repair"] = "repairkit01",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_NAIL_AMMO",
		["Durability"] = 7,
		["Vehicle"] = false,
		["Weight"] = 4.25,
	},
	["WEAPON_MINISMG"] = {
		["Index"] = "skorpionv61",
		["Name"] = "Skorpion V61",
		["Repair"] = "repairkit03",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 5.25,
	},
	["WEAPON_SNSPISTOL"] = {
		["Index"] = "amt380",
		["Name"] = "AMT 380",
		["Repair"] = "repairkit02",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 2.25,
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		["Index"] = "hkp7m10",
		["Name"] = "HK P7M10",
		["Repair"] = "repairkit02",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 8.25,
	},
	["WEAPON_VINTAGEPISTOL"] = {
		["Index"] = "m1922",
		["Name"] = "Ruger Mark IV",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 8.25,
	},
	["WEAPON_PISTOL50"] = {
		["Index"] = "desert",
		["Name"] = "Desert Eagle",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 10.25,
	},
	["WEAPON_REVOLVER"] = {
		["Index"] = "magnum",
		["Name"] = "Magnum 44",
		["Repair"] = "repairkit03",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_AMMO",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 4.25,
	},
	["WEAPON_COMBATPISTOL"] = {
		["Index"] = "glock",
		["Name"] = "Glock",
		["Repair"] = "repairkit02",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PISTOL_POLICE",
		["Durability"] = 14,
		["Vehicle"] = true,
		["Weight"] = 3.25,
	},
	["WEAPON_PARAFAL"] = {
		["Index"] = "parafal",
		["Name"] = "PARA-FAL M964A1",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_FNFAL"] = {
		["Index"] = "fnfal",
		["Name"] = "FN L1A1",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_COLTXM177"] = {
		["Index"] = "coltxm177",
		["Name"] = "Colt XM177",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_CARBINERIFLE"] = {
		["Index"] = "m4a1",
		["Name"] = "M4A1",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["Index"] = "m4a4",
		["Name"] = "M4A4",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 8.75,
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["Index"] = "tar21",
		["Name"] = "Tar-21",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["Index"] = "qbz95",
		["Name"] = "QBZ-95",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["Index"] = "l85",
		["Name"] = "L85",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_SPECIALCARBINE"] = {
		["Index"] = "g36c",
		["Name"] = "G36C",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 8.75,
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["Index"] = "sigsauer556",
		["Name"] = "Sig Sauer 556",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 8.75,
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["Index"] = "mossberg590",
		["Name"] = "Mossberg 590",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SHOTGUN_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.25,
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["Index"] = "mossberg590a1",
		["Name"] = "Mossberg 590A1",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SHOTGUN_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.25,
	},
	["WEAPON_MUSKET"] = {
		["Index"] = "winchester",
		["Name"] = "Winchester 1892",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_MUSKET_AMMO",
		["Durability"] = 21,
		["Weight"] = 6.25,
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		["Index"] = "mossberg500",
		["Name"] = "Mossberg 500",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SHOTGUN_AMMO",
		["Durability"] = 21,
		["Weight"] = 5.75,
	},
	["WEAPON_SMG"] = {
		["Index"] = "mp5",
		["Name"] = "MP5",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 21,
		["Weight"] = 5.25,
	},
	["WEAPON_SMG_MK2"] = {
		["Index"] = "evo3",
		["Name"] = "Evo-3",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 21,
		["Vehicle"] = true,
		["Weight"] = 5.25,
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["Index"] = "ak103",
		["Name"] = "AK-103",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["Index"] = "ak74",
		["Name"] = "AK-74",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 7.75,
	},
	["WEAPON_ASSAULTSMG"] = {
		["Index"] = "steyraug",
		["Name"] = "Steyr AUG",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RIFLE_AMMO",
		["Durability"] = 21,
		["Weight"] = 5.75,
	},
	["WEAPON_GUSENBERG"] = {
		["Index"] = "thompson",
		["Name"] = "Thompson",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_SMG_AMMO",
		["Durability"] = 21,
		["Weight"] = 6.25,
	},
	["WEAPON_PETROLCAN"] = {
		["Index"] = "gallon",
		["Name"] = "Galão",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_PETROLCAN_AMMO",
		["Weight"] = 1.25,
	},
	["GADGET_PARACHUTE"] = {
		["Index"] = "parachute",
		["Name"] = "Paraquedas",
		["Type"] = "Usável",
		["Weight"] = 2.25,
	},
	["WEAPON_STUNGUN"] = {
		["Index"] = "stungun",
		["Name"] = "Tazer",
		["Type"] = "Armamento",
		["Durability"] = 21,
		["Weight"] = 0.75,
	},
	["WEAPON_NAIL_AMMO"] = {
		["Index"] = "nails",
		["Name"] = "Pregos",
		["Type"] = "Munição",
		["Weight"] = 0.05,
	},
	["WEAPON_PISTOL_AMMO"] = {
		["Index"] = "pistolammo",
		["Name"] = "Munição de Pistola",
		["Type"] = "Munição",
		["Weight"] = 0.5,
	},
	["WEAPON_PISTOL_POLICE"] = {
		["Index"] = "pistolammo",
		["Name"] = "Munição de Pistola Policial",
		["Type"] = "Munição",
		["Weight"] = 0.035,
	},
	["WEAPON_SMG_AMMO"] = {
		["Index"] = "smgammo",
		["Name"] = "Munição de Sub",
		["Type"] = "Munição",
		["Weight"] = 0.045,
	},
	["WEAPON_RIFLE_AMMO"] = {
		["Index"] = "rifleammo",
		["Name"] = "Munição de Rifle",
		["Type"] = "Munição",
		["Weight"] = 0.055,
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		["Index"] = "shotgunammo",
		["Name"] = "Munição de Escopeta",
		["Type"] = "Munição",
		["Weight"] = 0.075,
	},
	["WEAPON_MUSKET_AMMO"] = {
		["Index"] = "musketammo",
		["Name"] = "Munição de Mosquete",
		["Type"] = "Munição",
		["Weight"] = 0.075,
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		["Index"] = "fuel",
		["Name"] = "Combustível",
		["Type"] = "Munição",
		["Weight"] = 0.001,
	},
	["WEAPON_BRICK"] = {
		["Index"] = "brick",
		["Name"] = "Tijolo",
		["Type"] = "Throwing",
		["Vehicle"] = true,
		["Weight"] = 0.75,
	},
	["WEAPON_SNOWBALL"] = {
		["Index"] = "snowball",
		["Name"] = "Bola de Neve",
		["Type"] = "Throwing",
		["Vehicle"] = true,
		["Weight"] = 0.55,
	},
	["WEAPON_SHOES"] = {
		["Index"] = "shoes",
		["Name"] = "Tênis",
		["Type"] = "Throwing",
		["Vehicle"] = true,
		["Weight"] = 0.755,
	},
	["WEAPON_MOLOTOV"] = {
		["Index"] = "molotov",
		["Name"] = "Coquetel Molotov",
		["Type"] = "Throwing",
		["Vehicle"] = true,
		["Weight"] = 0.95,
		["Max"] = 3
	},
	["WEAPON_SMOKEGRENADE"] = {
		["Index"] = "smokegrenade",
		["Name"] = "Granada de Fumaça",
		["Type"] = "Throwing",
		["Vehicle"] = true,
		["Weight"] = 0.95,
		["Max"] = 3
	},
	["pager"] = {
		["Index"] = "pager",
		["Name"] = "Pager",
		["Type"] = "Usável",
		["Weight"] = 2.25,
	},
	["firecracker"] = {
		["Index"] = "firecracker",
		["Name"] = "Fogos de Artificio",
		["Description"] = "Traga uma multidão com esses lindos fogos de artifício.",
		["Type"] = "Usável",
		["Weight"] = 2.25,
	},
	["analgesic"] = {
		["Index"] = "analgesic",
		["Name"] = "Analgésico",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 5,
	},
	["drogazil"] = {
		["Index"] = "analgesic",
		["Name"] = "Droga-zil",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 5,
	},
	["oxy"] = {
		["Index"] = "analgesic",
		["Name"] = "Oxy",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 5,
	},
	["gauze"] = {
		["Index"] = "gauze",
		["Name"] = "Gaze",
		["Type"] = "Usável",
		["Weight"] = 0.25,
		["Max"] = 5,
	},
	["gsrkit"] = {
		["Index"] = "gsrkit",
		["Name"] = "Kit Residual",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["gdtkit"] = {
		["Index"] = "gdtkit",
		["Name"] = "Kit Químico",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["coal"] = {
		["Index"] = "coal",
		["Name"] = "Carvão",
		["Type"] = "Comum",
		["Weight"] = 0.95,
	},
	["sulfur"] = {
		["Index"] = "sulfur",
		["Name"] = "Enxofre",
		["Description"] = "Isso fede muito!",
		["Type"] = "Comum",
		["Weight"] = 0.95,
	},
	["polvora"] = {
		["Index"] = "polvora",
		["Name"] = "Pólvora",
		["Description"] = "Altamente inflamável!",
		["Type"] = "Comum",
		["Weight"] = 0.10,
	},
	["emerald"] = {
		["Index"] = "emerald",
		["Name"] = "Esmeralda",
		["Type"] = "Comum",
		["Weight"] = 0.95,
	},
	["diamond"] = {
		["Index"] = "diamond",
		["Name"] = "Diamante",
		["Type"] = "Comum",
		["Weight"] = 0.95,
	},
	["ruby"] = {
		["Index"] = "ruby",
		["Name"] = "Rubi",
		["Type"] = "Comum",
		["Weight"] = 0.85,
	},
	["sapphire"] = {
		["Index"] = "sapphire",
		["Name"] = "Safira",
		["Type"] = "Comum",
		["Weight"] = 0.85,
	},
	["amethyst"] = {
		["Index"] = "amethyst",
		["Name"] = "Ametista",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["amber"] = {
		["Index"] = "amber",
		["Name"] = "Âmbar",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["turquoise"] = {
		["Index"] = "turquoise",
		["Name"] = "Turquesa",
		["Type"] = "Comum",
		["Weight"] = 0.65,
	},
	["keyboard"] = {
		["Index"] = "keyboard",
		["Name"] = "Teclado",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["mouse"] = {
		["Index"] = "mouse",
		["Name"] = "Mouse",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["smarthwatch"] = {
		["Index"] = "smarthwatch",
		["Name"] = "Smarth Watch",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["silverring"] = {
		["Index"] = "silverring",
		["Name"] = "Anel de Prata",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["adrenaline"] = {
        ["Index"] = "adrenaline",
        ["Name"] = "Adrenalina",
        ["Type"] = "Usável",
        ["Weight"] = 0.35,
		["Max"] = 1,
    },
	["phone"] = {
		["Index"] = "phone",
		["Name"] = "Fone de ouvido Bluetooth",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["smarthphone"] = {
		["Index"] = "smarthphone",
		["Name"] = "Galáxia S15 Quebrado",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["brincodeouro"] = {
		["Index"] = "brincodeouro",
		["Name"] = "Brincos de ouro",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["correntedeouro"] = {
		["Index"] = "correntedeouro",
		["Name"] = "Corrente de Ouro",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["goldring"] = {
		["Index"] = "goldring",
		["Name"] = "Anel de Ouro",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["silvercoin"] = {
		["Index"] = "silvercoin",
		["Name"] = "Moeda de Prata",
		["Type"] = "Usável",
		["Weight"] = 0.05,
	},
	["goldcoin"] = {
		["Index"] = "goldcoin",
		["Name"] = "Moeda de Ouro",
		["Type"] = "Usável",
		["Weight"] = 0.05,
	},
	["watch"] = {
		["Index"] = "watch",
		["Name"] = "Relógio",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["playstation"] = {
		["Index"] = "playstation",
		["Name"] = "Playstation",
		["Type"] = "Comum",
		["Weight"] = 1.25,
	},
	["xbox"] = {
		["Index"] = "xbox",
		["Name"] = "Xbox",
		["Type"] = "Comum",
		["Weight"] = 1.25,
	},
	["inscricao"] = {
		["Index"] = "inscricao",
		["Name"] = "Ticket de inscrição para evento",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["centraldecontrole"] = {
		["Index"] = "centralveicular",
		["Name"] = "central veicular",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["recibo"] = {
		["Index"] = "recibo",
		["Name"] = "recibo",
		["Type"] = "Comum",
		["Weight"] = 0.1,
	},
	["bracelet"] = {
		["Index"] = "bracelet",
		["Name"] = "Bracelete",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["bateria"] = {
		["Index"] = "bateria",
		["Name"] = "bateria",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["spray01"] = {
		["Index"] = "spray01",
		["Name"] = "Desodorante 24hrs",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["spray02"] = {
		["Index"] = "spray02",
		["Name"] = "Antisséptico",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["spray03"] = {
		["Index"] = "spray03",
		["Name"] = "Desodorante 48hrs",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["spray04"] = {
		["Index"] = "spray04",
		["Name"] = "Desodorante 72hrs",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["dices"] = {
		["Index"] = "dices",
		["Name"] = "Dados",
		["Type"] = "Usável",
		["Weight"] = 0.35,
	},
	["dish"] = {
		["Index"] = "dish",
		["Name"] = "Prato",
		["Type"] = "Comum",
		["Weight"] = 0.55,
	},
	["oxidonitroso"] = {
		["Index"] = "oxidonitroso",
		["Name"] = "Carga de óxido nitroso",
		["Type"] = "Usável",
		["Weight"] = 0.55,
	},
	["fan"] = {
		["Index"] = "fan",
		["Name"] = "Ventilador",
		["Type"] = "Comum",
		["Weight"] = 1.15,
	},
	["smartphone"] = {
		["Index"] = "smartphone",
		["Name"] = "smartphone",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["blender"] = {
		["Index"] = "blender",
		["Name"] = "Liquidificador",
		["Type"] = "Usável",
		["Weight"] = 0.75,
	},
	["switch"] = {
		["Index"] = "switch",
		["Name"] = "Interruptor",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["horseshoe"] = {
		["Index"] = "horseshoe",
		["Name"] = "Ferradura",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["brush"] = {
		["Index"] = "brush",
		["Name"] = "Escova",
		["Type"] = "Comum",
		["Weight"] = 0.25,
	},
	["pendrive"] = {
		["Index"] = "pendrive",
		["Name"] = "pendrive",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["floppy"] = {
		["Index"] = "floppy",
		["Name"] = "Disquete",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["cup"] = {
		["Index"] = "cup",
		["Name"] = "Cálice",
		["Type"] = "Comum",
		["Weight"] = 0.45,
	},
	["deck"] = {
		["Index"] = "deck",
		["Name"] = "Baralho",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["eraser"] = {
		["Index"] = "eraser",
		["Name"] = "Apagador",
		["Type"] = "Comum",
		["Weight"] = 0.15,
	},
	["pliers"] = {
		["Index"] = "pliers",
		["Name"] = "Alicate",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["lampshade"] = {
		["Index"] = "lampshade",
		["Name"] = "Abajur",
		["Type"] = "Comum",
		["Weight"] = 0.75,
	},
	["soap"] = {
		["Index"] = "soap",
		["Name"] = "Sabonete",
		["Type"] = "Usável",
		["Weight"] = 0.25,
	},
	["slipper"] = {
		["Index"] = "slipper",
		["Name"] = "Chinelo",
		["Type"] = "Comum",
		["Weight"] = 0.35,
	},
	["pendrive2"] = {
		["Index"] = "pendrive2",
		["Name"] = "Pendrive com Malware",
		["Type"] = "Comum",
		["Durability"] = 3,
		["Weight"] = 0.75,
	},
	["folheto"] = {
		["Index"] = "folheto",
		["Name"] = "Folheto",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},
	["autorizacao"] = {
		["Index"] = "autorizacao",
		["Name"] = "Autorizaçao de trabalho",
		["Type"] = "Usável",
		["Description"] = "Certificado de autorização de trafego livre entre sul e norte para trabalho, o mesmo deve conter veiculo de trabalho e uniforme. VALIDO APENAS PARA TRABALHOS SEM SETAGEM.",
		["Charges"] = 2,
		["Weight"] = 0.1,
	},
	["vazo"] = {
		["Index"] = "vazo",
		["Name"] = "Vaso para colocar plantas",
		["Type"] = "Comum",
		["Weight"] = 1.500
	},
	["terra"] = {
		["Index"] = "terra",
		["Name"] = "Pacote de terra com fertilizante",
		["Type"] = "Comum",
		["Weight"] = 3.000
	},
	["dryweedleaf"] = {
		["Index"] = "dryweedleaf",
		["Name"] = "Flor de Cannabis Seca",
		["Type"] = "Comum",
		["Weight"] = 0.30
	},
	["cardapiobs"] = {
		["Index"] = "cardapiobs",
		["Name"] = "Cardápio BurgerShot",
		["Type"] = "Usável",
		["Weight"] = 0.0,
	},
	["folhetolock"] = {
		["Index"] = "folhetolock",
		["Name"] = "Papel com informações",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},
	["folhetopinxar"] = {
		["Index"] = "folhetolock",
		["Name"] = "Papel com informações",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},
	["mandado"] = {
		["Index"] = "mandado",
		["Name"] = "Mandado de Busca e Apreensão.",
		["Type"] = "Usável",
		["Weight"] = 0.1,
	},
	["folhetopd"] = {
		["Index"] = "folhetopd",
		["Name"] = "Papel com informações",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},
	["folhetoproerd"] = {
		["Index"] = "folhetoproerd",
		["Name"] = "PROERD",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},
	["folhetolavagem"] = {
		["Index"] = "folhetolavagem",
		["Name"] = "Folheto com informações",
		["Type"] = "Usável",
		["Charges"] = 1,
		["Weight"] = 0.1,
	},	

	["racaosilvestre"] = {
		["Index"] = "racaosilvestre",
		["Name"] = "Ração Silvestre",
		["Description"] = "Raçao ultilizada para atrair o animal, usar no ponto marcado no mapa.",
		["Type"] = "Usável",
		["Weight"] = 0.1,
	},
	["WEAPON_RPG_AMMO"] = {
		["Index"] = "rpg_ammo",
		["Name"] = "Munição de RPG",
		["Type"] = "Munição",
		["Weight"] = 0.045,
	},
	["WEAPON_RPG"] = {
		["Index"] = "weapon_rpg",
		["Name"] = "RPG Launcher",
		["Type"] = "Armamento",
		["Ammo"] = "WEAPON_RPG_AMMO",
		["Durability"] = 21,
		["Vehicle"] = true,
		["Weight"] = 5.25,
	},
	["slotgaragem"] = {
		["Index"] = "slotgaragem",
		["Name"] = "+1 Vaga de Garagem",
		["Description"] = "Adiciona uma vaga em sua garagem.",
		["Type"] = "Usável",
		["Weight"] = 0.1,
		['Block'] = true
	},
	["chip"] = {
		["Index"] = "chip",
		["Name"] = "Chip Telefônico",
		["Type"] = "Usável",
		["Weight"] = 0.1,
		['Block'] = true
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBody(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] then
		return List[Item]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function itemIndex(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Index"] then
		return List[Item]["Index"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function itemName(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Name"] then
		return List[Item]["Name"]
	end

	return "Deletado"
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemType(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Type"] then
		return List[Item]["Type"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
function itemAmmo(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Ammo"] then
		return List[Item]["Ammo"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemVehicle(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Vehicle"] then
		return List[Item]["Vehicle"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemWeight(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Weight"] then
		return List[Item]["Weight"] + 0.0
	end

	return 0.0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function itemMaxAmount(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Max"] then
		return List[Item]["Max"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
function itemScape(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Scape"] then
		return List[Item]["Scape"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDescription(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Description"] then
		return List[Item]["Description"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemDurability(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Durability"] then
		return List[Item]["Durability"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
function itemCharges(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Charges"] then
		return List[Item]["Charges"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMY
-----------------------------------------------------------------------------------------------------------------------------------------
function itemEconomy(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Economy"] then
		return List[Item]["Economy"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
function itemBlock(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Block"] then
		return List[Item]["Block"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMREPAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function itemRepair(Item)
	local Split = splitString(Item,"-")
	local Item = Split[1]

	if List[Item] and List[Item]["Repair"] then
		return List[Item]["Repair"]
	end

	return false
end