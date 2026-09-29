-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("RazeBank",cRP)
vSERVER = Tunnel.getInterface("RazeBank")
local trans = {}
local isBankOpened = false
local closestATM, atmPos
local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney

local banks = {
	{149.73,-1040.69,29.37,164.41 , 3000},
	{ 314.01,-279.01,54.17,155.91 , 3000},
	{ -351.6,-49.7,49.03,158.75 , 3000},
	{ -2962.58,482.73,15.7,266.46 , 3000},
	{ -1212.68,-330.77,37.78,204.1 , 3000},
	{ 1175.13,2706.81,38.1,0.0 , 3000},
	{ -109.85,6469.13,31.63,0.0 , 3000},
	{ -108.14,6470.83,31.63,0.0 , 3000},
	{ 1-111.99,6469.15,31.63,0.0 , 3000},
	{ 257.03,226.82,106.27,0.0 , 3000},
	{ 257.03,226.82,106.27,0.0 , 3000},
	{ 259.24,226.08,106.27,0.0 , 3000},
	{314.11,-279.11,54.17,161.58, 3000},
	{-350.99,-49.89,49.03,158.75, 3000},

}

local atmList = {
	{ 121.17,-3019.62,7.04 },
	{ 797.69,-767.52,26.77 },
	{ -1431.17,-447.73,35.91 },
	{ 155.65,6643.13,31.59 },
	{ 228.18,338.4,105.56 },
	{ 158.63,234.22,106.63 },
	{ -57.67,-92.62,57.78 },
	{ 356.97,173.54,103.07 },
	{ -1415.94,-212.03,46.51 },
	{ -1430.2,-211.08,46.51 },
	{ -1282.54,-210.9,42.44 },
	{ -1286.25,-213.44,42.44 },
	{ -1289.32,-226.82,42.44 },
	{ -1285.58,-224.28,42.44 },
	{ -1109.8,-1690.82,4.36 },
	{ 1686.85,4815.82,42.01 },
	{ 1701.21,6426.57,32.76 },
	{ 1171.56,2702.58,38.16 },
	{ 1172.5,2702.59,38.16 },
	{ -1091.49,2708.66,18.96 },
	{ -3144.38,1127.6,20.86 },
	{ 527.36,-160.69,57.09 },
	{ 285.45,143.39,104.17 },
	{ -846.27,-341.28,38.67 },
	{ -846.85,-340.2,38.67 },
	{ -721.06,-415.56,34.98 },
	{ -1410.34,-98.75,52.42 },
	{ -1409.78,-100.49,52.39 },
	{ -712.9,-818.92,23.72 },
	{ -710.05,-818.9,23.72 },
	{ -660.71,-854.07,24.48 },
	{ -594.58,-1161.29,22.33 },
	{ -596.09,-1161.28,22.33 },
	{ -821.64,-1081.91,11.12 },
	{ 155.93,6642.86,31.59 },
	{ 174.14,6637.94,31.58 },
	{ -283.01,6226.11,31.49 },
	{ -95.55,6457.19,31.46 },
	{ -97.3,6455.48,31.46 },
	{ -132.93,6366.52,31.48 },
	{ -386.74,6046.08,31.49 },
	{ 24.47,-945.96,29.35 },
	{ 5.24,-919.83,29.55 },
	{ 295.77,-896.1,29.22 },
	{ 296.47,-894.21,29.23 },
	{ 1138.22,-468.93,66.73 },
	{ 1166.97,-456.06,66.79 },
	{ 1077.75,-776.54,58.23 },
	{ 289.1,-1256.8,29.44 },
	{ 288.81,-1282.37,29.64 },
	{ -1571.05,-547.38,34.95 },
	{ -1570.12,-546.72,34.95 },
	{ -1305.4,-706.41,25.33 },
	{ -2072.36,-317.28,13.31 },
	{ -2295.48,358.13,174.6 },
	{ -2294.7,356.46,174.6 },
	{ -2293.92,354.8,174.6 },
	{ 2558.75,351.01,108.61 },
	{ 89.69,2.47,68.29 },
	{ -866.69,-187.75,37.84 },
	{ -867.62,-186.09,37.84 },
	{ -618.22,-708.89,30.04 },
	{ -618.23,-706.89,30.04 },
	{ -614.58,-704.83,31.24 },
	{ -611.93,-704.83,31.24 },
	{ -537.82,-854.49,29.28 },
	{ -526.62,-1222.98,18.45 },
	{ -165.15,232.7,94.91 },
	{ -165.17,234.78,94.91 },
	{ -303.25,-829.74,32.42 },
	{ -301.7,-830.01,32.42 },
	{ -203.81,-861.37,30.26 },
	{ 119.06,-883.72,31.12 },
	{ 112.58,-819.4,31.34 },
	{ 111.26,-775.25,31.44 },
	{ 114.43,-776.38,31.41 },
	{ -256.23,-715.99,33.53 },
	{ -258.87,-723.38,33.48 },
	{ -254.42,-692.49,33.6 },
	{ -28.0,-724.52,44.23 },
	{ -30.23,-723.69,44.23 },
	{ -1315.75,-834.69,16.95 },
	{ -1314.81,-835.96,16.95 },
	{ -2956.86,487.64,15.47 },
	{ -2958.98,487.73,15.47 },
	{ -3043.97,592.42,7.9 },
	{ -3241.17,997.6,12.55 },
	{ -1205.78,-324.79,37.86 },
	{ -1205.02,-326.3,37.84 },
	{ 147.58,-1035.77,29.34 },
	{ 146.0,-1035.17,29.34 },
	{ 33.55,-1345.0,29.49 },
	{ 2555.28,389.99,108.61 },
	{ 1153.65,-326.78,69.2 },
	{ -717.71,-915.66,19.21 },
	{ -56.98,-1752.09,29.42 },
	{ 381.93,326.43,103.56 },
	{ -3243.78,1009.24,12.82 },
	{ 1737.02,6413.25,35.03 },
	{ 540.4,2667.86,42.16 },
	{ 1966.81,3746.52,32.33 },
	{ 2680.45,3288.48,55.23 },
	{ 1703.0,4933.6,42.06 },
	{ -1827.3,784.88,138.3 },
	{ -3043.91,592.48,7.9 },
	{ 238.61,212.44,106.27 },
	{ 239.06,213.67,106.27 },
	{ 239.5,214.88,106.27 },
	{ 239.94,216.15,106.27 },
	{ 241.01,219.02,106.27 },
	{ 241.43,220.24,106.27 },
	{ 241.89,221.49,106.27 },
	{ 242.35,222.7,106.27 },
	{ 264.02,203.62,106.27 },
	{ 264.48,204.89,106.27 },
	{ 264.94,206.14,106.27 },
	{ 265.38,207.34,106.27 },
	{ 126.82,-1296.6,29.27 },
	{ 127.81,-1296.03,29.27 },
	{ -248.04,6327.51,32.42 },
	{ 315.09,-593.68,43.29 },
	{ -677.36,5834.58,17.32 },
	{ 472.3,-1001.57,30.68 },
	{ 468.52,-990.55,26.27 },
	{ 349.86,-594.51,28.8 },
	{ -556.12,-205.21,38.22 },
	{ 560.5,2742.61,42.87 },
	{ 2564.5,2584.79,38.08 },
	{ -1200.76,-885.44,13.26 },
	{ 821.54,-780.27,26.17 },
	{ -1243.12,-1455.52,4.31 },
	{ -1242.01,-1454.75,4.31 },
	{ -1240.89,-1453.96,4.31 },
	{ -352.87,-144.98,38.91 },

	--- Banco Central
	{238.22,215.87,106.29,311.82, 3000},
	{237.84,216.97,106.29,283.47, 3000},
	{237.42,217.81,106.29,303.31, 3000},
	{237.06,218.7,106.29,303.31, 3000},
	{236.55,219.63,106.29,291.97, 3000},

	{265.88,213.97,106.27,238.12, 3000},
	{265.51,212.93,106.27,257.96, 3000},
	{265.13,211.93,106.27,263.63, 3000},
	{264.77,210.93,106.27,274.97, 3000},
	{264.44,210.06,106.27,257.96, 3000},
	

	
	-- BENNYS TUNER
	{ 836.47,-2114.67,29.59 },

	--- Lojas de Departamento
	{ 33.54,-1344.98,29.49,311.82 , 3000},
	{1737.05,6413.31,35.03,235.28, 3000},
	{2680.44,3288.44,55.23,337.33, 3000},
	{1966.75,3746.58,32.33,297.64, 3000},
	{540.37,2667.9,42.16,99.22, 3000},
	{2555.25,389.99,108.61,0.0, 3000},
	{1153.75,-326.8,69.2,104.89, 3000},
	{381.87,326.54,103.56,263.63, 3000},
	{-717.69,-915.67,19.21,93.55, 3000},

	-- LOCAIS Invoke
	{33.35,-1348.16,29.49},
	{540.18,2671.11,42.16},
	{2683.07,3286.5,55.23},
	{1735.22,6410.51,35.03},
	{-3240.59,1008.43,12.82},
	{-3040.7,593.04,7.9},
	{-2975.07,380.27,15.0},
	{380.66,323.45,103.56},



}

Citizen.CreateThread(function()
    SetNuiFocus(false,false)

    for k,v in pairs(atmList) do
        exports["target"]:AddCircleZone("ATM:"..k,vector3(v[1],v[2],v[3]),2.0,{
            name = "ATM:"..k,
            heading = 0.0
        },{
            Distance = 1.0,
			shop = k,
            options = {
                {
                    event = "atm:open",
                    label = "Acessar",
                    tunnel = "client",
                },
				{
					event = "bd_jackpotting:startRobbery",
					label = "Roubar",
					tunnel = "server",
				}
            }
        })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ELETRONICS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local currentTimer = GetGameTimer()
AddEventHandler("eletronics:openSystem",function(shopId)
	if vSERVER.checkSystems() then
		inTimers = 35
		inService = true
		TriggerEvent("Progress",'Roubando',35 * 1000)
		TriggerEvent('emotes','mexer')
		LocalPlayer["state"]["Cancel"] = true
		LocalPlayer["state"]["Commands"] = true
		SetEntityHeading(PlayerPedId(),atmList[shopId][4])
		SetEntityCoords(PlayerPedId(),atmList[shopId][1],atmList[shopId][2],atmList[shopId][3] - 1,1,0,0,0)

		while inService do
			if inTimers > 0 and GetGameTimer() >= currentTimer then
				inTimers = inTimers - 1
				currentTimer = GetGameTimer() + 1000
				vSERVER.paymentSystems(atmList[shopId][5])

				if inTimers <= 0 then
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Cancel"] = false
					vRP.removeObjects()
					inService = false
					break
				end
			end

			Citizen.Wait(1)
		end
	end
end)

Citizen.CreateThread(function()
    SetNuiFocus(false,false)

    for k,v in pairs(banks) do
        exports["target"]:AddCircleZone("BANK:"..k,vector3(v[1],v[2],v[3]),2.0,{
            name = "BANK:"..k,
            heading = 0.0
        },{
            Distance = 2.0,
            options = {
                {
                    event = "bank:open",
                    label = "Abrir",
                    tunnel = "client"
                }
            }
        })
    end
end)

RegisterNetEvent("bank:open",function()
	if vSERVER.requestWanted() then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	end
end)

RegisterNetEvent("atm:open",function()

	local ped = PlayerPedId()
	if not isBankOpened then
		local pin = vSERVER.GetPIN()
		if pin then
		
			if not isBankOpened then
				isBankOpened = true
				SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'atm',
					pin = pin,
				})
			end
		else
			TriggerEvent("Notify","vermelho","Para acessar o ATM, registre um pincode direto em uma agência!",5000)
		end
	end
end)

function openBank()
	local hasJob = false
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	multas = vSERVER.requestFines()
	isBankOpened = true

	local data = vSERVER.GetPlayerInfo()
	local cb, identifier, allDays = vSERVER.GetOverviewTransactions()

	isBankOpened = true
	trans = cb
	
	Citizen.Wait(1000)
	playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'bankmenu',
		playerName = data.playerName,
		playerSex = data.sex,
		playerBankMoney = data.playerBankMoney,
		walletMoney = walletMoney,
		db = trans,
		multas = multas,
		identifier = trsIdentifier,
		graphDays = allDaysValues,
	})
end

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:DepositMoney', tonumber(data.value))
			end
		end
	elseif data.action == "withdraw" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:WithdrawMoney', tonumber(data.value))
			end
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				TriggerServerEvent('RazeBank:TransferMoney', tonumber(data.value),data.iban)
			end
		end
	elseif data.action == "fines" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				vSERVER.finesPayment(data.id,tonumber(data.value))
			end
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
		})
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			pinCost = 1000,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				TriggerServerEvent('RazeBank:UpdatePINDB', data.pin, 1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("finesPayment",function(data)

	if data.id ~= nil then
		vSERVER.finesPayment(data.id,data.price)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateTransactions")
AddEventHandler("RazeBank:updateTransactions", function(money, wallet)
	Citizen.Wait(100)
	if isBankOpened then
		local cb, id, allDays = vSERVER.GetOverviewTransactions()
		trans = cb
		allDaysValues = allDays
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
		})
		TriggerEvent('RazeBank:updateMoney', money, wallet)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateMoney")
AddEventHandler("RazeBank:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEFINES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("RazeBank:updateFines")
AddEventHandler("RazeBank:updateFines", function(money, wallet)
    Citizen.Wait(100)
    if isBankOpened then
        multas = vSERVER.requestFines()
        allDaysValues = allDays
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'multas_page',
            playerBankMoney = playerBankMoney,
            walletMoney = walletMoney,
            db = multas,
            identifier = trsIdentifier,
            graphDays = allDaysValues,
        })
        TriggerEvent('RazeBank:updateMoney', money, wallet)
    end
end)