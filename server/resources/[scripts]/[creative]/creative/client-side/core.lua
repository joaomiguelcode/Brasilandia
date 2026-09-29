-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFTENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function driftEnable()
	if not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) and not IsPedOnAnyBike(Ped) and not IsPedInAnyHeli(Ped) and not IsPedInAnyBoat(Ped) and not IsPedInAnyPlane(Ped) then
			local Vehicle = GetVehiclePedIsIn(Ped)
			if GetPedInVehicleSeat(Vehicle,-1) == Ped then
				local speed = GetEntitySpeed(Vehicle) * 3.6
				if speed <= 100.0 and speed >= 5.0 then
					SetVehicleReduceGrip(Vehicle,true)

					if not GetDriftTyresEnabled(Vehicle) then
						SetDriftTyresEnabled(Vehicle,true)
						SetReduceDriftVehicleSuspension(Vehicle,true)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFTDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function driftDisable()
	local Ped = PlayerPedId()
	if IsPedInAnyVehicle(Ped) then
		local Vehicle = GetLastDrivenVehicle()

		if GetDriftTyresEnabled(Vehicle) then
			SetVehicleReduceGrip(Vehicle,false)
			SetDriftTyresEnabled(Vehicle,false)
			SetReduceDriftVehicleSuspension(Vehicle,false)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeDrift",driftEnable)
RegisterCommand("-activeDrift",driftDisable)
RegisterKeyMapping("+activeDrift","Ativação do drift.","keyboard","LSHIFT")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Blips = {

	{ -293.24,1548.97,358.16,86,1, "Boi Malhado", 0.4 }, -- Armas
	{ 862.77,384.23,126.51,86,1, "Marconi", 0.4 }, -- Armas
	{ -1741.79,1014.97,194.67,86,1, "Elisa Maria", 0.4 }, -- Armas

	{ 1231.61,-230.22,75.82,86,1, "Inferninho", 0.4 }, -- Munição
	{ 476.09,981.59,226.58,86,1, "Zaki Nachi", 0.4 }, -- Munição
	{ 2509.77,2485.96,40.57,86,1, "Taipas", 0.4 }, -- Munição

	{ 1221.82,-116.49,66.78,86,1, "Brasilândia", 0.4 }, -- Desmanche
	{ 625.36,2449.01,62.78,86,1, "Divineia", 0.4 }, -- Desmanche
	{ -83.44,3073.68,34.76,86,1, "Monte Cristo", 0.4 }, -- Desmanche
	{ 2406.77,-585.04,89.12,86,1, "Capão Redondo", 0.4 }, -- Desmanche

	{ 1478.27,-712.62,93.57,86,1, "Heliópolis", 0.4 }, -- Drogas
	{ -828.42,-1873.93,26.62,86,1, "Vila Ede", 0.4 }, -- Drogas
	{ 2723.48,1870.3,51.71,86,1, "São Bento", 0.4 }, -- Drogas
	{ 13.63,2622.14,86.88,86,1, "Tiradentes", 0.4 }, -- Drogas
	{ 2005.47,460.98,168.73,86,1, "Cachoeirinha", 0.4 }, -- Drogas

    { -1388.33,-586.76,30.21,93,27,"Casa de Festas",0.5 }, -- Lavagem
    { 129.09,-1299.15,29.23,93,27,"Casa de Festas",0.5 }, -- Lavagem
    { -233.41,-333.42,30.09,93,27,"Casa de Festas",0.5 }, -- Lavagem
    { -618.73,33.14,43.52,93,27,"Casa de Festas",0.5 }, -- Lavagem
    
	{ -1605.05,171.13,60.24,526,3,"PMESP | Polícia Militar", 0.5 },
	-- { -2148.07,-372.21,13.53,526,3,"PMESP | 18 BPM | 2° CIA", 0.5 },
    { -1061.63,-3483.5,14.02,526,3,"PMESP | CavPM", 0.5 },
    { -1081.55,-1914.14,14.66,526,0,"PMESP | CPTran", 0.5 },
    { 2909.17,4198.0,50.13,526,5,"PMESP | 1° BPRv", 0.5 },
    { 1031.73,-2356.0,30.51,526,40,"PMESP | 4 BAEP", 0.5 },
    { 963.14,-1794.15,31.14,526,40,"PMESP | CAEP SUL", 0.5 },
    -- { 612.98,-1656.56,25.04,526,40,"PMESP | FT 22M", 0.5 },
    -- { 2507.62,2840.67,48.7,526,40,"PMESP | FT 18M", 0.5 },
    { -2022.17,-451.01,11.81,526,40,"PMESP | 1° CHOQUE", 0.5 },
    { -844.93,-2656.66,13.82,526,9,"PMESP | 2° CHOQUE", 0.5 },
    { 809.03,-1688.99,29.93,526,39,"PMESP | 3° CHOQUE", 0.5 },
    { 106.7,6569.19,31.39,526,2,"PMESP | 4° CHOQUE", 0.5 },
    { 1642.01,3776.95,35.01,526,2,"PMESP | 5° CHOQUE", 0.5 },
    { -620.25,-2317.38,14.0,526,1,"PMESP | Bombeiro", 0.5 },
	{ 1712.14,4774.67,41.52,526,3,"PCESP | 1ª DP - Flagrantes", 0.5 },
	-- { -409.43, 1188.93, 325.59,526,3,"PCESP | 2ª DP - Inteligência e Repressão Especializada", 0.5 },
	-- { 1806.11,3578.26,35.47,526,3,"PCESP | 3ª DP - Crime Organizado e Operações", 0.5 },
	{ -2811.99,28.45,14.86,526,40,"SAP | Base de Escolta", 0.5 },
	
	{ -1379.8,-481.63,47.68,815,12,"Receita Federal", 0.5 },

	{ -1028.32,-1524.42,4.97,526,3,"GCM | Inspetoria", 0.5 },
    { -449.16,1139.23,328.02,79,0,"Tribunal de Justiça", 0.5 },
	{ 3447.84,4856.66,34.93,189,0,"Prisão | Presidente Venceslau 2", 0.5 },

	{ -819.44,-819.53,19.8,355,0,"Detran SP", 0.5 },

	{ 732.68,-2130.96,29.39,621,49,"Hospital",0.7 },
    { 38.37,-1740.85,29.3,446,51,"Mecânica",0.5 },

	{ -766.87,-23.3,41.08,197,0,"Igreja",0.5 },

	{ 316.73,-698.83,29.34,407,1,"Base iFood",0.5 },
	{ -602.25,-931.09,23.86,135,0,"Brasilândia News",0.5 },

	{ 301.72,136.08,104.11,135,0, "Cinema",0.5 },    

    -- { 237.3,-406.1,47.92,457,0, "Jurídico",0.5 },

	{ 265.05,-1262.65,29.3,361,62,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,62,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,62,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,62,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,62,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,62,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,62,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,62,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,62,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,62,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,62,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,62,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,62,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,62,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,62,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,62,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,62,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,62,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,62,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,62,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,62,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,62,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,62,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,62,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,62,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,62,"Posto de Gasolina",0.4 },
	{ 1776.7,3330.56,41.32,361,62,"Posto de Gasolina",0.4 },
	{ -1112.4,-2884.08,13.93,361,62,"Posto de Gasolina",0.4 },

	{ 100.54,-1073.2,29.37,357,3,"Garagem Pública",0.5},
	{ 213.67,-808.9,31.0,357,3,"Garagem Pública",0.5},
	{ 55.93,-876.52,30.65,357,3,"Garagem Pública",0.5},
	{ -348.89,-874.72,31.31,357,3,"Garagem Pública",0.5},
	{ 275.46,-345.09,45.17,357,3,"Garagem Pública",0.5},
	{ 596.6,91.18,93.13,357,3,"Garagem Pública",0.5},
	{ 983.83,-206.22,71.07,357,3,"Garagem Pública",0.5},
	{ -340.73,266.5,85.68,357,3,"Garagem Pública",0.5},
	{ -129.99,6291.09,31.49,357,3,"Garagem Pública",0.5},
	{ 638.14,206.41,97.59,357,3,"Garagem Pública",0.5},
	{ -1184.57,-1509.71,4.65,357,3,"Garagem Pública",0.5},
	{ -73.38,-2004.69,18.27,357,3,"Garagem Pública",0.5},
	{ 1884.9,3726.69,32.76,357,3,"Garagem Pública",0.5},
	{ -2224.33,4226.56,47.11,357,3,"Garagem Pública",0.5},

	{ 81.14,274.11,110.21,383,46,"MC Donalds",0.7 },

	-- { 1506.74,1703.62,110.42,100,2,"Ferro Velho",0.7 }, 
	
	{ 29.2,-1351.89,29.34,52,36,"Loja de Departamento",0.5 },
	{ 2561.74,385.22,108.61,52,36,"Loja de Departamento",0.5 },
	{ 1160.21,-329.4,69.03,52,36,"Loja de Departamento",0.5 },
	{ -711.99,-919.96,19.01,52,36,"Loja de Departamento",0.5 },
	{ -54.56,-1758.56,29.05,52,36,"Loja de Departamento",0.5 },
	{ 375.87,320.04,103.42,52,36,"Loja de Departamento",0.5 },
	{ -3237.48,1004.72,12.45,52,36,"Loja de Departamento",0.5 },
	{ 1730.64,6409.67,35.0,52,36,"Loja de Departamento",0.5 },
	{ 543.51,2676.85,42.14,52,36,"Loja de Departamento",0.5 },
	{ 1966.53,3737.95,32.18,52,36,"Loja de Departamento",0.5 },
	{ 2684.73,3281.2,55.23,52,36,"Loja de Departamento",0.5 },
	{ 1696.12,4931.56,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.18,785.69,137.98,52,36,"Loja de Departamento",0.5 },
	{ 1395.35,3596.6,34.86,52,36,"Loja de Departamento",0.5 },
	{ -2977.14,391.22,15.03,52,36,"Loja de Departamento",0.5 },
	{ -3034.99,590.77,7.8,52,36,"Loja de Departamento",0.5 },
	{ 1144.46,-980.74,46.19,52,36,"Loja de Departamento",0.5 },
	{ 1166.06,2698.17,37.95,52,36,"Loja de Departamento",0.5 },
	{ -1493.12,-385.55,39.87,52,36,"Loja de Departamento",0.5 },
	{ -1228.6,-899.7,12.27,52,36,"Loja de Departamento",0.5 },
	{ 157.82,6631.8,31.68,52,36,"Loja de Departamento",0.5 },
	{ 1702.78,3748.82,34.05,76,6,"Loja de Armas",0.4 },
	{ 240.06,-43.74,69.71,76,6,"Loja de Armas",0.4 },
	{ 843.95,-1020.43,27.53,76,6,"Loja de Armas",0.4 },
	{ -322.19,6072.86,31.27,76,6,"Loja de Armas",0.4 },
	{ -664.03,-949.22,21.53,76,6,"Loja de Armas",0.4 },
	{ -1318.83,-389.19,36.43,76,6,"Loja de Armas",0.4 },
	{ -1110.11,2687.5,18.62,76,6,"Loja de Armas",0.4 },
	{ 2569.23,309.46,108.46,76,6,"Loja de Armas",0.4 },
	{ -3159.91,1080.64,20.69,76,6,"Loja de Armas",0.4 },
	{ 15.42,-1120.47,28.81,76,6,"Loja de Armas",0.4 },
	{ 811.81,-2145.58,29.34,76,6,"Loja de Armas",0.4 },
	{ -815.12,-184.15,37.57,71,62,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,62,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,62,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,62,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,62,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,62,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,62,"Barbearia",0.5 },
	{ -1117.26,-1438.74,5.11,366,62,"Loja de Roupas",0.5 },
	{ 86.06,-1391.64,29.23,366,62,"Loja de Roupas",0.5 },
	{ -719.94,-158.18,37.0,366,62,"Loja de Roupas",0.5 },
	{ -152.79,-306.79,38.67,366,62,"Loja de Roupas",0.5 },
	{ -816.39,-1081.22,11.12,366,62,"Loja de Roupas",0.5 },
	{ -1206.51,-781.5,17.12,366,62,"Loja de Roupas",0.5 },
	{ -1458.26,-229.79,49.2,366,46,"Tatuapé Conceito",0.5 },
	{ -2.41,6518.29,31.48,366,62,"Loja de Roupas",0.5 },
	{ 1682.59,4819.98,42.04,366,62,"Loja de Roupas",0.5 },
	{ 129.46,-205.18,54.51,366,62,"Loja de Roupas",0.5 },
	{ 618.49,2745.54,42.01,366,62,"Loja de Roupas",0.5 },
	{ 1197.93,2698.21,37.96,366,62,"Loja de Roupas",0.5 },
	{ -3165.74,1061.29,20.84,366,62,"Loja de Roupas",0.5 },
	{ -1093.76,2703.99,19.04,366,62,"Loja de Roupas",0.5 },
	{ 414.86,-807.57,29.34,366,62,"Loja de Roupas",0.5 },
	{ -1082.22,-247.54,37.77,439,73,"Life Invader",0.6 },
	{ -776.72,-1495.02,2.29,266,62,"Embarcações",0.5 },
	{ -1604.83,5256.85,2.07,266,62,"Embarcações",0.5 },
	{ 4971.95,-5171.1,2.29,266,62,"Embarcações",0.5 },

	{ 2747.28,3473.04,55.67,78,11,"Mercado Central",0.5 },

	{ -361.52,-1564.52,25.02,318,62,"Lixeiro",0.6 },
	-- { 2680.0,1418.17,24.57,67,29,"Caminhoneiro",0.5 },
	{ 1525.07,3784.92,34.49,317,62,"Pescador",0.5 },
	{ 368.87,6475.52,29.81,76,62,"Agricultura",0.4 },
	-- { 401.52,-1147.02,29.28,198,0,"Uber",0.5 },
	-- { -9.17,-657.0,33.45,67,62,"Transportador de valores",0.5 },
	-- { 2409.91,5043.58,46.0,285,0,"Lenhador",0.4 },
	{ -680.9,5832.41,17.32,89,11,"Central de Agropecuária",0.5 },
	{ 2832.82,2795.1,57.47,78,66,"Minerador",0.5 },

	{ -595.06,5066.48,136.1,141,21,"Área de caça (10km²)",1.0},

	{ 2953.93,2787.49,41.5,617,62,"Pedreira",0.6 },
	{ 1322.93,-1652.29,52.27,75,13,"Loja de Tatuagem",0.5 },
	{ -1154.42,-1425.9,4.95,75,13,"Loja de Tatuagem",0.5 },
	{ 322.84,180.16,103.58,75,13,"Loja de Tatuagem",0.5 },
	{ -3169.62,1075.8,20.83,75,13,"Loja de Tatuagem",0.5 },
	{ 1864.07,3747.9,33.03,75,13,"Loja de Tatuagem",0.5 },
	{ -293.57,6199.85,31.48,75,13,"Loja de Tatuagem",0.5 },

	-- { 1134.62,-469.92,66.71,459,8,"DigitalDen",0.6 },
	{ 154.94,-217.93,54.34,76,0,"Apple",0.6 },
	
	{ 1087.67,6509.36,21.06,210,2,"Hortifruit",0.5 },
	{ -69.92,6262.28,31.09,154,0,"Açougueiro",0.4 },

	{ -795.07,-100.81,37.61,106,0,"Bicicletário",0.4 },

	-- { 374.23,-1267.59,32.5,469,69,"Blazeit",0.8 },
	-- {177.95,-1321.41,29.5,431,69,"PawnShop",0.7},
	{391.84,-763.78,29.4,407,1,"Poupa Tempo",0.4},
	{2062.66,3938.34,33.13,439,0,"Condomínio | Alphaville",0.5},
	{-895.45,1022.42,225.37,439,0,"Condomínio | Vintage",0.5},

	{ 408.56,-1624.93,29.15,357,9,"Pátio de Veículos",0.6 },
	-- { -614.08,-1608.6,26.86,365,1,"Compra e venda Scrap",0.6 },
	-- { 1691.53,2566.09,45.57,12,2,"Serviço",0.4 },
	-- { 1178.18,2650.95,37.79,402,0,"68 LS Auto Repair",0.8 },
	-- { -175.49,-1288.72,31.64,478,52,"Self Storage",0.6 },
	-- { -60.09,-1215.82,28.59,478,52,"Self Storage",0.6 },
	-- { 915.37,3570.61,33.78,478,52,"Self Storage",0.6 },
	{ -424.78,111.49,64.82,79,0,"Tcar Imports",0.4 },

	{ -509.67,276.06,83.24,51,13,"Drogaria São Paulo", 0.5 },
	{ -698.1,271.46,83.1,374,44,"Imobiliária", 0.5 },


}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()

		SetCreateRandomCops(false)
		CancelCurrentPoliceReport()
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		SetPedInfiniteAmmoClip(PlayerPedId(),false)

		SetVehicleModelIsSuppressed(GetHashKey("jet"),true)
		SetVehicleModelIsSuppressed(GetHashKey("besra"),true)
		SetVehicleModelIsSuppressed(GetHashKey("luxor"),true)
		SetVehicleModelIsSuppressed(GetHashKey("blimp"),true)
		SetVehicleModelIsSuppressed(GetHashKey("polmav"),true)
		SetVehicleModelIsSuppressed(GetHashKey("buzzard2"),true)
		SetVehicleModelIsSuppressed(GetHashKey("mammatus"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prismuscl_01"),true)
		SetPedModelIsSuppressed(GetHashKey("u_m_y_prisoner_01"),true)
		SetPedModelIsSuppressed(GetHashKey("s_m_y_prisoner_01"),true)

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local areas = {
    -- {x = -816.92, y = -2672.14, range = 150.0}, -- ANCHIETA
    -- {x = -588.38, y = -1068.71, range = 150.0}, -- 18M
    -- {x = -1124.41, y = -1902.65, range = 50.0}, -- CPTran
    -- {x = -1151.8, y = -1723.14, range = 80.0}, -- 4BAEP
    -- {x = -1657.18, y = -791.97, range = 50.0}, -- CavPV 1
    -- {x = -1705.19, y = -751.22, range = 50.0}, -- CavPV 2
    -- {x = -2064.89, y = -494.13, range = 150.0}, -- Rota
    -- {x = 631.9, y = -1657.47, range = 40.0}, -- FT22M
    -- {x = 780.84, y = -1659.77, range = 50.0}, -- Humaitá

    -- {x = 1369.15, y = -738.58, range = 150.0}, -- Favela Helipa
    -- {x = 1203.72, y = -153.45, range = 150.0}, -- Favela Barragem
    -- {x = 916.78, y = 361.6, range = 100.0}, -- Favela Cassino
    -- {x = 1087.28, y = 692.71, range = 100.0}, -- Favela Cassino 2

	{x = 476.09, y = 981.59, range = 350.0}, -- Zaki Nachi 
	{x = 862.77, y = 384.23, range = 250.0}, -- Marconi 1 
	{x = 862.77, y = 384.23, range = 250.0}, -- Marconi 2 
	{x = 2723.48, y = 1870.3, range = 350.0}, -- São Bento 
	{x = -1741.79, y = 1014.97, range = 300.0}, -- Elisa Maria 
	{x = 2509.77, y = 2485.96, range = 200.0}, -- Taipas 
	{x = -828.42, y = -1873.93, range = 200.0}, -- Vila Ede 
	{x = -293.24, y = 1548.97, range = 300.0}, -- Boi Malhado 
	{x = 625.36, y = 2449.01, range = 250.0}, -- Divineia 
	{x = 1221.82, y = -116.49, range = 400.0}, -- Brasilândia
	{x = 1231.61, y = -230.22, range = 100.0}, -- Inferninho
	{x = 1478.27, y = -712.62, range = 300.0}, -- Heliópolis
	{x = 13.63, y = 2622.14, range = 250.0}, -- Tiradentes
	{x = -83.44, y = 3073.68, range = 250.0}, -- Monte Cristo
	{x = 2406.77, y = -585.04, range = 250.0}, -- Capão Redondo
	{x = 2005.47, y = 460.98, range = 350.0}, -- Cachoeirinha

	{x = 129.35, y = -1299.57,range = 80.0}, -- Vanilla
	{x = -1388.41, y = -615.74, range = 120.0}, -- Bahamas 
	{x = -230.82, y = -331.79, range = 80.0}, -- Galaxy

	{x = -1680.61, y = 203.37, z = 60.25, range = 350.0}, -- PMESP | Polícia Militar
	{x = 2914.33, y = 4176.98, range = 100.0}, -- PMESP | 1 BPRv 
	{x = -2065.8, y = -495.66, range = 300.0}, -- PMESP | 1 CHOQUE
	{x = -1153.27, y = -1726.98, range = 150.0}, -- PMESP | 4 BAEP
	{x = 1023.12, y = -2354.34, range = 150.0}, -- PMESP | 4 BAEP NOVO 
	{x = -818.42, y = -2670.92, range = 200.0}, -- PMESP | 2 CHOQUE
	{x = 780.48, y = -1680.02, range = 250.0}, -- PMESP | 3 CHOQUE 
	{x = 67.97, y = 6539.99, range = 250.0}, -- PMESP | 4 CHOQUE 
	{x = 384.15, y = -757.67, range = 150.0}, -- PMESP | BOMBEIRO
	{x = 975.41, y = -1796.16, range = 100.0}, -- PMESP | CAEP
	{x = -1061.63, y = -3483.5, range = 200.0}, -- PMESP | CavPM
	{x = -1127.77, y = -1903.83, range = 100.0}, --  PMESP | CPtran
	-- {x = 627.67, y = -1653.89, range = 70.0}, -- PMESP | FT 22M
	-- {x = 953.89, y = 159.33, range = 50.0}, -- PMESP | FT 18M

	{x = 313.69, y = 356.51, range = 350.0}, -- Hospital 
	{x = -454.49, y = 1143.06, range = 50.0}, -- Judiciario
	-- {x = -475.01, y = 284.23, range = 250.0}, -- Civil Antiga (Sul)
	{x = -235.1, y = 6078.78, range = 250.0}, -- Civil
	{x = 1712.14, y = 4774.67, range = 100.0}, -- PCESP 
	{x = -455.44, y = 1146.4, range = 100.0}, -- TJSP
	{x = 49.5, y = -1759.22, range = 250.0}, -- Mecanica
	{x = -600.02, y = -2337.03, range = 250.0}, -- Bombeiro novo

	{x = 514.77, y = -3125.1, range = 400.0}, -- CRAFT C4
	{x = -400.83, y = 1205.65, range = 250.0}, -- 2° DP
	{x = 1799.35, y = 3606.82, range = 250.0}, -- 3° DP
	{x = -1379.8, y = -481.63, range = 250.0}, -- 3° DP

	{x = 3899.85, y = 5136.14, range = 500.0}, -- Prisão | Presidente Venceslau 2

	{x = -822.07, y = -793.62, range = 80.0}, -- DETRAN

	{x = -712.04, y = 266.5, range = 150.0}, -- Imobiliária

	{x = -1006.36, y = -1507.13, range = 150.0}, -- GCM NEW

	{x = -2837.24, y = 11.91, range = 100.0}, -- BASE ESCOLTA SAP

	{x = 726.99, y = -2127.04, range = 80.0}, -- UNIMED

}

local isInsideArea = false

local function isPlayerInArea(playerCoords, area)
    local distance = #(vector2(playerCoords.x, playerCoords.y) - vector2(area.x, area.y))
    return distance <= area.range, distance
end

local realTime = true
local localHours = false
local localMinutes = false
local realWeather = true
local localWeather = false

CreateThread(function()
	while true do
		SetWeaponDamageModifierThisFrame("WEAPON_BAT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KATANA",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HAMMER",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_WRENCH",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_UNARMED",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_CROWBAR",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_MACHETE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_POOLCUE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KNUCKLE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_KARAMBIT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_GOLFCLUB",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_BATTLEAXE",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_FLASHLIGHT",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_NIGHTSTICK",0.05)
		SetWeaponDamageModifierThisFrame("WEAPON_STONE_HATCHET",0.25)
		SetWeaponDamageModifierThisFrame("WEAPON_SMOKEGRENADE",0.0)
		SetWeaponDamageModifierThisFrame("WEAPON_PUMPSHOTGUN",0.0)
		SetWeaponDamageModifierThisFrame("WEAPON_DOZEBORRACHA",0.0)
		
		RemoveAllPickupsOfType("PICKUP_WEAPON_KNIFE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PISTOL")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MINISMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_MICROSMG")
		RemoveAllPickupsOfType("PICKUP_WEAPON_PUMPSHOTGUN")
		RemoveAllPickupsOfType("PICKUP_WEAPON_CARBINERIFLE")
		RemoveAllPickupsOfType("PICKUP_WEAPON_SAWNOFFSHOTGUN")

		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(16)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)

		DisableControlAction(1,37,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,157,true)
		DisableControlAction(1,158,true)
		DisableControlAction(1,159,true)
		DisableControlAction(1,160,true)
		DisableControlAction(1,161,true)
		DisableControlAction(1,162,true)
		DisableControlAction(1,163,true)
		DisableControlAction(1,164,true)
		DisableControlAction(1,165,true)

		SetVehicleDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetAmbientVehicleRangeMultiplierThisFrame(0.0)

		if LocalPlayer["state"]["Route"] > 0 then
			-- SetVehicleDensityMultiplierThisFrame(0.0)
			-- SetRandomVehicleDensityMultiplierThisFrame(0.0)
			-- SetParkedVehicleDensityMultiplierThisFrame(0.0)
			-- SetAmbientVehicleRangeMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
			SetPedDensityMultiplierThisFrame(0.0)
		end

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end

		if GetPlayerWantedLevel(PlayerId()) ~= 0 then
			ClearPlayerWantedLevel(PlayerId())
		end

		DisablePlayerVehicleRewards(PlayerId())

		if realWeather then
			SetWeatherTypeNow(GlobalState["Weather"])
			SetWeatherTypePersist(GlobalState["Weather"])
			SetWeatherTypeNowPersist(GlobalState["Weather"])
		else
			SetWeatherTypeNow(localWeather)
			SetWeatherTypePersist(localWeather)
			SetWeatherTypeNowPersist(localWeather)
		end

		if realTime then
			NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)
		else
			NetworkOverrideClockTime(localHours,localMinutes,00)
		end

		-- CONTROLE DE NPCS
		local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local insideAnyArea = false

        for _, area in ipairs(areas) do
            local isInside, distance = isPlayerInArea(playerCoords, area)

            if isInside then
                insideAnyArea = true
                break
            end
        end

        if insideAnyArea and not isInsideArea then
            isInsideArea = true
        elseif not insideAnyArea and isInsideArea then
            isInsideArea = false
        end

        if isInsideArea then
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetAmbientVehicleRangeMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
            SetPedDensityMultiplierThisFrame(0.0)
        else
            SetVehicleDensityMultiplierThisFrame(0.0)
            SetRandomVehicleDensityMultiplierThisFrame(0.0)
            SetParkedVehicleDensityMultiplierThisFrame(0.0)
            SetAmbientVehicleRangeMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.6, 0.6)
            SetPedDensityMultiplierThisFrame(0.6)
        end

		-- ANTI FURTIVO
		local ped = PlayerPedId()
        DisableControlAction(0, 36, true) 
        
        if GetPedStealthMovement(ped) then
            SetPedStealthMovement(ped, false, 0)
        end
        SetPedUsingActionMode(ped, false, -1, "DEFAULT_ACTION")
        if IsPedInMeleeCombat(ped) and GetPedStealthMovement(ped) then
            ClearPedTasksImmediately(ped)
        end

		Wait(0)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ALTERAR HORÁRIO LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mTT:setTime")
AddEventHandler("mTT:setTime", function(arg)
	if not arg then return end

	if arg == "dia" then
		realTime = false
		localHours = 12
		localMinutes = 00
		TriggerEvent("Notify", "azul", "Horário local alterado para <b>dia</b>.", 5000)
	elseif arg == "noite" then
		realTime = false
		localHours = 00
		localMinutes = 00
		TriggerEvent("Notify", "azul", "Horário local alterado para <b>noite</b>.", 5000)
	elseif arg == "real" then
		realTime = true
		localHours = false
		localMinutes = false
		TriggerEvent("Notify", "azul", "Horário alterado para o <b>real</b>.", 5000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ALTERAR CLIMA LOCAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mTT:setWeather")
AddEventHandler("mTT:setWeather", function(arg)
	if not arg then return end

	if arg == "real" then
		realWeather = true
		localWeather = false
		TriggerEvent("Notify", "azul", "Clima alterado para <b>real</b>.", 5000)
	else
		realWeather = false
		localWeather = arg
		TriggerEvent("Notify", "azul", "Clima alterado para <b>" .. arg .. "</b>.", 5000)
	end

end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	{ 330.19,-601.21,43.29,343.65,-581.77,28.8 },
	{ 343.65,-581.77,28.8,330.19,-601.21,43.29 },

	{ 327.16,-603.53,43.29,338.97,-583.85,74.16 },
	{ 338.97,-583.85,74.16,327.16,-603.53,43.29 },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19 },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66 },

	{ -1194.46,-1189.31,7.69,1173.55,-3196.68,-39.00 },
	{ 1173.55,-3196.68,-39.00,-1194.46,-1189.31,7.69 },

	{ -79.75,-836.72,40.56,-75.0,-824.54,321.29 },
	{ -75.0,-824.54,321.29,-79.75,-836.72,40.56 },

	{ 240.89,-1004.87,-99.01,183.02,-1062.76,74.37 },      -------- LUGAR BRANCO  
	{ 183.02,-1062.76,74.37,240.89,-1004.87,-99.01 },

	
	{ 0.94,-703.18,16.13,10.36,-668.13,33.45 },      -------- transporte  
	{ 10.36,-668.13,33.45,0.94,-703.18,16.13 },


	
	
	{ 236.23,229.27,97.11,234.24,229.94,97.11 },
	{ 234.24,229.94,97.11,236.23,229.27,97.11 },
	{575.68,-423.15,-69.66, -322.08,-894.81,31.07},
	{402.68,-1004.0,-99.01, -322.08,-894.81,31.07}

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Number = 1,#Blips do
		Wait(5)
		local Blip = AddBlipForCoord(Blips[Number][1],Blips[Number][2],Blips[Number][3])
		SetBlipSprite(Blip,Blips[Number][4])
		SetBlipDisplay(Blip,4)
		SetBlipAsShortRange(Blip,true)
		SetBlipColour(Blip,Blips[Number][5])
		SetBlipScale(Blip,Blips[Number][7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Blips[Number][6])
		EndTextCommandSetBlipName(Blip)
	end

	local Tables = {}

	for Number = 1,#Teleport do
		Tables[#Tables + 1] = { Teleport[Number][1],Teleport[Number][2],Teleport[Number][3],2.5,"E","Porta de Acesso","Pressione para acessar" }
	end

	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number = 1,#Teleport do
					local v = Teleport[Number]
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 1 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							SetEntityCoords(Ped,v[4],v[5],v[6],false,false,false,false)

							if k == 19 or k == 20 then
								local Finishing = false
								local Handle,Object = FindFirstObject()
		
								repeat
									local Coords2 = GetEntityCoords(Object)
									local Distance = #(Coords2 - Coords)
		
									if Distance < 3.0 and GetEntityModel(Object) == 961976194 then
										FreezeEntityPosition(Object,true)
									end
		
									Finishing,Object = FindNextObject(Handle)
								until not Finishing
		
								EndFindObject(Handle)
							end
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 10.0
local speed_ud = 3.0
local zoomspeed = 2.0
local vehCamera = false
local fov = (fov_max + fov_min) * 0.5
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local waitPacket = 500
		local Ped = PlayerPedId()
		if IsPedInAnyHeli(Ped) then
			waitPacket = 4

			local veh = GetVehiclePedIsUsing(Ped)
			SetVehicleRadioEnabled(veh,false)

			if IsControlJustPressed(1,51) then
				-- TriggerEvent("hud:Active",false)
				vehCamera = true
			end

			if IsControlJustPressed(1,154) then
				if GetPedInVehicleSeat(veh,1) == Ped or GetPedInVehicleSeat(veh,2) == Ped then
					TaskRappelFromHeli(Ped,1)
				end
			end

			if vehCamera then
				SetTimecycleModifierStrength(0.3)
				SetTimecycleModifier("heliGunCam")

				local scaleform = RequestScaleformMovie("HELI_CAM")
				while not HasScaleformMovieLoaded(scaleform) do
					Wait(0)
				end

				local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
				AttachCamToEntity(cam,veh,0.0,0.0,-1.5,true)
				SetCamRot(cam,0.0,0.0,GetEntityHeading(veh))
				SetCamFov(cam,fov)
				RenderScriptCams(true,false,0,1,0)
				PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
				PushScaleformMovieFunctionParameterInt(0)
				PopScaleformMovieFunctionVoid()

				while vehCamera do
					if IsControlJustPressed(1,51) then
						TriggerEvent("hud:Active",true)
						vehCamera = false
					end

					local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
					CheckInputRotation(cam,zoomvalue)
					HandleZoom(cam)
					HideHudAndRadarThisFrame()
					HideHudComponentThisFrame(19)
					PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
					PushScaleformMovieFunctionParameterFloat(GetEntityCoords(veh).z)
					PushScaleformMovieFunctionParameterFloat(zoomvalue)
					PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
					PopScaleformMovieFunctionVoid()
					DrawScaleformMovieFullscreen(scaleform,255,255,255,255)

					Wait(0)
				end

				ClearTimecycleModifier()
				fov = (fov_max + fov_min) * 0.5
				RenderScriptCams(false,false,0,1,0)
				SetScaleformMovieAsNoLongerNeeded(scaleform)
				DestroyCam(cam,false)
				SetNightvision(false)
				SetSeethrough(false)
			end
		end

		Wait(waitPacket)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINPUTROTATION
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckInputRotation(cam,zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
		new_x = math.max(math.min(20.0,rotation.x + rightAxisY * -1.0 * (3.0) * (zoomvalue + 0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDLEZOOM
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - zoomspeed,fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + zoomspeed,fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov - current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov + (fov - current_fov) * 0.05)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISLAND
-----------------------------------------------------------------------------------------------------------------------------------------
local Island = {
	"h4_islandairstrip",
	"h4_islandairstrip_props",
	"h4_islandx_mansion",
	"h4_islandx_mansion_props",
	"h4_islandx_props",
	"h4_islandxdock",
	"h4_islandxdock_props",
	"h4_islandxdock_props_2",
	"h4_islandxtower",
	"h4_islandx_maindock",
	"h4_islandx_maindock_props",
	"h4_islandx_maindock_props_2",
	"h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb",
	"h4_beach",
	"h4_beach_props",
	"h4_beach_bar_props",
	"h4_islandx_barrack_props",
	"h4_islandx_checkpoint",
	"h4_islandx_checkpoint_props",
	"h4_islandx_Mansion_Office",
	"h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02",
	"h4_islandx_Mansion_LockUp_03",
	"h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B",
	"h4_islandairstrip_doorsclosed",
	"h4_Underwater_Gate_Closed",
	"h4_mansion_gate_closed",
	"h4_aa_guns",
	"h4_IslandX_Mansion_GuardFence",
	"h4_IslandX_Mansion_Entrance_Fence",
	"h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights",
	"h4_islandxcanal_props",
	"h4_beach_props_party",
	"h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b",
	"h4_islandX_Terrain_props_06_c",
	"h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b",
	"h4_islandX_Terrain_props_05_c",
	"h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e",
	"h4_islandX_Terrain_props_05_f",
	"h4_islandx_terrain_01",
	"h4_islandx_terrain_02",
	"h4_islandx_terrain_03",
	"h4_islandx_terrain_04",
	"h4_islandx_terrain_05",
	"h4_islandx_terrain_06",
	"h4_ne_ipl_00",
	"h4_ne_ipl_01",
	"h4_ne_ipl_02",
	"h4_ne_ipl_03",
	"h4_ne_ipl_04",
	"h4_ne_ipl_05",
	"h4_ne_ipl_06",
	"h4_ne_ipl_07",
	"h4_ne_ipl_08",
	"h4_ne_ipl_09",
	"h4_nw_ipl_00",
	"h4_nw_ipl_01",
	"h4_nw_ipl_02",
	"h4_nw_ipl_03",
	"h4_nw_ipl_04",
	"h4_nw_ipl_05",
	"h4_nw_ipl_06",
	"h4_nw_ipl_07",
	"h4_nw_ipl_08",
	"h4_nw_ipl_09",
	"h4_se_ipl_00",
	"h4_se_ipl_01",
	"h4_se_ipl_02",
	"h4_se_ipl_03",
	"h4_se_ipl_04",
	"h4_se_ipl_05",
	"h4_se_ipl_06",
	"h4_se_ipl_07",
	"h4_se_ipl_08",
	"h4_se_ipl_09",
	"h4_sw_ipl_00",
	"h4_sw_ipl_01",
	"h4_sw_ipl_02",
	"h4_sw_ipl_03",
	"h4_sw_ipl_04",
	"h4_sw_ipl_05",
	"h4_sw_ipl_06",
	"h4_sw_ipl_07",
	"h4_sw_ipl_08",
	"h4_sw_ipl_09",
	"h4_islandx_mansion",
	"h4_islandxtower_veg",
	"h4_islandx_sea_mines",
	"h4_islandx",
	"h4_islandx_barrack_hatch",
	"h4_islandxdock_water_hatch",
	"h4_beach_party"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCAYO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local CayoPerico = false

	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if #(Coords - vec3(4840.57,-5174.42,2.0)) <= 2000 then
			if not CayoPerico then
				for _,v in pairs(Island) do
					RequestIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",true)
				SetAiGlobalPathNodesType(1)
				SetDeepOceanScaler(0.0)
				LoadGlobalWaterType(1)
				CayoPerico = true
			end
		else
			if CayoPerico then
				for _,v in pairs(Island) do
					RemoveIpl(v)
				end

				SetIslandHopperEnabled("HeistIsland",false)
				SetAiGlobalPathNodesType(0)
				SetDeepOceanScaler(1.0)
				LoadGlobalWaterType(0)
				CayoPerico = false
			end
		end

		Wait(TimeDistance)
	end
end)

-- PLACA MERCOSUL
local textureDic = CreateRuntimeTxd('duiTxd')
local txdPlate = "http://131.196.198.90/mercosul/mercosul.png"
local txdModel = "http://131.196.198.90/mercosul/plate.png"

local object = CreateDui(txdPlate, 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex", handle)
AddReplaceTexture('vehshare', 'plate01', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate02', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate03', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate04', 'duiTxd', 'duiTex')
AddReplaceTexture('vehshare', 'plate05', 'duiTxd', 'duiTex')

local object = CreateDui(txdModel, 540, 300)
local handle = GetDuiHandle(object)
CreateRuntimeTextureFromDuiHandle(textureDic, "duiTex2", handle)
AddReplaceTexture('vehshare', 'plate01_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate02_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate03_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate04_n', 'duiTxd', 'duiTex2')
AddReplaceTexture('vehshare', 'plate05_n', 'duiTxd', 'duiTex2')