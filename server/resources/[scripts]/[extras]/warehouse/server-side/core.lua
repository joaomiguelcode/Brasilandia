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
Tunnel.bindInterface("warehouse",Creative)
vKEYBOARD = Tunnel.getInterface("keyboard")

local webhookwarehouse = "https://discord.com/api/webhooks/1156490227599294504/lIdMZ-mjQfFukzU7I-k9gbColcYcemGPezeeOZ9HiPO2Cc2JUMUEqU1alxDkPTNAza6s"
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE:PASSWORD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Password")
AddEventHandler("warehouse:Password",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] and Warehouse[1]["Passport"] == Passport then
			local Keyboard = vKEYBOARD.keyWord(source,"Nova Senha:")
			if Keyboard then
				local Password = sanitizeString(Keyboard[1],"0123456789",true)
				if string.len(Password) >= 4 and string.len(Password) <= 20 then
					vRP.Query("warehouse/Password",{ name = Name, password = Password })
					TriggerClientEvent("Notify",source,"verde","Senha atualizada.",5000)
				else
					TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Warehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not exports["hud"]:Wanted(Passport) then
			local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
			if Warehouse[1] then
				local Keyboard = vKEYBOARD.keyWord(source,"Senha:")
				if Keyboard then
					local Warehouse = vRP.Query("warehouse/Acess",{ name = Name, password = Keyboard[1] })
					if Warehouse[1] then
						if Warehouse[1]["tax"] > os.time() then
							return true
						else
							if vRP.Request(source,"Pagar o aluguel do armazém por 25 Diamantes por 30 dias?","Sim, por favor","Não, decido depois") then
								if vRP.PaymentGems(Passport, 25) then
									vRP.Query("warehouse/Tax",{ name = Name })
									return true
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
								end
							end
						end
					else
						TriggerClientEvent("Notify",source,"vermelho","Senha incorreta.",5000)
					end
				end
			else
				if vRP.Request(source,"Gostaria de alugar o armazém por <b>25 Diamantes</b> por 30 dias?","Sim, por favor","Não, decido depois") then
					local Keyboard = vKEYBOARD.keyWord(source,"Senha:")
					if Keyboard then
						local Password = sanitizeString(Keyboard[1],"0123456789",true)
						if string.len(Password) >= 4 and string.len(Password) <= 20 then
							if vRP.Request(source,"Finalizar a compra usando a senha <b>"..Password.."</b>?","Sim, por favor","Não, decido depois") then
								if vRP.PaymentGems(Passport, 25) then
									vRP.Query("warehouse/Buy",{ name = Name, Passport = Passport, password = Password })
									return true
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Diamantes</b> insuficientes.",5000)
								end
							end
						else
							TriggerClientEvent("Notify",source,"amarelo","Necessário possuir entre <b>4</b> e <b>20</b> números.",5000)
						end
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAREHOUSEUPGRADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("warehouse:Upgrade")
AddEventHandler("warehouse:Upgrade",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			if vRP.Request(source,"Aumentar <b>10Kg</b> por <b>$10.000</b> dólares?","Sim, efetuar pagamento","Não, decido depois") then
				if vRP.PaymentFull(Passport,10000) then
					vRP.Query("warehouse/Upgrade",{ name = Name })
					TriggerClientEvent("Notify",source,"verde","Aumento concluído.",3000)
				else
					TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.openWarehouse(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myInventory = {}
		local Inv = vRP.Inventory(Passport)
		for Index,v in pairs(Inv) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["desc"] = itemDescription(v["item"])
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

			myInventory[Index] = v
		end

		local myWarehouse = {}
		local Consult = vRP.GetSrvData("Warehouse:"..Name,true)
		for Index,v in pairs(Consult) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["economy"] = parseFormat(itemEconomy(v["item"]))
			v["desc"] = itemDescription(v["item"])
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

			myWarehouse[Index] = v
		end

		local Warehouse = vRP.Query("warehouse/Informations",{ name = Name })
		if Warehouse[1] then
			return myInventory,myWarehouse,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(Consult),Warehouse[1]["weight"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.storeItem(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if itemBlock(Item) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			goto scapeInventory
		end

		local Consult = vRP.Query("warehouse/Informations",{ name = Name })
		if Consult[1] then
			if vRP.StoreChest(Passport,"Warehouse:"..Name,Amount,Consult[1]["weight"],Slot,Target,true) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.GetSrvData("Warehouse:"..Name,true)
				TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(result),Consult[1]["weight"])
				vRP.SendWebhook(webhookwarehouse, "LOGs Warehouse", "**Passaporte: **"..Passport.."\n**Guardou: **"..Amount.."x "..itemName(Item).."\n**ID do Baú: **"..Consult[1].Passport, 48896)
			end
		end
	end

	::scapeInventory::
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.takeItem(Item,Slot,Amount,Target,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		local Consult = vRP.Query("warehouse/Informations",{ name = Name })

		

		if Consult[1] then
			if vRP.TakeChest(Passport,"Warehouse:"..Name,Amount,Slot,Target,true) then
				TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
			else
				local result = vRP.GetSrvData("Warehouse:"..Name,true)
				TriggerClientEvent("warehouse:Weight",source,vRP.InventoryWeight(Passport),vRP.GetWeight(Passport),vRP.ChestWeight(result),Consult[1]["weight"])
				vRP.SendWebhook(webhookwarehouse, "LOGs Warehouse", "**Passaporte: **"..Passport.."\n**Pegou: **"..Amount.."x "..itemName(Item).."\n**ID do Baú: **"..Consult[1].Passport, 10747904)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEWAREHOUSE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.updateWarehouse(Slot,Target,Amount,Name)
	local source = source
	local Amount = parseInt(Amount)
	local Passport = vRP.Passport(source)
	if Passport then
		if Amount <= 0 then Amount = 1 end

		if vRP.UpdateChest(Passport,"Warehouse:"..Name,Slot,Target,Amount,true) then
			TriggerClientEvent("warehouse:Update",source,"requestWarehouse")
		end
	end
end