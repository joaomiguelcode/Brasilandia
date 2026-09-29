-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local localPeds = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	{ --C4
		Distance = 20,
		Coords = { 1272.26, -1711.55, 54.76, 42.52 },
		Model =  "cs_lestercrest" ,
		anim = { "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle" }
	},
	{ --TICKET
	Distance = 20,
	Coords = { 945.02,-1744.52,21.03,172.92 },
	Model =  "u_m_y_sbike" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},	

	{ --Lenhador
	Distance = 20,
	Coords = { 2412.15,5046.4,46.02,136.07},
	Model =  "cs_old_man2" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},	

	{ --Transporte
	Distance = 20,
	Coords = { 12.03,-663.32,33.45,82.21},
	Model =  "cs_casey" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},	


	{ --Transporte
		Distance = 20,
		Coords = { 11.7,-659.74,33.45,96.38 },
		Model =  "cs_casey" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},	
	{ --Polvora
		Distance = 20,
		Coords = { 2707.27, 2776.73, 37.88, 28.35 },
		Model =  "s_m_y_airworker" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},

	{ -- Venda Reciclagem
		Distance = 20,
		Coords = { -350.09,-1570.03,25.22,300.48 },
		Model =  "s_m_y_airworker" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},


	{ --PenDrive Life Invader
		Distance = 20,
		Coords = { -1051.83, -232.74, 44.01, 206.93 },
		Model =  "ig_lifeinvad_01" ,
		anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
	},

	{ -- Minerador
		Distance = 20,
		Coords = { 2833.41, 2795.17, 57.47, 99.22 },
		Model =  "s_m_y_airworker" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},
	-- Maconha Sul
	{
		Distance = 20,
		Coords = { -1568.66,-3224.46,26.34,158.75 },
		Model =  "g_m_m_mexboss_01" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},
	-- Maconha norte
	{
		Distance = 20,
		Coords = { 1337.35,4383.61,44.33,354.34 },
		Model =  "s_m_y_blackops_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	

	-- Frutas
	{
		Distance = 20,
		Coords = { 1087.65, 6509.91, 21.06, 184.26 },
		Model =  "ig_old_man2" ,
	},

	-- Compra de Carnes
	{
		Distance = 20,
		Coords = { -69.86, 6261.71, 31.09, 25.52 },
		Model =  "s_m_m_migrant_01" ,
	},

	-- Moagem de Carnes
	{
		Distance = 20,
		Coords = { 998.27, -2187.86, 29.98, 90.71 },
		Model =  "s_m_m_migrant_01" ,
	},

	{ -- Dismantle
		Distance = 20,
		Coords = { 2333.15,3054.51,48.16,5.67 },
		Model =  "s_m_y_airworker" ,
		anim = { "mini@repair", "fixing_a_player" }
	},

	{ -- Caminhoneiro
		Distance = 20,
		Coords = { 2679.41, 1418.25, 24.55, 274.97 },
		Model =  "s_m_y_airworker" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	-- { -- Uber
	-- 	Distance = 20,
	-- 	Coords = { 396.24,-1178.76,29.4,357.17 },
	-- 	Model =  "u_m_m_bankman" ,
	-- },
	{ -- Banco de Paleto
		Distance = 20,
		Coords = { -110.65, 6469.92, 31.63, 226.78 },
		Model =  "u_m_m_bankman" ,
	},
	{ -- Banco Praça
		Distance = 20,
		Coords = { 149.4, -1042.07, 29.37, 340.16 },
		Model =  "u_m_m_bankman" ,
	},
	{ -- Mecanica SportRace
		Distance = 20,
		Coords = { -1286.61,-290.01,36.82,65.2 },
		Model =  "mp_m_waremech_01" ,
		anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
	},
	{ -- Mecanica Paleto
		Distance = 20,
		Coords = { 101.54,6623.58,31.78,68.04 },
		Model =  "mp_m_waremech_01" ,
		anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
	},


	{ -- Megamall
		Distance = 20,
		Coords = { 2748.23, 3472.53, 55.67, 256.10 },
		Model =  "cs_brad" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }

	},

	-- { -- banco
	-- 	Distance = 20,
	-- 	Coords = { 253.23, 216.43, 106.27, 343.0 },
	-- 	Model =  "ig_paper" ,
	-- },
	{ -- banco paleto recibo
		Distance = 20,
		Coords = { -109.14,6471.74,31.63,232.45 },
		Model =  "ig_paper" ,
	},
	{ -- Rota de Armas
		Distance = 20,
		Coords = { 787.22, 4178.28, 41.77, 160.76 },
		Model =  "mp_m_exarmy_01" ,
		anim = { "timetable@trevor@smoking_meth@base", "base" }
	},

	{ -- Reciclagem
		Distance = 20,
		Coords = { -340.56,-1567.84,25.22,68.04 },
		Model =  "s_m_y_garbage" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},

	{ -- Reciclagem Rogers
		Distance = 20,
		Coords = { -611.92,-1613.64,27.01,272.13 },
		Model =  "s_m_y_garbage" ,
		anim = { "amb@lo_res_idles@", "world_human_lean_male_foot_up_lo_res_base" }
	},

	{ -- TCAR
		Distance = 30,
		Coords = { -418.86,96.9,65.23,0.0 },
		Model =  "ig_paper" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	
	-- { -- Prefeitura
	-- 	Distance = 30,
	-- 	Coords = { -545.23,-203.73,38.22,209.77 },
	-- 	Model =  "ig_barry" ,
	-- 	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	-- },
	{ -- POUPATEMPO
		Distance = 30,
		Coords = { 384.55,-753.69,29.4,269.3 },
		Model =  "ig_barry" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- DOCUMENTO FALSO COIOTE
		Distance = 30,
		Coords = { 2328.2,2570.05,46.67,328.82 },
		Model =  "a_m_y_soucent_02" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- COIOTE FALSO COIOTE
		Distance = 30,
		Coords = { 2331.64,2570.92,46.67,59.53 },
		Model =  "a_m_y_soucent_02" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	
	{ -- Garagem Impound
	Distance = 20,
	Coords = { 409.24,-1622.98,29.28,235.28 },
	Model =  "s_f_y_cop_01" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Garagem DP Missow Row
		Distance = 20,
		Coords = { 426.88,-986.65,25.7,274.97 },
		Model =  "s_f_y_cop_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Paramedic Garagem Paleto
		Distance = 30,
		Coords = { -271.59, 6320.84, 32.42, 351.5 },
		Model =  "s_m_m_paramedic_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Paramedic Garagem Paleto 2
		Distance = 30,
		Coords = { -254.05, 6338.58, 32.42, 0.0 },
		Model =  "s_m_m_paramedic_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Banco Central
		Distance = 10,
		Coords = { 247.42,223.28,106.29,158.75 },
		Model =  "u_m_m_bankman" ,
	},

	{ -- Departament Store
		Distance = 10,
		Coords = { 24.89, -1346.91, 29.49, 274.97 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 2556.86, 381.26, 108.61, 0.0 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 161.21, 6641.69, 31.69, 232.45 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 1164.82, -323.63, 69.2, 99.22 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -706.16, -914.55, 19.21, 90.71 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -47.39, -1758.63, 29.42, 51.03 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 373.11, 326.81, 103.56, 252.29 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { -3242.74, 1000.46, 12.82, 357.17 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { 1728.43, 6415.42, 35.03, 243.78 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { 548.71, 2670.8, 42.16, 93.55 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { 1960.21, 3740.66, 32.33, 300.48 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { 2677.8, 3279.95, 55.23, 334.49 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 6,
		Coords = { -1819.55, 793.51, 138.08, 133.23 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 1392.03, 3606.1, 34.98, 204.1 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -2966.41, 391.59, 15.05, 85.04 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -3039.57, 584.75, 7.9, 11.34 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 1134.33, -983.09, 46.4, 277.8 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { 1165.26, 2710.79, 38.15, 178.59 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -1486.77, -377.56, 40.15, 133.23 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Departament Store
		Distance = 10,
		Coords = { -1221.42, -907.91, 12.32, 31.19 },
		Model =  "mp_m_shopkeep_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 1692.28, 3760.94, 34.69, 229.61 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 253.79, -50.5, 69.94, 68.04 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 842.41, -1035.28, 28.19, 0.0 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { -331.62, 6084.93, 31.46, 226.78 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { -662.29, -933.62, 21.82, 181.42 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { -1304.17, -394.62, 36.7, 73.71 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { -1118.95, 2699.73, 18.55, 223.94 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 2567.98, 292.65, 108.73, 0.0 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { -3173.51, 1088.38, 20.84, 249.45 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 22.59, -1105.54, 29.79, 155.91 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Ammu-Nation Store
		Distance = 12,
		Coords = { 810.22, -2158.99, 29.62, 0.0 },
		Model =  "ig_dale" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Life Invader
		Distance = 20,
		Coords = { -1083.15, -245.88, 37.76, 209.77 },
		Model =  "ig_barry" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	{ -- Pawn Shop Compra
		Distance = 50,
		Coords = { 173.45,-1319.51,29.35,289.14 },
		Model =  "ig_cletus" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Pawn Shop Venda
		Distance = 50,
		Coords = { 174.08,-1323.38,29.35,334.49},
		Model =  "s_f_y_clubbar_02" ,
		anim = { "friends@fra@ig_1", "base_idle" }
	},
	{ -- Pawn Shop Venda Interna
		Distance = 50,
		Coords = { 171.58,-1313.3,29.35,153.08 },
		Model =  "s_f_y_clubbar_02" ,
		anim = { "friends@fra@ig_1", "base_idle" }
	},
	{ -- Pawn Shop Venda Interna
	Distance = 50,
	Coords = { 156.11,-1313.92,29.35,252.29 },
	Model =  "s_f_y_clubbar_02" ,
	anim = { "friends@fra@ig_1", "base_idle" }
	},

	
	{ -- Digitalden Compra
	Distance = 50,
	Coords = { 1132.26,-474.29,66.71,340.16 },
	Model =  "u_m_y_gabriel" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Apple Compra
		Distance = 50,
		Coords = { 148.95,-234.52,54.42,340.16 },
		Model =  "u_m_y_gabriel" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Apple Venda
		Distance = 50,
		Coords = { 154.55,-238.18,54.42,348.67 },
		Model =  "u_m_o_dean" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- DOMINACAO
	Distance = 50,
	Coords = { -2175.29,4294.67,49.05,249.45 },
	Model =  "ig_cletus" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- DOMINACAO
	Distance = 50,
	Coords = { 452.92,-1305.32,30.11,311.82 },
	Model =  "ig_cletus" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Digitalden Venda
	Distance = 50,
	Coords = { 1135.07,-469.33,66.71,158.75 },
	Model =  "u_m_o_dean" ,
	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Taxista
		Distance = 30,
		Coords = { -1601.97,-837.15,10.26,31.19 },
		Model =  "a_m_y_stlat_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
	{ -- Caçador
		Distance = 10,
		Coords = { -679.13, 5839.52, 17.32, 226.78 },
		Model =  "ig_hunter" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	-- { -- Farmacia Store LS
	-- 	Distance = 30,
	-- 	Coords = { 1141.79,-1529.94,35.03,93.55 },
	-- 	Model =  "s_m_m_scientist_01" ,
	-- 	anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	-- },

	-- { -- Recepção HP
	-- 	Distance = 30,
	-- 	Coords = { 309.58,-593.8,43.29,28.35 },
	-- 	Model =  "s_m_m_scientist_01" ,
	-- },
	
	-- { -- Maca HP
	-- 	Distance = 30,
	-- 	Coords = { 1123.88,-1554.44,35.03,272.13 },
	-- 	Model =  "s_m_m_scientist_01" ,
	-- 	anim = { "mini@repair", "fixing_a_ped" }

	-- },
	-- { -- Maca HP
	-- 	Distance = 30,
	-- 	Coords = { 1123.88,-1563.33,35.03,269.3 },
	-- 	Model =  "s_m_m_scientist_01" ,
	-- 	anim = { "mini@repair", "fixing_a_ped" }

	-- },

	-- { -- Farmacia Store Paleto
	-- Distance = 30,
	-- Coords = { -253.71,6327.33,32.42,317.49},
	-- Model =  "s_m_m_scientist_01" ,
	-- anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	-- },			
	{ -- Reciclagem Roupas
	Distance = 50,
	Coords = { -347.28,-1576.08,25.22,300.48 },
	Model =  "s_f_y_clubbar_02" ,
	anim = { "friends@fra@ig_1", "base_idle" }
	},

	{ -- loja Roupas
	Distance = 50,
	Coords = { 1689.79,4822.53,42.06,102.05 },
	Model =  "s_f_y_clubbar_02" ,
	anim = { "friends@fra@ig_1", "base_idle" }
	},

	{ -- loja Roupas
	Distance = 50,
	Coords = { 79.3,-1393.22,29.37,269.3},
	Model =  "s_f_y_clubbar_02" ,
	anim = { "friends@fra@ig_1", "base_idle" }
	},
	{ -- loja Roupas
	Distance = 50,
	Coords = { 2.42,6515.46,31.88,42.52},
	Model =  "s_f_y_clubbar_02" ,
	anim = { "friends@fra@ig_1", "base_idle" }
	},

	

	{ -- Ballas
	Distance = 50,
	Coords = { 111.46,-1980.8,20.96,107.72 },
	Model =  "g_m_y_ballaorig_01" ,
	},
	{ -- Families
	Distance = 50,
	Coords = { -218.26,-1626.14,38.11,87.88 },
	Model =  "g_m_y_ballaorig_01" ,
	},
	{ -- Bloods
	Distance = 50,
	Coords = { 952.87,-1480.83,33.78,87.88 },
	Model =  "g_m_y_ballaorig_01" ,
	},
	{ -- Vagos
	Distance = 50,
	Coords = { 	800.23,-2304.18,30.85,172.92 },
	Model =  "g_m_y_ballaorig_01" ,
	},
	{ -- LAVAGEM
	Distance = 50,
	Coords = { 2432.34,4971.8,42.34,56.7 },
	Model =  "s_m_m_migrant_01" ,
	anim = { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }
	},

	{ -- CONTRABANDO
		Distance = 20,
		Coords = { 705.25,-961.1,30.4,269.3 },
		Model =  "a_m_m_business_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	{ -- RADCUSTOMS
		Distance = 20,
		Coords = { 64.16,-1733.81,29.3,167.25 },
		Model =  "mp_m_waremech_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	{ -- RADCUSTOMS PLAYER
		Distance = 20,
		Coords = { 43.01,-1753.97,29.3,48.19 },
		Model =  "mp_m_waremech_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	{ -- Farmacia
		Distance = 30,
		Coords = { -506.82, 292.55, 83.39, 172.92 },
		Model =  "s_m_m_scientist_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	-- { -- DigitalDen
	-- Distance = 50,
	-- Coords = { -1530.14,-401.96,35.64,232.45 },
	-- Model =  "u_m_o_dean" ,
	-- anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	-- },

	{ -- Venda de Vara de Pesca e Isca
		Distance = 30,
		Coords = { 1524.77, 3783.84, 34.49, 187.09 },
		Model =  "a_f_y_eastsa_03" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},

	{ -- Venda Peixes
		Distance = 20,
		Coords = { 1520.56, 3780.08, 34.46, 274.97 },
		Model =  "mp_m_weed_01" ,
		anim = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLIST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number = 1, #List do
			local Distance = #(Coords - vec3(List[Number]["Coords"][1], List[Number]["Coords"][2], List[Number]["Coords"][3]))
			if Distance <= List[Number]["Distance"] then
				if not localPeds[Number] and LocalPlayer["state"]["Route"] < 900000 then
					if LoadModel(List[Number]["Model"]) then
						localPeds[Number] = CreatePed(4, List[Number]["Model"], List[Number]["Coords"][1],
							List[Number]["Coords"][2], List[Number]["Coords"][3] - 1, List[Number]["Coords"][4], false,
							false)
						SetPedArmour(localPeds[Number], 99)
						SetEntityInvincible(localPeds[Number], true)
						FreezeEntityPosition(localPeds[Number], true)
						SetBlockingOfNonTemporaryEvents(localPeds[Number], true)

						SetModelAsNoLongerNeeded(List[Number]["Model"])

						if List[Number]["Model"] == "s_f_y_casino_01" then
							SetPedDefaultComponentVariation(localPeds[Number])
							SetPedComponentVariation(localPeds[Number], 0, 3, 0, 0)
							SetPedComponentVariation(localPeds[Number], 1, 0, 0, 0)
							SetPedComponentVariation(localPeds[Number], 2, 3, 0, 0)
							SetPedComponentVariation(localPeds[Number], 3, 0, 1, 0)
							SetPedComponentVariation(localPeds[Number], 4, 1, 0, 0)
							SetPedComponentVariation(localPeds[Number], 6, 1, 0, 0)
							SetPedComponentVariation(localPeds[Number], 7, 1, 0, 0)
							SetPedComponentVariation(localPeds[Number], 8, 0, 0, 0)
							SetPedComponentVariation(localPeds[Number], 10, 0, 0, 0)
							SetPedComponentVariation(localPeds[Number], 11, 0, 0, 0)
							SetPedPropIndex(localPeds[Number], 1, 0, 0, false)
						end

						if List[Number]["anim"] ~= nil then
							if LoadAnim(List[Number]["anim"][1]) then
								TaskPlayAnim(localPeds[Number], List[Number]["anim"][1], List[Number]["anim"][2], 8.0,
									8.0, -1, 1, 0, 0, 0, 0)
							end
						end
					end
				end
			else
				if localPeds[Number] then
					if DoesEntityExist(localPeds[Number]) then
						DeleteEntity(localPeds[Number])
					end
				end
				localPeds[Number] = nil
			end
		end

		Wait(1000)
	end
end)
