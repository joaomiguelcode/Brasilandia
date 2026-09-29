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
Tunnel.bindInterface("doors",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Doors"] = {
	[1] = { Coords = vec3(-366.42,-354.63,31.66), Hash = -1603028996, Lock = true, Distance = 1.5, Perm = "Police" },
	[2] = { Coords = vec3(-367.0,-356.14,31.66), Hash = -1603028996, Lock = true, Distance = 1.5, Perm = "Police" },
	[3] = { Coords = vec3(1560.51,833.53,77.66), Hash = -1603817716, Lock = true, Distance = 7, Perm = "Police" },
	[4] = { Coords = vec3(1564.65,831.16,77.64), Hash = -1603817716, Lock = true, Distance = 1.5, Perm = "Police" },
	[5] = { Coords = vec3(1562.99,828.55,77.64), Hash = -1603817716, Lock = true, Distance = 1.5, Perm = "Police" },
	[6] = { Coords = vec3(1559.07,830.96,77.66), Hash = -1603817716, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [7] = { Coords = vec3(480.91,-1012.18,26.48), Hash = -53345114, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [8] = { Coords = vec3(483.91,-1012.18,26.48), Hash = -53345114, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [9] = { Coords = vec3(486.91,-1012.18,26.48), Hash = -53345114, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [10] = { Coords = vec3(484.17,-1007.73,26.48), Hash = -53345114, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [11] = { Coords = vec3(440.52,-977.60,30.82), Hash = 2888281650, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [12] = { Coords = vec3(440.52,-986.23,30.82), Hash = 4198287975, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [13] = { Coords = vec3(479.75,-999.62,30.78), Hash = -692649124, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [14] = { Coords = vec3(487.43,-1000.18,30.78), Hash = -692649124, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [15] = { Coords = vec3(467.36,-1014.40,26.48), Hash = -692649124, Lock = true, Distance = 1.5, Perm = "Police", Other = 16 },
	-- [16] = { Coords = vec3(469.77,-1014.40,26.48), Hash = -692649124, Lock = true, Distance = 1.5, Perm = "Police", Other = 15 },
	-- [17] = { Coords = vec3(440.73,-998.74,30.81), Hash = -1547307588, Lock = true, Distance = 1.5, Perm = "Police", Other = 18 },
	-- [18] = { Coords = vec3(443.06,-998.74,30.81), Hash = -1547307588, Lock = true, Distance = 1.5, Perm = "Police", Other = 17 },
	-- [19] = { Coords = vec3(458.20,-972.25,30.81), Hash = -1547307588, Lock = true, Distance = 1.5, Perm = "Police", Other = 20 },
	-- [20] = { Coords = vec3(455.88,-972.25,30.81), Hash = -1547307588, Lock = true, Distance = 1.5, Perm = "Police", Other = 19 },
	[21] = { Coords = vec3(1844.99,2604.81,44.63), Hash = 741314661, Lock = true, Distance = 7, Perm = "Emergency" },
	[22] = { Coords = vec3(1818.54,2604.40,44.61), Hash = 741314661, Lock = true, Distance = 7, Perm = "Emergency" },
	-- [23] = { Coords = vec3(1837.91,2590.25,46.19), Hash = 539686410, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [24] = { Coords = vec3(1768.54,2498.41,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [25] = { Coords = vec3(1765.40,2496.59,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [26] = { Coords = vec3(1762.25,2494.77,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [27] = { Coords = vec3(1755.96,2491.14,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [28] = { Coords = vec3(1752.81,2489.33,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [29] = { Coords = vec3(1749.67,2487.51,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [30] = { Coords = vec3(1758.07,2475.39,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [31] = { Coords = vec3(1761.22,2477.20,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [32] = { Coords = vec3(1764.36,2479.02,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [33] = { Coords = vec3(1767.51,2480.84,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [34] = { Coords = vec3(1770.66,2482.65,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [35] = { Coords = vec3(1773.80,2484.47,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [36] = { Coords = vec3(1776.95,2486.29,45.88), Hash = 913760512, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [37] = { Coords = vec3(383.40,798.29,187.61), Hash = 517369125, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [38] = { Coords = vec3(382.96,796.82,187.61), Hash = 517369125, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [39] = { Coords = vec3(378.75,796.83,187.61), Hash = 517369125, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [40] = { Coords = vec3(398.15,-1607.52,28.34), Hash = 1286535678, Lock = true, Distance = 7, Perm = "Police" },
	-- -- [41] = { Coords = vec3(413.09,-1619.81,28.34), Hash = -1483471451, Lock = true, Distance = 7, Perm = "Police" },
	-- -- [42] = { Coords = vec3(418.54,-1651.08,28.29), Hash = -1483471451, Lock = true, Distance = 7, Perm = "Police" },
	-- [43] = { Coords = vec3(1861.75,3687.30,33.01), Hash = 1286535678, Lock = true, Distance = 7, Perm = "Police" },
	-- [51] = { Coords = vec3(369.06,-1605.68,29.94), Hash = -674638964, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [52] = { Coords = vec3(368.26,-1605.01,29.94), Hash = -674638964, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [53] = { Coords = vec3(375.07,-1598.43,25.34), Hash = -674638964, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [54] = { Coords = vec3(375.87,-1599.10,25.34), Hash = -674638964, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [61] = { Coords = vec3(1813.55,3675.05,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [62] = { Coords = vec3(1810.13,3676.46,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [63] = { Coords = vec3(1808.62,3679.06,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [64] = { Coords = vec3(1807.13,3681.66,34.39), Hash = 2010487154, Lock = true, Distance = 1.5, Perm = "Police" },
	-- [65] = { Coords = vec3(391.86,-1636.07,29.97), Hash = -1156020871, Lock = true, Distance = 1.5, Perm = "Police" },
	-- Hospital
	[71] = { Coords = vec3(309.14,-597.75,43.44), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[72] = { Coords = vec3(307.11,-569.56,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[73] = { Coords = vec3(336.16,-580.14,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[74] = { Coords = vec3(340.78,-581.82,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[75] = { Coords = vec3(346.77,-584.00,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[76] = { Coords = vec3(339.00,-586.70,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[77] = { Coords = vec3(360.50,-588.99,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[78] = { Coords = vec3(358.72,-593.88,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[79] = { Coords = vec3(352.19,-594.14,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[80] = { Coords = vec3(350.83,-597.89,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[81] = { Coords = vec3(345.51,-597.35,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[82] = { Coords = vec3(346.88,-593.59,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[83] = { Coords = vec3(356.12,-583.36,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[84] = { Coords = vec3(357.49,-579.61,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[85] = { Coords = vec3(303.95,-572.55,43.43), Hash = 854291622, Lock = true, Distance = 1.5, Perm = "Paramedic" },
	[86] = { Coords = vec3(324.24,-589.22,43.44), Hash = -434783486, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 87 },
	[87] = { Coords = vec3(326.66,-590.1,43.44), Hash = -1700911976, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 86 },
	[88] = { Coords = vec3(312.00,-571.34,43.43), Hash = -434783486, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 89 },
	[89] = { Coords = vec3(314.42,-572.22,43.43), Hash = -1700911976, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 88 },
	[90] = { Coords = vec3(317.84,-573.46,43.43), Hash = -434783486, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 91 },
	[91] = { Coords = vec3(320.26,-574.34,43.43), Hash = -1700911976, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 90 },
	[92] = { Coords = vec3(323.23,-575.42,43.43), Hash = -434783486, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 93 },
	[93] = { Coords = vec3(325.65,-576.30,43.43), Hash = -1700911976, Lock = true, Distance = 1.5, Perm = "Paramedic", Other = 92 },


	--Bennys
	[94] = { Coords = vec3(823.82,-2091.0,29.74), Hash = 1211775065, Lock = true, Distance = 7, Perm = "Bennys"},
	[95] = { Coords = vec3(820.79,-2114.04,29.44), Hash = 894997194, Lock = true, Distance = 7, Perm = "Bennys"},
	[96] = { Coords = vec3(812.83,-2113.41,29.44), Hash = 894997194, Lock = true, Distance = 7, Perm = "Bennys"},

	--Mecanica
	-- [97] = { Coords = vec3(948.53,-965.35,39.65), Hash = 1289778077, Lock = true, Distance = 1.5, Perm = "Mechanic"},
	-- [98] = { Coords = vec3(955.36,-972.44,39.65), Hash = -626684119, Lock = true, Distance = 1.5, Perm = "Mechanic"},
	-- [99] = { Coords = vec3(945.94,-985.62,41.93), Hash = -983965772, Lock = false, Distance = 10, Perm = "Mechanic"},


	--Favelas Norte
	--[101] = { Coords = vec3(-296.24,1845.12,197.98), Hash = 1173348778, Lock = true, Distance = 1.5, Perm = "Redencao"},
	-- [102] = { Coords = vec3(2146.54,4014.26,35.63), Hash = -1987474252, Lock = true, Distance = 1.5, Perm = "Coiote"},



	-- DP Norte
	-- [103] = { Coords = vec3(-442.24,6012.62,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [104] = { Coords = vec3(-443.39,6015.44,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [105] = { Coords = vec3(-446.36,6018.41,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [106] = { Coords = vec3(-448.91,6015.86,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [107] = { Coords = vec3(-445.94,6012.89,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [108] = { Coords = vec3(-443.64,6006.98,27.74), Hash = -594854737, Lock = true, Distance = 1.5, Perm = "Police"},



	-- [109] = { Coords = vec3(-448.07,6004.87,32.29), Hash = 1857649811, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [110] = { Coords = vec3(-446.65,6003.46,32.29), Hash = 1362051455, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [111] = { Coords = vec3(-453.48,5996.64,32.29), Hash = 965382714, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [112] = { Coords = vec3(-454.9,5998.06,32.29), Hash = 733214349, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [113] = { Coords = vec3(-443.95,6017.17,32.29), Hash = 1362051455, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [114] = { Coords = vec3(1829.86,3673.79,34.29), Hash = -1264811159, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [115] = { Coords = vec3(1838.01,3677.11,34.29), Hash = 1364638935, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [116] = { Coords = vec3(1830.66,3676.57,34.29), Hash = -1264811159, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [117] = { Coords = vec3(1823.87,3681.12,34.34), Hash = -1501157055, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [118] = { Coords = vec3(1831.35,2595.0,46.04), Hash = -684929024, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [119] = { Coords = vec3(1791.6,2551.47,45.76), Hash = 1373390714, Lock = true, Distance = 1.5, Perm = "Police"},
	-- [119] = { Coords = vec3(1765.12,2566.53,45.81), Hash = 1373390714, Lock = true, Distance = 1.5, Perm = "Police"},

	-- Guetos Sul
	-- [120] = { Coords = vec3(109.14,-1975.46,21.17), Hash = 1184805384, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [121] = { Coords = vec3(106.52,-1976.44,21.17), Hash = 1947176169, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [122] = { Coords = vec3(104.63,-1977.14,21.07), Hash = 1122314606, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [123] = { Coords = vec3(111.44,-1979.29,21.06), Hash = -1730259609, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [124] = { Coords = vec3(-1.87,-1808.82,25.55), Hash = -1351120742, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [125] = { Coords = vec3(-6.94,-1819.73,29.35), Hash = 373216819, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [131] = { Coords = vec3(0.21,-1823.3,29.74), Hash = -1052955611, Lock = true, Distance = 1.5, Perm = "Ballas"},
	-- [126] = { Coords = vec3(324.72,-1991.08,24.37), Hash = 2118614536, Lock = true, Distance = 1.5, Perm = "Vagos"},
	-- [127] = { Coords = vec3(336.75,-1991.84,24.37), Hash = 2118614536, Lock = true, Distance = 1.5, Perm = "Vagos"},
	-- [128] = { Coords = vec3(-152.02,-1622.64,33.84), Hash = 1381046002, Lock = true, Distance = 1.5, Perm = "Families"},

	--Hospital Phillbox
	[129] = { Coords = vec3(330.15,-561.79,30.36), Hash = -820650556, Lock = true, Distance = 7, Perm = "Paramedic"},
	[130] = { Coords = vec3(337.29,-564.42,29.82), Hash = -820650556, Lock = true, Distance = 7, Perm = "Paramedic"},
	-- Bennys
	-- [132] = { Coords = vec3(-230.69,-1315.14,31.46), Hash = -147325430, Lock = true, Distance = 7, Perm = "Bennys"},

	-- BurgerShot
	[134] = { Coords = vec3(-1181.35,-886.29,13.88), Hash = -1890974902, Lock = true, Distance = 1.5, Perm = "BurgerShot"},
	[135] = { Coords = vec3(-1181.35,-886.29,13.88), Hash = 1143532813, Lock = true, Distance = 1.5, Perm = "BurgerShot"},
	[136] = { Coords = vec3(-1197.92,-904.58,13.88), Hash = 1465287574, Lock = true, Distance = 1.5, Perm = "BurgerShot"},

	[137] = { Coords = vec3(1131.08,-474.3,66.71), Hash = -2023754432, Lock = true, Distance = 1.5, Perm = "Digitalden"},
		

	-- Portas HP
	[140] = { Coords = vec3(303.61,-581.74,43.29), Hash = -434783486, Lock = false, Distance = 1.5, Perm = "Paramedic", Other = 141 },
	[141] = { Coords = vec3(304.44,-582.13,43.29), Hash = -1700911976, Lock = false, Distance = 1.5, Perm = "Paramedic", Other = 140 },
	[142] = { Coords = vec3(317.78,-579.03,43.44), Hash = -434783486, Lock = false, Distance = 1.5, Perm = "Paramedic", Other = 143 },
	[143] = { Coords = vec3(316.82,-578.75,43.29), Hash = -1700911976, Lock = false, Distance = 1.5, Perm = "Paramedic", Other = 142 },
	[144] = { Coords = vec3(313.49,-595.45,43.44), Hash = 854291622, Lock = false, Distance = 1.5, Perm = "Paramedic" },

	[145] = { Coords = vec3(164.27,-1317.75,29.37), Hash = -538477509, Lock = true, Distance = 1.5, Perm = "Pawnshop" },
	[146] = { Coords = vec3(161.2,-1307.74,29.39), Hash = -397082484, Lock = true, Distance = 1.5, Perm = "Pawnshop" },

	
	
	-- Portas Rogers
	[147] = { Coords = vec3(-608.72,-1610.31,27.16), Hash = 1099436502, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 148 },
	[148] = { Coords = vec3(-611.32,-1610.08,27.16), Hash = -1627599682, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 147 },
	[149] = { Coords = vec3(-592.93,-1631.57,27.16), Hash = 1099436502, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 150 },
	[150] = { Coords = vec3(-592.71,-1628.98,27.16), Hash = -1627599682, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 149 },
	[151] = { Coords = vec3(-605.7,-1612.19,27.17), Hash = 362975687, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 152 },
	[152] = { Coords = vec3(-603.11,-1612.42,27.17), Hash = 362975687, Lock = true, Distance = 1.5, Perm = "Rogers", Other = 151 },



	-- [153] = { Coords = vec3(1978.0,3844.02,31.05), Hash = -1453580247, Lock = true, Distance = 10, Perm = "Renegados" },
	-- [154] = { Coords = vec3(1947.29,3858.86,31.03), Hash = -1453580247, Lock = true, Distance = 10, Perm = "Renegados" },
	-- [155] = { Coords = vec3(1928.06,3848.83,31.2), Hash = -1453580247, Lock = true, Distance = 10, Perm = "Renegados" },
	-- [156] = { Coords = vec3(1951.33,3842.64,32.35), Hash = 434562625, Lock = true, Distance = 1.5, Perm = "Renegados" },
	-- [157] = { Coords = vec3(1952.62,3840.39,32.35), Hash = 434562625, Lock = true, Distance = 1.5, Perm = "Renegados" },
	-- [158] = { Coords = vec3(1952.58,3824.27,33.03), Hash = 3665713, Lock = true, Distance = 1.5, Perm = "Renegados" },
	-- [159] = { Coords = vec3(1941.7,3843.23,35.93), Hash = 434562625, Lock = true, Distance = 1.5, Perm = "Renegados" },

	-- [160] = { Coords = vec3(1250.23,-1583.8,54.74), Hash = -955445187, Lock = true, Distance = 1.5, Perm = "Cripz" },
	-- [161] = { Coords = vec3(1251.98,-1569.28,58.94), Hash = -658590816, Lock = true, Distance = 1.5, Perm = "Cripz" },


	[166] = { Coords = vec3(2520.69,4124.04,38.59), Hash = 497665568, Lock = true, Distance = 1.5, Perm = "Thelost", Other = 167 },
	[167] = { Coords = vec3(2508.0,4094.81,38.59), Hash = -626684119, Lock = true, Distance = 1.5, Perm = "Thelost", Other = 166 },
	[168] = { Coords = vec3(2512.95,4104.74,38.59), Hash = -626684119, Lock = true, Distance = 1.5, Perm = "Thelost" },
	[169] = { Coords = vec3(-35.56,2872.12,59.61), Hash = -1083130717, Lock = true, Distance = 5, Perm = "Tijuana" },

	[170] = { Coords = vec3(-561.28,293.51,87.78), Hash = 993120320, Lock = true, Distance = 1.5, Perm = "Tequila" },
	[171] = { Coords = vec3(-565.17,276.63,83.29), Hash = 993120320, Lock = true, Distance = 1.5, Perm = "Tequila" },
	[172] = { Coords = vec3(-560.23,293.02,82.33), Hash = -626684119, Lock = true, Distance = 1.5, Perm = "Tequila" },
	[173] = { Coords = vec3(-567.92,290.77,79.33), Hash = -2023754432, Lock = true, Distance = 1.5, Perm = "Tequila" },
	[174] = { Coords = vec3(1987.42,3046.96,50.28), Hash = -1346995970, Lock = true, Distance = 1.5, Perm = "Tequila" },

	-- [138] = { Coords = vec3(1247.09,-355.61,69.23), Hash = -1265474312, Lock = true, Distance = 1.5, Perm = "Hornys"},
	-- [139] = { Coords = vec3(1242.45,-353.73,69.23), Hash = 1358044601, Lock = true, Distance = 1.5, Perm = "Hornys"},
	-- [175] = { Coords = vec3(1246.3,-350.56,69.23), Hash = -147325430, Lock = true, Distance = 1.5, Perm = "Hornys"},

	[176] = { Coords = vec3(-1887.9,2051.39,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 177},
	[177] = { Coords = vec3(-1890.22,2052.24,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 176},
	[178] = { Coords = vec3(-1887.53,2051.24,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 179},
	[179] = { Coords = vec3(-1885.21,2050.38,141.31), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 178},
	[180] = { Coords = vec3(-1884.92,2073.47,141.31), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 181},
	[181] = { Coords = vec3(-1887.24,2074.31,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 180},
	[182] = { Coords = vec3(-1875.61,2070.07,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 183},
	[183] = { Coords = vec3(-1873.29,2069.22,141.31), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 182},
	[184] = { Coords = vec3(-1894.72,2075.97,141.32), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 185},
	[185] = { Coords = vec3(-1892.83,2074.39,141.31), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 184},
	[186] = { Coords = vec3(-1898.51,2082.86,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 187},
	[187] = { Coords = vec3(-1900.4,2084.45,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 186},
	[188] = { Coords = vec3(-1900.99,2084.95,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 189},
	[189] = { Coords = vec3(-1902.88,2086.55,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 188},
	[190] = { Coords = vec3(-1905.99,2085.63,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 191},
	[191] = { Coords = vec3(-1907.59,2083.75,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 190},
	[192] = { Coords = vec3(-1910.2,2080.68,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 193},
	[193] = { Coords = vec3(-1911.81,2078.8,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 192},
	[194] = { Coords = vec3(-1912.1,2075.57,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 195},
	[195] = { Coords = vec3(-1910.2,2073.97,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 194},
	[196] = { Coords = vec3(-1909.62,2073.48,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 197},
	[197] = { Coords = vec3(-1907.73,2071.88,140.92), Hash = 1843224684, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 186},
	[198] = { Coords = vec3(-1861.68,2054.12,141.36), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 199},
	[199] = { Coords = vec3(-1859.21,2054.12,141.36), Hash = 1077118233, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 198},
	[200] = { Coords = vec3(-1864.19,2059.9,141.15), Hash = -1141522158, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 201},
	[201] = { Coords = vec3(-1864.21,2061.27,141.15), Hash = 988364535, Lock = true, Distance = 1.5, Perm = "Cosanostra", Other = 200},

	[202] = { Coords = vec3(493.08,-1541.83,29.45), Hash = 903896222, Lock = true, Distance = 1.5, Perm = "Bloods"},
	[203] = { Coords = vec3(486.02,-1530.39,29.45), Hash = 2103001488, Lock = true, Distance = 1.5, Perm = "Bloods"},

	[204] = { Coords = vec3(-587.34,-1051.89,22.42), Hash = -1283712428, Lock = true, Distance = 1.5, Perm = "Uwucoffee"},
	[205] = { Coords = vec3(-600.91,-1059.21,22.8), Hash = 522844070, Lock = true, Distance = 5, Perm = "Uwucoffee"},
	[206] = { Coords = vec3(-600.88,-1055.13,22.72), Hash = 1099436502, Lock = true, Distance = 1.5, Perm = "Uwucoffee"},
	[207] = { Coords = vec3(-575.01,-1063.78,26.77), Hash = 2089009131, Lock = true, Distance = 1.5, Perm = "Uwucoffee"},
	[208] = { Coords = vec3(-575.01,-1062.38,26.77), Hash = 2089009131, Lock = true, Distance = 1.5, Perm = "Uwucoffee"},
	[209] = { Coords = vec3(106.08,-1979.92,20.96), Hash = 1173348778, Lock = true, Distance = 1.5, Perm = "Ballas"},

	[210] = { Coords = vec3(-1817.44,428.56,132.62), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 211},
	[211] = { Coords = vec3(-1815.43,428.56,132.62), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 210},
	[212] = { Coords = vec3(-1817.44,423.65,128.71), Hash = 1314286287, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 213},
	[213] = { Coords = vec3(-1814.44,423.65,128.71), Hash = 1314286287, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 212},
	[214] = { Coords = vec3(-1813.16,445.97,128.73), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 215},
	[215] = { Coords = vec3(-1813.16,447.98,128.73), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 214},
	[216] = { Coords = vec3(-1805.54,436.23,129.23), Hash = 1558415341, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 217},
	[217] = { Coords = vec3(-1804.33,436.23,129.23), Hash = 1558415341, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 216},
	[218] = { Coords = vec3(-1788.57,433.88,128.49), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 219},
	[219] = { Coords = vec3(-1788.57,435.88,128.49), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia", Other = 218},
	[220] = { Coords = vec3(-1792.21,424.5,128.61), Hash = -610054759, Lock = true, Distance = 1.5, Perm = "Mafia"},

	[221] = { Coords = vec3(-320.5,-105.45,38.02), Hash = 758463511, Lock = true, Distance = 1.5, Perm = "LSCustoms", Other = 222},
	[222] = { Coords = vec3(-325.67,-103.57,38.02), Hash = 2134335554, Lock = true, Distance = 1.5, Perm = "LSCustoms", Other = 221},
	[223] = { Coords = vec3(-386.89,-1884.19,22.2), Hash = -1098702270, Lock = true, Distance = 10, Perm = "Admin", Other = 224},
	[224] = { Coords = vec3(-375.96,-1878.89,22.37), Hash = -1098702270, Lock = true, Distance = 10, Perm = "Admin", Other = 223},


	[225] = { Coords = vec3(-1805.38,428.95,129.14), Hash = -627047580, Lock = true, Distance = 1.5, Perm = "Mafia"},
	[226] = { Coords = vec3(-1804.17,428.95,129.14), Hash = -627047580, Lock = true, Distance = 1.5, Perm = "Mafia"},
	[227] = { Coords = vec3(-1799.03,470.64,133.96), Hash = 546378757, Lock = true, Distance = 10, Perm = "Mafia", Other = 228},
	[228] = { Coords = vec3(-1801.69,475.45,133.97), Hash = -1249591818, Lock = true, Distance = 10, Perm = "Mafia", Other = 227},
	[229] = { Coords = vec3(-1798.23,468.83,133.78), Hash = 1100960097, Lock = true, Distance = 1.5, Perm = "Mafia"},
	[230] = { Coords = vec3(-1801.67,411.85,128.52), Hash = 724862427, Lock = true, Distance = 1.5, Perm = "Mafia"},


	[231] = { Coords = vec3(-14.86,-1441.18,31.2), Hash = 520341586, Lock = true, Distance = 1.5, Perm = "Families"},
	[232] = { Coords = vec3(-25.27,-1431.01,31.45), Hash = 703855057, Lock = true, Distance = 1.5, Perm = "Families"},

	-- [233] = { Coords = vec3(-308.9,6272.31,31.87), Hash = -1671830748, Lock = true, Distance = 1.5, Perm = "HenHouse"},
	-- [234] = { Coords = vec3(-300.04,6257.8,31.93), Hash = 1286502769, Lock = true, Distance = 1.5, Perm = "HenHouse", Other = 235},
	-- [235] = { Coords = vec3(-302.0,6255.96,31.93), Hash = 633547679, Lock = true, Distance = 1.5, Perm = "HenHouse", Other = 234},
	-- [236] = { Coords = vec3(-298.16,6272.9,31.87), Hash = -1671830748, Lock = true, Distance = 1.5, Perm = "HenHouse"},
	-- [237] = { Coords = vec3(-301.8,6271.45,31.67), Hash = 1743859485, Lock = true, Distance = 1.5, Perm = "HenHouse"},
	-- [238] = { Coords = vec3(-297.45,6266.32,34.98), Hash = 1901183774, Lock = true, Distance = 1.5, Perm = "HenHouse"},
	-- [239] = { Coords = vec3(-304.25,6288.11,31.98), Hash = -1671830748, Lock = true, Distance = 1.5, Perm = "HenHouse"},

	-- [240] = { Coords = vec3(1697.07,4753.26,40.95), Hash = -1591814513, Lock = true, Distance = 5, Perm = "Yellow" },
	-- [241] = { Coords = vec3(1698.42,4760.85,42.2), Hash = 1018270732, Lock = true, Distance = 1.5, Perm = "Yellow" },
	-- [242] = { Coords = vec3(1700.19,4766.2,42.15), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Yellow" },
	-- [243] = { Coords = vec3(1709.33,4761.74,42.19), Hash = 1018270732, Lock = true, Distance = 1.5, Perm = "Yellow" },

	-- [244] = { Coords = vec3(113.7,6843.88,17.43), Hash = 1173348778, Lock = true, Distance = 1.5, Perm = "Trem" },
	[245] = { Coords = vec3(-1107.59,-1609.6,4.72), Hash = 30769481, Lock = true, Distance = 1.5, Perm = "Yakuza" },
	[246] = { Coords = vec3(-1036.7,-1485.16,1.63), Hash = -739446345, Lock = true, Distance = 1.5, Perm = "Yakuza" },

	[247] = { Coords = vec3(-2597.11,1926.77,167.98), Hash = 1068002766, Lock = true, Distance = 7, Perm = "Mansao" },
	[248] = { Coords = vec3(-2587.57,1910.46,167.65), Hash = 308207762, Lock = true, Distance = 1.5, Perm = "Mansao" },
	[249] = { Coords = vec3(2599.56,1900.01,167.74), Hash = 813813633, Lock = true, Distance = 1.5, Perm = "Mansao" },
	[250] = { Coords = vec3(-2599.79,1901.75,164.11), Hash = 813813633, Lock = true, Distance = 1.5, Perm = "Mansao" },
	[251] = { Coords = vec3(-2559.19,1910.86,169.08), Hash = 546378757, Lock = true, Distance = 1.5, Perm = "Mansao", Other = 252 },
	[252] = { Coords = vec3(-2556.65,1915.72,169.08), Hash = -1249591818, Lock = true, Distance = 1.5, Perm = "Mansao", Other = 251 },
--- POLICIA SANDY
	[253] = { Coords = vec3(1846.65,3685.49,34.41), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Police", Other = 252 },
	[254] = { Coords = vec3(1844.87,3688.57,34.41), Hash = 631614199, Lock = true, Distance = 1.5, Perm = "Police", Other = 253 },
--- POLICIA PALETO
	[255] = { Coords = vec3(-435.75,5990.62,31.87), Hash = 1346738325, Lock = true, Distance = 1.5, Perm = "Police", Other = 254 },
--- POLICIA SUL
	[256] = { Coords = vec3(-396.77,-416.02,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 255 },
	[257] = { Coords = vec3(-395.11,-412.39,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 256 },
	[258] = { Coords = vec3(-395.27,-419.58,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 257 },
	[259] = { Coords = vec3(-389.37,-421.78,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 258 },
	[260] = { Coords = vec3(-380.92,-421.01,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 259 },
	[261] = { Coords = vec3(-379.25,-417.3,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 260 },
	[262] = { Coords = vec3(-380.81,-413.73,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 261 },
	[263] = { Coords = vec3(-387.55,-411.45,25.24), Hash = 1176241902, Lock = true, Distance = 1.5, Perm = "Police", Other = 262 },

	[264] = { Coords = vec3(-390.3,-433.05,25.24), Hash = 1401135549, Lock = true, Distance = 1.5, Perm = "Police", Other = 263 },
	[265] = { Coords = vec3(-393.0,-429.27,25.24), Hash = 1401135549, Lock = true, Distance = 1.5, Perm = "Police", Other = 264 },
	[266] = { Coords = vec3(-387.41,-428.74,25.24), Hash = 1401135549, Lock = true, Distance = 1.5, Perm = "Police", Other = 265 },
	[267] = { Coords = vec3(-417.09,-332.14,33.26), Hash = -143534454, Lock = true, Distance = 5.5, Perm = "Police", Other = 266 },
	[268] = { Coords = vec3(-417.71,-336.63,34.91), Hash = -143534454, Lock = true, Distance = 5.5, Perm = "Police", Other = 267 },

	[269] = { Coords = vec3(-582.67,228.4,79.43), Hash = -612979079, Lock = true, Distance = 2.5, Perm = "Digitalden", Other = 268 },
	[270] = { Coords = vec3(102.57,-1960.16,20.88), Hash = 1033826026, Lock = true, Distance = 2.5, Perm = "Ballas", Other = 269 },
	[271] = { Coords = vec3(943.44,-1489.68,30.33), Hash = 488722403, Lock = true, Distance = 2.5, Perm = "Bloods", Other = 270 },
	[272] = { Coords = vec3(935.87,-1489.84,30.33), Hash = 488722403, Lock = true, Distance = 2.5, Perm = "Bloods", Other = 271 },
	[273] = { Coords = vec3(939.83,-1490.0,30.16), Hash = -274493186, Lock = true, Distance = 2.5, Perm = "Bloods", Other = 272 },
	[274] = { Coords = vec3(961.05,-1498.98,31.09), Hash = 1042000049, Lock = true, Distance = 2.5, Perm = "Bloods", Other = 273 },
	[275] = { Coords = vec3(829.09,-2334.18,30.31), Hash = 363214472, Lock = true, Distance = 2.5, Perm = "Vagos", Other = 274 },
	[276] = { Coords = vec3(838.37,-2329.66,30.33), Hash = 1220702663, Lock = true, Distance = 2.5, Perm = "Vagos", Other = 275 },

	[278] = { Coords = vec3(2330.4,2576.21,46.67), Hash = 914592203, Lock = true, Distance = 2.5, Perm = "Coiote", Other = 276 },
	[279] = { Coords = vec3(2332.48,2575.22,46.67), Hash = -26664553, Lock = true, Distance = 2.5, Perm = "Coiote", Other = 278 },

	[280] = { Coords = vec3(897.92,-958.11,35.55), Hash = 1742849246, Lock = true, Distance = 1.5, Perm = "Pawnshop" },
	[281] = { Coords = vec3(1995.28,3046.38,47.21), Hash = 747286790, Lock = true, Distance = 1.5, Perm = "Bratva" },
	[282] = { Coords = vec3(1997.62,3039.91,47.03), Hash = 1287245314, Lock = true, Distance = 1.5, Perm = "Bratva" },

	
	
	
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DoorsPermission(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if GlobalState["Doors"][Number]["Perm"] ~= nil then
			if vRP.HasService(Passport,GlobalState["Doors"][Number]["Perm"]) or vRP.hasPermission(Passport,'Admin',2) then
				if vRP.hasPermission(Passport,'Admin',2) then
					TriggerClientEvent('Notify',source,'amarelo','Acionado como admin', 5000)
				end
				local Doors = GlobalState["Doors"]

				Doors[Number]["Lock"] = not Doors[Number]["Lock"]

				if Doors[Number]["Other"] ~= nil then
					local Second = Doors[Number]["Other"]
					Doors[Second]["Lock"] = not Doors[Second]["Lock"]
				end

				GlobalState:set("Doors",Doors,true)

				TriggerClientEvent("doors:Update",-1,Number,Doors[Number]["Lock"])

				vRPC.playAnim(source,true,{"anim@heists@keycard@","exit"},false)
				Wait(350)
				vRPC.stopAnim(source)
			end
		end
	end
end