-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("robberys",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberype = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS
-----------------------------------------------------------------------------------------------------------------------------------------
local Robberys = {
	["1"] = {
		["Coords"] = vec3(31.28,-1339.31,29.49),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = -3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["2"] = {
		["Coords"] = vec3(2549.46,387.92,108.61),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 0,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["3"] = {
		["Coords"] = vec3(1159.46,-314.0,69.2),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["4"] = {
		["Coords"] = vec3(-709.78,-904.12,19.21),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["5"] = {
		["Coords"] = vec3(-43.45,-1748.32,29.42),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["6"] = {
		["Coords"] = vec3(381.09,332.5,103.56),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["7"] = {
		["Coords"] = vec3(-3249.65,1007.46,12.82),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["8"] = {
		["Coords"] = vec3(1737.49,6419.37,35.03),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["9"] = {
		["Coords"] = vec3(543.68,2662.61,42.16),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["10"] = {
		["Coords"] = vec3(1961.89,3750.24,32.33),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["11"] = {
		["Coords"] = vec3(2674.36,3289.26,55.23),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["12"] = {
		["Coords"] = vec3(1707.96,4920.45,42.06),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["13"] = {
		["Coords"] = vec3(-1829.22,798.74,138.19),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["14"] = {
		["Coords"] = vec3(-2959.66,387.08,14.04),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["15"] = {
		["Coords"] = vec3(-3048.68,588.59,7.9),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["16"] = {
		["Coords"] = vec3(1126.81,-980.07,45.41),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["17"] = {
		["Coords"] = vec3(1169.33,2717.82,37.15),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["18"] = {
		["Coords"] = vec3(-1478.9,-375.48,39.16),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["19"] = {
		["Coords"] = vec3(-1220.9,-916.02,11.32),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["20"] = {
		["Coords"] = vec3(170.97,6642.43,31.69),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["21"] = {
		["Coords"] = vec3(-168.42,6318.78,30.58),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["22"] = {
		["Coords"] = vec3(819.29,-774.6,26.17),
		["name"] = "Loja de Departamento",
		["type"] = "department",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card01",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 50000, ["max"] = 55000 }
		}
	},
	["23"] = {
		["Coords"] = vec3(1693.15,3761.99,34.69),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["24"] = {
		["Coords"] = vec3(253.34,-51.77,69.94),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["25"] = {
		["Coords"] = vec3(841.01,-1035.27,28.19),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["26"] = {
		["Coords"] = vec3(-330.72,6085.89,31.46),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["27"] = {
		["Coords"] = vec3(-660.9,-933.54,21.82),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["28"] = {
		["Coords"] = vec3(-1304.4,-395.89,36.7),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["29"] = {
		["Coords"] = vec3(-1117.97,2700.66,18.55),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["30"] = {
		["Coords"] = vec3(2566.58,292.59,108.73),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["31"] = {
		["Coords"] = vec3(-3172.99,1089.64,20.84),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["32"] = {
		["Coords"] = vec3(23.83,-1106.01,29.79),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["33"] = {
		["Coords"] = vec3(808.86,-2159.01,29.62),
		["name"] = "Loja de Armas",
		["type"] = "ammunation",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 3,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card02",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 30000, ["max"] = 40000 }
		}
	},
	["34"] = {
		["Coords"] = vec3(138.23,-1703.74,29.28),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 8000, ["max"] = 10000 }
		}
	},
	["35"] = {
		["Coords"] = vec3(1216.86,-472.32,66.2),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 8000, ["max"] = 10000 }
		}
	},
	["36"] = {
		["Coords"] = vec3(-1278.73,-1115.44,6.99),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 8000, ["max"] = 10000 }
		}
	},
	["37"] = {
		["Coords"] = vec3(-823.04,-183.94,37.56),
		["name"] = "Barbearia",
		["type"] = "barbershop",
		["cooldown"] = 5400,
		["duration"] = 300,
		["group"] = "Police",
		["population"] = 5,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card04",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 8000, ["max"] = 10000 }
		}
	},
	["38"] = {
		["Coords"] = vec3(-1210.46,-336.45,38.10),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["39"] = {
		["Coords"] = vec3(-353.54,-55.44,49.36),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["40"] = {
		["Coords"] = vec3(311.51,-284.59,54.48),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["41"] = {
		["Coords"] = vec3(147.18,-1046.23,29.68),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["42"] = {
		["Coords"] = vec3(-2956.50,482.09,16.01),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["43"] = {
		["Coords"] = vec3(1175.69,2712.89,38.41),
		["name"] = "Banco Fleeca",
		["type"] = "fleeca",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 6,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "card03",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 80000, ["max"] = 100000 }
		}
	},
	["44"] = {
		["Coords"] = vec3(225.37,226.83,97.11),
		["name"] = "Banco Central",
		["type"] = "Central",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 10,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 300000, ["max"] = 400000 }
		}
	},
	["45"] = {
		["Coords"] = vec3(-631.47,-230.18,38.05),
		["name"] = "Roubo Joalheria",
		["type"] = "Joalheria",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 0,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 110000, ["max"] = 150000 }
		}
	},
	["46"] = {
		["Coords"] = vec3(-77.72,6224.63,31.09),
		["name"] = "Roubo ao Galinheiro",
		["type"] = "Galinheiro",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 8,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 35000, ["max"] = 45000 }
		}
	},
	["47"] = {
		["Coords"] = vec3(3560.02,3672.16,28.12),
		["name"] = "Roubo Niobio",
		["type"] = "Niobio",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 15,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 400000, ["max"] = 450000 }
		}
	},
	["48"] = {
		["Coords"] = vec3(-103.96,6477.58,31.63),
		["name"] = "Banco Paleto",
		["type"] = "Paleto",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 8,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 110000, ["max"] = 150000 }
		}
	},
	["49"] = {
		["Coords"] = vec3(990.32,-2149.71,30.19),
		["name"] = "Roubo ao Açougue",
		["type"] = "Açougue",
		["cooldown"] = 21600,
		["duration"] = 480,
		["group"] = "Police",
		["population"] = 8,
		["avaiable"] = false,
		["timavaiable"] = 0,
		["need"] = {
			["item"] = "pendrive",
			["amount"] = 1
		},
		["payment"] = {
			{ ["item"] = "dollarz", ["min"] = 35000, ["max"] = 45000 }
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("robberys:Init")
AddEventHandler("robberys:Init",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Robberys[Number] then
			if not Robberys[Number]["avaiable"] then
				if not Robberype[Robberys[Number]["type"]] then
					Robberype[Robberys[Number]["type"]] = os.time()
				end

				if os.time() >= Robberype[Robberys[Number]["type"]] then
					local Service,Total = vRP.NumPermission(Robberys[Number]["group"])
					if Total >= Robberys[Number]["population"] then
						local Consult = vRP.InventoryItemAmount(Passport,Robberys[Number]["need"]["item"])
						if Consult[1] >= Robberys[Number]["need"]["amount"] then
							if not vRP.CheckDamaged(Consult[2]) then
								if vRP.TakeItem(Passport,Consult[2],Robberys[Number]["need"]["amount"]) then
									Robberype[Robberys[Number]["type"]] = os.time() + Robberys[Number]["cooldown"]
									Robberys[Number]["timavaiable"] = os.time() + Robberys[Number]["duration"]
									Robberys[Number]["avaiable"] = true

									for Passports,Sources in pairs(Service) do
										async(function()
											TriggerClientEvent("NotifyPush",Sources,{ code = 31, title = Robberys[Number]["name"], x = Robberys[Number]["Coords"]["x"], y = Robberys[Number]["Coords"]["y"], z = Robberys[Number]["Coords"]["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
											vRPC.PlaySound(Sources,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
										end)
									end

									TriggerClientEvent("Notify",source,"verde","Progresso de desencriptação do sistema iniciado, o mesmo vai estar concluído em <b>"..Robberys[Number]["duration"].."</b> segundos.",5000)
								end
							else
								TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Robberys[Number]["need"]["item"]).."</b> danificado.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..Robberys[Number]["need"]["amount"].."x "..itemName(Robberys[Number]["need"]["item"]).."</b>.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Contingente indisponível.",5000)
					end
				else
					local Cooldown = parseInt(Robberype[Robberys[Number]["type"]] - os.time())
					TriggerClientEvent("Notify",source,"azul","Cofre está vazio, aguarde <b>"..Cooldown.."</b> segundos.",5000)
				end
			else
				if os.time() >= Robberys[Number]["timavaiable"] then
					Robberys[Number]["avaiable"] = false

					for k,v in pairs(Robberys[Number]["payment"]) do
						vRP.GenerateItem(Passport,v["item"],math.random(v["min"],v["max"]),true)
					end
				else
					local Cooldown = parseInt(Robberys[Number]["timavaiable"] - os.time())
					TriggerClientEvent("Notify",source,"azul","Desencriptação em andamento, aguarde <b>"..Cooldown.."</b> segundos.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("robberys:Init",source,Robberys)
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	TriggerClientEvent("robberys:Init",-1,Robberys)
end)