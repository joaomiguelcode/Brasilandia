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
Tunnel.bindInterface("garages",Creative)
vCLIENT = Tunnel.getInterface("garages")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local Spawn = {}
local Signal = {}
local Searched = {}
local Propertys = {}
local Cooldown = {}


-- SNT = exports[""]
local webhookCar = "https://discord.com/api/webhooks/1156470299404017716/scLSEnDlEjBNP1aHjr2epd8N8q_42ZXZ7TyBU_gn2evEj6vhUJsA3NwGC--ze9eLr9kZ"
local webhookimpound = "https://discord.com/api/webhooks/1156470434829705246/I800enimELMxlCpT2YRKRReiBESYMOqCpm8PYEDO2__OvU-wCEruaBIkQ9lKxyzLnjfC"
local webhookcompragaragem = "https://discord.com/api/webhooks/1156470629390880798/3JDCkZENJbqGbTclabk2ARxDXFMpFwcdC9SwezzrnoCoUdhLxj44BEIt1Tt07GugExM0"
local webhookgaragemretirada = "https://discord.com/api/webhooks/1156470798165483550/7GikbkbtxLL0APrD2PTx4HfRDjg1oi59X3Y67tjdlaTP1HDx5qALLpnSmZbcYKP21Lb7"
local webhooktaxagaragem = "https://discord.com/api/webhooks/1156470942659256351/sFbkRg2LgJMoJ-ZNMwEy_SnFJ1roOaFc-y2f_RucgsQu_JUOHkWB67lIh4bA2QGCY8Vz"
local webhookvendagaragem = "https://discord.com/api/webhooks/1156471109789692004/65ve3YyO8mpVfFnEwKEN0-SAP0TUc-nK8MBcHzgh-e-da1cBzVfq6vpQbkG_vusBZjCw"
local webhooktransferenciacarro = "https://discord.com/api/webhooks/1156471314178125935/b4OKop8GS6gaUpzhMC6rQI9psiVRIjtk4y-wQBsiEhwyg1MNHo5ynz2LN2ZiSFa8Mht_"
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
GlobalState["Plates"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVERVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ServerVehicle(Model,x,y,z,Heading,Plate,Nitrox,Doors,Body,Fuel)
	local Vehicle = CreateVehicle(Model,x,y,z,Heading,true,true)

	while not DoesEntityExist(Vehicle) do
		Wait(100)
	end

	if DoesEntityExist(Vehicle) then
		if Plate ~= nil then
			Citizen.Wait(400)
			SetVehicleNumberPlateText(Vehicle,Plate)
		else
			Plate = vRP.GeneratePlate()
			Citizen.Wait(400)
			SetVehicleNumberPlateText(Vehicle,Plate)
		end
		SetVehicleBodyHealth(Vehicle,Body + 0.0)
		
		if not Fuel then
			TriggerEvent("engine:tryFuel",Plate,100)
		end

		if Doors then
			local Doors = json.decode(Doors)
			if Doors ~= nil then
				for Number,Status in pairs(Doors) do
					if Status then
						SetVehicleDoorBroken(Vehicle,parseInt(Number),true)
					end
				end
			end
		end
		
		local Network = NetworkGetNetworkIdFromEntity(Vehicle)
		
		-- TriggerEvent("tunning:applyTunning", Network, Model, Plate)

		if Model ~= "wheelchair" then
			local Network = NetworkGetEntityFromNetworkId(Network)
			SetVehicleDoorsLocked(Network,2)

			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = Nitrox or 0
			GlobalState:set("Nitro",Nitro,true)
		end

		return true,Network,Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
local Garages = {
	["1"] = { name = "Garage", payment = false },
	["2"] = { name = "Garage", payment = true },
	["3"] = { name = "Garage", payment = true },
	["4"] = { name = "Garage", payment = false },
	["5"] = { name = "Garage", payment = false },
	["6"] = { name = "Garage", payment = true },
	["7"] = { name = "Garage", payment = true },
	["8"] = { name = "Garage", payment = true },
	["9"] = { name = "Garage", payment = false },
	["10"] = { name = "Garage", payment = true },
	["11"] = { name = "Garage", payment = true },
	["12"] = { name = "Garage", payment = true },
	["13"] = { name = "Garage", payment = true },
	["14"] = { name = "Garage", payment = true },
	["15"] = { name = "Garage", payment = true },
	["16"] = { name = "Garage", payment = true },
	["17"] = { name = "Garage", payment = true },
	["18"] = { name = "Garage", payment = true },
	["19"] = { name = "Garage", payment = true },
	["20"] = { name = "Garage", payment = true },
	["21"] = { name = "Garage", payment = true },
	["22"] = { name = "Garage", payment = true },
	["23"] = { name = "Garage", payment = false },
	["24"] = { name = "Garage", payment = true },
	["25"] = { name = "Garage", payment = true },
	["144"] = { name = "Garage", payment = true },
	["159"] = { name = "Garage", payment = false },

	-- Bicicletário
	["26"] = { name = "Bikes", payment = true },
	["27"] = { name = "Bikes", payment = true },
	["28"] = { name = "Bikes", payment = true },
	["29"] = { name = "Bikes", payment = true },
	-- Paramedic
	["41"] = { name = "Paramedic-sul", payment = false, perm = "Paramedic" },
	["42"] = { name = "heliParamedic-sul", payment = false, perm = "Paramedic" },

	["43"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["44"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	["45"] = { name = "Paramedic", payment = false, perm = "Paramedic" },
	["46"] = { name = "heliParamedic", payment = false, perm = "Paramedic" },

	-- Police
	["61"] = { name = "Police", payment = false, perm = "Police" },
	["62"] = { name = "heliPolice", payment = false, perm = "Police" },

	["63"] = { name = "Police", payment = false, perm = "Police" },
	["64"] = { name = "heliPolice", payment = false, perm = "Police" },

	["65"] = { name = "Police", payment = false, perm = "Police" },
	["66"] = { name = "heliPolice", payment = false, perm = "Police" },

	["67"] = { name = "Police", payment = false, perm = "Police" },
	["68"] = { name = "busPolice", payment = false, perm = "Police" },

	["69"] = { name = "Police", payment = false, perm = "Police" },

	["70"] = { name = "Police", payment = false, perm = "Police" },
	["71"] = { name = "heliPolice", payment = false, perm = "Police" },
	["72"] = { name = "busPolice", payment = false, perm = "Police" },

	["91"] = { name = "Garage", payment = false, perm = "Ballas" },
	["92"] = { name = "Garage", payment = false, perm = "Families" },
	["93"] = { name = "Garage", payment = false, perm = "Vagos" },
	["94"] = { name = "Garage", payment = false, perm = "Aztecas" },
	["95"] = { name = "Garage", payment = false, perm = "Bloods" },
	["96"] = { name = "Garage", payment = false, perm = "Triads" },
	["97"] = { name = "Garage", payment = false, perm = "Razors" },

	-- Boats
	["121"] = { name = "Boats", payment = false },
	["122"] = { name = "Boats", payment = false },
	["123"] = { name = "Boats", payment = false },
	["124"] = { name = "Boats", payment = false },
	["125"] = { name = "Boats", payment = false },
	["126"] = { name = "Boats", payment = false },

	-- Works
	["143"] = { name = "Garbageman", payment = false },
	["145"] = { name = "Taxi", payment = false },
	["149"] = { name = "Taxi", payment = false },
	["150"] = { name = "Trucker", payment = false },
	["151"] = { name = "Garage", payment = false, perm = "Hornys" },
	["152"] = { name = "Garbageman", payment = false, perm = "Rogers"  },
	["153"] = { name = "Garage", payment = false, perm = "Rogers" },
	["154"] = { name = "Mechanic", payment = false, perm = "Mechanic" },
	["155"] = { name = "Garage", payment = false, perm = "Pawnshop" },
	["156"] = { name = "Garage", payment = false, perm = "Bennys" },
	["157"] = { name = "Garage", payment = false, perm = "Paramedic" },
	["158"] = { name = "Garage", payment = false, perm = "Fazenda" },

	["160"] = { name = "Garage", payment = false, perm = "Esquadrao" },
	["161"] = { name = "Garage", payment = false, perm = "Redencao" },
	["162"] = { name = "Garage", payment = false, perm = "Renegados" },
	["163"] = { name = "Garage", payment = false, perm = "Thelost" },
	["164"] = { name = "Garage", payment = false, perm = "Bratva" },
	["165"] = { name = "Garage", payment = false, perm = "Tequila" },
	["166"] = { name = "Garage", payment = false, perm = "Cosanostra" },
	["167"] = { name = "Garage", payment = false, perm = "Uwucoffee" },
	["168"] = { name = "Garage", payment = false, perm = "BurgerShot" },

	["169"] = { name = "Bikes", payment = true },
	["170"] = { name = "Mechanic", payment = false, perm = "Mechanic68" },

	["171"] = { name = "Garage", payment = false, perm = "Ballas" },
	["172"] = { name = "Garage", payment = false, perm = "Families" },
	["173"] = { name = "Garage", payment = false, perm = "Vagos" },
	["174"] = { name = "Garage", payment = false, perm = "Bloods" },
	["175"] = { name = "Garage", payment = false, perm = "Tijuana" },
	["176"] = { name = "Garage", payment = false, perm = "LSCustoms" },
	["177"] = { name = "Garage", payment = false, perm = "Mafia" },
	["178"] = { name = "Garage", payment = false, perm = "Trem" },
	["179"] = { name = "Garage", payment = false, perm = "Cripz" },
	["180"] = { name = "Evento", payment = false, perm = "Evento" },
	["181"] = { name = "Police", payment = false, perm = "Police" },
	["182"] = { name = "Garage", payment = false, perm = "Digitalden" },
	["183"] = { name = "Lenhador", payment = false },
	["184"] = { name = "Transporter", payment = false },
	["185"] = { name = "Police", payment = false, perm = "Police" },
	["186"] = { name = "heliPolice2", payment = false, perm = "Police" },
	["187"] = { name = "Judiciario", payment = false, perm = "Judiciario" },
	["188"] = { name = "Garage", payment = false, perm = "Coiote" },
	["189"] = { name = "Rota", payment = false, perm = "Police" },
	["190"] = { name = "PMESP", payment = false, perm = "Police" },
	["191"] = { name = "CIVIL", payment = false, perm = "Police" },
	["192"] = { name = "RODOVIARIA", payment = false, perm = "Police" },
	["193"] = { name = "BAEP", payment = false, perm = "Police" },
	["194"] = { name = "FEDERAL", payment = false, perm = "Police" },

	
	

	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNALREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("signalRemove",function(Plate)
	if not Signal[Plate] then
		Signal[Plate] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEREVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateReveryone",function(Plate)
	if GlobalState["Plates"][Plate] then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = nil
		GlobalState:set("Plates",Plates,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEEVERYONE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("plateEveryone",function(Plate)
	local Plates = GlobalState["Plates"]
	Plates[Plate] = true
	GlobalState:set("Plates",Plates,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATEPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("platePlayers",function(Plate,Passport)
	if not vRP.PassportPlate(Plate) then
		local Plates = GlobalState["Plates"]
		Plates[Plate] = Passport
		GlobalState:set("Plates",Plates,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local Works = {
	["Bikes"] = {
		"bmx",
	},
	["Paramedic"] = {
		"st_Wrasprinter"
	},
	["Paramedic-sul"] = {
		"st_Wrasprinter"
	},
	["heliParamedic-sul"] = {
		"st_polmav"
	},
	["Judiciario"] = {
		"dubsta2"
	},
	["heliParamedic"] = {
		"st_polmav"
	},
	["Rota"] = {
		"sw4pm",	
		"trail20pm",
		"trail21pm"
	},
	["PMESP"] = {
		"basepm",	
		"spinaegis",
		"spineng",
		"trail21pc",
		"sw4pm",
		"police",
		"onibuspolicia",
		"trail21ft1",
		"corollarodrp1",
		"baserp1",
		"xre19rpm"
	},
	["CIVIL"] = {	
		"trailcivileie",
		"traildope3",
		"s10garrasp",
		"sidsw4"
	},
	["RODOVIARIA"] = {
		"corollarod",	
		"dusterrp1",
		"spinlegion",
		"sw4tor",
		"trail21pm",
		"xt2017pm"
	},
	["BAEP"] = {
		"trail17pm",	
		"trail20pm",
		"trail22bpchq",
		"trail22bpchq2",
		"tchoque",
		"sprintergate",
		"hiluxcoe",
		"s10garrasp"
	},
	["FEDERAL"] = {	
		"dusterrp1",
		"trail21pm"
		
	},
	["Evento"] = {
		"dominator4",
	},
	["heliPolice"] = {
		"as350",
		"frogger"
	},
	["heliPolice2"] = {
		"as350"
	},
	["busPolice"] = {
		"pbus",
		"riot"
	},
	["Driver"] = {
		"bus"
	},
	["Boats"] = {
		"dinghy",
		"jetmax",
		"marquis",
		"seashark",
		"speeder",
		"squalo",
		"suntrap",
		"toro",
		"tropic"
	},
	["Transporter"] = {
		"stockade"
	},
	["TowDriver"] = {
		"flatbed",
		"towtruck",
		"towtruck2"
	},
	["Garbageman"] = {
		"trash"
	},
	["Taxi"] = {
		"taxi"
	},
	["Lenhador"] = {
		"ratloader"
	},
	["Trucker"] = {
		"hauler",
		"packer",
	},
	["Mechanic"] = {
		"flatbed",
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.canOpen()
	local src = source
	local charId = vRP.Passport(src)
	local totalFines = exports["oxmysql"]:query_async("SELECT fines FROM characters WHERE id = "..charId)

	if #totalFines < 0 then return false end

	totalFines = totalFines[1].fines
	if totalFines < 20000 then return true end

	TriggerClientEvent("Notify",src,'vermelho','Você tem mais de $20.000 em multas pendentes',5000)
	return false

end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Vehicles(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Wanted(Passport) then
		if Garages[Number]["perm"] then
			if not vRP.HasService(Passport,Garages[Number]["perm"]) then
				return false
			end
		end

		if Garages[Number]['type'] then
			if not hasResidencePermission(Passport,Garages[Number]['type'],Garages[Number]['id']) then return false end
		end

		local Vehicle = {}
		local Garage = Garages[Number]["name"]
		if Works[Garage] then
			for _,v in pairs(Works[Garage]) do
				if VehicleExist(v) then
					Vehicle[#Vehicle + 1] = { ["Model"] = v, ["name"] = VehicleName(v) }
				end
			end
		else
			local Consult = vRP.Query("vehicles/UserVehicles",{ Passport = Passport })
			for _,v in pairs(Consult) do
				if VehicleExist(v["vehicle"]) then
					if v["work"] == "false" then
						Vehicle[#Vehicle + 1] = { ["Model"] = v["vehicle"], ["name"] = VehicleName(v["vehicle"]) }
					end
				end
			end
		end

		return Vehicle
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Impound()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicles = {}
		local Vehicle = vRP.Query("vehicles/UserVehicles",{ Passport = Passport })

		for Number,v in ipairs(Vehicle) do
			if v["arrest"] >= os.time() then
				Vehicles[#Vehicles + 1] = { ["Model"] = Vehicle[Number]["vehicle"], ["name"] = VehicleName(Vehicle[Number]["vehicle"]) }
			end
		end

		return Vehicles
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:IMPOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Impound")
AddEventHandler("garages:Impound",function(vehName)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local VehiclePrice = VehiclePrice(vehName)
		TriggerClientEvent("dynamic:closeSystem",source)

		if vRP.Request(source,"A liberação do veículo tem o custo de <b>$"..parseFormat(VehiclePrice * 0.10).."</b> dólares, deseja prosseguir com a liberação do mesmo?","Sim, efetuar o pagamento","Não, decido depois") then
			if vRP.PaymentFull(Passport,VehiclePrice * 0.10) then
				vRP.Query("vehicles/paymentArrest",{ Passport = Passport, vehicle = vehName })
				TriggerClientEvent("Notify",source,"verde","Veículo liberado.",5000)
				vRP.SendWebhook(webhookimpound, "LOGs Impound", "**Passaporte: **"..Passport.."\n**Retirou o veículo : **"..vehName.."\n**Pagando: **"..VehiclePrice * 0.10, 10357504)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TAX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Tax")
AddEventHandler("garages:Tax",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Consult[1] and Consult[1]["tax"] <= os.time() then
			local Price = VehiclePrice(Name) * 0.05

			if vRP.PaymentFull(Passport,Price) then
				vRP.Query("vehicles/updateVehiclesTax",{ Passport = Passport, vehicle = Name })
				TriggerClientEvent("Notify",source,"verde","Pagamento concluído.",5000)
				vRP.SendWebhook(webhooktaxagaragem, "LOGs Taxa", "**Passaporte: **"..Passport.."\n**Pagou a taxa do veículo: **"..Consult[1].vehicle.."\n**Pelo valor de: **"..Price, 10357504)
			else
				TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SELL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Sell")
AddEventHandler("garages:Sell",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Mode = VehicleMode(Name)
		if Mode == "rental" or Mode == "work" then
			return
		end

		local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if Consult[1] then
			local Price = VehiclePrice(Name) * 0.5
			if vRP.Request(source,"Vender o veículo <b>"..VehicleName(Name).."</b> por <b>$"..parseFormat(Price).."</b>?","Sim, concluír venda","Não, mudei de ideia") then
				local Consult = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
				if Consult[1] then
					vRP.GiveBank(Passport,Price)
					vRP.Query("vehicles/removeVehicles",{ Passport = Passport, vehicle = Name })
					vRP.Query("entitydata/RemoveData",{ dkey = "Mods:"..Passport..":"..Name })
					vRP.Query("entitydata/RemoveData",{ dkey = "Chest:"..Passport..":"..Name })
					vRP.SendWebhook(webhookvendagaragem, "LOGs Venda Garagem", "**Passaporte: **"..Passport.."\n**Vendeu o veículo: **"..Consult[1].vehicle.."\n**Valor: **"..Price, 10357504)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:TRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Transfer")
AddEventHandler("garages:Transfer",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local myVehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
		if myVehicle[1]  then
			TriggerClientEvent("dynamic:closeSystem",source)
			local Mode = VehicleMode(Name)

			local Keyboard = vKEYBOARD.keySingle(source,"Passaporte:")
			if Mode ~= "rental" then
				if Keyboard then
					local OtherPassport = parseInt(Keyboard[1])
					local Identity = vRP.Identity(OtherPassport)
					local Price = VehiclePrice(Name) * 0.05
					if Identity then
						if vRP.UserPremium(Passport) and vRP.Request(source,"Transferir o veículo <b>"..VehicleName(Name).."</b> para <b>"..Identity["name"],"Sim","Não, mudei de ideia") then
							local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = parseInt(OtherPassport), vehicle = Name })
							if Vehicle[1] then
								TriggerClientEvent("Notify",source,"amarelo","<b>"..Identity["name"].." "..Identity["name2"].."</b> já possui este modelo de veículo.",5000)
							else
								local playerCars = exports["oxmysql"]:query_async([[
									SELECT COUNT(vehicle) as vehicles FROM vehicles WHERE Passport = ? AND `work` = "false" AND rental = 0
								]], {parseInt(OtherPassport)})[1]["vehicles"]
								local maxCars = exports["oxmysql"]:query_async([[
									SELECT garage from characters WHERE id = ?
								]], {parseInt(OtherPassport)})[1]["garage"]

								if playerCars >= maxCars then
									TriggerClientEvent("Notify",source,"vermelho","A pessoa só pode ter "..maxCars.." carros em sua garagem.",5000)
									return
								end

								vRP.Query("vehicles/moveVehicles",{ Passport = Passport, OtherPassport = parseInt(OtherPassport), vehicle = Name })

								local Datatable = vRP.Query("entitydata/GetData",{ dkey = "Mods:"..Passport..":"..Name })
								if parseInt(#Datatable) > 0 then
									vRP.Query("entitydata/SetData",{ dkey = "Mods:"..OtherPassport..":"..Name, dvalue = Datatable[1]["dvalue"] })
									vRP.Query("entitydata/RemoveData",{ dkey = "Mods:"..Passport..":"..Name })
								end

								local Datatable = vRP.GetSrvData("Chest:"..Passport..":"..Name,true)
								vRP.SetSrvData("Chest:"..OtherPassport..":"..Name,Datatable,true)
								vRP.RemSrvData("Chest:"..Passport..":"..Name,true)

								TriggerClientEvent("Notify",source,"verde","Transferência concluída.",5000)
							end
						elseif vRP.Request(source,"Transferir o veículo <b>"..VehicleName(Name).."</b> para <b>"..Identity["name"].." "..Identity["name2"].."</b>","por <b>$"..parseFormat(Price).."</b>?","Não, mudei de ideia") then
							local Vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = parseInt(OtherPassport), vehicle = Name })

							local playerCars = exports["oxmysql"]:query_async([[
								SELECT COUNT(vehicle) as vehicles FROM vehicles WHERE Passport = ? AND `work` = "false" AND rental = 0
							]], {parseInt(OtherPassport)})[1]["vehicles"]
							local maxCars = exports["oxmysql"]:query_async([[
								SELECT garage from characters WHERE id = ?
							]], {parseInt(OtherPassport)})[1]["garage"]

							if playerCars >= maxCars then
								TriggerClientEvent("Notify",source,"vermelho","A pessoa só pode ter "..maxCars.." carros em sua garagem.",5000)
								return
							end

							if Vehicle[1] then
								TriggerClientEvent("Notify",source,"amarelo","<b>"..Identity["name"].." "..Identity["name2"].."</b> já possui este modelo de veículo.",5000)
							elseif vRP.PaymentFull(Passport,Price) then
								vRP.Query("vehicles/moveVehicles",{ Passport = Passport, OtherPassport = parseInt(OtherPassport), vehicle = Name })

								local Datatable = vRP.Query("entitydata/GetData",{ dkey = "Mods:"..Passport..":"..Name })
								if parseInt(#Datatable) > 0 then
									vRP.Query("entitydata/SetData",{ dkey = "Mods:"..OtherPassport..":"..Name, dvalue = Datatable[1]["dvalue"] })
									vRP.Query("entitydata/RemoveData",{ dkey = "Mods:"..Passport..":"..Name })
								end

								local Datatable = vRP.GetSrvData("Chest:"..Passport..":"..Name,true)
								vRP.SetSrvData("Chest:"..OtherPassport..":"..Name,Datatable,true)
								vRP.RemSrvData("Chest:"..Passport..":"..Name,true)

								TriggerClientEvent("Notify",source,"verde","Transferência concluída.",5000)
								vRP.SendWebhook(webhooktransferenciacarro, "LOGs Transferencia", "**Passaporte: **"..Passport.."\n**Transferiu o veículo: **"..Name.."\n Para o ID: "..OtherPassport, 10357504)

							else
								TriggerClientEvent("Notify",source,"vermelho","Dólares insuficientes.",5000)
							end
						end
					end
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Não é possível transferir veículos alugados.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Spawn")
AddEventHandler("garages:Spawn",function(Table)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Cooldown[Passport] then
			TriggerClientEvent('Notify',source,'amarelo','Aguarde: '..Cooldown[Passport]..' segundos para retirar outro veículo',5000)
			return
		end
		Cooldown[Passport] = 5
		local splitName = splitString(Table,"-")
		local Number = splitName[2]
		local Name = splitName[1]

		local Gemstone = VehicleGems(Name)
		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })

		if not vehicle[1] then
			if parseInt(Gemstone) > 0 then
				if vRP.Request(source,"Alugar o veículo <b>"..VehicleName(Name).."</b> por <b>"..Gemstone.."</b> Diamantes por 30 dias ?","Sim, concluír aluguel","Não, mudei de ideia") then
					if vRP.PaymentGems(Passport,Gemstone) then
						vRP.Query("vehicles/rentalVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
						TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> concluído.",5000)
						vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
						
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
						return
					end
				else
					return
				end
			else
				local VehiclePrice = VehiclePrice(Name)
				if parseInt(VehiclePrice) > 0 then
					if vRP.Request(source,"Comprar <b>"..VehicleName(Name).."</b> por <b>$"..parseFormat(VehiclePrice).."</b> dólares?","Sim, concluír pagamento","Não, mudei de ideia") then
						if vRP.PaymentFull(Passport,VehiclePrice) then
							vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
							vRP.SendWebhook(webhookcompragaragem, "LOGs Compra", "**Passaporte: **"..Passport.."\n**Comprou o veículo: **"..VehicleName(Name).."\n**Valor: **"..parseFormat(VehiclePrice), 10357504)
							vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					else
						return
					end
				else
					vRP.Query("vehicles/addVehicles",{ Passport = Passport, vehicle = Name, plate = vRP.GeneratePlate(), work = "true" })
					vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = Name })
				end
			end
		end

		if vehicle[1] then
			local Plates = GlobalState["Plates"]
			local Plate = vehicle[1]["plate"]

			if Spawn[Plate] then
				if not Signal[Plate] then
					if not Searched[Passport] then
						Searched[Passport] = os.time()
					end

					if os.time() >= parseInt(Searched[Passport]) then
						Searched[Passport] = os.time() + 60

						local Network = Spawn[Plate][3]
						local Network = NetworkGetEntityFromNetworkId(Network)
						if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 then
							vCLIENT.SearchBlip(source,GetEntityCoords(Network))
							TriggerClientEvent("Notify",source,"amarelo","Rastreador do veículo foi ativado por <b>30</b> segundos, lembrando que se o mesmo estiver em movimento a localização pode ser imprecisa.",10000)
						else
							if Spawn[Plate] then
								Spawn[Plate] = nil
							end

							if Plates[Plate] then
								Plates[Plate] = nil
								GlobalState:set("Plates",Plates,true)
							end

							TriggerClientEvent("Notify",source,"verde","A seguradora efetuou o resgate do seu veículo e o mesmo já se encontra disponível para retirada.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"amarelo","Rastreador só pode ser ativado a cada <b>60</b> segundos.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"amarelo","Rastreador está desativado.",5000)
				end
			else
				if vehicle[1]["tax"] <= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Taxa do veículo atrasada.",5000)
				elseif vehicle[1]["arrest"] >= os.time() then
					TriggerClientEvent("Notify",source,"amarelo","Veículo apreendido, dirija-se até o <b>Impound</b> e efetue o pagamento da liberação do mesmo.",5000)
				elseif vehicle[1]["dismantle"] == 1 then
					local vehDismantlePrice = VehiclePrice(Name)
					local vehType = VehicleMode(Name)
					
					if vRP.Request(source,"Veiculo desmanchado deseja pagar a seguradora? valor:<b>$"..parseFormat(vehDismantlePrice * 0.1).."</b> dólares?", 30) then
						if vRP.PaymentFull(Passport, vehDismantlePrice * 0.1) then
							TriggerClientEvent("Notify",source,"verde","<b>O seguro foi pago! e todos os danos ao veiculo restaurados.</b>",7000)
							vRP.Query("desmanche/set",{ Passport = Passport, vehicle = Name, dismantle = 0 })
						else
							TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
						end
					end
				else
					if vehicle[1]["rental"] ~= 0 then
						if vehicle[1]["rental"] <= os.time() then
							if vRP.Request(source,"Atualizar o aluguel do veículo <b>"..VehicleName(Name).."</b> por <b>"..Gemstone.." gemas</b>?","Sim, concluír pagamento","Não, mudei de ideia") then
								if vRP.PaymentGems(Passport,Gemstone) then
									vRP.Query("vehicles/rentalVehiclesUpdate",{ Passport = Passport, vehicle = Name })
									TriggerClientEvent("Notify",source,"verde","Aluguel do veículo <b>"..VehicleName(Name).."</b> atualizado.",5000)
								else
									TriggerClientEvent("Notify",source,"vermelho","<b>Gemas</b> insuficientes.",5000)
									return
								end
							else
								return
							end
						end
					end

					local Coords = vCLIENT.SpawnPosition(source,Number)
					if Coords then
						local Mods = nil
						local Datatable = vRP.Query("entitydata/GetData",{ dkey = "Mods:"..Passport..":"..Name })
						if parseInt(#Datatable) > 0 then
							Mods = Datatable[1]["dvalue"]
						end

						if Garages[Number]["payment"] then
							print(vRP.UserPremium(Passport))
							if vRP.UserPremium(Passport) then
								TriggerClientEvent("dynamic:closeSystem",source)
								local Exist,Network = Creative.ServerVehicle(Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

								if Exist then
									vCLIENT.CreateVehicle(-1,Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"],vehicle[1]["tyres"])
									TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
									TriggerEvent("engine:tryFuel",Plate,vehicle[1]["fuel"])
									Spawn[Plate] = { Passport,Name,Network }

									Plates[Plate] = Passport
									GlobalState:set("Plates",Plates,true)
								end
							else
								local VehiclePrice = VehiclePrice(Name)
								if vRP.Request(source,"Retirar o veículo por <b>$"..parseFormat(VehiclePrice * 0.05).."</b> dólares?","Sim, efetuar o pagamento","Não, volto depois") then
									if vRP.GetBank(source) >= parseInt(VehiclePrice * 0.05) or vRP.ConsultItem(Passport,"dollars",VehiclePrice * 0.05) then
										TriggerClientEvent("dynamic:closeSystem",source)
										local Exist,Network = Creative.ServerVehicle(Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

										if Exist then
											vCLIENT.CreateVehicle(-1,Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"],vehicle[1]["tyres"])
											TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
											TriggerEvent("engine:tryFuel",Plate,vehicle[1]["fuel"])
											Spawn[Plate] = { Passport,Name,Network }
											vRP.PaymentFull(Passport,VehiclePrice * 0.05)
											vRP.SendWebhook(webhookgaragemretirada, "LOGs Retirada", "**Passaporte: **"..Passport.."\n**Retirou o veículo: **"..VehicleName(Name).."\n**Valor: **"..parseFormat(VehiclePrice * 0.05).."\n**Coordenada: **"..Coords[1]..", "..Coords[2]..", "..Coords[3], 10357504)

											Plates[Plate] = Passport
											GlobalState:set("Plates",Plates,true)
										end
									else
										TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
									end
								end
							end
						else
							TriggerClientEvent("dynamic:closeSystem",source)
							local Exist,Network = Creative.ServerVehicle(Name,Coords[1],Coords[2],Coords[3],Coords[4],Plate,vehicle[1]["nitro"],vehicle[1]["doors"],vehicle[1]["body"])

							if Exist then
								vCLIENT.CreateVehicle(-1,Name,Network,vehicle[1]["engine"],vehicle[1]["health"],Mods,vehicle[1]["windows"],vehicle[1]["tyres"])
								TriggerClientEvent("Notify",source,"azul",CompleteTimers(vehicle[1]["tax"] - os.time()),1000)
								TriggerEvent("engine:tryFuel",Plate,vehicle[1]["fuel"])
								Spawn[Plate] = { Passport,Name,Network }

								Plates[Plate] = Passport
								GlobalState:set("Plates",Plates,true)
							end
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		for k,v in pairs(Cooldown) do
			Cooldown[k] = v-1
			if Cooldown[k] < 0 then
				Cooldown[k] = nil
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("car",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) and Message[1] then
			local VehicleName = Message[1]
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local Heading = GetEntityHeading(Ped)
			local Plate = "VEH"..(math.random(10000,19999) + math.random(0,Passport))
			local Exist,Network,Vehicle = Creative.ServerVehicle(VehicleName,Coords["x"],Coords["y"],Coords["z"],Heading,Plate,2000,nil,1000)

			if not Exist then
				return
			end

			vCLIENT.CreateVehicle(-1,VehicleName,Network,1000,1000,nil,false,false)
			Spawn[Plate] = { Passport,VehicleName,Network }
			TriggerEvent("engine:tryFuel",Plate,100)
			SetPedIntoVehicle(Ped,Vehicle,-1)

			local Plates = GlobalState["Plates"]
			Plates[Plate] = Passport
			GlobalState:set("Plates",Plates,true)

			vRP.SendWebhook(webhookCar, "LOGs Spawn Carro", "**Passaporte: **"..Passport.."\n**Spawnou: **"..VehicleName.."\n**CDS: **"..json.encode(Coords), 3558275)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("dv", function(source, args, rawCommand)
    local Passport = vRP.Passport(source)
    if Passport and vRP.HasGroup(Passport, "Admin", 2) then
        local Vehicle = vRPC.vehicleName(source)
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        
        TriggerClientEvent("garages:Delete", source)

        local logMessage = string.format("**Passaporte:** %s\n**Deu:** dv\n**Veículo:** %s\n**Localidade:** %.2f, %.2f, %.2f\n**Horário:** %s", Passport, Vehicle, coords.x, coords.y, coords.z, os.date("%H:%M:%S"))

        TriggerEvent("Discord", "dv", logMessage, 3092790)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:KEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Key")
AddEventHandler("garages:Key",function(entity)
	local source = source
	local Plate = entity[1]
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Plates"][Plate] == Passport then
		vRP.GenerateItem(Passport,"vehkey-"..Plate,1,true,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Lock")
AddEventHandler("garages:Lock",function(Network,Plate)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and GlobalState["Plates"][Plate] == Passport then
		TriggerEvent("garages:LockVehicle",source,Network)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:LOCKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("garages:LockVehicle",function(source,Network)
	local Network = NetworkGetEntityFromNetworkId(Network)
	local Doors = GetVehicleDoorLockStatus(Network)

	if parseInt(Doors) <= 1 then
		TriggerClientEvent("Notify",source,"locked","Veículo trancado.",5000)
		TriggerClientEvent("sounds:Private",source,"locked",0.7)
		SetVehicleDoorsLocked(Network,2)
	else
		TriggerClientEvent("Notify",source,"verde","Veículo destrancado.",5000)
		TriggerClientEvent("sounds:Private",source,"unlocked",0.7)
		SetVehicleDoorsLocked(Network,1)
	end

	if not vRP.InsideVehicle(source) then
		vRPC.playAnim(source,true,{"anim@mp_player_intmenu@key_fob@","fob_click"},false)
		Wait(350)
		vRPC.stopAnim(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Delete(Network,Health,Engine,Body,Fuel,Doors,Windows,Tyres,Plate)
	if Spawn[Plate] then
		local Passport = Spawn[Plate][1]
		local vehName = Spawn[Plate][2]

		if parseInt(Engine) <= 100 then
			Engine = 100
		end

		if parseInt(Body) <= 100 then
			Body = 100
		end

		if parseInt(Fuel) >= 100 then
			Fuel = 100
		end

		if parseInt(Fuel) <= 0 then
			Fuel = 0
		end

		local vehicle = vRP.Query("vehicles/selectVehicles",{ Passport = Passport, vehicle = vehName })
		if vehicle[1] ~= nil then
			vRP.Query("vehicles/updateVehicles",{ Passport = Passport, vehicle = vehName, nitro = GlobalState["Nitro"][Plate] or 0, engine = parseInt(Engine), body = parseInt(Body), health = parseInt(Health), fuel = parseInt(Fuel), doors = json.encode(Doors), windows = json.encode(Windows), tyres = json.encode(Tyres) })
		end
	end

	TriggerEvent("garages:deleteVehicle",Network,Plate)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:DELETEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle",function(Network,Plate)
	if Network ~= nil and Plate ~= nil then
		if GlobalState["Plates"][Plate] then
			local Plates = GlobalState["Plates"]
			Plates[Plate] = nil
			GlobalState:set("Plates",Plates,true)
		end

		if GlobalState["Nitro"][Plate] then
			local Nitro = GlobalState["Nitro"]
			Nitro[Plate] = nil
			GlobalState:set("Nitro",Nitro,true)
		end

		if Signal[Plate] then
			Signal[Plate] = nil
		end

		if Spawn[Plate] then
			Spawn[Plate] = nil
		end

		if string.sub(Plate,1,4) == "DISM" then
			local Passport = parseInt(string.sub(Plate,5,8)) - 1000
			local source = vRP.Source(Passport)
			if source then
				TriggerClientEvent("inventory:Disreset",source)
				TriggerClientEvent("Notify",source,"amarelo","O veículo do seu contrato foi encaminhado para o <b>Impound</b> e o <b>Lester</b> disse que você pode assinar um novo contrato quando quiser.",10000)
			end
		end

		local Network = NetworkGetEntityFromNetworkId(Network)
		if DoesEntityExist(Network) and not IsPedAPlayer(Network) and GetEntityType(Network) == 2 and GetVehicleNumberPlateText(Network) == Plate then
			DeleteEntity(Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARAGES:PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("garages:Propertys")
AddEventHandler("garages:Propertys",function(Name)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		TriggerClientEvent("dynamic:closeSystem",source)
		TriggerClientEvent("Notify",source,"amarelo","Selecione o local da garagem.",5000)

		local Hash = "prop_offroad_tyres02"
		local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
		if Application then
			if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
				TriggerClientEvent("Notify",source,"amarelo","Selecione o local do veículo.",5000)

				local Open = Coords
				local Hash = "patriot"
				local Application,Coords,Heading = vRPC.objectCoords(source,Hash)
				if Application then
					if #(Coords - exports["propertys"]:Coords(Name)) <= 25 then
						local New = {
							["1"] = { mathLength(Open["x"]),mathLength(Open["y"]),mathLength(Open["z"] + 1) },
							["2"] = { mathLength(Coords["x"]),mathLength(Coords["y"]),mathLength(Coords["z"] + 1),mathLength(Heading) }
						}

						Garages[Name] = { name = "Garage", payment = false }

						Propertys[Name] = {
							["x"] = New["1"][1],
							["y"] = New["1"][2],
							["z"] = New["1"][3],
							["1"] = New["2"]
						}

						vRP.Query("propertys/Garage",{ name = Name, garage = json.encode(New) })
						TriggerClientEvent("garages:Propertys",-1,Propertys)
					else
						TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000)
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","A garagem precisa ser próximo da entrada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIGNAL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Signal",function(Plate)
	return Signal[Plate]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("garages:Propertys",source,Propertys)
end)