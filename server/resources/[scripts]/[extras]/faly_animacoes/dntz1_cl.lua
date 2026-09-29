local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

faly = {}
Tunnel.bindInterface("faly_animacoes",faly)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 60309 hand ESQUERDA
-- 28422 hand DIREITA
-- 50 NÃO REPETE
-- 49 REPETE
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_min = 5.0
local fov_max = 70.0
local binoculos = false
local camera = false
local fov = (fov_max+fov_min)*0.5

local algemado = false
RegisterNetEvent("algemado")
AddEventHandler("algemado",function(bool)
  algemado = bool
end)

local Poledance = {
	{108.97,-1289.28,28.25,297.89},
	{105.04,-1294.39,28.25,297.89},
	{102.48,-1290.07,28.25,297.89},
	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS2
-----------------------------------------------------------------------------------------------------------------------------------------
local beds2 = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
local chairs = {
    { "v_serv_ct_chair02",0.0 },
    { "v_corp_offchair",0.5 },
    { "prop_bench_01a",0.5 },
    { "prop_bench_09",0.3 },
    { "prop_wheelchair_01",0.0 },
    { "v_ret_gc_chair02",0.0 },
    { "prop_off_chair_05",0.4 },
    { "v_club_officechair",0.4 },
    { "prop_table_01_chr_a",0.0 },
    { "prop_table_03_chr",0.4 },
    { "hei_prop_yah_seat_03",0.5 },
    { "hei_prop_yah_seat_02",0.5 },
    { "prop_bench_02",0.5 },
    { "prop_bench_06",0.5 },
    { "v_ret_chair_white",0.5 },
    { "v_res_jarmchair",0.5 },
    { "v_ret_chair",0.5 },
    { "prop_chair_02",0.5 },
    { "prop_chair_01b",0.5 },
    { "prop_chair_04a",0.5 },
    { "prop_off_chair_01",0.5 },
    { "v_corp_bk_chair3",0.5 },
    { "prop_table_03b_chr",0.5 },
    { "prop_table_05_chr",0.5 },
    { "prop_skid_chair_02",0.0 },
    { "prop_old_deck_chair",-0.05 },
    { "prop_chair_06",0.5 },
    { "prop_bar_stool_01",0.8 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
local animacoes = {
	
	{ nome = "radio2" , prop = "prop_boombox_01" , flag = 50 , hand = 57005 , pos1 = 0.30 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa" , prop = "prop_ld_case_01" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa2" , prop = "prop_ld_case_01_s" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa3" , prop = "prop_security_case_01" , flag = 50 , hand = 57005 , pos1 = 0.16 , pos2 = 0 , pos3 = -0.01 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa4" , prop = "w_am_case" , flag = 50 , hand = 57005 , pos1 = 0.08 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa5" , prop = "prop_ld_suitcase_01" , flag = 50 , hand = 57005 , pos1 = 0.39 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "bolsa6" , prop = "xm_prop_x17_bag_med_01a" , flag = 50 , hand = 57005 , pos1 = 0.39 , pos2 = 0 , pos3 = 0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "caixa2" , prop = "prop_tool_box_04" , flag = 50 , hand = 57005 , pos1 = 0.45 , pos2 = 0 , pos3 = 0.05 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "lixo" , prop = "prop_cs_rub_binbag_01" , flag = 50 , hand = 57005 , pos1 = 0.11 , pos2 = 0 , pos3 = 0.0 , pos4 = 0 , pos5 = 260.0 , pos6 = 60.0 },
	{ nome = "mic" , prop = "prop_microphone_02" , flag = 50 , hand = 60309 , pos1 = 0.08 , pos2 = 0.03 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "mic2" , prop = "p_ing_microphonel_01" , flag = 50 , hand = 60309 , pos1 = 0.08 , pos2 = 0.03 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "mic3" , dict = "missfra1" , anim = "mcs2_crew_idle_m_boom" , prop = "prop_v_bmike_01" , flag = 50 , hand = 28422 },
	{ nome = "buque" , prop = "prop_snow_flower_02" , flag = 50 , hand = 60309 , pos1 = 0.0 , pos2 = 0.0 , pos3 = 0.0 , pos4 = 300.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "rosa" , prop = "prop_single_rose" , flag = 50 , hand = 60309 , pos1 = 0.055 , pos2 = 0.05 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 },
	{ nome = "prebeber" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_fib_coffee" , flag = 49 , hand = 28422 },
	{ nome = "prebeber" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_fib_coffee" , flag = 49 , hand = 28422 },
	{ nome = "prebeber2" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_ld_flow_bottle" , flag = 49 , hand = 28422 },
	{ nome = "prebeber3" , dict = "amb@code_human_wander_drinking@beer@male@base" , anim = "static" , prop = "prop_cs_bs_cup" , flag = 49 , hand = 28422 },
	{ nome = "verificar" , dict = "amb@medic@standing@tendtodead@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mexer" , dict = "amb@prop_human_parking_meter@female@idle_a" , anim = "idle_a_female" , andar = true , loop = true },
	{ nome = "cuidar" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_pumpchest" , andar = true , loop = true },
	{ nome = "cuidar2" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol" , andar = true , loop = true },
	{ nome = "cuidar3" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_kol_idle" , andar = true , loop = true },
	{ nome = "cansado" , dict = "rcmbarry" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "meleca" , dict = "anim@mp_player_intuppernose_pick" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "bora" , dict = "missfam4" , anim = "say_hurry_up_a_trevor" , andar = true , loop = false },
	{ nome = "limpar" , dict = "missfbi3_camcrew" , anim = "final_loop_guy" , andar = true , loop = false },
	{ nome = "galinha" , dict = "random@peyote@chicken" , anim = "wakeup" , andar = true , loop = true },
	{ nome = "amem" , dict = "rcmepsilonism8" , anim = "worship_base" , andar = true , loop = true },
	{ nome = "nervoso" , dict = "rcmme_tracey1" , anim = "nervous_loop" , andar = true , loop = true },
	{ nome = "morrer" , dict = "misslamar1dead_body" , anim = "dead_idle" , andar = false , loop = true },
	{ nome = "ajoelhar" , dict = "amb@medic@standing@kneel@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sinalizar" , dict = "amb@world_human_car_park_attendant@male@base" , anim = "base" , prop = "prop_parking_wand_01" , flag = 49 , hand = 28422 },
	{ nome = "placa" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_01" , flag = 49 , hand = 28422 },
	{ nome = "placa2" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_03" , flag = 49 , hand = 28422 },
	{ nome = "placa3" , dict = "amb@world_human_bum_freeway@male@base" , anim = "base" , prop = "prop_beggers_sign_04" , flag = 49 , hand = 28422 },
	{ nome = "abanar" , dict = "timetable@amanda@facemask@base" , anim = "base" , andar = true , loop = true },
	{ nome = "cocada" , dict = "mp_player_int_upperarse_pick" , anim = "mp_player_int_arse_pick" , andar = true , loop = true },
	{ nome = "cocada2" , dict = "mp_player_int_uppergrab_crotch" , anim = "mp_player_int_grab_crotch" , andar = true , loop = true },
	{ nome = "lero" , dict = "anim@mp_player_intselfiejazz_hands" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "dj2" , dict = "anim@mp_player_intupperair_synth" , anim = "idle_a_fp" , andar = false , loop = true },
	{ nome = "beijo" , dict = "anim@mp_player_intselfieblow_kiss" , anim = "exit" , andar = true , loop = false },
	{ nome = "malicia" , dict = "anim@mp_player_intupperdock" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "ligar" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "radio" , dict = "cellphone@" , anim = "cellphone_call_in" , prop = "prop_cs_hand_radio" , flag = 50 , hand = 28422 },
	{ nome = "cafe" , dict = "amb@world_human_aa_coffee@base" , anim = "base" , prop = "prop_fib_coffee" , flag = 50 , hand = 28422 },
	{ nome = "cafe2" , dict = "amb@world_human_aa_coffee@idle_a" , anim = "idle_a" , prop = "prop_fib_coffee" , flag = 49 , hand = 28422 },
	{ nome = "caixa" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "hei_prop_heist_box" , flag = 50 , hand = 28422 },
	{ nome = "chuva" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01" , flag = 50 , hand = 28422 },
	{ nome = "chuva2" , dict = "amb@world_human_drinking@coffee@male@base" , anim = "base" , prop = "p_amb_brolly_01_s" , flag = 50 , hand = 28422 },
	{ nome = "comer" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_burger_01" , flag = 49 , hand = 28422 },
	{ nome = "comer2" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_cs_hotdog_01" , flag = 49 , hand = 28422 },
	{ nome = "comer3" , dict = "amb@code_human_wander_eating_donut@male@idle_a" , anim = "idle_c" , prop = "prop_amb_donut" , flag = 49 , hand = 28422 },
	{ nome = "beber" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_cs_bottle_01" , flag = 49 , hand = 28422 },
	{ nome = "beber2" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_energy_drink" , flag = 49 , hand = 28422 },
	{ nome = "beber3" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_amb_beer_bottle" , flag = 49 , hand = 28422 },
	{ nome = "beber4" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "p_whiskey_notop" , flag = 49 , hand = 28422 },
	{ nome = "beber5" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_logopen" , flag = 49 , hand = 28422 },
	{ nome = "beber6" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_beer_blr" , flag = 49 , hand = 28422 },
	{ nome = "beber7" , dict = "amb@world_human_drinking@beer@male@idle_a" , anim = "idle_a" , prop = "prop_ld_flow_bottle" , flag = 49 , hand = 28422 },
	{ nome = "digitar" , dict = "anim@heists@prison_heistig1_p1_guard_checks_bus" , anim = "loop" , andar = false , loop = true },
	{ nome = "continencia" , dict = "mp_player_int_uppersalute" , anim = "mp_player_int_salute" , andar = true , loop = true },
	{ nome = "naruto" , dict = "missfbi1" , anim = "ledge_loop" , andar = true , loop = true },
	{ nome = "naruto2" , dict = "missfam5_yoga" , anim = "a2_pose" , andar = true , loop = true },
	{ nome = "rebolar" , dict = "switch@trevor@mocks_lapdance" , anim = "001443_01_trvs_28_idle_stripper" , andar = false , loop = true },
	{ nome = "celebrar" , dict = "rcmfanatic1celebrate" , anim = "celebrate" , andar = false , loop = false },
	-- { nome = "tablet" , dict = "amb@code_human_in_bus_passenger_idles@female@tablet@idle_a" , anim = "idle_b" , prop = "prop_cs_tablet" , flag = 49 , hand = 60309 },
	{ nome = "atm" , dict = "amb@prop_human_atm@male@idle_a" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "nao" , dict = "mp_player_int_upper_nod" , anim = "mp_player_int_nod_no" , andar = true , loop = true },
	{ nome = "palmas" , dict = "anim@mp_player_intcelebrationfemale@slow_clap" , anim = "slow_clap" , andar = true , loop = false },
	{ nome = "palmas2" , dict = "amb@world_human_cheering@male_b" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas3" , dict = "amb@world_human_cheering@male_d" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas4" , dict = "amb@world_human_cheering@male_e" , anim = "base" , andar = true , loop = true },
	{ nome = "palmas5" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "angry_clap_a_player_a" , andar = false , loop = true },
	{ nome = "palmas6" , dict = "anim@mp_player_intupperslow_clap" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "postura" , dict = "anim@heists@prison_heiststation@cop_reactions" , anim = "cop_a_idle" , andar = true , loop = true },
	{ nome = "postura2" , dict = "amb@world_human_cop_idles@female@base" , anim = "base" , andar = true , loop = true },
	{ nome = "postura3" , dict = "mini@strip_club@idles@bouncer@base" , anim = "base" , andar = true , loop = true },
	{ nome = "dedos" , dict = "anim@mp_player_intupperfinger" , anim = "idle_a_fp" , andar = true , loop = true },
	{ nome = "varrer" , dict = "amb@world_human_janitor@male@idle_a" , anim = "idle_a" , prop = "prop_tool_broom" , flag = 49 , hand = 28422 },
	{ nome = "musica" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_01" , flag = 49 , hand = 60309 },
	{ nome = "musica2" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_02" , flag = 49 , hand = 60309 },
	{ nome = "musica3" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_el_guitar_03" , flag = 49 , hand = 60309 },
	{ nome = "musica4" , dict = "amb@world_human_musician@guitar@male@base" , anim = "base" , prop = "prop_acc_guitar_01" , flag = 49 , hand = 60309 },
	{ nome = "camera" , dict = "amb@world_human_paparazzi@male@base" , anim = "base" , prop = "prop_pap_camera_01" , flag = 49 , hand = 28422 },
	{ nome = "camera2" , dict = "missfinale_c2mcs_1" , anim = "fin_c2_mcs_1_camman" , prop = "prop_v_cam_01" , flag = 49 , hand = 28422 },
	{ nome = "prancheta" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "p_amb_clipboard_01" , flag = 50 , hand = 60309 },
	{ nome = "mapa" , dict = "amb@world_human_clipboard@male@base" , anim = "base" , prop = "prop_tourist_map_01" , flag = 50 , hand = 60309 },
	{ nome = "anotar" , dict = "amb@medic@standing@timeofdeath@base" , anim = "base" , prop = "prop_notepad_01" , flag = 49 , hand = 60309 }, -- prop_police_phone
	{ nome = "anotar2" , dict = "cellphone@" , anim = "cellphone_text_in" , prop = "prop_police_phone" , flag = 50 , hand = 28422 }, -- prop_police_phone
	{ nome = "peace" , dict = "mp_player_int_upperpeace_sign" , anim = "mp_player_int_peace_sign" , andar = true , loop = true },
	{ nome = "peace2" , dict ="anim@mp_player_intupperpeace" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "lanca", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca" , flag = 49 , hand = 28422 },
	{ nome = "lanca2", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca_02" , flag = 49 , hand = 28422 },
	{ nome = "teste", dict = "delta@driveby@suv_ps_1h", anim = "enter", prop = "mah_lanca_02" , flag = 49 , hand = 28422 },
	
	{ nome = "deitar" , dict = "anim@gangops@morgue@table@" , anim = "body_search" , andar = false , loop = true , extra = function()
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(beds) do
			local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
			if DoesEntityExist(object) then
				local x2,y2,z2 = table.unpack(GetEntityCoords(object))

				SetEntityCoords(ped,x2,y2,z2+v[2])
				SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)
			end
		end
	end },

	{ nome = "bruschetta" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_bruschetta",49,60309,0.0, 0.0, 0.0, 20.0, -100.0, 50.0)    --- PIZZA
	end },
	{ nome = "sanduiche" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_sanduiche",49,60309,0.0, -0.05, -0.03, 20.0, -100.0, 50.0)
	end},
	{ nome = "sorvete" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_sorvete",49,60309,0.08, 0.0, 0.0, 0.0, -100.0, 50.0)
	end},
	{ nome = "cappuccino" , dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", loop = true, extra = function()
		vRP._createObjects("","","bag_cappuccino",49,28422,0.02, -0.0, 0.04, 0.0, 0.0, 0.0)
	end },
	{ nome = "cha" , dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", loop = true, extra = function()
		vRP._createObjects("","","bag_tea",49,28422,-0.01, 0.01, -0.0, 0.0, 0.0, -40.0)
	end  },
	{ nome = "detox" , dict = "amb@world_human_drinking@coffee@male@idle_a", anim = "idle_c", loop = true, extra = function()
		vRP._createObjects("","","bag_detox",49,28422,0.02, -0.0, -0.08, 0.0, 0.0, 0.0)
	end },
	{ nome = "cupcake" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_cupcake",49,60309,0.05, 0.0, 0.0, 0.0, -100.0, 50.0)
	end },
	{ nome = "quiche" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_quiche",49,60309,0.03, 0.0, -0.05, 100.0, -100.0, 50.0)  -- ISFIRRA 
	end },
	{ nome = "redvelvet" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_burger", loop = true, extra = function()
		vRP._createObjects("","","bag_redvelvet",49,60309,0.03, 0.0, -0.07, 0.0, 0.0, 0.0) -- BOLO DE MORANGO
	end },

	------------------------------------- novas comidas -------------------------------------------------

	{ nome = "cookie" , dict = "mp_player_inteat@burger", anim = "mp_player_int_eat_cookie", loop = true, extra = function()
		vRP._createObjects("","","cookie",49,60309,0.03, 0.0, -0.07, 0.0, 0.0, 0.0) -- BOLO DE MORANGO
	end },




	{ nome = "garcom" , dict = "anim@move_f@waitress", anim = "idle", prop = "vw_prop_vw_tray_01a", flag = 49, mao = 28422, altura = 5.0, pos1 = 0.0, pos2 = 0.015, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	{ nome = "garcom2" , dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_01", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.01, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	{ nome = "garcom3" , dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_02", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.01, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	{ nome = "garcom4" , dict = "anim@move_f@waitress", anim = "idle", prop = "prop_food_tray_03", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.01, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	{ nome = "garcom5" , dict = "anim@move_f@waitress", anim = "idle", prop = "h4_prop_h4_champ_tray_01b", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.01, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },
	{ nome = "garcom6" , dict = "anim@move_f@waitress", anim = "idle", prop = "h4_prop_h4_champ_tray_01c", flag = 49, mao = 28422, altura = 0.0, pos1 = 0.0, pos2 = 0.01, pos3 = 0.0, pos4 = 0.0, pos5 = 0.0 },





	{ nome = "deitar2" , dict = "amb@world_human_sunbathe@female@front@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar3" , dict = "amb@world_human_sunbathe@male@back@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar4" , dict = "amb@world_human_sunbathe@male@front@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "deitar5" , dict = "mini@cpr@char_b@cpr_str" , anim = "cpr_kol_idle" , andar = false , loop = true },
	{ nome = "deitar6" , dict = "switch@trevor@scares_tramp" , anim = "trev_scares_tramp_idle_tramp" , andar = false , loop = true },
	{ nome = "deitar7" , dict = "switch@trevor@annoys_sunbathers" , anim = "trev_annoys_sunbathers_loop_girl" , andar = false , loop = true },		
	{ nome = "deitar8" , dict = "switch@trevor@annoys_sunbathers" , anim = "trev_annoys_sunbathers_loop_guy" , andar = false , loop = true },
	{ nome = "debrucar" , dict = "amb@prop_human_bum_shopping_cart@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "dancar" , dict = "rcmnigel1bnmt_1b" , anim = "dance_loop_tyler" , andar = false , loop = true },
	{ nome = "dancar2" , dict = "mp_safehouse" , anim = "lap_dance_girl" , andar = false , loop = true },
	{ nome = "dancar3" , dict = "misschinese2_crystalmazemcs1_cs" , anim = "dance_loop_tao" , andar = false , loop = true },
	{ nome = "dancar4" , dict = "mini@strip_club@private_dance@part1" , anim = "priv_dance_p1" , andar = false , loop = true },
	{ nome = "dancar5" , dict = "mini@strip_club@private_dance@part2" , anim = "priv_dance_p2" , andar = false , loop = true },
	{ nome = "dancar6" , dict = "mini@strip_club@private_dance@part3" , anim = "priv_dance_p3" , andar = false , loop = true },
	{ nome = "dancar7" , dict = "special_ped@mountain_dancer@monologue_2@monologue_2a" , anim = "mnt_dnc_angel" , andar = false , loop = true },
	{ nome = "dancar8" , dict = "special_ped@mountain_dancer@monologue_3@monologue_3a" , anim = "mnt_dnc_buttwag" , andar = false , loop = true },
	{ nome = "dancar9" , dict = "missfbi3_sniping" , anim = "dance_m_default" , andar = false , loop = true },
	{ nome = "dancar10" , dict = "anim@amb@nightclub@dancers@black_madonna_entourage@" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar11" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar12" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar13" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar14" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar15" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar16" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar17" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar18" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar19" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar20" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar21" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar22" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar23" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar24" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar25" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^3" , andar = false , loop = true },
	{ nome ="dancar26" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar27" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar28" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar29" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar30" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^2" , andar = false , loop = true },
	{ nome ="dancar31" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar32" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar33" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar34" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_09_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar35" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar36" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar37" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar38" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar39" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar40" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar41" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar42" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar43" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar44" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar45" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar46" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar47" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar48" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar49" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar50" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar51" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar52" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar53" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar54" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar55" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar56" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar57" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar58" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_11_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar59" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar60" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar61" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar62" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar63" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar64" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar65" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar66" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar67" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar68" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar69" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar70" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar71" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar72" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar73" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar74" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar75" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar76" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar77" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar78" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar79" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar80" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar81" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar82" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_13_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar83" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar84" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar85" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar86" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar87" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar88" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar89" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar90" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar91" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar92" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar93" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar94" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar95" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar96" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar97" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar98" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar99" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar100" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar101" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar102" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar103" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar104" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar105" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar106" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_15_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar107" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar108" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar109" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar110" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar111" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar112" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar113" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar114" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar115" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar116" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar117" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar118" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar119" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar120" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar121" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar122" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar123" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar124" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar125" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar126" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar127" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar128" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar129" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar130" , dict = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity" , anim = "hi_dance_facedj_17_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar131" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar132" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar133" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar134" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar135" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar136" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar137" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar138" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar139" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar140" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar141" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar142" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar143" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar144" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar145" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar146" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar147" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar148" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar149" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar150" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar151" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar152" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar153" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar154" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_09_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar155" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar156" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar157" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar158" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar159" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar160" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar161" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar162" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar163" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar164" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar165" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar166" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_11_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar167" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar168" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar169" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar170" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar171" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar172" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar173" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar174" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar175" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar176" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar177" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar178" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_13_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar179" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar180" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar181" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar182" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar183" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar184" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar185" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar186" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar187" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar188" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar189" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar190" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar191" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar192" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar193" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar194" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar195" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar196" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar197" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar198" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar199" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar200" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar201" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar202" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_15_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar203" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar204" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^2" , andar = false , loop = true },
	{ nome = "dancar205" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^3" , andar = false , loop = true },
	{ nome = "dancar206" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^4" , andar = false , loop = true },
	{ nome = "dancar207" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^5" , andar = false , loop = true },
	{ nome = "dancar208" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_female^6" , andar = false , loop = true },
	{ nome = "dancar209" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^1" , andar = false , loop = true },
	{ nome = "dancar210" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^2" , andar = false , loop = true },
	{ nome = "dancar211" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^3" , andar = false , loop = true },
	{ nome = "dancar212" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^4" , andar = false , loop = true },
	{ nome = "dancar213" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^5" , andar = false , loop = true },
	{ nome = "dancar214" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v1_male^6" , andar = false , loop = true },
	{ nome = "dancar215" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^1" , andar = false , loop = true },
	{ nome = "dancar216" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^2" , andar = false , loop = true },
	{ nome = "dancar217" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^3" , andar = false , loop = true },
	{ nome = "dancar218" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^4" , andar = false , loop = true },
	{ nome = "dancar219" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^5" , andar = false , loop = true },
	{ nome = "dancar220" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_female^6" , andar = false , loop = true },
	{ nome = "dancar221" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^1" , andar = false , loop = true },
	{ nome = "dancar222" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^2" , andar = false , loop = true },
	{ nome = "dancar223" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^3" , andar = false , loop = true },
	{ nome = "dancar224" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^4" , andar = false , loop = true },
	{ nome = "dancar225" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar226" , dict = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity" , anim = "hi_dance_crowd_17_v2_male^6" , andar = false , loop = true },
	{ nome = "dancar227" , dict = "anim@amb@nightclub@lazlow@hi_podium@" , anim = "danceidle_hi_11_buttwiggle_b_laz" , andar = false , loop = true },
	{ nome = "dancar228" , dict = "timetable@tracy@ig_5@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "dancar229" , dict = "anim@mp_player_intupperfind_the_fish" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "dancar230" , dict = "anim@amb@nightclub@dancers@podium_dancers@" , anim = "hi_dance_facedj_17_v2_male^5" , andar = false , loop = true },
	{ nome = "dancar231" , dict = "anim@amb@nightclub@dancers@solomun_entourage@" , anim = "mi_dance_facedj_17_v1_female^1" , andar = false , loop = true },
	{ nome = "dancar232" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "dancar233" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "dancar234" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "dancar235" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_left" , andar = false , loop = true },
	{ nome = "dancar236" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_left_down" , andar = false , loop = true },
	{ nome = "dancar237" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_left_up" , andar = false , loop = true },
	{ nome = "dancar238" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_right" , andar = false , loop = true },
	{ nome = "dancar239" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_right_down" , andar = false , loop = true },
	{ nome = "dancar240" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "high_right_up" , andar = false , loop = true },
	{ nome = "dancar241" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "dancar242" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "dancar243" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_center_up" , andar = false , loop = true },
	{ nome = "dancar244" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_left" , andar = false , loop = true },
	{ nome = "dancar245" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_left_down" , andar = false , loop = true },
	{ nome = "dancar246" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_left_up" , andar = false , loop = true },
	{ nome = "dancar247" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_right" , andar = false , loop = true },
	{ nome = "dancar248" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_right_down" , andar = false , loop = true },
	{ nome = "dancar249" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "low_right_up" , andar = false , loop = true },
	{ nome = "dancar250" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "dancar251" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_center_down" , andar = false , loop = true },
	{ nome = "dancar252" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_center_up" , andar = false , loop = true },
	{ nome = "dancar253" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_left" , andar = false , loop = true },
	{ nome = "dancar254" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_left_down" , andar = false , loop = true },
	{ nome = "dancar255" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_left_up" , andar = false , loop = true },
	
	{ nome = "dancar256" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "dancar257" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_right_down" , andar = false , loop = true },
	{ nome = "dancar258" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@" , anim = "med_right_up" , andar = false , loop = true },
	{ nome = "dancar259" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "dancar260" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "dancar261" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "dancar262" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_left" , andar = false , loop = true },
	{ nome = "dancar263" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_left_down" , andar = false , loop = true },
	{ nome = "dancar264" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_left_up" , andar = false , loop = true },
	{ nome = "dancar265" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_right" , andar = false , loop = true },
	{ nome = "dancar266" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_right_down" , andar = false , loop = true },
	{ nome = "dancar267" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "high_right_up" , andar = false , loop = true },
	{ nome = "dancar268" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "dancar269" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "dancar270" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_center_up" , andar = false , loop = true },
	{ nome = "dancar271" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_left" , andar = false , loop = true },
	{ nome = "dancar272" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_left_down" , andar = false , loop = true },
	{ nome = "dancar273" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_left_up" , andar = false , loop = true },
	{ nome = "dancar274" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_right" , andar = false , loop = true },
	{ nome = "dancar275" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_right_down" , andar = false , loop = true },
	{ nome = "dancar276" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_right_up" , andar = false , loop = true },
	{ nome = "dancar277" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "dancar278" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_center_down" , andar = false , loop = true },
	{ nome = "dancar279" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_center_up" , andar = false , loop = true },
	{ nome = "dancar280" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_left" , andar = false , loop = true },
	{ nome = "dancar281" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_left_down" , andar = false , loop = true },
	{ nome = "dancar282" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_left_up" , andar = false , loop = true },
	{ nome = "dancar283" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "dancar284" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_right_down" , andar = false , loop = true },
	{ nome = "dancar285" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "med_right_up" , andar = false , loop = true },
	{ nome = "dancar286" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "dancar287" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "dancar288" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "dancar289" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_left" , andar = false , loop = true },
	{ nome = "dancar290" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_left_down" , andar = false , loop = true },
	{ nome = "dancar291" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_left_up" , andar = false , loop = true },
	{ nome = "dancar292" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_right" , andar = false , loop = true },
	{ nome = "dancar293" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_right_down" , andar = false , loop = true },
	{ nome = "dancar294" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "high_right_up" , andar = false , loop = true },
	{ nome = "dancar295" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "dancar296" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "dancar297" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_center_up" , andar = false , loop = true },
	{ nome = "dancar298" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_left" , andar = false , loop = true },
	{ nome = "dancar299" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_left_down" , andar = false , loop = true },
	{ nome = "dancar300" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_left_up" , andar = false , loop = true },
	{ nome = "dancar301" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_right" , andar = false , loop = true },
	{ nome = "dancar302" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_right_down" , andar = false , loop = true },
	{ nome = "dancar303" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "low_right_up" , andar = false , loop = true },
	{ nome = "dancar304" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "dancar305" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_center_down" , andar = false , loop = true },
	{ nome = "dancar306" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_center_up" , andar = false , loop = true },
	{ nome = "dancar307" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_left" , andar = false , loop = true },
	{ nome = "dancar308" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_left_down" , andar = false , loop = true },
	{ nome = "dancar309" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_left_up" , andar = false , loop = true },
	{ nome = "dancar310" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "dancar311" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_right_down" , andar = false , loop = true },
	{ nome = "dancar312" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_a@" , anim = "med_right_up" , andar = false , loop = true },
	
	{ nome = "dancar313" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "dancar314" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "dancar315" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "dancar316" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_left" , andar = false , loop = true },
	{ nome = "dancar317" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_left_down" , andar = false , loop = true },
	{ nome = "dancar318" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_left_up" , andar = false , loop = true },
	{ nome = "dancar319" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_right" , andar = false , loop = true },
	{ nome = "dancar320" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_right_down" , andar = false , loop = true },
	{ nome = "dancar321" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "high_right_up" , andar = false , loop = true },
	{ nome = "dancar322" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "dancar323" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "dancar324" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_center_up" , andar = false , loop = true },
	{ nome = "dancar325" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_left" , andar = false , loop = true },
	{ nome = "dancar326" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_left_down" , andar = false , loop = true },
	{ nome = "dancar327" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_left_up" , andar = false , loop = true },
	{ nome = "dancar328" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_right" , andar = false , loop = true },
	{ nome = "dancar329" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_right_down" , andar = false , loop = true },
	{ nome = "dancar330" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "low_right_up" , andar = false , loop = true },
	{ nome = "dancar331" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "dancar332" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_center_down" , andar = false , loop = true },
	{ nome = "dancar333" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_center_up" , andar = false , loop = true },
	{ nome = "dancar334" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_left" , andar = false , loop = true },
	{ nome = "dancar335" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_left_down" , andar = false , loop = true },
	{ nome = "dancar336" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_left_up" , andar = false , loop = true },
	{ nome = "dancar337" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "dancar338" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_right_down" , andar = false , loop = true },
	{ nome = "dancar339" , dict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@" , anim = "med_right_up" , andar = false , loop = true },
	{ nome = "dancar340" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_center" , andar = false , loop = true },
	{ nome = "dancar341" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_center_down" , andar = false , loop = true },
	{ nome = "dancar342" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_center_up" , andar = false , loop = true },
	{ nome = "dancar343" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_left" , andar = false , loop = true },
	{ nome = "dancar344" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_left_down" , andar = false , loop = true },
	{ nome = "dancar345" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_left_up" , andar = false , loop = true },
	{ nome = "dancar346" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_right" , andar = false , loop = true },
	{ nome = "dancar347" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_right_down" , andar = false , loop = true },
	{ nome = "dancar348" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "high_right_up" , andar = false , loop = true },
	{ nome = "dancar349" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_center" , andar = false , loop = true },
	{ nome = "dancar350" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_center_down" , andar = false , loop = true },
	{ nome = "dancar351" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_center_up" , andar = false , loop = true },
	{ nome = "dancar352" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_left" , andar = false , loop = true },
	{ nome = "dancar353" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_left_down" , andar = false , loop = true },
	{ nome = "dancar354" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_left_up" , andar = false , loop = true },
	{ nome = "dancar355" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_right" , andar = false , loop = true },
	{ nome = "dancar356" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_right_down" , andar = false , loop = true },
	{ nome = "dancar357" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "low_right_up" , andar = false , loop = true },
	{ nome = "dancar358" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_center" , andar = false , loop = true },
	{ nome = "dancar359" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_center_down" , andar = false , loop = true },
	{ nome = "dancar360" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_center_up" , andar = false , loop = true },
	{ nome = "dancar361" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_left" , andar = false , loop = true },
	{ nome = "dancar362" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_left_down" , andar = false , loop = true },
	{ nome = "dancar363" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_left_up" , andar = false , loop = true },
	{ nome = "dancar364" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_right" , andar = false , loop = true },
	{ nome = "dancar365" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_right_down" , andar = false , loop = true },
	{ nome = "dancar366" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_a@" , anim = "med_right_up" , andar = false , loop = true },
	{ nome = "dancar367" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_center" , andar = false , loop = true },	
	{ nome = "dancar368" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_center_down" , andar = false , loop = true },	
	{ nome = "dancar369" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_center_up" , andar = false , loop = true },	
	{ nome = "dancar370" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_left" , andar = false , loop = true },	
	{ nome = "dancar371" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_left_down" , andar = false , loop = true },	
	{ nome = "dancar372" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_left_up" , andar = false , loop = true },	
	{ nome = "dancar373" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_right" , andar = false , loop = true },	
	{ nome = "dancar374" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_right_down" , andar = false , loop = true },	
	{ nome = "dancar375" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "high_right_up" , andar = false , loop = true },	
	{ nome = "dancar376" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_center" , andar = false , loop = true },	
	{ nome = "dancar377" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_center_down" , andar = false , loop = true },	
	{ nome = "dancar378" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_center_up" , andar = false , loop = true },	
	{ nome = "dancar379" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_left" , andar = false , loop = true },	
	{ nome = "dancar380" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_left_down" , andar = false , loop = true },	
	{ nome = "dancar381" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_left_up" , andar = false , loop = true },	
	{ nome = "dancar382" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_right" , andar = false , loop = true },	
	{ nome = "dancar383" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_right_down" , andar = false , loop = true },	
	{ nome = "dancar384" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "low_right_up" , andar = false , loop = true },	
	{ nome = "dancar385" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_center" , andar = false , loop = true },	
	{ nome = "dancar386" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_center_down" , andar = false , loop = true },	
	{ nome = "dancar387" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_center_up" , andar = false , loop = true },	
	{ nome = "dancar388" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_left" , andar = false , loop = true },	
	{ nome = "dancar389" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_left_down" , andar = false , loop = true },	
	{ nome = "dancar390" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_left_up" , andar = false , loop = true },	
	{ nome = "dancar391" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_right" , andar = false , loop = true },	
	{ nome = "dancar392" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_right_down" , andar = false , loop = true },	
	{ nome = "dancar393" , dict = "anim@amb@casino@mini@dance@dance_solo@female@var_b@" , anim = "med_right_up" , andar = false , loop = true },	
	{ nome = "sexo" , dict = "rcmpaparazzo_2" , anim = "shag_loop_poppy" , andar = false , loop = true },
	{ nome = "sexo2" , dict = "rcmpaparazzo_2" , anim = "shag_loop_a" , andar = false , loop = true },
	{ nome = "sexo3" , dict = "anim@mp_player_intcelebrationfemale@air_shagging" , anim = "air_shagging" , andar = false , loop = true },
	{ nome = "sexo4" , dict = "oddjobs@towing" , anim = "m_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo5" , dict = "oddjobs@towing" , anim = "f_blow_job_loop" , andar = false , loop = true , carros = true },
	{ nome = "sexo6" , dict = "mini@prostitutes@sexlow_veh" , anim = "low_car_sex_loop_female" , andar = false , loop = true , carros = true },
	{ nome = "sexo7" , dict = "misscarsteal2pimpsex" , anim = "pimpsex_hooker" , andar = false , loop = true }, -- BOQUETE DAR

	{ nome = "sexo8" , dict = "director@character_select_intro@female" , anim = "exit_trailer_female_sexy" , andar = false , loop = true },
	


	--[[ { nome = "sentar" , anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" , extra = function()
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(chairs) do
            local object = GetClosestObjectOfType(x,y,z,0.7,GetHashKey(v[1]),0,0,0)
            if DoesEntityExist(object) then
                local x2,y2,z2 = table.unpack(GetEntityCoords(object))
                FreezeEntityPosition(object,true)
                SetEntityCoords(ped,x2,y2,z2+v[2])
                SetEntityHeading(ped,GetEntityHeading(object)-180.0)
            end
        end
    end }, ]]
	{ nome = "sentar2" , dict = "amb@world_human_picnic@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar3" , dict = "anim@heists@fleeca_bank@ig_7_jetski_owner" , anim = "owner_idle" , andar = false , loop = true },
	{ nome = "sentar4" , dict = "amb@world_human_stupor@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar5" , dict = "amb@world_human_picnic@female@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar6" , dict = "anim@amb@nightclub@lazlow@lo_alone@" , anim = "lowalone_base_laz" , andar = false , loop = true },
	{ nome = "sentar7" , dict = "anim@amb@business@bgen@bgen_no_work@" , anim = "sit_phone_phoneputdown_idle_nowork" , andar = false , loop = true },
	{ nome = "sentar8" , dict = "rcm_barry3" , anim = "barry_3_sit_loop" , andar = false , loop = true },
	{ nome = "sentar9" , dict = "amb@world_human_picnic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar10" , dict = "amb@world_human_picnic@female@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar11" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "idle_a_jimmy" , andar = false , loop = true },
	{ nome = "sentar12" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_jimmy" , andar = false , loop = true },
	{ nome = "sentar13" , dict = "amb@world_human_stupor@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sentar14" , dict = "timetable@tracy@ig_14@" , anim = "ig_14_base_tracy" , andar = false , loop = true },
	{ nome = "sentar15" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_loop_ped_b" , andar = false , loop = true },
	{ nome = "sentar16" , dict = "anim@heists@ornate_bank@hostages@ped_e@" , anim = "flinch_loop" , andar = false , loop = true },
	{ nome = "sentar17" , dict = "timetable@ron@ig_5_p3" , anim = "ig_5_p3_base" , andar = false , loop = true },
	{ nome = "sentar18" , dict = "timetable@reunited@ig_10" , anim = "base_amanda" , andar = false , loop = true },
	{ nome = "sentar19" , dict = "timetable@ron@ig_3_couch" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar20" , dict = "timetable@jimmy@mics3_ig_15@" , anim = "mics3_15_base_tracy" , andar = false , loop = true },
	{ nome = "sentar21" , dict = "timetable@maid@couch@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar22" , dict = "timetable@ron@ron_ig_2_alt1" , anim = "ig_2_alt1_base" , andar = false , loop = true },
	{ nome = "sentar23" , dict = "timetable@reunited@ig_10" , anim ="shouldntyouguys_jimmy" , andar = false , loop = true },
    { nome = "sentar24" , dict = "timetable@tracy@ig_2@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar25" , dict = "anim@amb@office@boss@female@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar26" , dict = "anim@amb@casino@out_of_money@ped_female@01a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar27" , dict = "anim@amb@casino@out_of_money@ped_female@01b@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar28" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar29" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@01b@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar30" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar31" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02b@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar32" , dict = "anim_casino_a@amb@casino@games@slots@ped_female@regular@02a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar33" , dict = "anim_casino_b@amb@casino@games@blackjack@ped_male@engaged@01a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar34" , dict = "misslester1aig_3main" , anim ="air_guitar_01_a" , andar = false , loop = true },
    { nome = "sentar35" , dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim ="sitting_loop_wade" , andar = false , loop = true },
    { nome = "sentar36" , dict = "switch@franklin@stripclub2" , anim ="ig_16_base" , andar = false , loop = true },
    { nome = "sentar37" , dict = "switch@michael@restaurant" , anim ="001510_02_gc_mics3_ig_1_base_amanda" , andar = false , loop = true },
    { nome = "sentar38" , dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
    { nome = "sentar39" , dict = "timetable@amanda@facemask@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar40" , dict = "timetable@reunited@ig_7" , anim ="amandabase_amanda" , andar = false , loop = true },
    { nome = "sentar41" , dict = "timetable@tracy@ig_2@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar42" , dict = "mini@strip_club@backroom@" , anim ="leadin_loop_idle_c_stripper_c" , andar = false , loop = true },
    { nome = "sentar43" , dict = "timetable@trevor@smoking_meth@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar44" , dict = "switch@michael@sitting_on_car_premiere" , anim ="sitting_on_car_premiere_loop_player" , andar = false , loop = true },
    { nome = "sentar45" , dict = "mp_am_stripper" , anim ="lap_dance_player" , andar = false , loop = true },
    { nome = "sentar46" , dict = "switch@michael@opens_door_for_ama" , anim ="001895_02_mics3_17_opens_door_for_ama_idle_ama" , andar = false , loop = true },
    { nome = "sentar47" , dict = "switch@michael@lounge_chairs" , anim ="001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
    { nome = "sentar48" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01a@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
    { nome = "sentar49" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar50" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
    { nome = "sentar51" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar52" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01b@base_big_screen" , anim ="base_big_screen" , andar = false , loop = true },
    { nome = "sentar53" , dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02a@trans" , anim ="base_to_big_screen" , andar = false , loop = true },
    { nome = "sentar54" , dict = "switch@michael@parkbench_smoke_ranger" , anim ="parkbench_smoke_ranger_loop" , andar = false , loop = true },
    { nome = "sentar55" , dict = "switch@michael@lounge_chairs" , anim ="001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
    { nome = "sentar56" , dict = "anim@amb@business@cfm@cfm_machine_no_work@" , anim ="smokers_cough_v1_operator" , andar = false , loop = true },
    { nome = "sentar57" , dict = "rcmnigel1a_band_groupies" , anim ="bump_f1" , andar = false , loop = true },
    { nome = "sentar58" , dict = "anim@amb@nightclub@smoking@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar59" , dict = "amb@lo_res_idles@" , anim = "world_human_picnic_female_lo_res_base" , andar = false , loop = true },
    { nome = "sentar60" , dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim ="massage_loop_2_trevor" , andar = false , loop = true },
    { nome = "sentar61" , dict = "anim_casino_b@amb@casino@games@blackjack@ped_female@no_heels@regular@02a@reacts@v01" , anim ="reaction_impartial_var03" , andar = false , loop = true },
    { nome = "sentar62" , dict = "anim@amb@clubhouse@boss@female@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar63" , dict = "timetable@denice@ig_4" , anim = "base" , andar = false , loop = true },
    { nome = "sentar64" , anim = "snort_coke_a_female" , dict  = "missfbi3_party" , andar = false , loop = true },
    { nome = "sentar65" , anim = "loop_amanda" , dict  = "switch@michael@cafe" , andar = false , loop = true },
	{ nome = "sentar66" , dict = "safe@michael@ig_3" , anim ="base_michael" , andar = false , loop = true },
	{ nome = "sentar67" , dict = "rcmnigel1a_band_groupies" , anim ="base_m1" , andar = false , loop = true },
	{ nome = "sentar68" , dict = "anim@heists@fleeca_bank@hostages@intro" , anim ="intro_loop_ped_a" , andar = false , loop = true },
	{ nome = "sentar69" , dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
	{ nome = "sentar70" , dict = "timetable@reunited@ig_10" , anim = "shouldntyouguys_amanda" , andar = false , loop = true },
	{ nome = "sentar71" , dict = "bs_1_int-9" , anim = "player_one_dual-9" , andar = false , loop = true },
	{ nome = "sentar72" , dict = "anim@amb@office@boss@female@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar73" , dict = "rcmnigel1a_band_groupies" , anim = "bump_f1" , andar = false , loop = true },
	{ nome = "sentar74" , dict= "missheistdocks2aleadinoutlsdh_2a_int" , anim = "sitting_loop_wade" , andar = false , loop = true },
	{ nome = "sentar75" , dict= "anim@amb@business@cfid@cfid_desk_no_work_bgen_chair_no_work@" , anim = "lookaround_phoneless_lazyworker" , andar = false , loop = true },
	{ nome = "sentar76" , dict= "switch@michael@restaurant" , anim = "001510_02_gc_mics3_ig_1_base_amanda" , andar = false , loop = true },
	{ nome = "sentar77" , dict= "timetable@reunited@ig_7" , anim = "amandabase_amanda" , andar = false , loop = true },
	{ nome = "sentar78" , dict= "mini@strip_club@backroom@" , anim = "leadin_loop_idle_c_stripper_c" , andar = false , loop = true },
	{ nome = "sentar79" , dict= "switch@michael@lounge_chairs" , anim = "001523_01_mics3_9_lounge_chairs_idle_mic" , andar = false , loop = true },
	{ nome = "sentar80" , dict= "anim_casino_a@amb@casino@games@insidetrack@ped_female@engaged@01b@base_big_screen" , anim = "base_big_screen" , andar = false , loop = true },
	{ nome = "sentar81" , dict= "anim_casino_a@amb@casino@games@insidetrack@ped_female@regular@01a@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar82" , dict= "missheistdocks2aleadinoutlsdh_2a_int" , anim = "massage_loop_2_trevor" , andar = false , loop = true },
	{ nome = "sentar83" , dict= "timetable@amanda@ig_7" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar84" , dict= "hs3_pln_int-0" , anim = "csb_huang_dual-0" , andar = false , loop = true },
	{ nome = "sentar85" , dict = "timetable@tracy@ig_14@" , anim ="ig_14_iwishall_a_tracy" , andar = false , loop = true },
    { nome = "sentar86" , dict = "mp_safehouselost_table@" , anim ="lost_table_idle_a" , andar = false , loop = true },
    { nome = "sentar87" , dict = "timetable@ron@ron_ig_2_alt1" , anim ="ig_2_alt1_base" , andar = false , loop = true },
    { nome = "sentar88" , dict = "anim@amb@office@boss@female@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar89" , dict = "rcmnigel1aig_1" , anim ="you_know_girl" , andar = false , loop = true },
    { nome = "sentar90" , dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar91" , dict = "anim@amb@facility@briefing_room@seating@female@var_b@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar92" , dict = "switch@michael@ronex_ig_5_p2" , anim ="base_michael" , andar = false , loop = true },
    { nome = "sentar93" , dict = "switch@franklin@stripclub3" , anim ="ig_17_base" , andar = false , loop = true },
    { nome = "sentar94" , dict = "safe@franklin@ig_14" , anim ="base" , andar = false , loop = true },
    { nome = "sentar95" , dict = "rcmnigel1bnmt_1b" , anim ="base_girl" , andar = false , loop = true },
    { nome = "sentar96" , dict = "anim@amb@business@cfm@cfm_machine_no_work@" , anim ="hanging_out_operator" , andar = false , loop = true },
    { nome = "sentar97" , dict = "timetable@reunited@ig_10" , anim ="shouldntyouguys_tracy" , andar = false , loop = true },
    { nome = "sentar98" , dict = "missfbi3_party" , anim ="snort_coke_b_male5" , andar = false , loop = true },
    { nome = "sentar99" , dict = "missheistpaletoscoresetupleadin" , anim ="rbhs_mcs_1_leadin" , andar = false , loop = true },
    { nome = "sentar100" , dict = "misslester1aig_3exit" , anim ="air_guitar_01_exitloop_d" , andar = false , loop = true },
    { nome = "sentar101" , dict = "misslester1aig_3main" , anim ="air_guitar_01_b" , andar = false , loop = true },
    { nome = "sentar102" , dict = "misslester1aig_5intro" , anim ="boardroom_intro_f_c" , andar = false , loop = true },
    { nome = "sentar103" , dict = "misslester1b_crowd@m_" , anim ="001082_01_m_a" , andar = false , loop = true },
    { nome = "sentar104" , dict = "mp_am_stripper" , anim ="lap_dance_player" , andar = false , loop = true },
    { nome = "sentar105" , dict = "safe@franklin@ig_14" , anim ="base" , andar = false , loop = true },
    { nome = "sentar106" , dict = "switch@trevor@mocks_lapdance" , anim ="001443_01_trvs_28_idle_man" , andar = false , loop = true },
    { nome = "sentar107" , dict = "switch@trevor@rude_at_cafe" , anim ="001218_03_trvs_23_rude_at_cafe_idle_female" , andar = false , loop = true },
	{ nome = "sentar108" , dict = "amb@world_human_seat_steps@female@maos_by_sides@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar109" , dict = "amb@world_human_seat_wall@female@maos_by_sides@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar110" , dict = "timetable@trevor@trv_ig_2" , anim ="base_trevor" , andar = false , loop = true },
    { nome = "sentar111" , dict = "missdrfriedlanderdrf_idles" , anim ="drf_idle_drf" , andar = false , loop = true },
    { nome = "sentar112" , dict = "anim@amb@clubhouse@boss@female@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar113" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base_r@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar114" , dict = "anim@amb@office@seating@female@var_b@base@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar115" , dict = "anim@amb@office@seating@female@var_c@base@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar116" , dict = "amb@world_human_seat_steps@male@elbows_on_knees@base" , anim ="base" , andar = false , loop = true },
    { nome = "sentar117" , dict = "anim@amb@facility@briefing_room@seating@male@var_a@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar118" , dict = "anim@amb@clubhouse@boardroom@boss@female@base_r@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar119" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar120" , dict = "iaaj_ext-27" , anim ="csb_mp_agent14_dual-27" , andar = false , loop = true },
    { nome = "sentar121" , dict = "anim@amb@facility@briefing_room@seating@male@var_b@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar122" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar123" , dict = "missfam2_bikehire@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar124" , dict = "missarmenian2" , anim ="car_react_gang_ps" , andar = false , loop = true },
    { nome = "sentar125" , dict = "anim@amb@office@boardroom@boss@male@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar126" , dict = "anim@amb@office@seating@female@var_a@base@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar127" , dict = "anim@amb@office@seating@male@var_b@base@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar128" , dict = "anim@amb@office@seating@male@var_e@base@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar129" , dict = "anim@amb@office@boardroom@crew@male@var_b@base_r@" , anim ="base" , andar = false , loop = true },
    { nome = "sentar130" , dict = "sub_int-38" , anim ="mp_m_freemode_01^1_dual-38" , andar = false , loop = true },
    { nome = "sentar131" , dict = "sil_int-28" , anim ="mp_m_freemode_01_dual-28" , andar = false , loop = true },
    { nome = "sentar132" , dict = "drf_mic_1_cs_1-15" , anim ="cs_drfriedlander_dual-15" , andar = false , loop = true },
    { nome = "sentar133" , dict = "drf_mic_1_cs_1-24" , anim ="cs_drfriedlander_dual-24" , andar = false , loop = true },
    { nome = "sentar134" , dict = "drf_mic_1_cs_1-30" , anim ="cs_drfriedlander_dual-30" , andar = false , loop = true },
    { nome = "sentar135" , dict = "amb@lo_res_idles@" , anim = "prop_human_deckchair_female_lo_res_base" , andar = false , loop = true },
    { nome = "sentar136" , dict = "anim@amb@office@boardroom@boss@male@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar137" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar138" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_l@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar139" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar140" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar141" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_b@base_r@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar142" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar143" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_l@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar144" , dict = "anim@amb@clubhouse@boardroom@crew@female@var_c@base_r@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar145" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar146" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_l@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar147" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base_r@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar148" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_b@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar149" , dict = "anim@amb@clubhouse@boardroom@crew@male@var_c@base@" , anim = "base" , andar = false , loop = true },
    { nome = "sentar150" , dict = "amb@incar@male@smoking_van@enter" , anim = "enter" , andar = false , loop = true },
    { nome = "sentar151" , dict = "anim@amb@yacht@jacuzzi@seated@female@variation_05@" , anim = "idle_a" , andar = false , loop = true },
    { nome = "sentar152" , dict = "family_4_mcs_2-2" , anim = "csb_hugh_dual-2" , andar = false , loop = true },
	{ nome = "sentar153" , dict = "anim@amb@office@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar154" , dict = "arm_1_mcs_2_concat-0" , anim = "cs_denise_dual-0" , andar = false , loop = true },
	{ nome = "sentar155" , dict= "anim@amb@facility@briefing_room@seating@male@var_a@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar156" , dict= "anim@amb@office@seating@female@var_b@base@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar157" , dict= "anim@amb@office@seating@female@var_c@base@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar158" , dict= "anim@amb@clubhouse@boardroom@crew@female@var_a@base_r@" , anim = "base" , andar = false , loop = true },
	{ nome = "sentar159" , dict= "missheist_jewelleadinout" , anim = "jh_int_outro_loop_d" , andar = false , loop = true },
	{ nome = "sentar160" , dict= "drf_mic_1_cs_1-15" , anim = "cs_drfriedlander_dual-15" , andar = false , loop = true },
	{ nome = "sentar161" , dict= "sol_3_int-9" , anim = "cs_molly_dual-9" , andar = false , loop = true },
	{ nome = "sentar162" , dict= "sil_int-29" , anim = "mp_m_freemode_01^3_dual-29" , andar = false , loop = true },
	--{ nome = "beijar" , dict = "mp_ped_interaction" , anim = "kisses_guy_a" , andar = false , loop = false },
	{ nome = "striper" , dict = "mini@strip_club@idles@stripper" , anim = "stripper_idle_02" , andar = false , loop = true },
	{ nome = "escutar" , dict = "mini@safe_cracking" , anim = "idle_base" , andar = false , loop = true },
	{ nome = "alongar" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_e" , andar = false , loop = true },
	{ nome = "alongar2" , dict = "mini@triathlon" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "alongar3" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_c" , andar = false , loop = false },
	{ nome = "alongar4" , dict = "mini@triathlon" , anim = "idle_f" , andar = false , loop = true },
	{ nome = "alongar5" , dict = "mini@triathlon" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "alongar6" , dict = "rcmfanatic1maryann_stretchidle_b" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "alongar7" , dict = "timetable@reunited@ig_2" , anim = "jimmy_getknocked" , andar = false , loop = true },
	{ nome = "dj" , dict = "anim@mp_player_intupperdj" , anim = "idle_a", andar = true , loop = true },
	{ nome = "dj2" , dict = "anim@mp_player_intupperair_synth" , anim = "idle_a_fp" , andar = false , loop = true },
	{ nome = "dj3" , dict = "anim@mp_player_intcelebrationfemale@air_synth" , anim = "air_synth" , andar = false , loop = false },
	{ nome = "rock" , dict = "anim@mp_player_intcelebrationmale@air_guitar" , anim = "air_guitar" , andar = false , loop = true },
	{ nome = "rock2" , dict = "mp_player_introck" , anim = "mp_player_int_rock" , andar = false , loop = false },
	{ nome = "abracar" , dict = "mp_ped_interaction" , anim = "hugs_guy_a" , andar = false , loop = false },
	{ nome = "abracar2" , dict = "mp_ped_interaction" , anim = "kisses_guy_b" , andar = false , loop = false },
	{ nome = "peitos" , dict = "mini@strip_club@backroom@" , anim = "stripper_b_backroom_idle_b" , andar = false , loop = false },
	{ nome = "espernear" , dict = "missfam4leadinoutmcs2" , anim = "tracy_loop" , andar = false , loop = true },
	{ nome = "arrumar" , dict = "anim@amb@business@coc@coc_packing_hi@" , anim = "full_cycle_v1_pressoperator" , andar = false , loop = true },
	{ nome = "coca" , dict = "anim@amb@business@coc@coc_packing_hi@" , anim = "full_cycle_v3_pressoperator" , andar = false , loop = true },
	{ nome = "bebado" , dict = "missfam5_blackout" , anim = "pass_out" , andar = false , loop = false },
	{ nome = "bebado2" , dict = "missheist_agency3astumble_getup" , anim = "stumble_getup" , andar = false , loop = false },
	{ nome = "bebado3" , dict = "missfam5_blackout" , anim = "vomit" , andar = false , loop = false },
	{ nome = "bebado4" , dict = "random@drunk_driver_1" , anim = "drunk_fall_over" , andar = false , loop = false },
	{ nome = "bebado5" , dict = "misscarsteal4@actor" , anim = "stumble" , andar = false , loop = false },
	{ nome = "yoga" , dict = "missfam5_yoga" , anim = "f_yogapose_a" , andar = false , loop = true },
	{ nome = "yoga2" , dict = "amb@world_human_yoga@male@base" , anim = "base_a" , andar = false , loop = true },
	{ nome = "abdominal" , dict = "amb@world_human_sit_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "piriguete" , anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	{ nome = "piriguete2" , dict = "switch@michael@prostitute" , anim = "base_hooker" , andar = false , loop = true },
	{ nome = "piriguete3" , dict = "switch@michael@prostitute" , anim = "exit_hooker" , andar = false , loop = true },
	{ nome = "britadeira" , dict = "amb@world_human_const_drill@male@drill@base" , anim = "base" , prop = "prop_tool_jackham" , flag = 15 , hand = 28422 },
	{ nome = "cerveja" , anim = "WORLD_HUMAN_PARTYING" },
	{ nome = "churrasco" , anim = "PROP_HUMAN_BBQ" },
	{ nome = "consertar" , anim = "WORLD_HUMAN_WELDING" },
	{ nome = "bracos" , dict = "anim@heists@heist_corona@single_team" , anim = "single_team_loop_boss" , andar = true , loop = true },
	{ nome = "dormir" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_a" , andar = false , loop = true },
	{ nome = "dormir2" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_e" , andar = false , loop = true },
	{ nome = "dormir3" , dict = "anim@heists@ornate_bank@hostages@hit" , anim = "hit_react_die_loop_ped_h" , andar = false , loop = true },
	{ nome = "dormir4" , dict = "mp_sleep" , anim = "sleep_loop" , andar = false , loop = true },
	{ nome = "dormir5" , dict = "missarmenian2" , anim = "drunk_loop" , andar = false , loop = true },
	{ nome = "encostar" , dict = "amb@lo_res_idles@" , anim = "world_human_lean_male_foot_up_lo_res_base" , andar = false , loop = true },
	{ nome = "encostar2" , dict = "bs_2a_mcs_10-0" , anim = "hc_gunman_dual-0" , andar = false , loop = true },
	{ nome = "encostar3" , dict = "misscarstealfinalecar_5_ig_1" , anim = "waitloop_lamar" , andar = false , loop = true },
	{ nome = "encostar4" , dict = "anim@amb@casino@out_of_money@ped_female@02b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar5" , dict = "anim@amb@casino@hangout@ped_male@stand@03b@base" , anim = "base" , andar = true , loop = true },
	{ nome = "encostar6" , dict = "anim@amb@casino@hangout@ped_female@stand@02b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar7" , dict = "anim@amb@casino@hangout@ped_female@stand@02a@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar8" , dict = "anim@amb@casino@hangout@ped_female@stand@01b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "encostar9" , dict = "anim@amb@clubhouse@bar@bartender@" , anim = "base_bartender" , andar = false , loop = true },
	{ nome = "encostar10" , dict = "missclothing" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "encostar11" , dict = "misscarstealfinale" , anim = "packer_idle_1_trevor" , andar = false , loop = true },
	{ nome = "encostar12" , dict = "missarmenian1leadinoutarm_1_ig_14_leadinout" , anim = "leadin_loop" , andar = false , loop = true },
	{ nome = "flexao" , dict = "amb@world_human_push_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "fisico" , anim = "WORLD_HUMAN_MUSCLE_FLEX" },
	{ nome = "fumar" , anim = "WORLD_HUMAN_SMOKING" },
	{ nome = "fumar2" , anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS" },
	{ nome = "fumar3" , anim = "WORLD_HUMAN_AA_SMOKE" },
	{ nome = "fumar4" , anim = "WORLD_HUMAN_SMOKING_POT" },
	{ nome = "tragar" , dict = "amb@world_human_aa_smoke@male@idle_a" , anim = "idle_c" , prop = "p_cs_joint_02" , flag = 49 , hand = 28422 },
	{ nome = "fumar6" , dict = "amb@world_human_smoking@female@idle_a" , anim = "idle_b" , prop = "prop_cs_ciggy_01" , flag = 49 , hand = 28422 },
	{ nome = "fumar7" , dict = "amb@world_human_smoking@female@idle_a", anim = "idle_b", prop = "prop_cs_ciggy_01", flag = 49, mao = 28422 },
	{ nome = "malhar" , dict = "amb@world_human_muscle_free_weights@male@barbell@base" , anim = "base" , prop = "prop_curl_bar_01" , flag = 49 , hand = 28422 },
	{ nome = "malhar2" , dict = "amb@prop_human_muscle_chin_ups@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "martelo" , dict = "amb@world_human_hammering@male@base" , anim = "base" , prop = "prop_tool_hammer" , flag = 49 , hand = 28422 },
	{ nome = "pescar" , dict = "amb@world_human_stand_fishing@base" , anim = "base" , prop = "prop_fishing_rod_01" , flag = 49 , hand = 60309 },
	{ nome = "pescar2" , dict = "amb@world_human_stand_fishing@idle_a" , anim = "idle_c" , prop = "prop_fishing_rod_01" , flag = 49 , hand = 60309 },
	{ nome = "plantar" , dict = "amb@world_human_gardener_plant@female@base" , anim = "base_female" , andar = false , loop = true },
	{ nome = "plantar2" , dict = "amb@world_human_gardener_plant@female@idle_a" , anim = "idle_a_female" , andar = false , loop = true },
	{ nome = "procurar" , dict = "amb@world_human_bum_wash@male@high@base" , anim = "base" , andar = false , loop = true },
	{ nome = "soprador" , dict = "amb@code_human_wander_gardener_leaf_blower@base" , anim = "static" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },
	{ nome = "soprador2" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_a" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },
	{ nome = "soprador3" , dict = "amb@code_human_wander_gardener_leaf_blower@idle_a" , anim = "idle_b" , prop = "prop_leaf_blower_01" , flag = 49 , hand = 28422 },

	{ nome = "trotar" , dict = "amb@world_human_jog_standing@male@fitidle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "esquentar" , anim = "WORLD_HUMAN_STAND_FIRE" },
	{ nome = "selfie" , dict = "cellphone@self" , anim = "selfie_in_from_text" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "selfie2" , dict = "cellphone@" , anim = "cellphone_text_read_base_cover_low" , prop = "prop_amb_phone" , flag = 50 , hand = 28422 },
	{ nome = "mecanico" , dict = "amb@world_human_vehicle_mechanic@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "mecanico2" , dict = "mini@repair" , anim = "fixing_a_player" , andar = false , loop = true },
	{ nome = "mecanico3" , dict = "mini@repair" , anim = "fixing_a_ped" , andar = false , loop = true },
	{ nome = "pullover" , dict = "misscarsteal3pullover" , anim = "pull_over_right" , andar = false , loop = false },
	{ nome = "airguitar" , dict = "anim@mp_player_intcelebrationfemale@air_guitar" , anim = "air_guitar" , andar = false , loop = true },
	{ nome = "airsynth" , dict = "anim@mp_player_intcelebrationfemale@air_synth" , anim = "air_synth" , andar = false , loop = true },
	{ nome = "puto" , dict = "misscarsteal4@actor" , anim = "actor_berating_loop" , andar = true , loop = true },
	{ nome = "puto2" , dict = "oddjobs@assassinate@vice@hooker" , anim = "argue_a" , andar = true , loop = true },
	{ nome = "puto3" , dict = "mini@triathlon" , anim = "want_some_of_this" , andar = false , loop = false },
	{ nome = "unhas" , dict = "anim@amb@clubhouse@bar@drink@idle_a" , anim = "idle_a_bartender" , andar = true , loop = true },
	{ nome = "mandarbeijo" , dict = "anim@mp_player_intcelebrationfemale@blow_kiss" , anim = "blow_kiss" , andar = false , loop = false },
	{ nome = "mandarbeijo2" , dict = "anim@mp_player_intselfieblow_kiss" , anim = "exit" , andar = false , loop = false },
	{ nome = "bale" , dict = "anim@mp_player_intcelebrationpaired@f_f_sarcastic" , anim = "sarcastic_left" , andar = false , loop = true },
	{ nome = "bonzao" , dict = "misscommon@response" , anim = "bring_it_on" , andar = false , loop = false },
	{ nome = "cruzarbraco" , dict = "anim@amb@nightclub@peds@" , anim = "rcmme_amanda1_stand_loop_cop" , andar = true , loop = true },
	{ nome = "cruzarbraco2" , dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a" , anim = "idle_a" , andar = true , loop = true },
	--[[ { nome = "cruzarbraco3" , dict = "mp_arresting" , anim = "idle" , andar = true , loop = true }, ]]

	{ nome = "mijar" , dict = "misscarsteal2peeing" , anim = "peeing_intro" , andar = false , loop = false , extra = function()
		local ped = PlayerPedId()
		SetTimeout(4000,function()
			TriggerServerEvent("trySyncParticle","peeing",PedToNet(ped))
			Citizen.Wait(4500)
			TriggerServerEvent("tryStopParticle",PedToNet(ped))
		end)
	end },
	{ nome = "cagar" , dict = "missfbi3ig_0" , anim = "shit_loop_trev" , andar = false , loop = false , extra = function()
		local ped = PlayerPedId()
		TriggerServerEvent("trySyncParticle","poo",PedToNet(ped))
		SetTimeout(15000,function()
			TriggerServerEvent("tryStopParticle",PedToNet(ped))
		end)
	end	},
	{ nome = "aqui" , dict = "gestures@f@standing@casual" , anim = "gesture_hand_down" , andar = true , loop = false },
	{ nome = "inspecionar" , dict = "random@train_tracks" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "buuu" , dict = "anim@mp_player_intcelebrationfemale@jazz_hands" , anim = "jazz_hands" , andar = true , loop = false },
	{ nome = "coelho", dict = "random@peyote@rabbit", anim = "wakeup", andar = false, loop = true  },
	{ nome = "coelho2", dict = "random@peyote@rabbit", anim = "wakeup_loop", andar = false, loop = true  },
	{ nome = "unhas" , dict = "anim@amb@clubhouse@bar@drink@idle_a" , anim = "idle_a_bartender" , andar = true , loop = true },
	{ nome = "lanca", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca" , flag = 49 , mao = 28422},  
	{ nome = "lancab", dict = "amb@incar@male@smoking@enter", anim = "enter", prop = "mah_lanca_02" , flag = 49 , mao = 28422}, 
	{ nome = "livro" , dict = "cellphone@" , anim = "cellphone_text_read_base" , prop = "prop_novel_01" , andar = true , loop = true , flag = 49 , hand = 6286 , pos1 = 0.15 , pos2 = 0.03 , pos3 = -0.065 , pos4 = 0.0 , pos5 = 180.0 , pos6 = 90.0 , propAnim = true },
	{ nome = "urso" , dict = "impexp_int-0" , anim = "mp_m_waremech_01_dual-0" , prop = "v_ilev_mr_rasberryclean" , andar = true , loop = true , flag = 49 , hand = 24817 , pos1 = -0.20 , pos2 = 0.46 , pos3 = -0.016 , pos4 = -180.0 , pos5 = -90.0 , pos6 = 0.0 , propAnim = true },
	{ nome = "dinheiro" , dict = "anim@mp_player_intupperraining_cash" , anim = "idle_a" , prop = "prop_anim_cash_pile_01" , andar = true , loop = true , flag = 49 , hand = 60309 , pos1 = 0.0 , pos2 = 0.0 , pos3 = 0.0 , pos4 = 180.0 , pos5 = 0.0 , pos6 = 70.0 , propAnim = true },
	{ nome = "capo" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_bonnet_03a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.2 , pos2 = 0.2 , pos3 = -0.1 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 180.0 , propAnim = true },
	{ nome = "porta" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_car_door_04a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = -0.5 , pos2 = -0.15 , pos3 = -0.1 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 90.0 , propAnim = true },
	{ nome = "parachoque" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "imp_prop_impexp_front_bumper_02a" , andar = true , loop = true , flag = 49 , hand = 28422 , pos1 = 0.0 , pos2 = 0.1 , pos3 = 0.05 , pos4 = 0.0 , pos5 = 0.0 , pos6 = 0.0 , propAnim = true },
	{ nome = "megaphone" , dict = "anim@random@shop_clothes@watches" , anim = "base" , prop = "prop_megaphone_01" , andar = true , loop = true , flag = 49 , hand = 60309 , pos1 = 0.10 , pos2 = 0.04 , pos3 = 0.012 , pos4 = -60.0 , pos5 = 100.0 , pos6 = -30.0 , propAnim = true },
	
	
	{ nome = "megaphone" , dict = "anim@random@shop_clothes@watches", anim = "base", prop = "prop_megaphone_01", flag = 49, mao = 60309, altura = 0.10, pos1 = 0.04, pos2 = 0.012, pos3 = -60.0, pos4 = 100.0, pos5 = -30.0 },
	
	{ nome = "casalm2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_trevor" , andar = false , loop = true },
    { nome = "casalf2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_patricia" , andar = false , loop = true },
    { nome = "casalm3" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_trevor" , andar = false , loop = true },
	{ nome = "casalf3" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_patricia" , andar = false , loop = true },
	{ nome = "wait" , dict = "random@shop_tattoo" , anim = "_idle_a" , andar = true , loop = true },
	{ nome = "wait2" , dict = "rcmnigel1cnmt_1c" , anim = "base" , andar = true , loop = true },
	{ nome = "wait3" , dict = "rcmjosh1", anim = "idle" , andar = true , loop = true },
	{ nome = "wait4" , dict = "timetable@amanda@ig_3" , anim = "ig_3_base_tracy" , andar = true , loop = true },
	{ nome = "wait5" , dict = "misshair_shop@hair_dressers" , anim = "keeper_base" , andar = true , loop = true },
	{ nome = "blowkiss", dict = "anim@mp_player_intcelebrationfemale@blow_kiss" , anim = "blow_kiss" , andar = true , loop = true },



	{ nome = "pose197"  , dict = "lunyx@random@v3@pose001" , anim = "random@v3@pose001" , andar = false , loop = true },
    { nome = "pose198"  , dict = "lunyx@random@v3@pose002" , anim = "random@v3@pose002" , andar = false , loop = true },
    { nome = "pose199"  , dict = "lunyx@random@v3@pose003" , anim = "random@v3@pose003" , andar = false , loop = true },
    { nome = "pose200"  , dict = "lunyx@random@v3@pose004" , anim = "random@v3@pose004" , andar = false , loop = true },
    { nome = "pose201"  , dict = "lunyx@random@v3@pose005" , anim = "random@v3@pose005" , andar = false , loop = true },
    { nome = "pose202"  , dict = "lunyx@random@v3@pose006" , anim = "random@v3@pose006" , andar = false , loop = true },
    { nome = "pose203"  , dict = "lunyx@random@v3@pose007" , anim = "random@v3@pose007" , andar = false , loop = true },
    { nome = "pose204"  , dict = "lunyx@random@v3@pose008" , anim = "random@v3@pose008" , andar = false , loop = true },
    { nome = "pose205"  , dict = "lunyx@random@v3@pose009" , anim = "random@v3@pose009" , andar = false , loop = true },
    { nome = "pose206"  , dict = "lunyx@random@v3@pose010" , anim = "random@v3@pose010" , andar = false , loop = true },
    { nome = "pose207"  , dict = "lunyx@random@v3@pose011" , anim = "random@v3@pose011" , andar = false , loop = true },
    { nome = "pose208"  , dict = "lunyx@random@v3@pose012" , anim = "random@v3@pose012" , andar = false , loop = true },
    { nome = "pose209"  , dict = "lunyx@random@v3@pose013" , anim = "random@v3@pose013" , andar = false , loop = true },
    { nome = "pose210"  , dict = "lunyx@random@v3@pose014" , anim = "random@v3@pose014" , andar = false , loop = true },
    { nome = "pose211"  , dict = "lunyx@random@v3@pose015" , anim = "random@v3@pose015" , andar = false , loop = true },
    { nome = "pose212"  , dict = "lunyx@random@v3@pose016" , anim = "random@v3@pose016" , andar = false , loop = true },
    { nome = "pose213"  , dict = "lunyx@random@v3@pose017" , anim = "random@v3@pose017" , andar = false , loop = true },
    { nome = "pose214"  , dict = "lunyx@random@v3@pose018" , anim = "random@v3@pose018" , andar = false , loop = true },
    { nome = "pose215"  , dict = "lunyx@random@v3@pose019" , anim = "random@v3@pose019" , andar = false , loop = true },
    { nome = "pose216"  , dict = "lunyx@random@v3@pose020" , anim = "random@v3@pose020" , andar = false , loop = true },

	{ nome = "pose1"  , dict = "lunyx@portrait001" , anim = "portrait001" , andar = false , loop = true },
	{ nome = "pose2"  , dict = "lunyx@portrait002" , anim = "portrait002" , andar = false , loop = true },
	{ nome = "pose3"  , dict = "lunyx@portrait003" , anim = "portrait003" , andar = false , loop = true },
	{ nome = "pose4"  , dict = "lunyx@portrait004" , anim = "portrait004" , andar = false , loop = true },
	{ nome = "pose5"  , dict = "lunyx@portrait005" , anim = "portrait005" , andar = false , loop = true }, 
	{ nome = "pose6"  , dict = "lunyx@portrait006" , anim = "portrait006" , andar = false , loop = true },
	{ nome = "pose7"  , dict = "lunyx@portrait007" , anim = "portrait007" , andar = false , loop = true },
	{ nome = "pose8"  , dict = "lunyx@portrait008" , anim = "portrait008" , andar = false , loop = true },
	{ nome = "pose9"  , dict = "lunyx@portrait009" , anim = "portrait009" , andar = false , loop = true },
	{ nome = "pose10"  , dict = "lunyx@portrait010" , anim = "portrait010" , andar = false , loop = true },
	{ nome = "pose11"  , dict = "lunyx@justme001" , anim = "justme001" , andar = false , loop = true },
	{ nome = "pose12"  , dict = "lunyx@justme002" , anim = "justme002" , andar = false , loop = true },
	{ nome = "pose13"  , dict = "lunyx@justme003" , anim = "justme003" , andar = false , loop = true },
	{ nome = "pose14"  , dict = "lunyx@justme004" , anim = "justme004" , andar = false , loop = true },
	{ nome = "pose15"  , dict = "lunyx@justme005" , anim = "justme005" , andar = false , loop = true },
	{ nome = "pose16"  , dict = "lunyx@justme006" , anim = "justme006" , andar = false , loop = true },
	{ nome = "pose17"  , dict = "lunyx@justme007" , anim = "justme007" , andar = false , loop = true },
	{ nome = "pose18"  , dict = "lunyx@justme008" , anim = "justme008" , andar = false , loop = true },
	{ nome = "pose19"  , dict = "lunyx@justme009" , anim = "justme009" , andar = false , loop = true },
	{ nome = "pose20"  , dict = "lunyx@justme010" , anim = "justme010" , andar = false , loop = true },
	{ nome = "pose21"  , dict = "lunyx@justme011" , anim = "justme011" , andar = false , loop = true },
	{ nome = "pose22"  , dict = "lunyx@rgmp01" , anim = "rgmp01" , andar = false , loop = true },
	{ nome = "pose23"  , dict = "lunyx@rgmp02" , anim = "rgmp02" , andar = false , loop = true },
	{ nome = "pose24"  , dict = "lunyx@rgmp03" , anim = "rgmp03" , andar = false , loop = true },
	{ nome = "pose25"  , dict = "lunyx@rgmp04" , anim = "rgmp04" , andar = false , loop = true },
	{ nome = "pose26"  , dict = "lunyx@rgmp05" , anim = "rgmp05" , andar = false , loop = true },
	{ nome = "pose27"  , dict = "lunyx@rgmp06" , anim = "rgmp06" , andar = false , loop = true },
	{ nome = "pose28"  , dict = "lunyx@rgmp07" , anim = "rgmp07" , andar = false , loop = true },
	{ nome = "pose29"  , dict = "lunyx@random001" , anim = "random001" , andar = false , loop = true },
	{ nome = "pose30"  , dict = "lunyx@random002" , anim = "random002" , andar = false , loop = true },
	{ nome = "pose31"  , dict = "lunyx@random003" , anim = "random003" , andar = false , loop = true },
	{ nome = "pose32"  , dict = "syx@cute01" , anim = "cute01" , andar = false , loop = true },
	{ nome = "pose33"  , dict = "syx@cute02" , anim = "cute02" , andar = false , loop = true },
	{ nome = "pose34"  , dict = "syx@cute03" , anim = "cute03" , andar = false , loop = true },
	{ nome = "pose35"  , dict = "syx@cute04" , anim = "cute04" , andar = false , loop = true },
	{ nome = "pose36"  , dict = "syx@cute05" , anim = "cute05" , andar = false , loop = true },
	{ nome = "pose37"  , dict = "lunyx@letswalk@pose001@base_a" , anim = "letswalk@pose001@base_a" , andar = false , loop = true },	
	{ nome = "pose38"  , dict = "lunyx@letswalk@pose001@base_b" , anim = "letswalk@pose001@base_b" , andar = false , loop = true },	
	{ nome = "pose39" , dict = "anim@mp_player_intcelebrationfemale@peace" , anim ="peace" , andar = false , loop = true },
	{ nome = "pose40" , dict = "missfbi3_party_d" , anim ="stand_talk_loop_b_female" , andar = false , loop = true },
	{ nome = "pose41" , dict = "armenian_1_int-44" , anim ="a_m_y_musclbeac_01^1_dual-44" , andar = false , loop = true },
	{ nome = "pose42" , dict = "mp_clothing@female@trousers" , anim ="try_trousers_positive_a" , andar = false , loop = true },
	{ nome = "pose43" , dict = "silj_ext-19" , anim ="mp_m_freemode_01^3_dual-19" , andar = false , loop = true },
	{ nome = "pose44" , dict = "sdrm_mcs_2-0" , anim ="ig_bestmen^1-0" , andar = false , loop = true },
	{ nome = "pose45" , dict = "anim_heist@arcade_combined@" , anim ="ped_female@_stand@_02a@_idles_convo_idle_c" , andar = false , loop = true },
	{ nome = "pose46" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim ="thumbs_down_a_player_a" , andar = false , loop = true },
	{ nome = "pose47" , dict = "guard_reactions" , anim ="1hand_aiming_cycle" , andar = false , loop = true },
	{ nome = "pose48" , dict = "anim@move_f@waitress" , anim ="idle" , andar = false , loop = true },
	{ nome = "pose49" , dict = "anim_heist@arcade_combined@" , anim ="ped_female@_stand_withdrink@_01b@_base_base" , andar = false , loop = true },
	{ nome = "pose50" , dict = "amb@lo_res_idles@" , anim ="world_human_security_shine_torch_lo_res_base" , andar = false , loop = true },
	{ nome = "pose51" , dict = "rcmjosh2" , anim ="stand_lean_back_beckon_a" , andar = false , loop = true },
    { nome = "pose52" , dict = "rcmjosh2" , anim ="stand_lean_back_beckon_b" , andar = false , loop = true },
	{ nome = "pose53" , dict = "pro_mcs_7_concat-1" , anim ="cs_priest_dual-1" , andar = false , loop = true },
	{ nome = "pose54" , dict = "clothingshirt" , anim ="try_shirt_base" , andar = false , loop = true },
	{ nome = "pose55" , dict = "special_ped@pamela@trevor_1@trevor_1a" , anim ="pamela_convo_trevor_im_trying_to_get_noticed_0" , andar = false , loop = true },
    { nome = "pose56" , dict = "special_ped@impotent_rage@intro" , anim ="idle_intro" , andar = false , loop = true },
	{ nome = "pose57" , dict = "random@escape_paparazzi@standing@" , anim ="idle" , andar = false , loop = true },
	{ nome = "pose58" , dict = "pro_mcs_7_concat-8" , anim ="player_two_dual-8" , andar = false , loop = true },
	{ nome = "pose59" , dict = "anim@heists@ornate_bank@thermal_charge" , anim ="cover_eyes_loop" , andar = false , loop = true },
	{ nome = "pose60" , dict = "low_fun_int-7" , anim ="cs_lamardavis_dual-7" , andar = false , loop = true },
    { nome = "pose61" , dict = "tale_intro-12" , anim ="a_f_y_genhot_01^2_dual-12" , andar = false , loop = true },
	{ nome = "pose62" , dict = "amb@code_human_police_investigate@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose63" , dict = "anim@mp_player_intincarpeacebodhi@ds@" , anim ="enter" , andar = false , loop = true },
	{ nome = "pose64" , dict = "anim@mp_corona_idles@female_c@idle_a" , anim ="idle_a" , andar = false , loop = true },
	{ nome = "pose65" , dict = "anim@miss@low@fin@vagos@" , anim ="idle_ped07" , andar = false , loop = true },
	{ nome = "pose66" , dict = "oddjobs@assassinate@multi@" , anim ="idle_a_pros" , andar = false , loop = true },
	{ nome = "pose67" , dict = "timetable@jimmy@ig_5@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose68" , dict = "rcmnigel1bnmt_1b" , anim ="base_tyler" , andar = false , loop = true },
	{ nome = "pose69" , dict = "mp_fm_intro_cut" , anim ="world_human_standing_male_01_idle_03" , andar = false , loop = true },
	{ nome = "pose70" , dict = "mic_4_int-0" , anim ="a_f_y_bevhills_04-0" , andar = false , loop = true },
	{ nome = "pose71" , dict = "mic_4_int-0" , anim ="cs_milton_dual-0" , andar = false , loop = true },
	{ nome = "pose72" , dict = "cellphone@self@franklin@" , anim ="west_coast" , andar = false , loop = true },
	{ nome = "pose73" , dict = "anim@random@shop_clothes@watches" , anim ="idle_d" , andar = false , loop = true },
	{ nome = "pose74" , dict = "amb@world_human_muscle_flex@arms_in_front@idle_a" , anim ="idle_b" , andar = false , loop = true },
	{ nome = "pose75" , dict = "amb@world_human_prostitute@crackhooker@idle_a" , anim ="idle_c" , andar = false , loop = true },
	{ nome = "pose76" , dict = "amb@world_human_prostitute@hooker@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose77" , dict = "anim@mp_player_intupperfinger" , anim ="idle_a" , andar = false , loop = true },
	{ nome = "pose78" , dict = "anim@mp_player_intcelebrationmale@blow_kiss" , anim ="blow_kiss" , andar = false , loop = true },
	{ nome = "pose82" , dict = "mp_player_int_upperbro_love" , anim ="mp_player_int_bro_love_fp" , andar = false , loop = true },
	{ nome = "pose83" , dict = "hs3_arc_int-9" , anim ="csb_georginacheng_dual-9" , andar = false , loop = true },
	{ nome = "pose84" , dict = "armenian_1_int-0" , anim ="a_f_y_beach_01_dual-0" , andar = false , loop = true },
	{ nome = "pose85" , dict = "armenian_1_int-0" , anim ="a_f_y_hipster_02^2-0" , andar = false , loop = true },
	{ nome = "pose86" , dict = "armenian_1_int-0" , anim ="a_f_y_tourist_01^2-0" , andar = false , loop = true },
	{ nome = "pose87" , dict = "armenian_1_int-0" , anim ="a_m_y_beach_03-0" , andar = false , loop = true },
	{ nome = "pose88" , dict = "special_ped@pamela@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose89" , dict = "mp_fm_intro_cut" , anim ="world_human_standing_male_01_idle_01" , andar = false , loop = true },
	{ nome = "pose90" , dict = "amb@world_human_leaning@female@smoke@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose91" , dict = "amb@world_human_leaning@female@wall@back@hand_up@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose92" , dict = "amb@code_human_cross_road@female@base" , anim = "base" , andar = false , loop = true },
	{ nome = "pose93" , dict = "anim@heists@heist_corona@single_team" , anim = "single_team_intro_boss" , andar = false , loop = true },
	{ nome = "pose94" , dict = "amb@incar@male@smoking@idle_a" , anim = "idle_b" , andar = false , loop = true },
	{ nome = "pose95" , anim = "idle_a" , dict  = "anim@amb@casino@hangout@ped_male@stand@02b@idles" , andar = false , loop = true },
	{ nome = "pose96" , anim = "rub_neck_a_m_y_vinewood_01" , dict  = "anim@amb@casino@valet_scenario@pose_c@" , andar = false , loop = true },
	{ nome = "pose97" , dict = "anim@mp_player_intuppershush" , anim = "idle_a_fp" , andar = false , loop = true },
	{ nome = "pose98" , anim = "_car_a_flirt_girl" , dict  = "random@street_race" , andar = false , loop = true },
	{ nome = "pose99" , dict = "misshair_shop@barbers" , anim = "keeper_base" , andar = false , loop = true },
	{ nome = "pose100" , dict = "cellphone@self@franklin@" , anim = "chest_bump" , andar = false , loop = true },
    { nome = "pose101" , dict = "amb@world_human_leaning@male@wall@back@foot_up@aggro_react" , anim = "aggro_react_forward_enter", andar = false , loop = true },
    { nome = "pose102" , dict = "martin_1_int-0" , anim = "cs_patricia_dual-0" , andar = false , loop = true },
    { nome = "pose103" , dict = "mini@strip_club@lap_dance_2g@ld_2g_decline" , anim = "ld_2g_decline_h_s2" , andar = false , loop = true },
    { nome = "pose104" , anim = "stripper_idle_03" , dict  = "mini@strip_club@idles@stripper" , andar = false , loop = true },
    { nome = "pose105" , dict = "amb@world_human_binoculars@male@base" , anim ="base" , andar = false , loop = true },
    { nome = "pose106" , dict = "amb@world_human_tourist_mobile@male@base" , anim ="base" , andar = false , loop = true },
    { nome = "pose107" , dict = "anim@amb@board_room@whiteboard@" , anim ="read_03_amy_skater_01" , andar = false , loop = true },
    { nome = "pose108" , dict = "anim@heists@team_respawn@variations@variation_b_rot" , anim ="respawn_b_ped_c" , andar = false , loop = true },
	{ nome = "pose109" , anim = "idle_d" , dict  = "anim@amb@casino@hangout@ped_female@stand@01a@idles" , andar = false , loop = true },
	{ nome = "pose110" , dict = "amb@world_human_stand_guard@male@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "pose111" , dict = "amb@world_human_tourist_mobile@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "pose112" , dict = "switch@michael@pharmacy" , anim = "mics1_ig_11_loop" , andar = false , loop = true },
	{ nome = "pose113" , dict = "weapons@first_person@aim_idle@p_m_one@unarmed@fidgets@c" , anim = "fidget_low_loop" , andar = false , loop = true },
	{ nome = "pose114" , dict = "armenian_1_int-0" , anim = "player_one_dual-0" , andar = false , loop = true },
	{ nome = "pose115" , dict = "amb@world_human_bum_wash@male@low@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "pose116" , dict = "anim@amb@casino@hangout@ped_male@stand_withdrink@01b@base" , anim = "base" , andar = false , loop = true },
	{ nome = "pose117" , dict = "anim@move_m@trash_rc" , anim = "aim_high_loop" , andar = false , loop = true },
	{ nome = "pose118" , dict = "martin_1_int-10" , anim = "cs_patricia_dual-10" , andar = false , loop = true },
	{ nome = "pose119" , dict = "club_open-30" , anim = "ig_djsolmanager_dual-30" , andar = false , loop = true },
	{ nome = "pose120" , dict= "anim_heist@arcade_combined@" , anim = "ped_female@_stand@_02a@_idles_convo_idle_d" , andar = false , loop = true },
	{ nome = "pose121" , dict= "amb@code_human_police_investigate@base" , anim = "base" , andar = false , loop = true },
	{ nome = "pose122" , dict= "amb@world_human_golf_player@male@base" , anim = "base" , andar = false , loop = true },
	{ nome = "pose123" , dict= "rcmnigel1a" , anim = "base" , andar = false , loop = true },
	{ nome = "pose124" , dict= "timetable@ron@ig_1" , anim = "ig_1_base" , andar = false , loop = true },
	{ nome = "pose125" , dict= "anim@amb@code_human_in_car_idles@arm@generic@ds@idle_j" , anim = "idle_lowdoor" , andar = false , loop = true },
	{ nome = "pose126" , dict= "club_open-0" , anim = "cs_lazlow_2_dual-0" , andar = false , loop = true },
	{ nome = "pose127" , dict= "armenian_1_int-33" , anim = "a_m_y_runner_01-33" , andar = false , loop = true },
	{ nome = "pose128" , dict= "armenian_1_int-33" , anim = "ig_lamardavis_dual-33" , andar = false , loop = true },
	{ nome = "pose129" , dict= "armenian_1_int-3" , anim = "a_f_y_fitness_02^5-3" , andar = false , loop = true },
	{ nome = "pose130" , dict = "amb@lo_res_idles@" , anim ="world_human_lean_male_hands_together_lo_res_base" , andar = false , loop = true },
	{ nome = "pose131" , dict = "amb@code_human_cross_road@female@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose132" , dict = "amb@code_human_in_car_mp_actions@tit_squeeze@bodhi@rps@base" , anim ="idle_a" , andar = false , loop = true },
	{ nome = "pose133" , dict = "amb@world_human_hang_out_street@female_arm_side@enter" , anim ="enter" , andar = false , loop = true },
	{ nome = "pose134" , dict = "amb@world_human_hang_out_street@female_arm_side@idle_a" , anim ="idle_b" , andar = false , loop = true },
	{ nome = "pose135" , dict = "amb@world_human_hang_out_street@female_arms_crossed@idle_a" , anim ="idle_b" , andar = false , loop = true },
	{ nome = "pose136" , dict = "friends@" , anim ="pickupwait" , andar = false , loop = true },
	{ nome = "pose137" , dict = "mini@hookers_sp" , anim ="idle_reject_loop_a" , andar = false , loop = true },
	{ nome = "pose138" , dict = "misscarsteal2" , anim ="sweep_high" , andar = false , loop = true },
	{ nome = "pose139" , dict = "missheist_agency3aig_23" , anim ="urinal_base" , andar = false , loop = true },
	{ nome = "pose140" , dict = "misstrevor2ron_basic_moves" , anim ="idle" , andar = false , loop = true },
	{ nome = "pose141" , dict = "oddjobs@basejump@" , anim ="ped_a_loop" , andar = false , loop = true },
	{ nome = "pose142" , dict = "rcmjosh1" , anim ="idle" , andar = false , loop = true },
	{ nome = "pose143" , dict = "switch@franklin@plays_w_dog" , anim ="001916_01_fras_v2_9_plays_w_dog_idle" , andar = false , loop = true },
	{ nome = "pose144" , dict = "timetable@amanda@ig_9" , anim ="ig_9_base_amanda" , andar = false , loop = true },
	{ nome = "pose145" , dict = "misscommon@response" , anim ="bring_it_on" , andar = false , loop = true },
	{ nome = "pose146" , dict = "cover@first_person@move@base@core" , anim ="low_idle_l_facecover" , andar = false , loop = true },
	{ nome = "pose147" , dict = "cover@weapon@core" , anim ="idle_turn_stop" , andar = false , loop = true },
	{ nome = "pose148" , dict = "anim@amb@casino@hangout@ped_female@stand@02b@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose149" , dict = "anim@amb@casino@hangout@ped_male@stand@01a@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose150" , dict = "anim@amb@casino@out_of_money@ped_male@01b@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose151" , dict = "anim@amb@casino@shop@ped_female@01a@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose152" , dict = "anim@mp_corona_idles@female_c@base" , anim ="base" , andar = false , loop = true },
	{ nome = "pose153" , dict = "anim@random@shop_clothes@watches" , anim ="base" , andar = false , loop = true },
	{ nome = "pose154" , dict = "iaa_int-11" , anim ="csb_avon_dual-11" , andar = false , loop = true },
	{ nome = "pose155" , dict = "mini@strip_club@lap_dance@ld_girl_a_approach" , anim ="ld_girl_a_approach_f" , andar = false , loop = true },
    { nome = "pose156" , dict = "amb@code_human_in_car_mp_actions@rock@bodhi@rps@base" , anim ="idle_a" , andar = false , loop = true },
	{ nome = "pose157" , dict = "mini@hookers_spcrackhead" , anim ="idle_reject_loop_c" , andar = false , loop = true },
	{ nome = "pose158" , dict = "anim@mp_player_intupperfinger" , anim ="idle_a" , andar = false , loop = true },
	{ nome = "pose159" , dict = "switch@franklin@lamar_tagging_wall" , anim ="lamar_tagging_wall_loop_franklin" , andar = false , loop = true },
	{ nome = "pose160" , dict = "mp_move@prostitute@m@cokehead" , anim ="idle" , andar = false , loop = true },
	{ nome = "pose161" , dict = "anim@amb@casino@valet_scenario@pose_c@" , anim ="base_a_m_y_vinewood_01" , andar = false , loop = true },
	{ nome = "pose162" , dict = "anim@amb@casino@valet_scenario@pose_d@" , anim ="look_ahead_l_a_m_y_vinewood_01" , andar = false , loop = true },
	{ nome = "pose163" , dict = "anim@special_peds@casino@beth@wheel@" , anim ="action10_beth" , andar = false , loop = true },
	{ nome = "pose164" , dict = "anim@special_peds@casino@beth@wheel@" , anim ="action2_beth" , andar = false , loop = true },
	{ nome = "pose165" , dict = "anim@mp_player_intcelebrationfemale@v_sign" , anim ="v_sign" , andar = false , loop = true },
	{ nome = "pose166" , dict = "mini@strip_club@idles@stripper" , anim ="stripper_idle_03" , andar = false , loop = true },
	{ nome = "pose167" , dict = "mini@strip_club@idles@stripper" , anim ="stripper_idle_04" , andar = false , loop = true },
	{ nome = "pose168" , dict = "anim_heist@arcade@fortune@female@" , anim ="reaction_pondering" , andar = false , loop = true },
	{ nome = "pose169" , dict = "mp_clothing@female@trousers" , anim = "try_trousers_neutral_a" , andar = false , loop = true },
	{ nome = "pose170" , dict = "mp_clothing@female@shirt" , anim = "try_shirt_positive_a" , andar = false , loop = true },
	{ nome = "pose171" , dict = "mp_clothing@female@shoes" , anim = "try_shoes_positive_a" , andar = false , loop = true },
	{ nome = "pose172" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = true },
	{ nome = "pose173" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "pose174" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "pose175" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "pose176" , dict = "mp_deathmatch_intros@1hmale" , anim = "intro_male_1h_a_michael" , andar = false , loop = false },
	{ nome = "pose177" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_a" , andar = false , loop = false },
	{ nome = "pose178" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_b" , andar = false , loop = false },
	{ nome = "pose179" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_c" , andar = false , loop = false },
	{ nome = "pose180" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_d" , andar = false , loop = false },
	{ nome = "pose181" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_e" , andar = false , loop = false },
	{ nome = "pose182" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_a" , andar = false , loop = false },
	{ nome = "pose183" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = false },
	{ nome = "pose184" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "pose185" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "pose186" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "pose187" , dict = "anim@deathmatch_intros@1hmale" , anim = "intro_male_1h_d_michael" , andar = true , loop = false },
	{ nome = "pose188" , dict = "swat" , anim = "come" , andar = true , loop = false },
	{ nome = "pose189" , dict = "swat" , anim = "freeze" , andar = true , loop = false },
	{ nome = "pose190" , dict = "swat" , anim = "go_fwd" , andar = true , loop = false },
	{ nome = "pose191" , dict = "swat" , anim = "rally_point" , andar = true , loop = false },
	{ nome = "pose192" , dict = "swat" , anim = "understood" , andar = true , loop = false },
	{ nome = "pose193" , dict = "swat" , anim = "you_back" , andar = true , loop = false },
	{ nome = "pose194" , dict = "swat" , anim = "you_fwd" , andar = true , loop = false },
	{ nome = "pose195" , dict = "swat" , anim = "you_left" , andar = true , loop = false },
	{ nome = "pose196" , dict = "swat" , anim = "you_right" , andar = true , loop = false },


	{ nome = "abracocintura" , dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_chad" , andar = false , loop = true },
    { nome = "abracocintura2" , dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_chad" , andar = true , loop = true },
    { nome = "abracoombro" , dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_girl" , andar = false , loop = true },
    { nome = "abracoombro2" , dict = "misscarsteal2chad_goodbye" , anim = "chad_armsaround_girl" , andar = true , loop = true },
	{ nome = "cayo1" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f02" , andar = false , loop = true },
	{ nome = "cayo2" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m01" , andar = false , loop = true },
	{ nome = "cayo3" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m02" , andar = false , loop = true },
	{ nome = "cayo4" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_m03" , andar = false , loop = true },
	{ nome = "cayo5" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f01" , andar = false , loop = true },
	{ nome = "cayo6" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f02" , andar = false , loop = true },
	{ nome = "cayo7" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_f03" , andar = false , loop = true },
	{ nome = "cayo8" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m01" , andar = false , loop = true },
	{ nome = "cayo9" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m02" , andar = false , loop = true },
	{ nome = "cayo10" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_b_m03" , andar = false , loop = true },
	{ nome = "cayo11" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f01" , andar = false , loop = true },
	{ nome = "cayo12" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f02" , andar = false , loop = true },
	{ nome = "cayo13" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_f03" , andar = false , loop = true },
	{ nome = "cayo14" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m01" , andar = false , loop = true },
	{ nome = "cayo15" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m02" , andar = false , loop = true },
	{ nome = "cayo16" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_c_m03" , andar = false , loop = true },
	{ nome = "cayo17" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f01" , andar = false , loop = true },
	{ nome = "cayo18" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f02" , andar = false , loop = true },
	{ nome = "cayo19" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_f03" , andar = false , loop = true },
	{ nome = "cayo20" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m01" , andar = false , loop = true },
	{ nome = "cayo21" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m02" , andar = false , loop = true },
	{ nome = "cayo22" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_d_m03" , andar = false , loop = true },
	{ nome = "cayo23" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_e_f02" , andar = false , loop = true },
	{ nome = "cayo24" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_f_f02" , andar = false , loop = true },
	{ nome = "cayo25" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f01" , andar = false , loop = true },
	{ nome = "cayo26" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f02" , andar = false , loop = true },
	{ nome = "cayo27" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_f03" , andar = false , loop = true },
	{ nome = "cayo28" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m01" , andar = false , loop = true },
	{ nome = "cayo29" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m02" , andar = false , loop = true },
	{ nome = "cayo30" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_loop_m03" , andar = false , loop = true },
	{ nome = "cayo31" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f01" , andar = false , loop = true },
	{ nome = "cayo32" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f02" , andar = false , loop = true },
	{ nome = "cayo33" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_f03" , andar = false , loop = true },
	{ nome = "cayo34" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m01" , andar = false , loop = true },
	{ nome = "cayo35" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m02" , andar = false , loop = true },
	{ nome = "cayo36" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_li_m03" , andar = false , loop = true },
	{ nome = "cayo37" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f01" , andar = false , loop = true },
	{ nome = "cayo38" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f02" , andar = false , loop = true },
	{ nome = "cayo39" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_f03" , andar = false , loop = true },
	{ nome = "cayo40" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m01" , andar = false , loop = true },
	{ nome = "cayo41" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m02" , andar = false , loop = true },
	{ nome = "cayo42" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_mi_m03" , andar = false , loop = true },
	{ nome = "cayo43" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_si_f01" , andar = false , loop = true },
	{ nome = "cayo44" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f01" , andar = false , loop = true },
	{ nome = "cayo45" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f02" , andar = false , loop = true },
	{ nome = "cayo46" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_to_ti_f03" , andar = false , loop = true },
	{ nome = "cayo47" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f01" , andar = false , loop = true },

	{ nome = "fortnite" , dict = "custom@floss" , anim = "floss" , andar = false , loop = true },
	{ nome = "fortnite2" , dict = "custom@dont_start" , anim = "dont_start" , andar = false , loop = true },
	{ nome = "fortnite3" , dict = "custom@renegade" , anim = "renegade" , andar = false , loop = true },
	{ nome = "fortnite4" , dict = "custom@savage" , anim = "savage" , andar = false , loop = true },
	{ nome = "fortnite5" , dict = "custom@sayso" , anim = "sayso" , andar = false , loop = true },
	{ nome = "camisinha" , dict = "misscarsteal2peeing" , anim = "peeing_intro" , prop = "prop_cd" , flag = 49 , hand = 60309 },
	{ nome = "staff" , dict = "cellphone@self@franklin@" , anim = "chest_bump" , prop = "staff" , flag = 49 , hand = 12844 },

	{ nome = "tiktok1" , dict = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@" , anim = "low_left_up" , andar = false , loop = true },    
    { nome = "tiktok2" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok3" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_f@" , anim = "ped_b_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok4" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok5" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_h@" , anim = "ped_b_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok6" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_j@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok7" , dict = "anim@amb@nightclub@mini@dance@dance_paired@dance_m@" , anim = "ped_a_dance_idle" , andar = false , loop = true },    
    { nome = "tiktok8" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "hi_idle_a_f02" , andar = false , loop = true },    
    { nome = "tiktok9" , dict = "anim@amb@nightclub_island@dancers@club@" , anim = "mi_idle_b_f02" , andar = false , loop = true },    
    { nome = "tiktok10" , dict = "anim@mp_player_intcelebrationfemale@crowd_invitation" , anim = "crowd_invitation" , andar = false , loop = true },    
    { nome = "tiktok11" , dict = "anim@mp_player_intcelebrationfemale@driver" , anim = "driver" , andar = false , loop = true },    
    { nome = "tiktok12" , dict = "anim@mp_player_intcelebrationfemale@shooting" , anim = "shooting" , andar = false , loop = true },    
    { nome = "tiktok13" , dict = "anim@mp_player_intcelebrationmale@shooting" , anim = "shooting" , andar = false , loop = true },    
    { nome = "tiktok14" , dict = "anim@mp_player_intcelebrationmale@suck_it" , anim = "suck_it" , andar = false , loop = true },    
    { nome = "tiktok15" , dict = "anim@mp_player_intuppercrowd_invitation" , anim = "idle_a" , andar = false , loop = true },    
    { nome = "tiktok16" , dict = "anim@mp_player_intuppershooting" , anim = "idle_a" , andar = false , loop = true },    
    { nome = "tiktok17" , dict = "anim@mp_player_intuppersuck_it" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "tiktok18" , dict = "custom@billybounce" , anim = "billybounce" , andar = false , loop = true },
    { nome = "tiktok19" , dict = "custom@downward_fortnite" , anim = "downward_fortnite" , andar = false , loop = true },
    { nome = "tiktok20" , dict = "custom@pullup" , anim = "pullup" , andar = false , loop = true },
    { nome = "tiktok21" , dict = "custom@rollie" , anim = "rollie" , andar = false , loop = true },




	
	{ nome = "tiktok21" , dict = "custom@gloss" , anim = "gloss" , andar = false , loop = true },
	{ nome = "tiktok22" , dict = "custom@last_forever" , anim = "last_forever" , andar = false , loop = true },
	{ nome = "tiktok23" , dict = "custom@smooth_moves" , anim = "smooth_moves" , andar = false , loop = true },
	{ nome = "tiktok24" , dict = "custom@bellydance2" , anim = "bellydance2" , andar = false , loop = true },
	{ nome = "tiktok25" , dict = "custom@introducing" , anim = "introducing" , andar = false , loop = true },
	{ nome = "tiktok26" , dict = "custom@footwork" , anim = "footwork" , andar = false , loop = true },
	{ nome = "tiktok27" , dict = "custom@headspin" , anim = "headspin" , andar = false , loop = true },
	{ nome = "tiktok28" , dict = "custom@hiphop_pumpup" , anim = "hiphop_pumpup" , andar = false , loop = true },
	{ nome = "tiktok29" , dict = "custom@hiphop_yeah" , anim = "hiphop_yeah" , andar = false , loop = true },
	{ nome = "tiktok30" , dict = "custom@salsatime" , anim = "salsatime" , andar = false , loop = true },
	{ nome = "tiktok31" , dict = "custom@samba" , anim = "samba" , andar = false , loop = true },
	{ nome = "tiktok32" , dict = "custom@shockdance" , anim = "shockdance" , andar = false , loop = true },
	{ nome = "tiktok33" , dict = "custom@specialdance" , anim = "specialdance" , andar = false , loop = true },
	{ nome = "tiktok34" , dict = "custom@toetwist" , anim = "toetwist" , andar = false , loop = true },
	{ nome = "tiktok35" , dict = "custom@gangnamstyle" , anim = "gangnamstyle" , andar = false , loop = true },
	{ nome = "tiktok36" , dict = "custom@armswirl" , anim = "armswirl" , andar = false , loop = true },


	{ nome = "crossarms" , dict = "random@street_race", anim = "_car_b_lookout" , andar = true , loop = true },
	{ nome = "crossarms2" , dict = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop" , andar = true , loop = true },
	{ nome = "vaiapanhar" , dict = "anim@mp_player_intcelebrationfemale@knuckle_crunch", anim = "knuckle_crunch" , andar = true , loop = false },
	{ nome = "leanside" , dict = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar" , andar = true , loop = true },
	{ nome = "no2" , dict = "anim@heists@ornate_bank@chat_manager", anim = "fail" , andar = true , loop = false },
	{ nome = "aquipratu" , dict = "misscommon@response", anim = "screw_you" , andar = true , loop = false },
	{ nome = "wave" , dict = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b" , andar = true , loop = true },
	{ nome = "wave2" , dict = "friends@fra@ig_1", anim = "over_here_idle_a" , andar = true , loop = true },
	{ nome = "wave3" , dict = "friends@frj@ig_1", anim = "wave_e" , andar = true , loop = true },
	{ nome = "gangsign" , dict = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a" , andar = true , loop = true },
	{ nome = "gangsign2" , dict = "mp_player_int_uppergang_sign_b", anim = "mp_player_int_gang_sign_b" , andar = true , loop = true },
	{ nome = "flipoff" , dict = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_c_1st" , andar = true , loop = true },
	{ nome = "bow" , dict = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st" , andar = true , loop = false },
	{ nome = "headbutt" , dict = "melee@unarmed@streamed_variations", anim = "plyr_takedown_front_headbutt" , andar = true , loop = false },
	{ nome = "cough" , dict = "timetable@gardener@smoking_joint", anim = "idle_cough" , andar = true , loop = true },
	{ nome = "stretch" , dict = "mini@triathlon", anim = "idle_f" , andar = true , loop = true },
	{ nome = "punching" , dict = "rcmextreme2", anim = "loop_punching" , andar = true , loop = true },
	{ nome = "mindcontrol" , dict = "rcmbarry", anim = "bar_1_attack_idle_aln" , andar = true , loop = true },
	{ nome = "ok" , dict = "anim@mp_player_intselfiedock" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "tragar" , anim = "WORLD_HUMAN_DRUG_DEALER" },

	{ nome = "ajoelhar2" , dict = "amb@medic@standing@kneel@idle_a" , anim = "idle_c" , andar = false , loop = true },
	{ nome = "arrumar2" , dict = "misstrevor3" , anim = "brokendown_wrongwithyou" , andar = false , loop = true },
	{ nome = "bandeja" , dict = "anim@heists@box_carry@" , anim = "idle" , prop = "prop_food_tray_01" , flag = 50 , hand = 60309 },
	{ nome = "cruzarbraco" , dict = "anim@amb@casino@peds@" , anim = "amb_world_human_hang_out_street_male_c_base" , andar = false , loop = true },
	{ nome = "deitar9" , dict = "amb@world_human_sunbathe@female@front@idle_a" , anim = "idle_c" , andar = false , loop = true },
	{ nome = "digitar2" , dict = "anim@heists@fleeca_bank@scope_out@cashier_loop" , anim = "cashier_loop" , andar = false , loop = true },
	{ nome = "dj3" , dict = "anim@mp_player_intcelebrationmale@dj" , anim = "dj" , andar = false , loop = false },
	{ nome = "dj4" , dict = "anim@mp_player_intcelebrationfemale@dj" , anim = "dj" , andar = false , loop = false },
	{ nome = "discutir" , dict = "oddjobs@assassinate@vice@hooker" , anim = "argue_a" , andar = true , loop = true },
	{ nome = "dor" , dict = "combat@damage@injured_pistol@to_writhe" , anim = "variation_b" , andar = false , loop = false },
	{ nome = "dor2" , dict = "combat@damage@writheidle_a" , anim = "writhe_idle_a" , andar = false , loop = true },
	{ nome = "encostar13" , dict = "amb@world_human_leaning@male@wall@back@foot_up@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "escorar" , dict = "anim@heists@prison_heist" , anim = "ped_b_react" , andar = false , loop = true },
	{ nome = "escorar2" , dict = "anim@mp_ferris_wheel" , anim = "idle_a_playet_two" , andar = false , loop = true },
	{ nome = "escorar3" , dict = "rcmnigel1aig_1" , anim = "base_02_willie" , andar = false , loop = true },
	{ nome = "escorar4" , dict = "anim@amb@business@bgen@bgen_no_work@" , anim = "stand_phone_lookaround_nowork" , andar = false , loop = true },
	{ nome = "esperar" , dict = "amb@world_human_hang_out_street@female_arms_crossed@base" , anim = "base" , andar = false , loop = true },
	{ nome = "esperar2" , dict = "amb@world_human_hang_out_street@female_arm_side@base" , anim = "base" , andar = false , loop = true },
	{ nome = "esperar3" , dict = "switch@michael@parkbench_smoke_ranger" , anim = "ranger_nervous_loop" , andar = false , loop = true },
	{ nome = "esperar4" , dict = "oddjobs@assassinate@guard" , anim = "unarmed_fold_arms" , andar = false , loop = true },
	{ nome = "esperar5" , dict = "anim@amb@casino@hangout@ped_female@stand@01a@idles" , anim = "idle_d" , andar = false , loop = true },
	{ nome = "espreguicar" , dict = "amb@world_human_muscle_flex@arms_at_side@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "gravata" , dict = "clothingtie" , anim = "outro" , andar = false , loop = false },
	{ nome = "gravatab" , dict = "clothingtie" , anim = "try_tie_positive_b" , andar = false , loop = false },
	{ nome = "joia3" , dict = "anim@mp_player_intcelebrationmale@thumbs_up" , anim = "thumbs_up" , andar = false , loop = false },
	{ nome = "mapa2" , dict = "amb@world_human_tourist_map@male@base" , anim = "base" , prop = "prop_tourist_map_01" , flag = 50 , hand = 28422 },
	{ nome = "massagem" , dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim = "massage_loop_2_floyd" , andar = false , loop = true },
	{ nome = "massagem2" , dict = "missheistdocks2aleadinoutlsdh_2a_int" , anim = "massage_loop_2_trevor" , andar = false , loop = true },
	{ nome = "massagemperna" , dict = "missheistdocks2bleadinoutlsdh_2b_int" , anim = "leg_massage_b_floyd" , andar = false , loop = true },
	{ nome = "massagemperna2" , dict = "missheistdocks2bleadinoutlsdh_2b_int" , anim = "leg_massage_b_trevor" , andar = false , loop = true },
	{ nome = "obito" , dict = "mini@cpr@char_a@cpr_str" , anim = "cpr_fail" , andar = false , loop = true },
	{ nome = "palmas7" , dict = "anim@mp_player_intincarslow_clapbodhi@ds@" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "peace3" , dict = "anim@mp_player_intcelebrationfemale@peace" , anim = "peace" , andar = true , loop = false },
	{ nome = "peace4" , dict = "anim@mp_player_intincarpeacebodhi@ds@" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "pisar" , dict = "missfbi4leadinoutfbi_4_int" , anim = "agents_idle_b_andreas" , andar = false , loop = true },
	{ nome = "podevir" , dict = "timetable@lamar@ig_4" , anim = "nothing_to_see_here_stretch" , andar = false , loop = true },
	{ nome = "postura3" , dict = "rcmpaparazzo_3big_1" , anim = "_action_guard_a" , andar = false , loop = true },
	{ nome = "procurar2" , dict = "anim@miss@low@fin@lamar@" , anim = "idle" , andar = false , loop = true },
	{ nome = "sms" , dict = "amb@world_human_leaning@female@wall@back@texting@base" , anim = "base" , prop = "prop_amb_phone", flag = 50 , hand = 28422 },
	{ nome = "sentar23" , dict = "anim@amb@casino@out_of_money@ped_male@02b@idles" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "sexy" , dict = "amb@world_human_prostitute@cokehead@base" , anim = "base" , andar = false , loop = true },
	{ nome = "sexy2" , dict = "amb@world_human_prostitute@cokehead@idle_a" , anim = "idle_b" , andar = false , loop = true },
	{ nome = "sexy3" , dict = "amb@world_human_prostitute@french@base" , anim = "base" , andar = false , loop = true },  
	{ nome = "sexy4" , dict = "amb@world_human_prostitute@hooker@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "tocaai" , dict = "mp_ped_interaction" , anim = "handshake_guy_b" , andar = false , loop = true },
	{ nome = "tossir" , dict = "timetable@gardener@smoking_joint" , anim = "idle_cough" , andar = true , loop = false },
	{ nome = "trotar" , dict = "amb@world_human_jog_standing@male@fitidle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "trotar2" , dict = "amb@world_human_jog_standing@female@idle_a" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "verificar2" , dict = "amb@code_human_police_investigate@idle_b" , anim = "idle_f" , andar = false , loop = true },
	{ nome = "verificar3" , dict = "amb@code_human_police_investigate@idle_b" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "verificar4" , dict = "amb@world_human_guard_patrol@male@idle_b" , anim = "idle_e" , andar = false , loop = true },
	{ nome = "yoga3" , dict = "amb@world_human_yoga@female@base" , anim = "base_b" , andar = false , loop = true },
	{ nome = "yoga4" , dict = "amb@world_human_yoga@female@base" , anim = "base_c" , andar = false , loop = true },

	{ nome = "wtf" , dict = "anim@mp_player_intcelebrationfemale@face_palm" , anim = "face_palm" , andar = true , loop = false },
	{ nome = "wtf2" , dict = "random@car_thief@agitated@idle_a" , anim = "agitated_idle_a" , andar = true , loop = false },
	{ nome = "wtf3" , dict = "missminuteman_1ig_2" , anim = "tasered_2" , andar = true , loop = false },
	{ nome = "wtf4" , dict = "anim@mp_player_intupperface_palm" , anim = "idle_a" , andar = true , loop = false },
	{ nome = "suicidio" , dict = "mp_suicide" , anim = "pistol" , andar = false , loop = false },
	{ nome = "suicidio2" , dict = "mp_suicide" , anim = "pill" , andar = false , loop = false },
	{ nome = "lutar" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_c" , andar = false , loop = false },
	{ nome = "lutar2" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_e" , andar = false , loop = false },
	{ nome = "dedo" , dict = "anim@mp_player_intselfiethe_bird" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "dedo2" , dict = "anim@mp_player_intcelebrationfemale@finger" , anim = "finger" , andar = true , loop = false },
	{ nome = "dedo3" , dict = "anim@arena@celeb@podium@no_prop@" , anim = "flip_off_a_1st" , andar = false , loop = false },
	{ nome = "mochila" , dict = "move_m@hiking" , anim = "idle" , andar = true , loop = true },
	{ nome = "exercicios" , dict = "timetable@reunited@ig_2" , anim = "jimmy_getknocked" , andar = true , loop = true },
	{ nome = "escorar" , dict = "timetable@mime@01_gc" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "escorar2" , dict = "misscarstealfinale" , anim = "packer_idle_1_trevor" , andar = false , loop = true },
	{ nome = "escorar3" , dict = "misscarstealfinalecar_5_ig_1" , anim = "waitloop_lamar" , andar = false , loop = true },
	{ nome = "escorar4" , dict = "rcmjosh2" , anim = "josh_2_intp1_base" , andar = false , loop = true },
	--{ nome = "meditar" , dict = "rcmcollect_paperleadinout@" , anim = "meditiate_idle" , andar = false , loop = true },
	{ nome = "meditar2" , dict = "rcmepsilonism3" , anim = "ep_3_rcm_marnie_meditating" , andar = false , loop = true },
	{ nome = "meditar3" , dict = "rcmepsilonism3" , anim = "base_loop" , andar = false , loop = true },
	{ nome = "meleca2" , dict = "anim@mp_player_intcelebrationfemale@nose_pick" , anim = "nose_pick" , andar = false , loop = false },
	{ nome = "cortaessa" , dict = "gestures@m@standing@casual" , anim = "gesture_no_way" , andar = false , loop = false },
	{ nome = "meleca3" , dict = "move_p_m_two_idles@generic" , anim = "fidget_sniff_fingers" , andar = true , loop = false },
	{ nome = "joia" , dict = "anim@mp_player_intincarthumbs_uplow@ds@" , anim = "enter" , andar = false , loop = false },
	{ nome = "joia2" , dict = "anim@mp_player_intselfiethumbs_up" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "yeah" , dict = "anim@mp_player_intupperair_shagging" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "assobiar" , dict = "taxi_hail" , anim = "hail_taxi" , andar = false , loop = false },
	{ nome = "carona" , dict = "random@hitch_lift" , anim = "idle_f" , andar = true , loop = false },
	{ nome = "estatua" , dict = "amb@world_human_statue@base" , anim = "base" , andar = false , loop = true },
	{ nome = "estatua2" , dict = "fra_0_int-1" , anim = "cs_lamardavis_dual-1" , andar = false , loop = true },
	{ nome = "estatua3" , dict = "club_intro2-0" , anim = "csb_englishdave_dual-0" , andar = false , loop = true },
	{ nome = "tiltado" , dict = "anim@mp_player_intcelebrationfemale@freakout" , anim = "freakout" , andar = false , loop = false },
	{ nome = "colher" , dict = "creatures@rottweiler@tricks@" , anim = "petting_franklin" , andar = false , loop = false },
	{ nome = "rastejar" , dict = "move_injured_ground" , anim = "front_loop" , andar = false , loop = true },
	{ nome = "pirueta" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "cap_a_player_a" , andar = false , loop = false },
	{ nome = "pirueta2" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "flip_a_player_a" , andar = false , loop = false },
	{ nome = "escorregar" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "slide_a_player_a" , andar = false , loop = false },
	{ nome = "escorregar2" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "slide_c_player_a" , andar = false , loop = false },
	{ nome = "gang" , dict = "mp_player_int_uppergang_sign_a" , anim = "mp_player_int_gang_sign_a" , andar = true , loop = true },
	{ nome = "gang2" , dict = "mp_player_int_uppergang_sign_b" , anim = "mp_player_int_gang_sign_b" , andar = true , loop = true },
	{ nome = "fodase" , dict = "anim@arena@celeb@podium@no_prop@" , anim = "flip_off_a_1st" , andar = false , loop = false },
	{ nome = "taco" , dict = "anim@arena@celeb@flat@solo@no_props@" , anim = "slugger_a_player_a" , andar = false , loop = false },
	{ nome = "onda" , dict = "anim@mp_player_intupperfind_the_fish" , anim = "idle_a" , andar = false , loop = true },
	{ nome = "lutar3" , dict = "rcmextreme2" , anim = "loop_punching" , andar = true , loop = true },
	{ nome = "heroi" , dict = "rcmbarry" , anim = "base" , andar = true , loop = true },
	{ nome = "boboalegre" , dict = "rcm_barry2" , anim = "clown_idle_0" , andar = false , loop = false },
	{ nome = "boboalegre2" , dict = "rcm_barry2" , anim = "clown_idle_1" , andar = false , loop = false },
	{ nome = "boboalegre3" , dict = "rcm_barry2" , anim = "clown_idle_2" , andar = false , loop = false },
	{ nome = "boboalegre4" , dict = "rcm_barry2" , anim = "clown_idle_3" , andar = false , loop = false },
	{ nome = "boboalegre5" , dict = "rcm_barry2" , anim = "clown_idle_6" , andar = false , loop = false },
	{ nome = "meditar4" , dict = "timetable@amanda@ig_4" , anim = "ig_4_base" , andar = false , loop = true },
	{ nome = "passa" , dict = "mini@strip_club@lap_dance@ld_girl_a_approach" , anim = "ld_girl_a_approach_f" , andar = false , loop = false },	
	{ nome = "passaro" , dict = "random@peyote@bird" , anim = "wakeup" , andar = false , loop = false },
	{ nome = "cachorro" , dict = "random@peyote@dog" , anim = "wakeup" , andar = false , loop = false },
	{ nome = "karate" , dict = "anim@mp_player_intcelebrationfemale@karate_chops" , anim = "karate_chops" , andar = false , loop = false },
	{ nome = "karate2" , dict = "anim@mp_player_intcelebrationmale@karate_chops" , anim = "karate_chops" , andar = false , loop = false },
	{ nome = "ameacar" , dict = "anim@mp_player_intcelebrationmale@cut_throat" , anim = "cut_throat" , andar = false , loop = false },
	{ nome = "ameacar2" , dict = "anim@mp_player_intcelebrationfemale@cut_throat" , anim = "cut_throat" , andar = false , loop = false },
	{ nome = "boxe" , dict = "anim@mp_player_intcelebrationmale@shadow_boxing" , anim = "shadow_boxing" , andar = false , loop = false },
	{ nome = "boxe2" , dict = "anim@mp_player_intcelebrationfemale@shadow_boxing" , anim = "shadow_boxing" , andar = false , loop = false },
    { nome = "mamamia" , dict = "anim@mp_player_intcelebrationmale@finger_kiss" , anim = "finger_kiss" , andar = true , loop = false },
    { nome = "louco" , dict = "anim@mp_player_intincaryou_locobodhi@ds@" , anim = "idle_a" , andar = true , loop = true },
    { nome = "xiu" , dict = "anim@mp_player_intincarshushbodhi@ds@" , anim = "idle_a_fp" , andar = true , loop = true },
	{ nome = "cruzar" , dict = "amb@world_human_cop_idles@female@idle_b" , anim = "idle_e" , andar = true , loop = true },
	{ nome = "cruzar2" , dict = "anim@amb@casino@hangout@ped_male@stand@02b@idles" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "cruzar3" , dict = "amb@world_human_hang_out_street@male_c@idle_a" , anim = "idle_b" , andar = true , loop = true },
	{ nome = "cruzar4" , dict = "random@street_race" , anim = "_car_b_lookout" , andar = true , loop = true },
	{ nome = "cruzar5" , dict = "random@shop_gunstore" , anim = "_idle" , andar = true , loop = true },
	{ nome = "cruzar6" , dict = "move_m@hiking" , anim = "idle" , andar = true , loop = true },
	{ nome = "cruzar7" , dict = "anim@amb@casino@valet_scenario@pose_d@" , anim = "base_a_m_y_vinewood_01" , andar = true , loop = true },
	{ nome = "cruzar8" , dict = "anim@amb@casino@shop@ped_female@01a@base" , anim = "base" , andar = true , loop = true },
	{ nome = "cruzar9" , dict = "anim@amb@casino@valet_scenario@pose_c@" , anim = "shuffle_feet_a_m_y_vinewood_01" , andar = true , loop = true },
	{ nome = "cruzar10" , dict = "anim@amb@casino@hangout@ped_male@stand@03a@idles_convo" , anim = "idle_a" , andar = true , loop = true },
	{ nome = "fera" , dict = "anim@mp_fm_event@intro" , anim = "beast_transform" , andar = true , loop = false },
	{ nome = "render" , dict = "random@mugging3", anim = "handsup_standing_base", andar = true, loop = true },
	{ nome = "render2" , dict = "random@arrests@busted", anim = "idle_a", andar = true, loop = true },
	{ nome = "aqc" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_a" , andar = false , loop = false },
	{ nome = "aqc2" , dict = "anim@deathmatch_intros@unarmed" , anim = "intro_male_unarmed_d" , andar = false , loop = false },
	{ nome = "inspec" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = true },
	{ nome = "inspec2" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "inspec3" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "inspec4" , dict = "anim@deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "inspec5" , dict = "mp_deathmatch_intros@1hmale" , anim = "intro_male_1h_a_michael" , andar = false , loop = false },
	{ nome = "inspec6" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_a" , andar = false , loop = false },
	{ nome = "inspec7" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_b" , andar = false , loop = false },
	{ nome = "inspec8" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_c" , andar = false , loop = false },
	{ nome = "inspec9" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_d" , andar = false , loop = false },
	{ nome = "inspec10" , dict = "mp_deathmatch_intros@melee@1h" , anim = "intro_male_melee_1h_e" , andar = false , loop = false },
	{ nome = "inspec11" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_a" , andar = false , loop = false },
	{ nome = "inspec12" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_b" , andar = false , loop = false },
	{ nome = "inspec13" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_c" , andar = false , loop = false },
	{ nome = "inspec14" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_d" , andar = false , loop = false },
	{ nome = "inspec15" , dict = "mp_deathmatch_intros@melee@2h" , anim = "intro_male_melee_2h_e" , andar = false , loop = false },
	{ nome = "inspec16" , dict = "anim@deathmatch_intros@1hmale" , anim = "intro_male_1h_d_michael" , andar = true , loop = false },
	{ nome = "swat" , dict = "swat" , anim = "come" , andar = true , loop = false },
	{ nome = "swat2" , dict = "swat" , anim = "freeze" , andar = true , loop = false },
	{ nome = "swat3" , dict = "swat" , anim = "go_fwd" , andar = true , loop = false },
	{ nome = "swat4" , dict = "swat" , anim = "rally_point" , andar = true , loop = false },
	{ nome = "swat5" , dict = "swat" , anim = "understood" , andar = true , loop = false },
	{ nome = "swat6" , dict = "swat" , anim = "you_back" , andar = true , loop = false },
	{ nome = "swat7" , dict = "swat" , anim = "you_fwd" , andar = true , loop = false },
	{ nome = "swat8" , dict = "swat" , anim = "you_left" , andar = true , loop = false },
	{ nome = "swat9" , dict = "swat" , anim = "you_right" , andar = true , loop = false },
	{ nome = "casalm" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_trevor" , andar = false , loop = true },
    { nome = "casalf" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedontknowwhy_patricia" , andar = false , loop = true },
    { nome = "casalm2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_trevor" , andar = false , loop = true },
    { nome = "casalf2" , dict = "timetable@trevor@ig_1" , anim = "ig_1_thedesertissobeautiful_patricia" , andar = false , loop = true },
	{ nome = "binoculos" , dict = "amb@world_human_binoculars@male@enter" , anim = "enter" , prop = "prop_binoc_01" , flag = 50 , hand = 28422 , extra = function()
		binoculos = true
	end },
	{ nome = "empolgado" , dict = "amb@world_human_cheering@female_a" , anim = "base" , andar = false , loop = true },
	{ nome = "corridinha2" , dict = "amb@world_human_jog@female@base" , anim = "base" , andar = false , loop = true },
	{ nome = "corridinha3" , dict = "amb@world_human_power_walker@female@base" , anim = "base" , andar = false, loop = true },
	{ nome = "teste" , dict = "anim@deathmatch_intros@2hsniper_riflemale" , anim = "intro_male_sr_b" , andar = false, loop = true },
	{ nome = "dor1" , dict = "misstrevor3_beatup" , anim = "guard_beatup_exit_dockworker" , andar = false , loop = true },
	{ nome = "dor2" , dict = "combat@damage@writheidle_c" , anim = "writhe_idle_g" , andar = false , loop = false },
	{ nome = "no" , dict = "mp_player_int_upper_nod" , anim = "mp_player_int_nod_no" , andar = true , loop = true },
	{ nome = "bixa" , anim = "WORLD_HUMAN_PROSTITUTE_LOW_CLASS" },
	{ nome = "frio" , dict = "misschinese1leadinoutchi_1_mcs_4" , anim = "chi_1_mcs_4_translator_idle_2" , andar = false , loop = true },
	{ nome = "nervouser" , dict = "rcmme_tracey1" , anim = "nervous_loop" , andar = false , loop = true },
	{ nome = "taichi" , dict = "switch@trevor@rand_temple" , anim = "tai_chi_trevor" , andar = false , loop = false },
	{ nome = "peidar" , dict = "rcm_barry2" , anim = "clown_idle_2" , andar = false , loop = false },
	{ nome = "estralar" , dict = "anim@mp_player_intupperknuckle_crunch" , anim = "idle_a" , andar = false , loop = false },
	{ nome = "rejeitar" , dict = "mini@hookers_sp" , anim = "idle_reject" , andar = true , loop = false },
	{ nome = "guarda" , anim = "WORLD_HUMAN_GUARD_STAND" },
	


	{ nome = "urso" , dict = "impexp_int-0" , anim = "mp_m_waremech_01_dual-0" , andar = true , loop = true , extra = function()
		vRP._createObjects("","","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
	end },
	{ nome = "dinheiro" , dict = "anim@mp_player_intupperraining_cash" , anim = "idle_a" , andar = true , loop = true , extra = function()
		vRP._createObjects("","","prop_anim_cash_pile_01",49,60309,0.0,0.0,0.0,180.0,0.0,70.0)
	end },
	{ nome = "parachoque" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
	end },
	{ nome = "porta" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_car_door_01",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "porta2" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_car_door_02",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "porta3" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
		vRP._createObjects("","","prop_car_door_03",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "porta4" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_car_door_04",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "banco" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
		vRP._createObjects("","","prop_car_seat",49,28422,0.0,-0.2,-0.14,0.0,0.0,0.0)
	end },
	{ nome = "pneu" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_wheel_tyre",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "pneu2" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_wheel_03",49,28422,0.0,-0.1,-0.15,0.0,0.0,0.0)
	end },
	{ nome = "bateria" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_car_battery_01",49,28422,0.0,-0.1,-0.10,0.0,0.0,0.0)
	end },
	{ nome = "motor" , dict = "anim@heists@box_carry@" , anim = "idle" , andar = true , loop = true , extra = function()
		--TriggerServerEvent("createObjects","imp_prop_impexp_front_bumper_02a",49,28422,0.0,0.1,0.05,0.0,0.0,0.0)
        vRP._createObjects("","","prop_car_engine_01",49,28422,0.0,-0.1,-0.10,0.0,0.0,0.0)

	end },


	{ nome = "poledance" , dict = "mini@strip_club@pole_dance@pole_dance1" , anim = "pd_dance_01" , andar = false , loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(Poledance) do
			local distance = #(coords - vec3(v[1],v[2],v[3]))
			if distance <= 2 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,false,false,false,false)
				break
			end
		end
	end },
	{ nome = "poledance2" , dict = "mini@strip_club@pole_dance@pole_dance2" , anim = "pd_dance_02" , andar = false , loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(Poledance) do
			local distance = #(coords - vec3(v[1],v[2],v[3]))
			if distance <= 2 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,false,false,false,false)
				break
			end
		end
	end },
	{ nome = "poledance3" , dict = "mini@strip_club@pole_dance@pole_dance3" , anim = "pd_dance_03" , andar = false , loop = true, extra = function()
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		for k,v in pairs(Poledance) do
			local distance = #(coords - vec3(v[1],v[2],v[3]))
			if distance <= 2 then
				SetEntityHeading(ped,v[4])
				SetEntityCoords(ped,v[1],v[2],v[3] - 1,false,false,false,false)
				break
			end
		end
	end },

	--{ nome = "pano" , dict = "timetable@maid@cleaning_window@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422 },

 { nome = "pano3" , dict = "timetable@maid@cleaning_window@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422, andar = false , loop = true },

	{ nome = "pano2" , dict = "timetable@maid@cleaning_surface@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422 , extra = function()
		local vehicle = vRP.nearVehicle(10)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				TriggerServerEvent("tryClearVehicle",VehToNet(vehicle))
				vRP.removeObjects("one")
			end)
		end
	end },
	{ nome = "camera2" , dict = "missfinale_c2mcs_1" , anim = "fin_c2_mcs_1_camman" , prop = "prop_v_cam_01" , flag = 49 , hand = 28422 , extra = function() 
        camera = true
    end },
	{ nome = "pano" , dict = "timetable@maid@cleaning_window@base" , anim = "base" , prop = "prop_rag_01" , flag = 49 , hand = 28422 , extra = function()
		local vehicle = vRP.nearVehicle(10)
		if vehicle then
			TriggerEvent("Progress",10000)
			SetTimeout(10000,function()
				TriggerServerEvent("tryClearVehicle",VehToNet(vehicle))
				vRP.removeObjects("one")
			end)
		end
	end },	
	{ nome = "cajadonubsk" , prop = "prop_tool_broom" , flag = 50 , hand = 60309 , pos1 = 0.055 , pos2 = 0.05 , pos3 = 0.0 , pos4 = 240.0 , pos5 = 0.0 , pos6 = 0.0 , extra = function()
		TriggerServerEvent("cajaenvia")
	end },

	{ nome = "bong" , dict = "anim@safehouse@bong" , anim = "bong_stage1" , prop = "prop_bong_01" , flag = 50 , hand = 60309 , extra = function() 
		if not IsPedInAnyVehicle(PlayerPedId()) then
			TriggerEvent('cancelando',true)
			TriggerEvent("progress",9000,"fumando")
			TriggerEvent("vrp_sound:source",'bong',0.5)
			SetTimeout(8700,function()
				vRP.removeObjects("one")
				ShakeGameplayCam('SMALL_EXPLOSION_SHAKE',0.5)
			end)
			SetTimeout(9000,function()
				vRP.loadAnimSet("MOVE_M@DRUNK@VERYDRUNK")
				SetTimecycleModifier("REDMIST_blend")
				ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
				StartScreenEffect("DMT_flight",120000,false)
				Citizen.Wait(120000)
				TriggerEvent('cancelando',false)
				SetTimecycleModifier("")
				SetTransitionTimecycleModifier("")
				StopGameplayCamShaking()
				ResetPedMovementClipset(PlayerPedId(),0.0)
			end)
		end
	end}
}

local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}

RegisterNetEvent('emotes')
AddEventHandler('emotes',function(nome)
	if not algemado then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 100 then
			for _,emote in pairs(animacoes) do
				if not IsPedInAnyVehicle(ped) and not emote.carros then
					
					if nome == "checkin" then
						local ped = PlayerPedId()
						local x,y,z = table.unpack(GetEntityCoords(ped))
						for k,v in pairs(beds) do
							local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
							if DoesEntityExist(object) then
								local health = GetEntityHealth(ped)
								local armour = GetPedArmour(ped)
								local x2,y2,z2 = table.unpack(GetEntityCoords(object))
								NetworkResurrectLocalPlayer(x2,y2,z2+v[2],GetEntityHeading(object),true,false)
								SetEntityHealth(ped,health)
								SetPedArmour(ped,armour)
				
								TriggerEvent("resetBleeding")
								TriggerEvent("resetDiagnostic")
								TriggerEvent("vrp_hospital:macas")
				
								SetEntityCoords(ped,x2,y2,z2+v[2])
								SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)
							end
						end
						vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
						return
					end

					if nome == emote.nome then
						RequestAnimDict(emote.dict)
						while not HasAnimDictLoaded(emote.dict) do
							Wait(0)
						end
						if emote.extra then emote.extra() end
						if emote.pos1 then
							
							vRP.createObjects("","",emote.prop,emote.flag,emote.hand,emote.pos1,emote.pos2,emote.pos3,emote.pos4,emote.pos5,emote.pos6)
						elseif emote.prop then
							vRP.createObjects(emote.dict,emote.anim,emote.prop,emote.flag,emote.hand)
						elseif emote.dict then
							vRP.playAnim(emote.andar,{emote.dict,emote.anim},emote.loop)
						else
							vRP.playAnim(false,{task=emote.anim},false)
						end
					end
				else
					if IsPedInAnyVehicle(ped) and emote.carros then
						local vehicle = GetVehiclePedIsIn(ped,false)
						if nome == emote.nome then
							if (GetPedInVehicleSeat(vehicle,-1) == ped or GetPedInVehicleSeat(vehicle,1) == ped) and emote.nome == "sexo4" then
								vRP._playAnim(emote.andar,{{emote.dict,emote.anim}},emote.loop)
							elseif (GetPedInVehicleSeat(vehicle,0) == ped or GetPedInVehicleSeat(vehicle,2) == ped) and (emote.nome == "sexo5" or emote.nome == "sexo6") then
								vRP._playAnim(emote.andar,{{emote.dict,emote.anim}},emote.loop)
							end
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BINOCULOS E CAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if binoculos then
			sleep = 1
            local scaleform = RequestScaleformMovie("BINOCULARS")
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(10)
            end
 
            local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
            AttachCamToEntity(cam,PlayerPedId(),0.0,0.0,1.0,true)
            SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()))
            SetCamFov(cam,fov)
            RenderScriptCams(true,false,0,1,0)
 
            while binoculos and true do
                Citizen.Wait(1)
                BlockWeaponWheelThisFrame()
                local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                CheckInputRotation(cam,zoomvalue)
                HandleZoom(cam)
                DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
            end
 
            fov = (fov_max+fov_min)*0.5
            RenderScriptCams(false,false,0,1,0)
            SetScaleformMovieAsNoLongerNeeded(scaleform)
            DestroyCam(cam,false)
            SetNightvision(false)
            SetSeethrough(false)
        end
        if IsControlJustPressed(0,38) then
            if IsEntityPlayingAnim(PlayerPedId(),"missfinale_c2mcs_1","fin_c2_mcs_1_camman",3) then
                camera = true
            end
            if camera then
                local scaleform = RequestScaleformMovie("breaking_news")
                local scaleform2 = RequestScaleformMovie("security_camera")
                while not HasScaleformMovieLoaded(scaleform) do
                    Citizen.Wait(10)
                end
                while not HasScaleformMovieLoaded(scaleform2) do
                    Citizen.Wait(10)
                end
 
                local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
                AttachCamToEntity(cam,PlayerPedId(),0.0,0.0,1.0,true)
                SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()))
                SetCamFov(cam,fov)
                RenderScriptCams(true,false,0,1,0)
 
                while camera and true do
                    Citizen.Wait(1)
                    BlockWeaponWheelThisFrame()
                    local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                    CheckInputRotation(cam,zoomvalue)
                    HandleZoom(cam)
                    DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
                    DrawScaleformMovieFullscreen(scaleform2,255,255,255,255)
                    --Breaking("DISNEYLANDIA NEWS")
                    if IsControlJustPressed(0,38) then
                        camera = false
                    end
                end
 
                fov = (fov_max+fov_min)*0.5
                RenderScriptCams(false,false,0,1,0)
                SetScaleformMovieAsNoLongerNeeded(scaleform)
                SetScaleformMovieAsNoLongerNeeded(scaleform2)
                DestroyCam(cam,false)
                SetNightvision(false)
                SetSeethrough(false)
            end
        end
		Citizen.Wait(sleep)
    end
end)
 
RegisterNetEvent('binoculos')
AddEventHandler('binoculos',function()
    if IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_binoculars@male@enter","enter",3) then
        binoculos = true
        camera = true
    else
        binoculos = false
        camera = false
    end
end)
 
function CheckInputRotation(cam,zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0,220)
    local rightAxisY = GetDisabledControlNormal(0,221)
    local rotation = GetCamRot(cam,2)
    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z+rightAxisX*-1.0*(8.0)*(zoomvalue+0.1)
        new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(8.0)*(zoomvalue+0.1)),-89.5)
        SetCamRot(cam,new_x,0.0,new_z,2)
    end
end
 
function HandleZoom(cam)
    if IsControlJustPressed(0,241) then
        fov = math.max(fov-10.0,fov_min)
    end
 
    if IsControlJustPressed(0,242) then
        fov = math.min(fov+10.0,fov_max)
    end
 
    local current_fov = GetCamFov(cam)
    if math.abs(fov-current_fov) < 0.1 then
        fov = current_fov
    end
    SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end
 
function Breaking(text)
    SetTextColour(255,255,255,255)
    SetTextFont(8)
    SetTextScale(1.2,1.2)
    SetTextWrap(0.0,1.0)
    SetTextCentre(false)
    SetTextDropshadow(0,0,0,0,255)
    SetTextEdge(1,0,0,0,205)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.2,0.85)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end



------------------------------------------------------------------------
-- SYNC
------------------------------------------------------------------------
RegisterNetEvent('syncanim')
AddEventHandler('syncanim',function(pos)
 	local pedInFront = GetPlayerPed(GetClosestPlayer())
    local heading = GetEntityHeading(pedInFront)
    local coords = GetOffsetFromEntityInWorldCoords(pedInFront,0.0,pos,0.0)
    SetEntityHeading(PlayerPedId(),heading-180.1)
    SetEntityCoordsNoOffset(PlayerPedId(),coords.x,coords.y,coords.z,0)
end)

RegisterNetEvent('dancalouca')
AddEventHandler('dancalouca',function()
	vRP._playAnim(false, {{"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag"}}, false)
end)

RegisterNetEvent('yoga')
AddEventHandler('yoga',function()
	vRP._playAnim(false, {{"amb@world_human_yoga@male@base", "base_a"}}, false)
end)

RegisterNetEvent('beijar')
AddEventHandler('beijar',function()
	vRP._playAnim(false, {{"mp_ped_interaction", "kisses_guy_a"}}, false)
end)

RegisterNetEvent('abracar')
AddEventHandler('abracar',function()
	vRP._playAnim(false, {{"mp_ped_interaction", "hugs_guy_a"}}, false)
end)

RegisterNetEvent('abracar2')
AddEventHandler('abracar2',function()
	vRP._playAnim(false, {{"mp_ped_interaction", "kisses_guy_b"}}, false)
end)

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function PtfxThis(asset)
	while not HasNamedPtfxAssetLoaded(asset) do
	  RequestNamedPtfxAsset(asset)
	  Wait(10)
	end
	UseParticleFxAssetNextCall(asset)
  end
  -----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_HOSPITAL:MACAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_hospital:macas")
AddEventHandler("vrp_hospital:macas",function()
	local ped = PlayerPedId()
	TriggerEvent("cancelando",true)

	repeat
		SetEntityHealth(ped,GetEntityHealth(ped)+1)
		Citizen.Wait(1000)
	until GetEntityHealth(ped) >= 400
		TriggerEvent("Notify","verde","Tratamento completo.",5000)
		TriggerEvent("cancelando",false)
		ClearPedBloodDamage(ped)
end)

RegisterNetEvent("vrp_hospital:deitandonamaca")
AddEventHandler("vrp_hospital:deitandonamaca",function()
	local ped = PlayerPedId()
		Citizen.Wait(1000)
		ClearPedBloodDamage(ped)
end)









RegisterNetEvent("vrp_hospital:macas")
AddEventHandler("vrp_hospital:macas",function()
	local ped = PlayerPedId()
	TriggerEvent("cancelando",true)

	repeat
		SetEntityHealth(ped,GetEntityHealth(ped)+1)
		Citizen.Wait(1000)
	until GetEntityHealth(ped) >= 200
		TriggerEvent("Notify","verde","Tratamento completo.",5000)
		TriggerEvent("cancelando",false)
		ClearPedBloodDamage(ped)
		ClearPedTasks(ped)
end)