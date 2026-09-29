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
Tunnel.bindInterface("crafting",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")
----------------------------------------------------------------------------------------------------------------------------------------
-- Variáveis
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookcrafting = "https://discord.com/api/webhooks/1155802288670126091/zC-6YyqMXcEfHv7HzhCslDiw-6CRkq7RMcBacAMDhbFfKfxpMTTi_Vjw4cXfgzc4jD3s"
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	["Polvora"] = {
		["List"] = {
			["polvora"] = {
				["amount"] = 2,
				["destroy"] = false,
				["require"] = {
					["coal"] = 1,
					["sulfur"] = 1
				}
			},
		}
	},
	["Ballas"] = {
		["perm"] = "Ballas",
		["List"] = {
			["tablemeth"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
		}
	},
	["Families"] = {
		["perm"] = "Families",
		["List"] = {
			["tablelean"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
		}
	},
	["Bloods"] = {
		["perm"] = "Bloods",
		["List"] = {
			["tableecstasy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
		}
	},
	["Vagos"] = {
		["perm"] = "Vagos",
		["List"] = {
			["tablecoke"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 10,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2,
					["tarp"] = 1,
					["explosives"] = 3
				}
			},
		}
	},	
	["Yakuza-3"] = {
		["perm"] = "Yakuza",
		["List"] = {
			["attachsFlashlight"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					--["roadsigns"] = 2,
					["glass"] = 1,
					["plastic"] = 3
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					--["roadsigns"] = 6,
					["sheetmetal"] = 6
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					--["roadsigns"] = 2,
					["glass"] = 2,
					["aluminum"] = 1
				}
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					--["roadsigns"] = 2,
					["aluminum"] = 3
				}
			},
			["attachsMagazine"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["techtrash"] = 10,
					--["roadsigns"] = 4,
					["sheetmetal"] = 3
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 100
				}
			}
		}
	},
	
	["Tijuana"] = {
		["perm"] = "Tijuana",
		["List"] = {
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["rubber"] = 30,
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 120,
					["copper"] = 120,
					["rubber"] = 60,
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			
		}
	},
	["Bratva"] = {
		["perm"] = "Bratva",
		["List"] = {
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["rubber"] = 30,
				}
			},
			["WEAPON_HEAVYPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 120,
					["copper"] = 120,
					["rubber"] = 60,
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 140,
					["copper"] = 140,
					["rubber"] = 80,
				}
			},
			
		}
	},
	["Resistencia"] = {
		["perm"] = "Resistencia",
		["List"] = {
			["WEAPON_VINTAGEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 60,
					["copper"] = 60,
					["rubber"] = 30,
				}
			},
			["WEAPON_PISTOL50"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["weaponbody"] = 1,
					["moladearma"] = 1,
					["aluminum"] = 120,
					["copper"] = 120,
					["rubber"] = 60,
				}
			},
		}
	},
	
	["Cosanostra"] = {
		["perm"] = "Cosanostra",
		["List"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 1,
					["projetil"] = 1,
					["polvora"] = 1
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 1,
					["projetil"] = 1,
					["polvora"] = 1
				}
			},
		}
	},

	["Thelost"] = {
		["perm"] = "Thelost",
		["List"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 1,
					["projetil"] = 1,
					["polvora"] = 1
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["capsula"] = 1,
					["projetil"] = 1,
					["polvora"] = 1
				}
			},
		}
	},
	-- ["Rogers"] = {
	-- 	["perm"] = "Rogers",
	-- 	["List"] = {
	-- 		["WEAPON_PISTOL_AMMO"] = {
	-- 			["amount"] = 1,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["capsula"] = 1,
	-- 				["projetil"] = 1,
	-- 				["polvora"] = 1
	-- 			}
	-- 		},
	-- 	}
	-- },

	["Pawnshop"] = {
		["perm"] = "Pawnshop",
		["List"] = {
			["radio"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 15,
					["techtrash"] = 5,
					["copper"] = 1,
					["aluminum"] = 5,
				}
			},
			["repairkit03"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 3,
					["copper"] = 8
				}
			},
			["rope"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 3,
				}
			},
			["scanner"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 3,
					["techtrash"] = 3,
					["copper"] = 3,
					["aluminum"] = 3,
				}
			},
			["repairkit04"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 2,
					["techtrash"] = 2,
					["plastic"] = 2,
				}
			},
		}
	},
	["Mechanic"] = {
		["perm"] = "Mechanic",                    
		["List"] = {
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 7,
					["copper"] = 8
				}
			},
			["advtoolbox"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 15
				}
			},
			["kitlimpeza"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["tyres"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["rubber"] = 6
				 }
			},
			["WEAPON_CROWBAR"] = {
					["amount"] = 1,
					["destroy"] = false,
					["require"] = {
						["aluminum"] = 12,
						["rubber"] = 13
					}
			},
			["WEAPON_WRENCH"] = {
					["amount"] = 1,
					["destroy"] = false,
					["require"] = {
						["aluminum"] = 12,
						["rubber"] = 13

				}
			},
		}
	},

	["Mechanic-2"] = {
		["perm"] = "Mechanic",                    
		["List"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 4,
					["copper"] = 4,
					["plastic"] = 3
				}
			},
		}
	},


	["Lockpick"] = {
		["List"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 15,
					["copper"] = 15,
					["plastic"] = 5
				}
			},
			-- ["lockpickadv"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 4,
			-- 		["copper"] = 6,
			-- 		["plastic"] = 2
			-- 	}
			-- },
		}
	},
	["Mechanic68"] = {
		["perm"] = "Mechanic68",
		["List"] = {
			["toolbox"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 7,
					["plastic"] = 8
				}
			},
			["advtoolbox"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 15
				}
			},
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["paper"] = 5,
					["copper"] = 8
				}
			},
			["kitlimpeza"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["tyres"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["rubber"] = 6
				 }
			},
			["WEAPON_CROWBAR"] = {
					["amount"] = 1,
					["destroy"] = false,
					["require"] = {
						["aluminum"] = 12,
						["rubber"] = 13
					}
			},
			["WEAPON_WRENCH"] = {
					["amount"] = 1,
					["destroy"] = false,
					["require"] = {
						["aluminum"] = 12,
						["rubber"] = 13

				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 2,
					["copper"] = 3,
					["plastic"] = 1
				}
			},
			-- ["lockpickadv"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 4,
			-- 		["copper"] = 6,
			-- 		["plastic"] = 2
			-- 	}
			-- },
		}
	},
	["Pendrive"] = {
		["List"] = {
			["pendrive2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["pendrive"] = 1,
					["dollars"] = 5000
				}
			},
		}
	},
	["BurgerShot2"] = {
		["perm"] = "BurgerShot",
		["List"] = {
			["guarananatural"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["guarana"] = 2,
					["sugar"] = 2,
				}
			},
			["cola"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["guarana"] = 2,
					["sugar"] = 2,
				}
			},
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["orange"] = 2,
					["sugar"] = 2,
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["strawberry"] = 2,
					["sugar"] = 2,
				}
			},
		}
	},

	["BurgerShot"] = {
		["perm"] = "BurgerShot",
		["List"] = {
			["hamburger"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["alface"] = 2,
					["tomato"] = 1,
				}
			},
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["fishfillet"] = 1,
					["alface"] = 2,
					["tomato"] = 1,
				}
			},
			["hotdog"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["potato"] = 1,
					["tomato"] = 2,
				}
			},
		}
	},

	["BurgerShot3"] = {
		["perm"] = "BurgerShot",
		["List"] = {
			["fries"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["potato"] = 3,
					["sal"] = 1,
				}
			},
		}
	},

	["Uwucoffee1"] = {
		["perm"] = "Uwucoffee",
		["List"] = {
			["cupcake"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["coffee2"] = 4,
				}
			},
			["cookies"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["coffee2"] = 4,
				}
			},
			["tortasalgada"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["tomato"] = 3,
				}
			},
			["applelove"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["apple"] = 1,
					["sugar"] = 5,
				}
			},
			["donut"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["sugar"] = 3,
					["strawberry"] = 2,

				}
			},
			["paodequeijo"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["sugar"] = 3,
					["strawberry"] = 2,

				}
			},
			["bolochocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["sugar"] = 3,
					["strawberry"] = 2,

				}
			},

		}
	},

	["Uwucoffee2"] = {
		["perm"] = "Uwucoffee",
		["List"] = {
			["chagelado"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["guarana"] = 2,
					["sugar"] = 2,
				}
			},
			["frappuccino"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["coffee2"] = 2,
					["sugar"] = 2,
				}
			},
			["coffee"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["coffee2"] = 2,
					["sugar"] = 2,
				}
			},
			["coffeemilk"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["coffee2"] = 2,
					["sugar"] = 2,
				}
			},
		}
	},

	["Yakuza-1"] = {
		["perm"] = "Yakuza",
		["List"] = {
			["quiche"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["coffee2"] = 4,
				}
			},
			["redvelvet"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["coffee2"] = 4,
				}
			},
			["sushi"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["tomato"] = 3,
				}
			},
			["nigirizushi"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["apple"] = 1,
					["sugar"] = 5,
				}
			},
			["calzone"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["sugar"] = 3,
					["strawberry"] = 2,

				}
			},
		}
	},

	["Yakuza-2"] = {
		["perm"] = "Yakuza",
		["List"] = {
			["chagelado"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["guarana"] = 2,
					["sugar"] = 2,
				}
			},
			["frappuccino"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["coffee2"] = 2,
					["sugar"] = 2,
				}
			},
		}
	},

	["Hornys"] = {
		["perm"] = "Hornys",
		["List"] = {
			["hamburger"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["alface"] = 2,
					["tomato"] = 1,
				}
			},
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["alface"] = 2,
					["tomato"] = 1,
				}
			},
			["hotdog"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["bread"] = 1,
					["meat"] = 1,
					["potato"] = 1,
					["tomato"] = 2,
				}
			},
			["fries"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["potato"] = 3,
					["sal"] = 1,
				}
			},
		}
	},


	-- ["Hornys2"] = {
	-- 	["perm"] = "Hornys",
	-- 	["List"] = {
	-- 		["soda"] = {
	-- 			["amount"] = 1,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["guarana"] = 2,
	-- 				["sugar"] = 2,
	-- 			}
	-- 		},
	-- 		["cola"] = {
	-- 			["amount"] = 1,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["guarana"] = 2,
	-- 				["sugar"] = 2,
	-- 			}
	-- 		},
	-- 		["orangejuice"] = {
	-- 			["amount"] = 1,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["orange"] = 2,
	-- 				["sugar"] = 2,
	-- 			}
	-- 		},
	-- 		["strawberryjuice"] = {
	-- 			["amount"] = 1,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["strawberry"] = 2,
	-- 				["sugar"] = 2,
	-- 			}
	-- 		},
	-- 	}
	-- },	
		["Digital"] = {
			["perm"] = "Digitalden",
				["List"] = {
					["cellphone"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["copper"] = 5,
							["plastic"] =10,
							["glass"] = 8,
							["techtrash"] = 5,
						}
					},
					["repairkit04"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["aluminum"] = 2,
							["techtrash"] = 2,
							["plastic"] = 2,
						}
					},
					["tabletorg"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["aluminum"] = 2,
							["techtrash"] = 2,
							["plastic"] = 2,
						}
					},
					["repairkit03"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["aluminum"] = 3,
							["copper"] = 8
						}
					},
					["pendrive"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["aluminum"] = 2,
							["techtrash"] = 2,
					}
					},
					["vape"] = {
						["amount"] = 1,
						["destroy"] = false,
						["require"] = {
							["aluminum"] = 8,
							["copper"] = 5,
							["plastic"] = 10,
							["glass"] = 10,
					}
				},
			}
		},
	["Digital-2"] = {
		["perm"] = "Digitalden",
		["List"] = {
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["explosives"] = 1,
					["plastic"] =10,
					["glass"] = 8,
					["techtrash"] = 5,
				}
			},
			["card01"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 5,
					["chipset"] = 1,
					["techtrash"] = 5,
				}
			},
			["card02"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 7,
					["chipset"] = 1,
					["techtrash"] = 7,
				}
			},
			["card03"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 9,
					["chipset"] = 1,
					["techtrash"] = 9,
				}
			},
			["card04"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 12,
					["chipset"] = 1,
					["techtrash"] = 12,
				}
			},
			["card05"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 15,
					["chipset"] = 1,
					["techtrash"] = 15,
				}
			},
			["pager"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["copper"] = 5,
					["plastic"] = 5,
					["chipset"] = 1,
					["techtrash"] = 3,
				}
			},
			["blocksignal"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["antena"] = 1,
					["techtrash"] = 2,
					["chipset"] = 1,
					["plastic"] = 10,
			}
		},
	}
},
	["Digital-3"] = {
		["perm"] = "Digitalden",
		["List"] = {
			["techtrash"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["xbox"] = 1,
						
				}
			},
			["chipset"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["playstation"] = 1,
						
				}
			},
			["antena"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["smartphone"] = 1,
					
				}
			},
		}
	},
	["C4"] = {
		["List"] = {
			["c4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["polvora"] = 1,
					["dollars"] = 1000,
					["aluminum"] = 1,
					["smarthwatch"] = 1,
					["firecracker"] = 1,
				}
			},
		}
	},

	["Newfac"] = {
		["perm"] = "Vagos",
		["List"] = {
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 1000
				}
			},
		}
	},


	


	["Dismantle"] = {
		["List"] = {
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["paper"] = 2,
					["dollars"] = 200
				}
			},

		},
	},
	["Lixeiro"] = {
		["List"] = {
			["glass"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["copper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["sheetmetal"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1
				}
			},
			["techtrash"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1,
				}
			},
			["paper"] = {
				["amount"] = 3,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 1,
				}
			},

		}
	},
	["Lixeiro2"] = {
		["perm"] = "Rogers",
		["List"] = {
			["glass"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2
				}
			},
			["plastic"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2
				}
			},
			["rubber"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2
				}
			},
			["aluminum"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2
				}
			},
			["copper"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2
				}
			},
			["techtrash"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2,
				}
			},
			["paper"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["reciclavel"] = 2,
				}
			},

		}
	},
	["Lavagem"] = {
		["perm"] = "Admin",
		["List"] = {
			["dollars"] = {
				["amount"] = 950,
				["destroy"] = false,
				["require"] = {
					["dollarz"] = 1000,
					
				}
			},
			["dollarz"] = {
				["amount"] = 950,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 1000,
					
				}
			}
		}
	},
	
	["Banco"] = {
		["List"] = {
			["dollars"] = {
				["amount"] = 350,
				["destroy"] = false,
				["require"] = {
					["recibo"] = 1,
					
				}
			},

		}
	},
	-- ["Lavagem"] = {
	-- 	["List"] = {
	-- 		["dollars"] = {
	-- 			["amount"] = 600,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["dollarz"] = 1000,
					
	-- 			}
	-- 		},
	-- 		["dollarz"] = {
	-- 			["amount"] = 950,
	-- 			["destroy"] = false,
	-- 			["require"] = {
	-- 				["dollarx"] = 1000,
					
	-- 			}
	-- 		},

	-- 	}
	-- },
	["Coiote"] = {
		["perm"] = "Coiote",
		["List"] = {
			["vest2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tarp"] = 1,
					["leather"] = 1,
					["sheetmetal"] = 5
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tarp"] = 1,
					["plastic"] = 6
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["rubber"] = 15,
					["aluminum"] = 10,
					["sheetmetal"] = 2
				}
			}
		}
	},
	["Bennys"] = {
		["perm"] = "Bennys",
		["List"] = {
			["oxidonitroso"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 450
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["plastic"] = 1
				}
			},
			-- ["lockpickadv"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 4,
			-- 		["copper"] = 6,
			-- 		["plastic"] = 2
			-- 	}
			-- },
		}
	},
	["Bennys"] = {
		["perm"] = "Bennys",
		["List"] = {
			["oxidonitroso"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 450
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["plastic"] = 1
				}
			},
			-- ["lockpickadv"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 4,
			-- 		["copper"] = 6,
			-- 		["plastic"] = 2
			-- 	}
			-- },
		}
	},
	["Vanilla"] = {
		["perm"] = "Vanilla",
		["List"] = {
			["chocolate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 9,
					["copper"] = 6,
					["plastic"] =6,
					["glass"] = 6,
					["oxidonitroso"] = 1
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 900,
					["copper"] = 500,
					["plastic"] = 100
				}
			},
			-- ["macbook"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = true,
			-- 	["require"] = {
			-- 		["aluminum"] = 10,
			-- 		["techtrash"] = 8,
			-- 		["plastic"] = 6,       
			-- 		["glass"] = 5,
			-- 		["copper"] = 9,
			-- 		["dollars"] = 1000
			-- 	}
			-- },
		}
	},
	["Bennys3"] = {
		["perm"] = "Bennys",
		["List"] = {
			["oxidonitroso"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 450
				}
			},
			["kitlimpeza"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 1,
					["copper"] = 1,
					["plastic"] = 1
				}
			},
			-- ["lockpickadv"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["aluminum"] = 4,
			-- 		["copper"] = 6,
			-- 		["plastic"] = 2
			-- 	}
			-- },
			["nitro"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 9,
					["copper"] = 6,
					["plastic"] =6,
					["glass"] = 6,
					["oxidonitroso"] = 1
				}
			},
			["plate"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 9,
					["copper"] = 5,
					["plastic"] = 1
				}
			},
			["macbook"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 10,
					["techtrash"] = 8,
					["plastic"] = 6,       
					["glass"] = 5,
					["copper"] = 9,
					["dollars"] = 1000
				}
			},
		}
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestPerm(Name,Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if List[Type]["perm"] ~= nil then
			if vRP.HasGroup(Passport,List[Type]["perm"]) then
				return true
			end
		else
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.requestCrafting(Type)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local inventoryShop = {}
		
		for Item,v in pairs(List[Type]["List"]) do
			local keyList = {}

			for Required,Amount in pairs(v["require"]) do
				keyList[#keyList + 1] = { name = itemName(Required), amount = Amount }
			end

			inventoryShop[#inventoryShop + 1] = { name = itemName(Item), index = itemIndex(Item), max = itemMaxAmount(Item), economy = parseFormat(itemEconomy(Item)), key = Item, peso = itemWeight(Item), list = keyList, amount = parseInt(v["amount"]), desc = itemDescription(Item) }
		end

		local inventoryUser = {}
		local inventory = vRP.Inventory(Passport)
		for Index,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["key"] = v["item"]
			v["slot"] = Index

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

			inventoryUser[Index] = v
		end

		return inventoryShop,inventoryUser,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionCrafting(Item,Type,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if List[Type]["List"][Item] then
			if vRP.MaxItens(Passport,Item,List[Type]["List"][Item]["amount"] * Amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if (vRP.InventoryWeight(Passport) + (itemWeight(Item) * List[Type]["List"][Item]["amount"]) * Amount) <= vRP.GetWeight(Passport) then
				for Index,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,Index)
					if consultItem[1] < parseInt(v * Amount) then
						return
					end

					if vRP.CheckDamaged(consultItem[2]) then
						TriggerClientEvent("Notify",source,"vermelho","Item danificado.",5000)
						return
					end
				end

				for Index,v in pairs(List[Type]["List"][Item]["require"]) do
					local consultItem = vRP.InventoryItemAmount(Passport,Index)
					vRP.RemoveItem(Passport,consultItem[2],parseInt(v * Amount))
				end

				vRP.GenerateItem(Passport,Item,List[Type]["List"][Item]["amount"] * Amount,false,Slot)
				vRP.SendWebhook(webhookcrafting, "LOGs Crafting", "**Passaporte: **"..Passport.."\n**Craftou: ** x"..Amount.." "..Item, 10357504)
				FamilyExperience(source)
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.functionDestroy(Item,Type,Amount,Slot)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end
		
		local splitName = splitString(Item,"-")
		if List[Type]["List"][splitName[1]] then
			if List[Type]["List"][splitName[1]]["destroy"] then
				if vRP.CheckDamaged(Item) then
					TriggerClientEvent("Notify",source,"vermelho","Item danificado.",5000)
					TriggerClientEvent("crafting:Update",source,"requestCrafting")
					return
				end

				if vRP.TakeItem(Passport,Item,List[Type]["List"][splitName[1]]["amount"],Slot) then
					for Index,v in pairs(List[Type]["List"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.GenerateItem(Passport,Index,1)
						else
							vRP.GenerateItem(Passport,Index,v / 2)
						end
					end
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(Item,Slot,Target,Amount)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.TakeItem(Passport,Item,Amount,false,Slot) then
			vRP.GiveItem(Passport,Item,Amount,false,Target)
			TriggerClientEvent("crafting:Update",source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(Item,Slot,Target,Amount)
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

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end)
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