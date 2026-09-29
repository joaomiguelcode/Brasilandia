-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Owner"] = {
		["Parent"] = {
			["Owner"] = true
		},
		["Hierarchy"] = { "Owner","Developer" },
		["Service"] = {}
	},
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
		["Service"] = {}
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Gold","Silver","Bronze" },
		["Salary"] = { 9500, 7500, 5500 },
		["Service"] = {}
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Police1","Police2","Police3","Police4","Police5","Police6","Police7","Police8","Police9","Police10","Police11", "Cabo", "Soltado", "Recruta" },
		["Salary"] = { 7000,6500,6000,5900,5700,5500,5400,5300,5200,5000,4800,4500,4200,4000  },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Diretor","Supervisor","Médico", "Interno", "Paramédico", "Trainee"  },
		["Salary"] = { 4500,4000,3700,3500,2000,1500 },
		["Service"] = {},
		["Type"] = "Work"
	},
	-- ["LSCustoms"] = {
	-- 	["Parent"] = {
	-- 		["LSCustoms"] = true
	-- 	},
	-- 	["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Mecânico" },
	-- 	["Service"] = {},
	-- 	["Type"] = "Work"
	-- },
	["Judiciario"] = {
		["Parent"] = {
			["Judiciario"] = true
		},
		["Hierarchy"] = { "Juiz","Promotor","Oficial","Advogado" },
		["Salary"] = { 4000,3400,3200,2200 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Evento"] = {
		["Parent"] = {
			["Evento"] = true
		},
		["Hierarchy"] = { "Evento" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Pawnshop"] = {
		["Parent"] = {
			["Pawnshop"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Vendedor" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Weazel"] = {
		["Parent"] = {
			["Weazel"] = true
		},
		["Hierarchy"] = { "Diretor Geral","Redator","Jornalista"},
		["Salary"] = { 2300,1400,1250 },
		["Service"] = {},
		["Type"] = "Work"
	},
 ------------------------------------ COMIDAS -----------------------------------------
	["BurgerShot"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Membro" },
		["Salary"] = { 1500,1200,1000,800,500 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Uwucoffee"] = {
		["Parent"] = {
			["Uwucoffee"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Vendedor" },
		["Salary"] = { 1500,1200,1000,800,500 },
		["Service"] = {},
		["Type"] = "Work"
	},
------------------------- GUETOS/ORG/FAIXADA/EMPRESAS SUL  -----------------------------
	["Digitalden"] = {
		["Parent"] = {
			["Digitalden"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Vendedor" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Vanilla"] = {           
		["Parent"] = { 
			["Vanilla"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Ballas"] = {             
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},

	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Yakuza"] = {
		["Parent"] = {
			["Yakuza"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Cripz"] = {
		["Parent"] = {
			["Cripz"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Bennys"] = {
		["Parent"] = {
			["Bennys"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Mecânico","Peão" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Mechanic"] = {
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Mecânico" },
		["Salary"] = { 300,250,200,150 },
		["Service"] = {},
		["Type"] = "Work"
	},
	
 ------------------------------------ ORG - MAFIA NORTE -----------------------------
	["Bratva"] = {
		["Parent"] = {
			["Bratva"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Tijuana"] = {
		["Parent"] = {
			["Tijuana"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Sinalia"] = {
		["Parent"] = {
			["Sinalia"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Lafamilia"] = {
		["Parent"] = {
			["Lafamilia"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Mechanic68"] = {
		["Parent"] = {
			["Mechanic68"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Mecânico" },
		["Salary"] = { 300,250,200,150 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Thelost"] = {
		["Parent"] = {
			["Thelost"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Mecânico" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Cosanostra"] = {
		["Parent"] = {
			["Cosanostra"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Supervisor","Mecânico" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Coiote"] = {             
		["Parent"] = {
			["Coiote"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Favela1"] = {             
		["Parent"] = {
			["Favela1"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Chefe","Gerente","Conselheiro","Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
----------------------------------------------------------------------------------------------
-- ["Vinhedo"] = {
-- 	["Parent"] = {
-- 		["Vinhedo"] = true
-- 	},
-- 	["Hierarchy"] = { "Patrão","Gerente","Soldado","Vapor","Avião","Fogueteiro" },
-- 	["Service"] = {},
-- 	["Type"] = "Work"
-- },
["Rogers"] = {
	["Parent"] = {
		["Rogers"] = true
	},
	["Hierarchy"] = { "Diretor","Vice-Diretor","Supervisor","Gerente","Colaborador" },
	["Service"] = {},
	["Type"] = "Work"
},
["Marabunta"] = {
	["Parent"] = {
		["Marabunta"] = true
	},
	["Hierarchy"] = { "Diretor","Vice-Diretor","Supervisor","Gerente","Colaborador" },
	["Service"] = {},
	["Type"] = "Work"
},
----------------------------------------------------------------------------------------------
	["VerificadoInsta"] = {
		["Parent"] = {
			["VerificadoInsta"] = true
		},
		["Hierarchy"] = { "Verificado" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["VerificadoCam"] = {
		["Parent"] = {
			["VerificadoCam"] = true
		},
		["Hierarchy"] = { "Verificado" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Emergency"] = {
		["Parent"] = {
			["Police"] = true,
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Restaurants"] = {
		["Parent"] = {
			["BurgerShot"] = true,
			["PizzaThis"] = true,
			["Uwucoffee"] = true,
			["BeanMachine"] = true,
			["Hornys"] = true,

		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	}
}