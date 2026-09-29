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
Tunnel.bindInterface("garages",Creative)
vSERVER = Tunnel.getInterface("garages")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DECOR
-----------------------------------------------------------------------------------------------------------------------------------------
DecorRegister("PlayerVehicle",3)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Searched = nil
local Hotwired = false
local Anim = "machinic_loop_mechandplayer"
local Dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { x = -349.02, y = -874.78, z = 31.31,
		["1"] = { -343.83,-876.02,31.31,167.25 },
		["2"] = { -340.11,-876.81,31.31,167.25 },
		["3"] = { -336.51,-877.46,31.31,167.25 },
		["4"] = { -332.87,-878.41,31.31,167.25 },
		["5"] = { -329.07,-879.12,31.31,167.25 },
		["6"] = { -325.6,-880.03,31.31,167.25 }
	},
	["4"] = { x = -280.93, y = -888.29, z = 31.31,
		["1"] = { -285.81,-888.55,31.31,167.25 },
		["2"] = { -289.31,-887.82,31.31,167.25},
		["3"] = { -293.09,-887.07,31.31,167.25 },
		["4"] = { -296.75,-886.33,31.31,167.25 },
		["5"] = { -300.39,-885.57,31.31,167.25 },
		["6"] = { -303.91,-884.8,31.31,167.25 }
	},
	["5"] = { x = 317.73, y = 2623.51, z = 44.47,
		["1"] = { 328.08,2618.76,44.72,22.68 },
		["2"] = { 331.96,2620.55,44.72,22.68 },
		["3"] = { 335.56,2622.2,44.72,22.68 }
	},
	["9"] = { x = -767.26, y = 5583.43, z = 33.6,
		["1"] = { -774.4,5578.3,33.72,87.88},
		["2"] = { -774.38,5575.42,33.72,87.88 },
		["3"] = { -774.43,5572.41,33.72,87.88 }
	},
	["2"] = { x = 599.04, y = 2743.33, z = 42.04,
		["1"] = { 604.82,2738.27,41.64,187.09 },
		["2"] = { 601.75,2738.08,41.65,184.26 },
		["3"] = { 598.63,2737.85,41.69,184.26 },
		["4"] = { 595.59,2737.55,41.7,184.26 }
	},
	["3"] = { x = -136.8, y = 6356.84, z = 31.49,
		["1"] = { -133.72,6349.01,31.16,42.52 },
		["2"] = { -136.1,6346.53,31.16,42.52 }
	},
	["6"] = { x = -340.57, y = 266.04, z = 85.68,
		["1"] = { -339.73,279.31,85.8,93.55 },
		["2"] = { -340.04,283.09,85.7,93.55 },
		["3"] = { -340.29,286.8,85.68,93.55 },
		["4"] = { -340.53,290.46,85.68,93.55 },
		["5"] = { -340.78,293.62,85.66,93.55 }
	},
	["7"] = { x = -2030.03, y = -465.99, z = 11.59,
		["1"] = { -2037.4,-461.02,11.07,138.9 },
		["2"] = { -2039.78,-459.07,11.07,138.9 },
		["3"] = { -2042.12,-457.1,11.07,138.9 },
		["4"] = { -2044.47,-455.11,11.07,138.9 },
		["5"] = { -2046.85,-453.09,11.07,138.9 },
		["6"] = { -2049.12,-451.17,11.07,138.9 },
		["7"] = { -2051.51,-449.23,11.07,138.9 }
	},
	["8"] = { x = -1184.94, y = -1509.99, z = 4.65,
		["1"] = { -1183.29,-1495.81,4.04,121.89 },
		["2"] = { -1185.23,-1493.28,4.04,121.89 },
		["3"] = { -1186.87,-1490.71,4.04,121.89 },
		["4"] = { -1188.69,-1488.27,4.04,121.89 }
	},
	["13"] = { x = 361.96, y = 297.8, z = 103.88,
		["1"] = { 371.06,284.68,102.94,340.16 },
		["2"] = { 374.8,283.39,102.85,340.16 },
		["3"] = { 378.62,282.06,102.78,340.16 }
	},
	["14"] = { x = 1035.84, y = -763.87, z = 58.0,
		["1"] = { 1022.89,-755.43,58.2,226.78 },
		["2"] = { 1020.26,-758.17,58.22,226.78 },
		["3"] = { 1017.57,-760.73,58.2,223.78 },
		["4"] = { 1014.47,-762.97,58.11,223.78 }   
	},
	["15"] = { x = -796.69, y = -2022.85, z = 9.17,
		["1"] = { -779.77,-2040.03,8.56,314.65 },
		["2"] = { -777.36,-2042.58,8.56,314.65 },
		["3"] = { -774.92,-2044.9,8.56,314.65 }
	},
	["17"] = { x = 528.65, y = -146.25, z = 58.37,
		["1"] = { 540.99,-136.2,59.13,178.59 },
		["2"] = { 544.84,-136.25,59.01,178.59 },
		["3"] = { 548.83,-136.31,59.01,181.42 },
		["4"] = { 552.81,-136.41,58.99,178.59 }
	},
	["18"] = { x = -1159.56, y = -739.39, z = 19.88,
		["1"] = { -1144.95,-745.49,19.34,104.89 },
		["2"] = { -1142.76,-748.44,19.19,107.72 },
		["3"] = { -1140.18,-751.41,19.06,107.72 },
		["4"] = { -1137.99,-754.36,18.91,107.72 },
		["5"] = { -1135.43,-757.3,18.75,107.72 },
		["6"] = { -1133.12,-760.4,18.59,107.72 },
		["7"] = { -1130.59,-763.27,18.43,107.72 }
	},
	["22"] = { x = 1695.34, y = 4763.64, z = 41.99,
		["1"] = { 1687.27,4762.33,42.02,87.88 },
		["2"] = { 1687.38,4766.48,41.99,87.88}
	},
	["23"] = { x = 1624.05, y = 3566.14, z = 35.15,
		["1"] = { 1627.11,3576.65,35.38,119.06 },
		["2"] = { 1625.0,3580.21,35.38,119.06 }
	},
	["25"] = { x = -73.35, y = -2004.6, z = 18.27,
		["1"] = { -77.61,-2004.88,18.25,354.34 },
		["2"] = { -81.4,-2004.31,18.25,354.34 },
		["3"] = { -85.04,-2003.81,18.25,354.34 },
		["4"] = { -96.36,-2002.65,18.25,354.34},
		["5"] = { -92.46,-2002.93,18.25,354.34 },
		["6"] = { -88.8,-2003.28,18.25,354.34 }
	},
	["26"] = { x = -1031.63, y = -2734.56, z = 20.17,
		["1"] = { -1034.94,-2730.31,20.03,331.66 },
		["2"] = { -1027.26,-2734.87,19.61,331.66 }
	},
	["27"] = { x = 124.99, y = -1086.09, z = 29.18,
		["1"] = { 125.02,-1081.78,28.58,0.0 },
		["2"] = { 121.09,-1081.72,28.58,0.0 },
		["3"] = { 128.67,-1081.7,28.59,2.84 }
	},
	["28"] = { x = 1629.47, y = 3556.42, z = 35.18,   --------- BIKE SANDY
		["1"] = { 1632.82,3559.34,34.54,11.34 },
		["2"] = { 1635.42,3559.73,35.15,25.52 }
	},
	["29"] = { x = 152.83, y = 6452.79, z = 31.24,   
		["1"] = { 155.49,6449.6,30.67,218.27 },
		["2"] = { 158.51,6452.15,30.68,223.94 },
		["3"] = { 152.67,6447.16,30.67,226.78}
	},
	["41"] = { x = 1127.99, y = -1581.94, z = 34.86,  ---------- HOSPITAL SUL
		["1"] = { 1131.64,-1584.85,34.49,272.13}
	},
	["42"] = { x = 1136.79, y = -1620.4, z = 34.88,   
		["1"] = { 1137.74,-1612.07,34.69,82.21 }
	},
	["43"] = { x = -253.92, y = 6339.42, z = 32.42, ---------- HP PALETO
		["1"] = { -258.47,6347.58,32.1,269.3 },
		["2"] = { -261.6,6344.21,32.1,269.3 },
		["3"] = { -264.97,6340.84,32.1,272.13 }
	},
	["44"] = { x = -271.7, y = 6321.75, z = 32.42,
		["1"] = { -273.13,6329.85,32.1,133.23 }
	},
	["45"] = { x = 1808.46, y = 3677.21, z = 34.27,    --------- HP SANDY
		["1"] = { 1807.31,3682.15,33.95,119.06}
	},
	["46"] = { x = 1817.86, y = 3661.11, z = 34.27,     
		["1"] = { 1823.41,3652.41,34.58,212.6}
	},
	["61"] = { x = -387.37, y = -364.97, z = 24.75,        ------------- DP SUL
		["1"] = { -381.36,-365.69,24.48,79.38 },
		["2"] = { -380.57,-361.55,24.48,76.54 },
		["3"] = { -380.25,-357.05,24.48,79.38 },
		["4"] = { -373.91,-358.37,24.48,260.79},
		["5"] = { -374.46,-362.63,24.48,260.79 },
		["6"] = { -374.87,-366.92,24.48,260.79 }
	},
	["62"] = { x =  -942.07, y = -2020.86, z = 11.32,   ---------- HELIPONTO DP
		["1"] = { -950.61,-2021.05,11.32,45.36}  
	},

	["63"] = { x = 1839.35, y = 3691.23, z = 33.97,
		["1"] = { 1844.43,3689.35,33.78,303.31 },
		["2"] = { 1846.28,3686.09,33.78,303.31 },
		["3"] = { 1848.23,3682.71,33.78,303.31 }
	},
	["64"] = { x = 1837.24, y = 3703.9, z = 33.8,     ------------- HELIPONTO SANDY
		["1"] = { 1840.59,3710.25,33.68,17.01 }
	},
	["65"] = { x = 1852.7, y = 3706.48, z = 33.23,   ------- SANDY POLICE 
		["1"] = { 1850.81,3712.26,32.92,0.0 },
		["2"] = { 1855.42,3712.9,33.01,0.0 },
		["3"] = { 1860.73,3711.14,32.97,351.5 }
	},
	["66"] = { x = -467.45, y = 5996.6, z = 31.26,  --------- HELIPONTO PALETO
		["1"] = { -475.04,5988.45,31.73,317.49 }
	},
	["67"] = { x = 1840.78, y = 2545.84, z = 45.66, --------- PRESIDIO
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["68"] = { x = 1840.79, y = 2538.28, z = 45.66,  --------- PRESIDIO
		["1"] = { 1833.59,2542.09,45.54,272.13 }
	},
	["92"] = { x = -191.07, y = -1586.62, z = 34.74,  --------- Families
		["1"] = { -184.69,-1587.85,34.56,235.28 }
	},
	["93"] = { x = 817.34, y = -2336.84, z = 30.31,  --------- VAGOS
		["1"] = { 821.54,-2333.67,30.04,266.46 }
	},
	["95"] = { x = 945.22, y = -1484.22, z = 30.11,  --------- BLOODS
		["1"] = { 942.89,-1486.02,29.87,181.42 }
	},
	
	["123"] = { x = -776.63, y = -1494.93, z = 2.29,  ------- EMBARCAÇAO
		["1"] = { -786.5,-1498.89,-0.57,110.56 }
	},
	["124"] = { x = -1604.72, y = 5256.88, z = 2.07,   ------- EMBARCAÇAO
		["1"] = { -1602.06,5258.87,0.4,22.68 }
	},
	["126"] = { x = 4971.79, y = -5170.93, z = 2.27,
		["1"] = { 4952.76,-5163.61,-0.39,65.2 }
	},
	["143"] = { x = -338.38, y = -1565.6, z = 25.22,  ----------- LIXEIRO SUL
		["1"] = { -336.43,-1563.71,24.94,56.7 }
	},
	["144"] = { x = 2654.93, y = 1693.3, z = 24.48,
		["1"] = { 2660.17,1689.7,23.84,272.13 },
		["2"] = { 2660.17,1693.34,23.84,272.13 },
		["3"] = { 2660.18,1697.03,23.84,272.13 }
	},
	["145"] = { x = -1608.51, y = -837.46, z = 10.26,   
		["1"] = { -1610.7,-834.38,9.71,323.15 },
		["2"] = { -1615.58,-830.5,9.71,320.32 }
	},
	["149"] = { x = 1695.55, y = 4787.69, z = 42.01,     ---------- TAXI SANDY
		["1"] = { 1691.56,4782.3,41.52,87.88 },
		["2"] = { 1691.54,4778.38,41.53,87.88 },
		["3"] = { 1691.56,4774.37,41.53,87.88 },
		["4"] = { 1691.57,4770.32,41.53,87.88 },
		["5"] = { 1691.5,4766.35,41.53,87.88 },
		["6"] = { 1691.52,4762.46,41.52,87.88 }
	},
	["150"] = { x = 2676.7, y = 1423.31, z = 24.5,       ---------- CAMINHONEIRO
		["1"] = { 2678.26,1426.96,24.77,272.13 },
		["2"] = { 2678.26,1431.72,24.77,272.13 },
		["3"] = { 2678.26,1436.92,24.77,272.13 }
	},
	["151"] = { x = 1260.86, y = -335.9, z = 69.08,   ---------- Hogers
		["1"] = { 1257.66,-336.09,68.56,172.92},
		["2"] = { 1253.87,-335.6,68.56,172.92 },
		["3"] = { 1249.93,-334.97,68.56,172.92 }
		},

	["152"] = { x = -631.49, y = -1649.14, z = 25.97,    --------- COMPRA SPREP
		["1"] = { -635.76,-1656.68,25.53,240.95 },
		["2"] = { -633.34,-1652.28,25.53,240.95 },
	},

	["153"] = { x = -608.4, y = -1594.65, z = 26.74,
		["1"] = { -615.23,-1597.21,26.82,82.21 },
		["2"] = { -615.53,-1600.28,26.82,82.21 },
	},

	["154"] = { x = -556.45, y = -919.56, z = 23.88,     ---------- CARZONE
		["1"] = { -543.4,-911.44,23.57,56.7 },
	},
	["155"] = { x = 155.32, y = -1311.78, z = 29.2,     ------ PAWNSHOP
		["1"] = { 152.15,-1306.5,28.93,59.53},
		["2"] = { 150.81,-1309.25,28.93,62.37 },
	},

	["156"] = { x = -186.87, y = -1309.55, z = 31.29,       ----------- BENNYS
		["1"] = { -182.14,-1313.69,31.02,0.0 },
	},

	["157"] = { x = 319.15, y = -559.75, z = 28.75,  
		["1"] = { 316.29,-556.29,28.05,90.71 },
		["2"] = { 316.16,-553.45,28.05,90.71 },
		["3"] = { 316.17,-550.64,28.05,90.71 },
	},

	["158"] = { x = 423.67, y = 6478.8, z = 28.81,
		["1"] = { 425.08,6472.3,28.34,51.03 },
	},

	["159"] = { x = -37.34, y = -1113.4, z = 26.44,  --- premium motorsports delux 
		["1"] = { -47.85,-1115.97,26.17,2.84 },
		["2"] = { -45.19,-1115.82,26.17,2.84 },
	},

	["160"] = { x = 1534.17, y = 6343.63, z = 24.13,   ---- ponte rota 68 paleto
		["1"] = { 1536.32,6338.22,23.44,56.7 },
	},

	["161"] = { x = -250.11, y = 1933.13, z = 183.78,  --- favela lado plantiu
		["1"] = { -247.55,1932.0,183.51,195.6 },
	},

	["162"] = { x = 1951.43, y = 3828.76, z = 32.17,  --- barsandy sem interior
		["1"] = { 1955.99,3827.83,31.48,119.06 },
	},

	["163"] = { x = 2528.77, y = 4123.55, z = 38.59, 
		["1"] = { 2526.43,4118.34,38.32,150.24 },   ---- Thelost
	},

	["164"] = { x = 1979.91, y = 3046.25, z = 47.06,  --- barsandy 
		["1"] = { 1985.04,3042.11,47.13,56.7 },
	},

	["165"] = { x = -556.33, y = 306.57, z = 83.31,  -- tequila
		["1"] = { -553.63,303.37,82.7,266.46 },
	},

	["166"] = { x =-1927.39, y = 2039.17, z = 140.83,  -- vinhedo 
		["1"] = { -1922.29,2040.3,140.8,76.54 }, 
	},

	["167"] = { x =-592.49, y = -1057.84, z = 22.34,   ---catcoffe
		["1"] = { -597.79,-1059.36,21.67,87.88 },
	},

	["168"] = { x = -1165.99, y = -894.98, z = 14.0,   
		["1"] = { -1163.36,-890.74,13.46,303.31 },
		["2"] = { -1165.18,-887.64,13.46,303.31 },
	},

	["169"] = { x =1873.23, y = 2623.84, z = 45.66,
		["1"] = { 1870.32,2622.15,45.29,93.55 },
		["2"] = { 1870.32,2625.58,45.29,85.04 },
	},
	["170"] = { x = 1161.33, y = 2647.28, z = 38.0,
		["1"] = { 1166.48,2639.83,37.91,0.0 },
	},
	["171"] = { x = 115.85, y = -1953.4, z = 20.74,
		["1"] = { 112.57,-1948.1,19.95,311.82 },
	},
	["172"] = { x = -171.25, y = -1661.89, z = 33.46,
		["1"] = { -172.11,-1667.45,32.6,87.88 },
	},
	["173"] = { x = 318.97, y = -2014.52, z = 20.96,
		["1"] = { 318.8,-2019.66,20.05,141.74 },
	},
	["174"] = { x = 489.51, y = -1517.39, z = 29.28,
		["1"] = { 492.8,-1518.71,28.61,138.9 },
	},
	["175"] = { x = -29.8, y = 2870.3, z = 59.34,
		["1"] = { -26.39,2863.76,59.16,65.2 },
	},
	["176"] = { x = -345.05, y = -111.91, z = 39.01,
		["1"] = { -338.05,-115.84,38.33,294.81 },
		["2"] = { -341.88,-114.3,38.33,294.81 },
	},
	["177"] = { x = -1787.48, y = 459.37, z = 128.31,
		["1"] = { -1796.1,456.08,128.38,87.88  },
		["2"] = { -1796.1,460.32,128.38,87.88  },
	},
	["178"] = { x = -545.06, y = 3952.11, z = 98.93,
		["1"] = { -546.23,3954.36,98.5,266.46  },
	},
	["179"] = { x = 1258.74, y = -1590.39, z = 52.49,
		["1"] = { 1262.08,-1591.66,52.3,308.98  },
	},
	-- ["180"] = { x = -399.09, y = -1876.39, z = 20.52,
	-- 	["1"] = { -392.32,-1875.17,19.85,215.44  },
	-- 	["2"] = { -389.98,-1873.84,19.85,215.44  },
	-- 	["3"] = { -387.78,-1871.92,19.85,221.11  },
	-- },
	["181"] = { x = 392.17, y = -1603.83, z = 29.28,
		["1"] = { 392.89,-1608.18,28.61,48.19  },
		["2"] = { 390.73,-1610.28,28.61,48.19  },
		["3"] = { 388.62,-1612.66,28.61,48.19  },
	},
	["182"] = { x = -581.81, y = 192.8, z = 71.39,
		["1"] = { -588.97,194.17,71.09,90.71  },
		["2"] = { -588.8,197.37,71.19,90.71 },
		["3"] = { -588.39,191.28,71.04,90.71  },
	},
	["183"] = { x = 2414.7, y = 5043.92, z = 45.98,
		["1"] = { 2415.3,5038.92,45.17,127.56  }
	},
	["184"] = { x = -10.1, y = -669.57, z = 32.44,     
		["1"] = { -4.86,-671.6,31.95,189.93 }
	},
	["185"] = { x = 1557.14, y = 826.92, z = 77.14,     
		["1"] = { 1558.58,821.42,76.87,195.6 },
		["2"] = { 1555.8,817.3,76.87,195.6 }
	},
	["186"] = { x = 1566.1, y = 834.9, z = 77.14,     
		["1"] = { 1563.14,844.9,77.51,240.95 }
	},
	["187"] = { x = -501.44, y = -207.03, z = 36.8,     
		["1"] = { -493.76,-207.19,36.58,331.66 }
	},
	["188"] = { x = 2323.39, y = 2566.95, z = 46.66,     
		["1"] = { 2316.36,2573.35,46.39,269.3 }
	},
	["189"] = { x = -1183.83, y = -2319.21, z = 14.42,     
		["1"] = { -1180.49,-2314.41,14.15,331.66 },
		["2"] = { -1178.53,-2315.94,14.15,334.49 }

		
	},
	["190"] = { x = -908.59, y = -2038.97, z = 9.4,     
		["1"] = { -905.09,-2042.58,9.03,223.94 },
		["2"] = { -901.91,-2040.77,9.03,226.78 }

		
	},
	["191"] = { x = 1812.56, y = 3597.06, z = 36.38,     
		["1"] = { 1818.06,3595.43,36.38,113.39 },
		["2"] = { 1824.28,3598.46,36.38,110.56 }

		
	},
	["192"] = { x = 2629.13, y = 5324.85, z = 45.46,     
		["1"] = { 2625.21,5327.42,45.19,198.43 },
		["2"] = { 2622.04,5326.53,45.19,198.43 }

		
	},
	["193"] = { x = 74.5, y = 6524.72, z = 32.33,     
		["1"] = { 75.75,6519.95,32.07,226.78 },
		["2"] = { 73.11,6517.73,32.07,226.78 }

		
	},
	["194"] = { x = 2138.25, y = 3877.13, z = 33.94,     
		["1"] = { 2134.78,3875.2,33.58,212.6 },
		["2"] = { 2131.86,3873.63,33.58,212.6 }

		
	},
	

	
	
}


-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function VehicleMods(Vehicle,Customize)
	if Customize then
		SetVehicleModKit(Vehicle,0)

		if Customize["wheeltype"] ~= nil then
			SetVehicleWheelType(Vehicle,Customize["wheeltype"])
		end

		if Customize["mods"] then
			for i = 0,16 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 17,22 do
				if Customize["mods"][tostring(i)] ~= nil then
					ToggleVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end

			for i = 23,24 do
				if Customize["mods"][tostring(i)] ~= nil then
					if not Customize["var"] then
						Customize["var"] = {}
						Customize["var"][tostring(i)] = 0
					end

					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)],Customize["var"][tostring(i)])
				end
			end

			for i = 25,48 do
				if Customize["mods"][tostring(i)] ~= nil then
					SetVehicleMod(Vehicle,i,Customize["mods"][tostring(i)])
				end
			end
		end

		if Customize["neon"] ~= nil then
			for i = 0,3 do
				SetVehicleNeonLightEnabled(Vehicle,i,Customize["neon"][tostring(i)])
			end
		end

		if Customize["extras"] ~= nil then
			for i = 1,12 do
				local onoff = tonumber(Customize["extras"][i])
				if onoff == 1 then
					SetVehicleExtra(Vehicle,i,0)
				else
					SetVehicleExtra(Vehicle,i,1)
				end
			end
		end

		if Customize["liverys"] ~= nil and Customize["liverys"] ~= 24  then
			SetVehicleLivery(Vehicle,Customize["liverys"])
		end

		if Customize["plateIndex"] ~= nil and Customize["plateIndex"] ~= 4 then
			SetVehicleNumberPlateTextIndex(Vehicle,Customize["plateIndex"])
		end

		SetVehicleXenonLightsColour(Vehicle,Customize["xenonColor"])
		SetVehicleColours(Vehicle,Customize["colors"][1],Customize["colors"][2])
		SetVehicleExtraColours(Vehicle,Customize["extracolors"][1],Customize["extracolors"][2])
		SetVehicleNeonLightsColour(Vehicle,Customize["lights"][1],Customize["lights"][2],Customize["lights"][3])
		SetVehicleTyreSmokeColor(Vehicle,Customize["smokecolor"][1],Customize["smokecolor"][2],Customize["smokecolor"][3])

		if Customize["tint"] ~= nil then
			SetVehicleWindowTint(Vehicle,Customize["tint"])
		end

		if Customize["dashColour"] ~= nil then
			SetVehicleInteriorColour(Vehicle,Customize["dashColour"])
		end

		if Customize["interColour"] ~= nil then
			SetVehicleDashboardColour(Vehicle,Customize["interColour"])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Blip Garages
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 999
        if LocalPlayer["state"]["Route"] < 900000 then
            local Ped = PlayerPedId()
            if not IsPedInAnyVehicle(Ped) then
                local Coords = GetEntityCoords(Ped)

                for Number,v in pairs(Garages) do
                    local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
                    if Distance <= 15.0 then
                        TimeDistance = 1
                        DrawMarker(1,v["x"],v["y"],v["z"] - 1.0,0.0,0.0,0.0,0.0,0.0,0.0,1.00,1.00,1.00,255,0,0,100,0,0,0,10)
                    end
                end
            end
        end

        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SpawnPosition(Select)
	local Slot = "0"
	local Checks = 0
	local Selected = {}
	local Position = nil

	repeat
		Checks = Checks + 1

		Slot = tostring(Checks)
		if Garages[Select][Slot] ~= nil then
			local _,Groundz = GetGroundZAndNormalFor_3dCoord(Garages[Select][Slot][1],Garages[Select][Slot][2],Garages[Select][Slot][3])
			Selected = { Garages[Select][Slot][1],Garages[Select][Slot][2],Groundz,Garages[Select][Slot][4] }
			Position = GetClosestVehicle(Selected[1],Selected[2],Selected[3],2.501,0,71)
		end
	until not DoesEntityExist(Position) or not Garages[Select][Slot]

	if not Garages[Select][tostring(Checks)] then
		TriggerEvent("Notify","amarelo","Vagas estão ocupadas.",5000)
		return false
	end

	return Selected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CreateVehicle(Model,Network,Engine,Health,Customize,Windows,Tyres)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if Customize ~= nil then
				local Mods = json.decode(Customize)
				VehicleMods(Vehicle,Mods)
			end

			SetVehicleEngineHealth(Vehicle,Engine + 0.0)
			SetEntityHealth(Vehicle,Health)

			if Windows then
				local Windows = json.decode(Windows)
				if Windows ~= nil then
					for k,v in pairs(Windows) do
						if not v then
							RemoveVehicleWindow(Vehicle,parseInt(k))
						end
					end
				end
			end

			if Tyres then
				local Tyres = json.decode(Tyres)
				if Tyres ~= nil then
					for k,Burst in pairs(Tyres) do
						if Burst then
							SetVehicleTyreBurst(Vehicle,parseInt(k),true,1000.0)
						end
					end
				end
			end

			if Model == "maverick2" then
				if LocalPlayer["state"]["Police"] then
					SetVehicleLivery(Vehicle,0)
				elseif LocalPlayer["state"]["Paramedic"] then
					SetVehicleLivery(Vehicle,1)
				end
			end

			if not DecorExistOn(Vehicle,"PlayerVehicle") then
				DecorSetInt(Vehicle,"PlayerVehicle",-1)
			end

			SetModelAsNoLongerNeeded(Model)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Delete")
AddEventHandler("garages:Delete",function(Vehicle)
	if not Vehicle or Vehicle == "" then
		Vehicle = vRP.ClosestVehicle(15)
	end

	if IsEntityAVehicle(Vehicle) then
		local Tyres = {}
		local Doors = {}
		local Windows = {}

		for i = 0,5 do
			Doors[i] = IsVehicleDoorDamaged(Vehicle,i)
		end

		for i = 0,5 do
			Windows[i] = IsVehicleWindowIntact(Vehicle,i)
		end

		for i = 0,7 do
			local Status = false

			if GetTyreHealth(Vehicle,i) ~= 1000.0 then
				Status = true
			end

			Tyres[i] = Status
		end

		if DecorExistOn(Vehicle,"PlayerVehicle") then
			DecorRemove(Vehicle,"PlayerVehicle")
		end

		vSERVER.Delete(VehToNet(Vehicle),GetEntityHealth(Vehicle),GetVehicleEngineHealth(Vehicle),GetVehicleBodyHealth(Vehicle),GetVehicleFuelLevel(Vehicle),Doors,Windows,Tyres,GetVehicleNumberPlateText(Vehicle))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHBLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.SearchBlip(Coords)
	if DoesBlipExist(Searched) then
		RemoveBlip(Searched)
		Searched = nil
	end

	Searched = AddBlipForCoord(Coords["x"],Coords["y"],Coords["z"])
	SetBlipSprite(Searched,225)
	SetBlipColour(Searched,2)
	SetBlipScale(Searched,0.6)
	SetBlipAsShortRange(Searched,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(Searched)

	SetTimeout(30000,function()
		RemoveBlip(Searched)
		Searched = nil
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StartHotwired()
	Hotwired = true

	if LoadAnim(Dict) then
		TaskPlayAnim(PlayerPedId(),Dict,Anim,8.0,8.0,-1,49,5.0,0,0,0)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.StopHotwired(Vehicle)
	Hotwired = false

	if LoadAnim(Dict) then
		StopAnimTask(PlayerPedId(),Dict,Anim,8.0)
	end

	if Vehicle then
		SetEntityAsMissionEntity(Vehicle,true,false)
		SetVehicleHasBeenOwnedByPlayer(Vehicle,true)
		SetVehicleNeedsToBeHotwired(Vehicle,false)

		if not DecorExistOn(Vehicle,"PlayerVehicle") then
			DecorSetInt(Vehicle,"PlayerVehicle",-1)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.UpdateHotwired(Status)
	Hotwired = Status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOOPHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] == 0 then
			local Ped = PlayerPedId()
			if IsPedInAnyVehicle(Ped) then
				local Vehicle = GetVehiclePedIsUsing(Ped)
				local Plate = GetVehicleNumberPlateText(Vehicle)
				if GetPedInVehicleSeat(Vehicle,-1) == Ped and not GlobalState["Plates"][Plate] then
					SetVehicleEngineOn(Vehicle,false,true,true)
					DisablePlayerFiring(Ped,true)
					TimeDistance = 1
				end

				if Hotwired and Vehicle then
					DisableControlAction(1,75,true)
					DisableControlAction(1,20,true)
					TimeDistance = 1
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound",function()
	local Impound = vSERVER.Impound()
	if parseInt(#Impound) > 0 then
		for k,v in pairs(Impound) do
			exports["dynamic"]:AddButton(v["name"],"Clique para iniciar a liberação.","garages:Impound",v["Model"],false,true)
		end

		exports["dynamic"]:openMenu()
	else
		TriggerEvent("Notify","amarelo","Não possui veículos apreendidos.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for Number,v in pairs(Garages) do
					local Distance = #(Coords - vec3(v["x"],v["y"],v["z"]))
					if Distance <= 1.25 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) then
							if not vSERVER.canOpen() then TimeDistance = 1000 goto continue end

							local Vehicles = vSERVER.Vehicles(Number)
							if Vehicles then
								exports["dynamic"]:AddButton("Guardar","Guardar o veículo mais próximo.","garages:Delete","",false,false)

								if parseInt(#Vehicles) > 0 then
									for _,v in pairs(Vehicles) do
										exports["dynamic"]:AddButton("Pegar","Clique para pega-lo na garagem.","garages:Spawn",v["Model"].."-"..Number,v["Model"],true)
										exports["dynamic"]:AddButton("Taxas","Clique para o pagamento das taxas.","garages:Tax",v["Model"],v["Model"],true)
										exports["dynamic"]:AddButton("Vender","Clique para o vender o veículo.","garages:Sell",v["Model"],v["Model"],true)
										--exports["dynamic"]:AddButton("Transferência","Clique para transferir a outra pessoa.","garages:Transfer",v["Model"],v["Model"],true)

										exports["dynamic"]:SubMenu(v["name"],"Todas as funções do veículo.",v["Model"])
									end
								end

								exports["dynamic"]:openMenu()
							end
						end
					end
				end
			end
		end
		
		::continue::
		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Table)
	for Name,v in pairs(Table) do
		Garages[Name] = {
			["x"] = v["x"],
			["y"] = v["y"],
			["z"] = v["z"],
			["1"] = v["1"]
		}
	end
end)