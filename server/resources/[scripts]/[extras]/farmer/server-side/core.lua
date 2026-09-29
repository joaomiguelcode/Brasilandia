-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
local Active = {}
local webhookcolheita = "https://discord.com/api/webhooks/1155802694930411550/tWlRE3vxSyj6J_1iWukIanTnhgT3MdAT1trWfh9Sluiu_fbUWD2rnX0psNnoRTVDXWEo"
local Objects = {
	["1"] = { ["Coords"] = vec3(379.34,6508.98,28.04), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["2"] = { ["Coords"] = vec3(369.59,6508.8,28.46), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman",["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["3"] = { ["Coords"] = vec3(360.6,6508.73,28.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["4"] = { ["Coords"] = vec3(351.16,6508.7,28.63), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["5"] = { ["Coords"] = vec3(341.82,6508.83,28.8), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["6"] = { ["Coords"] = vec3(332.71,6508.92,28.54), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["7"] = { ["Coords"] = vec3(323.49,6508.7,29.05), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	
	["8"] = { ["Coords"] = vec3(379.34,6517.98,28.04), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["9"] = { ["Coords"] = vec3(369.59,6517.8,28.46), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman",["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["10"] = { ["Coords"] = vec3(360.6,6517.73,28.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["11"] = { ["Coords"] = vec3(351.16,6517.7,28.63), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["12"] = { ["Coords"] = vec3(341.82,6517.83,28.8), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["13"] = { ["Coords"] = vec3(332.71,6517.92,28.54), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["14"] = { ["Coords"] = vec3(323.49,6517.7,29.05), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	
	["15"] = { ["Coords"] = vec3(379.34,6526.98,28.04), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["16"] = { ["Coords"] = vec3(369.59,6526.8,28.46), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman",["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["17"] = { ["Coords"] = vec3(360.6,6526.73,28.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["18"] = { ["Coords"] = vec3(351.16,6526.7,28.63), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["19"] = { ["Coords"] = vec3(341.82,6526.83,28.8), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["20"] = { ["Coords"] = vec3(332.71,6526.92,28.54), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["21"] = { ["Coords"] = vec3(323.49,6526.7,29.05), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },

	["22"] = { ["Coords"] = vec3(379.34,6535.98,28.04), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["23"] = { ["Coords"] = vec3(369.59,6535.8,28.46), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman",["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["24"] = { ["Coords"] = vec3(360.6,6535.73,28.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["25"] = { ["Coords"] = vec3(351.16,6535.7,28.63), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["26"] = { ["Coords"] = vec3(341.82,6535.83,28.8), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["27"] = { ["Coords"] = vec3(332.71,6535.92,28.54), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },
	["28"] = { ["Coords"] = vec3(323.49,6535.7,29.05), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_orange", ["Event"] = "farmer:Fruitman", ["Label"] = "Colher", ["Time"] = 0, ["Distance"] = 1.5 },


	["34"] = { ["Coords"] = vec3(2952.07,2819.73,42.58), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["35"] = { ["Coords"] = vec3(2923.9,2809.09,43.35), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["36"] = { ["Coords"] = vec3(2921.64,2793.9,40.61), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["37"] = { ["Coords"] = vec3(2934.44,2779.35,39.07), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["38"] = { ["Coords"] = vec3(2949.26,2770.88,39.02), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["39"] = { ["Coords"] = vec3(2959.64,2775.72,39.92), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["40"] = { ["Coords"] = vec3(2972.0,2779.34,38.64), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["41"] = { ["Coords"] = vec3(2976.44,2787.3,39.9), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["42"] = { ["Coords"] = vec3(2968.12,2796.86,40.94), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["43"] = { ["Coords"] = vec3(2952.52,2847.42,47.11), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["44"] = { ["Coords"] = vec3(2967.8,2840.11,45.41), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["45"] = { ["Coords"] = vec3(2979.78,2821.56,44.74), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["46"] = { ["Coords"] = vec3(2991.88,2802.39,43.93), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["47"] = { ["Coords"] = vec3(3003.04,2780.11,43.41), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["48"] = { ["Coords"] = vec3(3001.14,2763.14,42.97), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["49"] = { ["Coords"] = vec3(2992.83,2756.31,42.82), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["50"] = { ["Coords"] = vec3(2968.98,2738.39,43.74), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["51"] = { ["Coords"] = vec3(2939.29,2751.12,43.39), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["52"] = { ["Coords"] = vec3(2967.54,2758.4,43.08), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["53"] = { ["Coords"] = vec3(2989.76,2770.21,42.87), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["54"] = { ["Coords"] = vec3(2937.02,2799.51,41.01), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["55"] = { ["Coords"] = vec3(2954.26,2802.48,41.74), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_e", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["56"] = { ["Coords"] = vec3(2964.23,2786.72,39.75), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_d", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["57"] = { ["Coords"] = vec3(2947.96,2783.56,39.93), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["58"] = { ["Coords"] = vec3(2944.7,2835.95,47.55), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["59"] = { ["Coords"] = vec3(2976.14,2806.08,43.64), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["60"] = { ["Coords"] = vec3(2993.87,2797.38,43.93), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["61"] = { ["Coords"] = vec3(2978.48,2779.86,38.57), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["62"] = { ["Coords"] = vec3(2949.92,2774.04,39.11), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["63"] = { ["Coords"] = vec3(2952.69,2752.77,43.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["64"] = { ["Coords"] = vec3(2959.79,2745.87,43.46), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["65"] = { ["Coords"] = vec3(2975.37,2759.94,43.0), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["66"] = { ["Coords"] = vec3(2991.34,2757.49,42.68), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["67"] = { ["Coords"] = vec3(3000.35,2767.4,42.83), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["68"] = { ["Coords"] = vec3(2990.18,2772.23,42.93), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["69"] = { ["Coords"] = vec3(2977.76,2789.81,40.44), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["70"] = { ["Coords"] = vec3(2953.98,2816.37,42.31), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["71"] = { ["Coords"] = vec3(2937.17,2810.72,42.61), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },
	["72"] = { ["Coords"] = vec3(2938.17,2800.52,41.05), ["Heading"] = 3374176, ["Height"] = 1.25, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_rock_1_f", ["Event"] = "farmer:Minerman", ["Label"] = "Minerar", ["Time"] = 0, ["Distance"] = 2.0 },

	["58"] = { ["Coords"] = vec3(2386.34,5099.58,47.55), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["59"] = { ["Coords"] = vec3(2397.96,5087.04,47.31), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["60"] = { ["Coords"] = vec3(2401.23,5099.75,46.4), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["61"] = { ["Coords"] = vec3(2391.37,5110.17,46.39), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["62"] = { ["Coords"] = vec3(2410.42,5089.48,46.51), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["63"] = { ["Coords"] = vec3(2420.39,5070.15,46.62), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["64"] = { ["Coords"] = vec3(2424.72,5082.12,46.71), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["65"] = { ["Coords"] = vec3(2434.98,5062.41,46.34), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["66"] = { ["Coords"] = vec3(2411.24,5079.37,46.88), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["67"] = { ["Coords"] = vec3(2433.39,5074.77,46.32), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["68"] = { ["Coords"] = vec3(2410.41,5127.09,47.25), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["69"] = { ["Coords"] = vec3(2416.61,5116.57,46.88), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["70"] = { ["Coords"] = vec3(2426.6,5122.74,46.98), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["71"] = { ["Coords"] = vec3(2434.38,5111.16,47.08), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["72"] = { ["Coords"] = vec3(2436.03,5098.54,46.45), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["73"] = { ["Coords"] = vec3(2444.76,5087.11,46.34), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["74"] = { ["Coords"] = vec3(2452.11,5073.92,46.32), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["75"] = { ["Coords"] = vec3(2459.98,5082.81,46.94), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["76"] = { ["Coords"] = vec3(2475.47,5086.5,46.13), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["77"] = { ["Coords"] = vec3(2463.86,5101.53,46.45), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["78"] = { ["Coords"] = vec3(2450.84,5107.65,46.89), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["79"] = { ["Coords"] = vec3(2461.8,5063.75,46.78), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["80"] = { ["Coords"] = vec3(2473.81,5048.59,46.44), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["81"] = { ["Coords"] = vec3(2487.0,5035.03,46.79), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["82"] = { ["Coords"] = vec3(2487.67,5053.43,49.29), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_cedar_s_01", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["83"] = { ["Coords"] = vec3(2504.84,5049.0,51.44), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_w_r_cedar_dead", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },
	["84"] = { ["Coords"] = vec3(2502.22,5069.15,46.51), ["Heading"] = 3374176, ["Height"] = 1.5, ["Width"] = 1.5, ["Show"] = 150.0, ["Model"] = "prop_tree_pine_02", ["Event"] = "farmer:Lumberman", ["Label"] = "Derrubar", ["Time"] = 0, ["Distance"] = 1.5 },

	["85"] = { ["Coords"] = vec3(-6.08,-678.48,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["86"] = { ["Coords"] = vec3(-8.1,-677.71,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["87"] = { ["Coords"] = vec3(-6.76,-678.21,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["88"] = { ["Coords"] = vec3(-7.44,-677.97,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["89"] = { ["Coords"] = vec3(-6.19,-677.78,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["90"] = { ["Coords"] = vec3(-6.91,-677.49,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["91"] = { ["Coords"] = vec3(-7.58,-677.22,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["92"] = { ["Coords"] = vec3(-3.12,-674.79,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["93"] = { ["Coords"] = vec3(-3.57,-675.43,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["94"] = { ["Coords"] = vec3(-3.2,-676.05,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["95"] = { ["Coords"] = vec3(-4.24,-675.63,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["96"] = { ["Coords"] = vec3(-4.93,-675.81,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["97"] = { ["Coords"] = vec3(-3.86,-676.27,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["98"] = { ["Coords"] = vec3(4.33,-677.51,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["99"] = { ["Coords"] = vec3(5.04,-677.71,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["100"] = { ["Coords"] = vec3(4.45,-678.24,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["101"] = { ["Coords"] = vec3(3.48,-682.07,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["102"] = { ["Coords"] = vec3(4.24,-682.35,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["103"] = { ["Coords"] = vec3(4.97,-682.65,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["104"] = { ["Coords"] = vec3(5.69,-682.95,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["105"] = { ["Coords"] = vec3(4.08,-681.58,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["106"] = { ["Coords"] = vec3(4.86,-681.82,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["107"] = { ["Coords"] = vec3(5.66,-682.16,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["108"] = { ["Coords"] = vec3(7.47,-681.16,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["109"] = { ["Coords"] = vec3(7.16,-682.05,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["110"] = { ["Coords"] = vec3(6.81,-681.41,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["111"] = { ["Coords"] = vec3(5.66,-679.38,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["112"] = { ["Coords"] = vec3(4.79,-679.0,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["113"] = { ["Coords"] = vec3(5.05,-679.76,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["114"] = { ["Coords"] = vec3(3.66,-677.92,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["115"] = { ["Coords"] = vec3(2.95,-677.64,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["116"] = { ["Coords"] = vec3(3.13,-678.44,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["117"] = { ["Coords"] = vec3(3.9,-678.76,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["118"] = { ["Coords"] = vec3(3.87,-675.63,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["119"] = { ["Coords"] = vec3(4.61,-675.92,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["120"] = { ["Coords"] = vec3(5.4,-676.23,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["121"] = { ["Coords"] = vec3(4.46,-675.23,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },
	["122"] = { ["Coords"] = vec3(5.26,-675.51,16.13), ["Heading"] = 358.04, ["Height"] = 1.0, ["Width"] = 0.25, ["Show"] = 20.0, ["Model"] = "prop_money_bag_01", ["Event"] = "farmer:Transporter", ["Label"] = "Pegar", ["Time"] = 0, ["Distance"] = 1.75 },


	--Batatas
	["123"] = { ["Coords"] = vec3(384.52,6487.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["124"] = { ["Coords"] = vec3(384.52,6484.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["125"] = { ["Coords"] = vec3(384.52,6481.01,29.02), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["126"] = { ["Coords"] = vec3(384.52,6478.01,29.39), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["127"] = { ["Coords"] = vec3(384.52,6475.01,29.61), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },

	["128"] = { ["Coords"] = vec3(382.52,6487.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["129"] = { ["Coords"] = vec3(382.52,6484.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["130"] = { ["Coords"] = vec3(382.52,6481.01,29.02), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["131"] = { ["Coords"] = vec3(382.52,6478.01,29.39), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["132"] = { ["Coords"] = vec3(382.52,6475.01,29.61), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["133"] = { ["Coords"] = vec3(382.52,6472.01,29.91), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["134"] = { ["Coords"] = vec3(382.34,6469.38,30.21), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },

	["135"] = { ["Coords"] = vec3(379.84,6487.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["136"] = { ["Coords"] = vec3(379.84,6484.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["137"] = { ["Coords"] = vec3(379.84,6481.01,29.02), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["138"] = { ["Coords"] = vec3(379.84,6478.01,29.39), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["139"] = { ["Coords"] = vec3(379.84,6475.01,29.61), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["140"] = { ["Coords"] = vec3(379.84,6472.01,29.91), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["141"] = { ["Coords"] = vec3(379.92,6469.47,30.21), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["142"] = { ["Coords"] = vec3(379.84,6467.01,30.21), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["143"] = { ["Coords"] = vec3(379.84,6464.01,30.51), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },

	["144"] = { ["Coords"] = vec3(377.49,6487.01,28.66), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["145"] = { ["Coords"] = vec3(377.49,6484.01,28.96), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["146"] = { ["Coords"] = vec3(377.49,6481.01,29.21), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["147"] = { ["Coords"] = vec3(377.49,6478.01,29.48), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["148"] = { ["Coords"] = vec3(377.49,6475.01,29.76), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["149"] = { ["Coords"] = vec3(377.49,6472.01,30.04), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["150"] = { ["Coords"] = vec3(377.57,6469.46,30.24), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["151"] = { ["Coords"] = vec3(377.49,6467.01,30.25), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["152"] = { ["Coords"] = vec3(377.49,6464.01,30.50), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },
	["153"] = { ["Coords"] = vec3(377.49,6461.01,30.78), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_plant_fern_02a", ["Event"] = "farmer:Potatos", ["Label"] = "Colher Batatas", ["Time"] = 0, ["Distance"] = 1.5 },

	-- Tomates
	["154"] = { ["Coords"] = vec3(366.02,6487.01,29.31-0.15),  ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["155"] = { ["Coords"] = vec3(366.02,6484.01,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["156"] = { ["Coords"] = vec3(366.02,6481.01,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["157"] = { ["Coords"] = vec3(366.02,6478.01,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["158"] = { ["Coords"] = vec3(366.02,6475.01,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["159"] = { ["Coords"] = vec3(366.02,6472.01,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["160"] = { ["Coords"] = vec3(366.02,6469.46,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["161"] = { ["Coords"] = vec3(366.02,6467.01,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["162"] = { ["Coords"] = vec3(366.02,6464.01,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },
	["163"] = { ["Coords"] = vec3(366.02,6461.01,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomates", ["Time"] = 0, ["Distance"] = 1.5 },

	-- Alfaces
	["164"] = { ["Coords"] = vec3(375.43,6487.32,29.31-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["165"] = { ["Coords"] = vec3(375.43,6484.15,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["166"] = { ["Coords"] = vec3(375.43,6481.05,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["167"] = { ["Coords"] = vec3(375.43,6478.13,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["168"] = { ["Coords"] = vec3(375.43,6475.06,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["169"] = { ["Coords"] = vec3(375.43,6471.95,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["170"] = { ["Coords"] = vec3(375.43,6469.57,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["171"] = { ["Coords"] = vec3(375.43,6466.9,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["172"] = { ["Coords"] = vec3(375.43,6464.14,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["173"] = { ["Coords"] = vec3(375.43,6461.02,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },

	["174"] = { ["Coords"] = vec3(372.88,6487.32,29.31-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["175"] = { ["Coords"] = vec3(372.88,6484.15,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["176"] = { ["Coords"] = vec3(372.88,6481.05,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["177"] = { ["Coords"] = vec3(372.88,6478.13,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["178"] = { ["Coords"] = vec3(372.88,6475.06,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["179"] = { ["Coords"] = vec3(372.88,6471.95,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["180"] = { ["Coords"] = vec3(372.88,6469.57,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["181"] = { ["Coords"] = vec3(372.88,6466.9,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["182"] = { ["Coords"] = vec3(372.88,6464.14,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["183"] = { ["Coords"] = vec3(372.88,6461.02,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },

	["184"] = { ["Coords"] = vec3(370.58,6487.32,29.31-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["185"] = { ["Coords"] = vec3(370.58,6484.15,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["186"] = { ["Coords"] = vec3(370.58,6481.05,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["187"] = { ["Coords"] = vec3(370.58,6478.13,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["188"] = { ["Coords"] = vec3(370.58,6475.06,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["189"] = { ["Coords"] = vec3(370.58,6471.95,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["190"] = { ["Coords"] = vec3(370.58,6469.57,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["191"] = { ["Coords"] = vec3(370.58,6466.9,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["192"] = { ["Coords"] = vec3(370.58,6464.14,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["193"] = { ["Coords"] = vec3(370.58,6461.02,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },

	["194"] = { ["Coords"] = vec3(368.35,6487.32,29.31-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["195"] = { ["Coords"] = vec3(368.35,6484.15,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["196"] = { ["Coords"] = vec3(368.35,6481.05,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["197"] = { ["Coords"] = vec3(368.35,6478.13,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["198"] = { ["Coords"] = vec3(368.35,6475.06,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["199"] = { ["Coords"] = vec3(368.35,6471.95,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["200"] = { ["Coords"] = vec3(368.35,6469.57,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["201"] = { ["Coords"] = vec3(368.35,6466.9,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["202"] = { ["Coords"] = vec3(368.35,6464.14,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },
	["203"] = { ["Coords"] = vec3(368.35,6461.02,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_03_cab", ["Event"] = "farmer:Alface", ["Label"] = "Colher Alface", ["Time"] = 0, ["Distance"] = 1.5 },

	-- Tomates
	["204"] = { ["Coords"] = vec3(361.45,6487.32,29.31-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["205"] = { ["Coords"] = vec3(361.45,6484.15,29.65-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["206"] = { ["Coords"] = vec3(361.45,6481.05,29.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["207"] = { ["Coords"] = vec3(361.45,6478.13,30.05-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["208"] = { ["Coords"] = vec3(361.45,6475.06,30.24-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["209"] = { ["Coords"] = vec3(361.45,6471.95,30.41-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["210"] = { ["Coords"] = vec3(361.45,6469.57,30.49-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["211"] = { ["Coords"] = vec3(361.45,6466.9,30.63-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["212"] = { ["Coords"] = vec3(361.45,6464.14,30.80-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },
	["213"] = { ["Coords"] = vec3(361.45,6461.02,30.90-0.15), ["Heading"] = 272.13, ["Height"] = 1.25, ["Width"] = 1.0, ["Show"] = 150.0, ["Model"] = "prop_veg_crop_02", ["Event"] = "farmer:Tomate", ["Label"] = "Colher Tomate", ["Time"] = 0, ["Distance"] = 1.5 },

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- Alfaces
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Alface")
AddEventHandler("farmer:Alface",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("PA") then
					local Amount = math.random(3,5)
					local Items = { "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface", "alface","brincodeouro","bracelet","goldring"   }
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"amb@world_human_gardener_plant@female@base","base_female"},true)
						TriggerClientEvent("Progress",source,"Colhendo Alface",10000)
						Objects[Number]["Time"] = GlobalState["Work"] + 25
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(100)
							end

							Wait(700)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						vRP.SendWebhook(webhookcolheita, "LOGs Colheita", "**Passaporte: **"..Passport.."\n**Colheu: **"..Amount.."x "..Items[Select], 12713984)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)

					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Pá</b> não encontrada.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Tomates
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Tomate")
AddEventHandler("farmer:Tomate",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("PA") then
					local Amount = math.random(3,5)
					local Items = { "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "tomato", "brincodeouro","bracelet","goldring"  }
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"amb@world_human_gardener_plant@female@base","base_female"},true)
						TriggerClientEvent("Progress",source,"Colhendo Tomates",10000)
						Objects[Number]["Time"] = GlobalState["Work"] + 25
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						vRP.SendWebhook(webhookcolheita, "LOGs Colheita", "**Passaporte: **"..Passport.."\n**Colheu: **"..Amount.."x "..Items[Select], 12713984)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Pá</b> não encontrada.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Potatos
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Potatos")
AddEventHandler("farmer:Potatos",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("PA") then
					local Amount = math.random(3,5)
					local Items = { "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "potato", "brincodeouro","bracelet","goldring"  }
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"amb@world_human_gardener_plant@female@base","base_female"},true)
						TriggerClientEvent("Progress",source,"Colhendo batata",10000)
						Objects[Number]["Time"] = GlobalState["Work"] + 25
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						vRP.SendWebhook(webhookcolheita, "LOGs Colheita", "**Passaporte: **"..Passport.."\n**Colheu: **"..Amount.."x "..Items[Select], 12713984)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Pá</b> não encontrada.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FRUITMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Fruitman")
AddEventHandler("farmer:Fruitman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_STONE_HATCHET") then
					local Amount = math.random(7)
					local Items = { "guarana","strawberry","orange", "apple", "coffee2"}
					local Select = math.random(#Items)

					if (vRP.InventoryWeight(Passport) + itemWeight(Items[Select]) * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"amb@prop_human_movie_bulb@base","base"},true)
						TriggerClientEvent("Progress",source,"Colhendo frutas",10000)
						Objects[Number]["Time"] = GlobalState["Work"] + 25
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true

						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"tesoura",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,Items[Select],Amount,true)
						vRP.SendWebhook(webhookcolheita, "LOGs Colheita", "**Passaporte: **"..Passport.."\n**Colheu: **"..Amount.."x "..Items[Select], 12713984)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Tesoura</b> não encontrada.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINERMAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Minerman")
AddEventHandler("farmer:Minerman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				if vRP.ConsultItem(Passport,"pickaxe",1) then
					local Amount = math.random(2)
					if (vRP.InventoryWeight(Passport) + itemWeight("geode") * Amount) <= vRP.GetWeight(Passport) then
						vRPC.createObjects(source,"melee@large_wpn@streamed_core","ground_attack_on_spot","prop_tool_pickaxe",1,18905,0.10,-0.1,0.0,-92.0,260.0,5.0)
						TriggerClientEvent("Progress",source,"Minerando",13000)
						Objects[Number]["Time"] = GlobalState["Work"] + 15
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 13

						repeat
							Wait(1000)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(1000)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,"geode",Amount,true)
						vRP.SendWebhook(webhookcolheita, "LOGs Colheita", "**Passaporte: **"..Passport.."\n**Minerou: **"..Amount.." Geodos", 12713984)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Picareta</b> não encontrada.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- LUMBERMAN
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Lumberman")
AddEventHandler("farmer:Lumberman",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				local Ped = GetPlayerPed(source)
				if GetSelectedPedWeapon(Ped) == GetHashKey("WEAPON_HATCHET") then
					local Amount = math.random(3,5)
					if (vRP.InventoryWeight(Passport) + itemWeight("woodlog") * Amount) <= vRP.GetWeight(Passport) then
						vRPC.playAnim(source,false,{"lumberjackaxe@idle","idle"},true)
						TriggerClientEvent("Progress",source,"Cortando",11000)
						Objects[Number]["Time"] = GlobalState["Work"] + 15
						Player(source)["state"]["Buttons"] = true
						Player(source)["state"]["Cancel"] = true
						local timeProgress = 10

						repeat
							if timeProgress ~= 10 then
								Wait(400)
							end

							Wait(700)
							TriggerClientEvent("sounds:Private",source,"lumberman",0.1)
							timeProgress = timeProgress - 1
						until timeProgress <= 0

						Wait(400)

						TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
						vRP.GenerateItem(Passport,"woodlog",Amount,true)
						Player(source)["state"]["Buttons"] = false
						Player(source)["state"]["Cancel"] = false
						vRP.UpgradeStress(Passport,1)
						vRPC.removeObjects(source)
						FamilyExperience(source)
					else
						TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","<b>Machado</b> não encontrado.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSPORTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("farmer:Transporter")
AddEventHandler("farmer:Transporter",function(Number)
	if Objects[Number] then
		if GlobalState["Work"] >= Objects[Number]["Time"] then
			local source = source
			local Passport = vRP.Passport(source)
			if Passport and not Active[Passport] then
				Active[Passport] = true

				if (vRP.InventoryWeight(Passport) + itemWeight("pouch")) <= vRP.GetWeight(Passport) then
					vRPC.playAnim(source,false,{"pickup_object","pickup_low"},true)
					TriggerClientEvent("Progress",source,"Coletando",1000)
					Objects[Number]["Time"] = GlobalState["Work"] + 10
					Player(source)["state"]["Buttons"] = true
					Player(source)["state"]["Cancel"] = true

					Wait(1000)

					TriggerClientEvent("farmer:Remover",-1,Number,Objects[Number]["Time"])
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRP.GenerateItem(Passport,"pouch",1,true)
					vRP.UpgradeStress(Passport,1)
					vRPC.removeObjects(source)
					FamilyExperience(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end

				Active[Passport] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("farmer:Table",source,Objects)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if Active[Passport] then
		Active[Passport] = nil
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