-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("RazeBank",cRP)
local atmTimers = 0

local webhookSacar = "https://discord.com/api/webhooks/1156482539570085919/zIQj6W7f7lwyFGZxVeUXKdthHKPP80RJiGgBocwrHZX38HSSrBkujAPCLQrKifNzE0fx"
local webhookDepositar = "https://discord.com/api/webhooks/1156482627038089286/jQbBc2rUHteOIZk5jyibRziMS5YjCmqvGbNKvONdwDTFiKPGovE-xER82WDEk7yh9q9j"
local webhookTransferir = "https://discord.com/api/webhooks/1156485651542323200/KaOhLJ2k7bwwrwzPsELRRcLc66thN8XEiyWKX2_4LaFOUizJ7T9lIxPJMWe8SNVFqljG"
local webhookPagarMulta = "https://discord.com/api/webhooks/1156486005373816892/olj_P2vRVE57pv-x385NQtpBxwlsiX0KQTpMLV3HgEeUKUjNmNiC5HzLaVhbtvE0-6ls"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREAPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("vRP/Get_Transactions","SELECT * FROM RazeBank_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC")
vRP.Prepare("vRP/Transactions",'SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `RazeBank_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY')
vRP.Prepare('insert_tranctions','INSERT INTO RazeBank_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)')

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERINFO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.GetPlayerInfo()
    local source = source
    local user_id = vRP.Passport(source)
    local identity = vRP.Identity(user_id)
	local sex = GetEntityModel(GetPlayerPed(source))
	if tostring(sex) == "mp_m_freemode_01" then
        sex = "m"
    else
        sex = "f"
    end
    local data = {
        playerName = identity.name .. " " .. identity.name2,
        playerBankMoney = vRP.GetBank(source),
        walletMoney = vRP.InventoryItemAmount(user_id,"dollars") and vRP.InventoryItemAmount(user_id,"dollars")[1] or 0,
        sex = sex,
    }
    return data
end

function cRP.paymentSystems(amount)
	if amount then
		print(amount)
		local source = source
		local user_id = vRP.Passport(source)
		if user_id then
			print(user_id)
			vRP.GiveItem(user_id,'dollars',amount,true)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestWanted()
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		if exports["hud"]:Wanted(user_id,source) then
			return false
		end
	end

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSYSTEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkSystems()
	local source = source
	local user_id = vRP.Passport(source)
	if user_id then
		local policeResult = vRP.NumPermission("Police")
		if parseInt(#policeResult) <= 3 or os.time() < atmTimers then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		else
			local consultItem = vRP.InventoryItemAmount(user_id,"c4")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>Bomba Caseira</b>.",5000)
				return false
			end

			vRP.UpgradeStress(user_id,10)

			atmTimers = os.time() + 1200
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			TriggerClientEvent("player:applyGsr",source)

			for k,v in pairs(policeResult) do
				async(function()
					vRPC.PlaySound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
					TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Caixa Eletrônico", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
				end)
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPIN
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare('characters/Players', 'SELECT * FROM characters WHERE id = @id')
function cRP.GetPIN()
	local source = source
	local user_id = vRP.Passport(source)
	local identity = vRP.Query("characters/Players",{ id = user_id })
	
	return identity[1]["pincode"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSITMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:DepositMoney")
AddEventHandler("RazeBank:DepositMoney", function(amount)
	local source = source
	local user_id = vRP.Passport(source)
	local hasMoney = vRP.TakeItem(user_id,"dollars", amount)

	if hasMoney then 
		vRP.GiveBank(user_id,amount,"Private")

		TriggerEvent('RazeBank:AddDepositTransaction', amount, source)
		TriggerClientEvent('RazeBank:updateTransactions', source, vRP.GetBank(source), vRP.InventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","Você depositou $"..amount,5000)

		vRP.SendWebhook(webhookDepositar, "LOGs Depositar", "**Passaporte: **"..user_id.."\n**Depositou: **"..amount)
		-- vRP.SendLog('depositar', '[ID]: '..Passport..' \n[SACOU]: $'..amount, true)
	else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:WithdrawMoney")
AddEventHandler("RazeBank:WithdrawMoney", function(amount)
	local source = source
	local user_id = vRP.Passport(source)

	if vRP.PaymentBank(user_id,amount) then
		vRP.GiveItem(user_id,"dollars",amount,true)
		TriggerEvent('RazeBank:AddWithdrawTransaction', amount, source)
		TriggerClientEvent('RazeBank:updateTransactions', source, vRP.GetBank(source), vRP.InventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","Você sacou $"..amount,5000)
		-- vRP.SendLog('sacar', '[ID]: '..Passport..' \n[SACOU]: $'..amount, true)
		vRP.SendWebhook(webhookSacar, "LOGs Sacar", "**Passaporte: **"..user_id.."\n**Sacou: **"..amount)
	else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:TransferMoney")
AddEventHandler("RazeBank:TransferMoney", function(amount, nuser_id)
    local source = source
    local user_id = vRP.Passport(source)
	local identity = vRP.Identity(user_id)
    if user_id ~= nuser_id then
        if vRP.PaymentBank(user_id,amount) then
            if nuser_id ~= nil then
                vRP.GiveBank(nuser_id, amount)

                for i=1, #vRP.Players(), 1 do
                    local xForPlayer = vRP.Passport(vRP.Players()[i])
                    if xForPlayer == nuser_id then
						local identity2 = vRP.Identity(xForPlayer)
                        TriggerClientEvent('RazeBank:updateTransactions', vRP.Players()[i], vRP.GetBank(source), vRP.InventoryItemAmount(nuser_id,"dollars"))
                        TriggerClientEvent('okokNotify:Alert', vRP.Players()[i], "BANK", "Você recebeu $"..amount.." from "..identity2.name .. " " .. identity2.name2, 5000, 'success')
                    end
                end
                TriggerEvent('RazeBank:AddTransferTransaction', amount, nuser_id, source)
				TriggerClientEvent('RazeBank:updateTransactions', source, vRP.GetBank(source), vRP.InventoryItemAmount(user_id,"dollars"))
				TriggerClientEvent("Notify",source,"verde","Você transferiu $"..amount.." para "..identity.name .. " " .. identity.name2,5000)
				vRP.SendWebhook(webhookTransferir, "LOGs Transferir", "**Passaporte: **"..user_id.."\n**Transferiu: **"..amount)
				-- vRP.SendLog('transferir', '[ID]: '..Passport..' \n[TRANSFERIU]: $'..amount..' \n[PARA]: '..nuser_id, true)
            end
        else
			TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
        end
    else
		TriggerClientEvent("Notify",source,"vermelho","Você não pode transferir para si mesmo.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOVERVIEWTRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.GetOverviewTransactions()
	local source = source
	local user_id = vRP.Passport(source)
	local playerIdentifier = user_id
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	local result = vRP.Query("vRP/Get_Transactions", { identifier = playerIdentifier })

	local result2 = vRP.Query("vRP/Transactions", { })
	for k, v in pairs(result2) do
		local type = v.type
		local receiver_identifier = v.receiver_identifier
		local sender_identifier = v.sender_identifier
		local value = tonumber(v.value)

		if v.day1 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day1_total = day1_total + value
					income = income + value
				elseif type == "withdraw" then
					day1_total = day1_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day1_total = day1_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day1_total = day1_total - value
					outcome = outcome - value
				end
			end
			
		elseif v.day2 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day2_total = day2_total + value
					income = income + value
				elseif type == "withdraw" then
					day2_total = day2_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day2_total = day2_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day2_total = day2_total - value
					outcome = outcome - value
				end
			end

		elseif v.day3 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day3_total = day3_total + value
					income = income + value
				elseif type == "withdraw" then
					day3_total = day3_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day3_total = day3_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day3_total = day3_total - value
					outcome = outcome - value
				end
			end

		elseif v.day4 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day4_total = day4_total + value
					income = income + value
				elseif type == "withdraw" then
					day4_total = day4_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day4_total = day4_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day4_total = day4_total - value
					outcome = outcome - value
				end
			end

		elseif v.day5 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day5_total = day5_total + value
					income = income + value
				elseif type == "withdraw" then
					day5_total = day5_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day5_total = day5_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day5_total = day5_total - value
					outcome = outcome - value
				end
			end

		elseif v.day6 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day6_total = day6_total + value
					income = income + value
				elseif type == "withdraw" then
					day6_total = day6_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day6_total = day6_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day6_total = day6_total - value
					outcome = outcome - value
				end
			end

		elseif v.day7 == 1 then
			if value ~= nil then
				if type == "deposit" then
					day7_total = day7_total + value
					income = income + value
				elseif type == "withdraw" then
					day7_total = day7_total - value
					outcome = outcome - value
				elseif type == "transfer" and receiver_identifier == playerIdentifier then
					day7_total = day7_total + value
					income = income + value
				elseif type == "transfer" and sender_identifier == playerIdentifier then
					day7_total = day7_total - value
					outcome = outcome - value
				end
			end

		end
	end

	totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

	table.remove(allDays)
	table.insert(allDays, day1_total)
	table.insert(allDays, day2_total)
	table.insert(allDays, day3_total)
	table.insert(allDays, day4_total)
	table.insert(allDays, day5_total)
	table.insert(allDays, day6_total)
	table.insert(allDays, day7_total)
	table.insert(allDays, income)
	table.insert(allDays, outcome)
	table.insert(allDays, totalIncome)

	return result, playerIdentifier, allDays
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDDEPOSITTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddDepositTransaction")
AddEventHandler("RazeBank:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.Passport(_source)
	local identity = vRP.Identity(user_id)

	vRP.Query('insert_tranctions', {
		['receiver_identifier'] = 'bank',
		['receiver_name'] = 'Bank Account',
		['sender_identifier'] = tostring(user_id),
		['sender_name'] = identity.name .. " " .. identity.name2,
		['value'] = tonumber(amount),
		['type'] = 'deposit'
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSALARI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddSalaryTransaction")
AddEventHandler("RazeBank:AddSalaryTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.Passport(_source)
	local identity = vRP.Identity(user_id)

	vRP.Query('insert_tranctions', {
		['receiver_identifier'] = 'bank',
		['receiver_name'] = 'Pagamento',
		['sender_identifier'] = tostring(user_id),
		['sender_name'] = identity.name .. " " .. identity.name2,
		['value'] = tonumber(amount),
		['type'] = 'salary'
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDWITHDRAWTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddWithdrawTransaction")
AddEventHandler("RazeBank:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.Passport(_source)
	local identity = vRP.Identity(user_id)

	vRP.Query('insert_tranctions', {
		['receiver_identifier'] = tostring(user_id),
		['receiver_name'] = identity.name .. " " .. identity.name2,
		['sender_identifier'] = 'bank',
		['sender_name'] = 'Bank Account',
		['value'] = tonumber(amount),
		['type'] = 'withdraw'
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTRANSFERTRANSACTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("RazeBank:AddTransferTransaction")
AddEventHandler("RazeBank:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local user_id = vRP.Passport(_source)
	local identity = vRP.Identity(user_id)
	local identity2 = vRP.Identity(xTarget)

	if targetName == nil then
		vRP.Query('insert_tranctions', {
			['receiver_identifier'] = tostring(xTarget),
			['receiver_name'] = identity2.name .. " " .. identity2.name2,
			['sender_identifier'] = tostring(user_id),
			['sender_name'] = identity.name .. " " .. identity.name2,
			['value'] = tonumber(amount),
			['type'] = 'transfer'
		})
	elseif targetName ~= nil and targetIdentifier ~= nil then
		vRP.Query('insert_tranctions', {
			['receiver_identifier'] = tostring(targetIdentifier),
			['receiver_name'] = tostring(targetName),
			['sender_identifier'] = tostring(user_id),
			['sender_name'] = identity.name .. " " .. identity.name2,
			['value'] = tonumber(amount),
			['type'] = 'transfer'
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPINDB
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare('update_pincode', 'UPDATE characters SET pincode = @pin WHERE id = @identifier')
RegisterServerEvent("RazeBank:UpdatePINDB")
AddEventHandler("RazeBank:UpdatePINDB", function(pin, amount)
    local source = source
    local user_id = vRP.Passport(source)
    if vRP.PaymentBank(user_id,1000) then
		vRP.Query('update_pincode', {
            ['pin'] = pin,
            ['identifier'] = user_id,
        })
        TriggerClientEvent('RazeBank:updateIbanPinChange', source)
		TriggerClientEvent('RazeBank:updateMoney',source, vRP.GetBank(source), vRP.InventoryItemAmount(user_id,"dollars"))
		TriggerClientEvent("Notify",source,"verde","PIN trocado com sucesso para "..pin,5000)
    else
		TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finesPayment(id,price)
    local source = source
    local user_id = vRP.Passport(source)
    if user_id then
        if vRP.PaymentBank(user_id,parseInt(price)) then
            vRP.RemoveFine(user_id,parseInt(price))
			vRP.SendWebhook(webhookPagarMulta, "LOGs Pagar Multa", "**Passaporte: **"..user_id.."\n**Pagou: **"..price)
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
        end
    end
end