-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("plants",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
local growthTime = 2 * 60 * 60
--local growthTime = 15
local phases = {
	[1] = 'bkr_prop_weed_01_small_01c',
	[2] = 'bkr_prop_weed_01_small_01a',
	[3] = 'bkr_prop_weed_med_01a'
}

local webhookPlantar = "https://discord.com/api/webhooks/1156481606240972861/EMjv6bnvrGZTXyHmt6ku9aWHUL0IXxIxvbH96xuQrxk2GstVp_EGly0-oEtv2zYiI6IY"
local webhookColherMaconha = "https://discord.com/api/webhooks/1156481685890813993/xFWAvrk8OafyGyf5Xd4Z3IINUAMURgUwqAetbPuhszE2Y7Tkwmd40SAtpXcWC0ETbsr1"
local webhookClonar = "https://discord.com/api/webhooks/1156481763166666752/YUOAh5z99c2wXpzaXo8OD3thWCxWZ7gFXQ4GnLsL6bnAd0VreyHiCOL9bPE0iTEwuUgv"
local webhookDestruirPlanta = "https://discord.com/api/webhooks/1156481825280114769/k_8Pkgqj1p01qbWfMMqGlQDHm1P3PSXACGSE7i5yfeoyKcTsZslxWmOoSkgASjfh8az3"

local timeInSecondsToDestroy = 180 * 60 --Tempo Para destruir em segundos caso nao tenha sido coletada
--local timeInSecondsToDestroy = 20 --Tempo Para destruir em segundos caso nao tenha sido coletada
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Plants",function(Source, Passport, Coords,Route,Points)
	local Number = 0

	repeat
		Number = Number + 1
	until not Plants[Number]

	Plants[Number] = {
		["Coords"] = { mathLength(Coords["x"]),mathLength(Coords["y"]),mathLength(Coords["z"]) },
		["Time"] = os.time() + growthTime,
		["Points"] = Points,
		["Route"] = Route,
		['startingPoint'] = os.time(),
		["Phase"] = 1
	}

	local Planta = phases[Plants[Number]['Phase']]
	vRP.SendWebhook(webhookPlantar, "LOGs Plantação", "**Passaporte: **"..Passport.."\n**Plantou: **"..Planta.."\n**Coordenada: **"..Coords, 10357504)

	TriggerClientEvent("plants:New",-1,Number,Plants[Number],phases[Plants[Number]['Phase']])
	CreateDB(Plants[Number],Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:COLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Collect")
AddEventHandler("plants:Collect",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Ped = GetPlayerPed(source)
	local CoordsLog = GetEntityCoords(Ped)
	Number = tonumber(Number)
	if Passport and Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > (timeInSecondsToDestroy / 2) then
			RemoveDB(Number,'Apodreceu prestes à ser coletada')
			Plants[Number] = nil
			TriggerClientEvent("plants:Remover",-1,Number)
			TriggerClientEvent("dynamic:closeSystem",source)
			TriggerClientEvent("Notify",source,"vermelho","A plantação apodreceu.",5000)
			
			vRP.SendWebhook(webhookColherMaconha, "LOGs Colher", "**Passaporte: **"..Passport.."\n**Colheu uma planta estragada**".."\n**Coordenada: **"..CoordsLog, 10357504)
		else
			if os.time() >= Plants[Number]["Time"] then
				local Temporary = Plants[Number]

				if (vRP.InventoryWeight(Passport) + itemWeight("weedleaf")) <= vRP.GetWeight(Passport) then
					vRP.SendWebhook(webhookColherMaconha, "LOGs Colher", "**Passaporte: **"..Passport.."\n**Coordenada: **"..CoordsLog, 10357504)
					
					RemoveDB(Number,'Coletada')
					Plants[Number] = nil
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:closeSystem",source)
					TriggerClientEvent("Progress",source,"Coletando",10000)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					Wait(10000)

					vRP.GenerateItem(Passport,"weedleaf-"..Temporary["Points"],1,true)
					TriggerClientEvent("plants:Remover",-1,Number)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.removeObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:CLONING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Cloning")
AddEventHandler("plants:Cloning",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Ped = GetPlayerPed(source)
	local CoordsLog = GetEntityCoords(Ped)
	Number = tonumber(Number)
	if Passport and Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > (timeInSecondsToDestroy / 2) then
			RemoveDB(Number,'Apodreceu quando estava para ser clonada')
			Plants[Number] = nil
			TriggerClientEvent("plants:Remover",-1,Number)
			TriggerClientEvent("dynamic:closeSystem",source)
			TriggerClientEvent("Notify",source,"vermelho","A plantação apodreceu.",5000)

			vRP.SendWebhook(webhookClonar, "LOGs Clonar", "**Passaporte: **"..Passport.."\n**Clonou uma planta estragada**".."\n**Coordenada: **"..CoordsLog, 10357504)
		else
			if (Plants[Number]["Time"] - os.time()) <= 30 then
				local Temporary = Plants[Number]

				if (vRP.InventoryWeight(Passport) + itemWeight("weedclone") * 2) <= vRP.GetWeight(Passport) then
					RemoveDB(Number,'Clonada')
					Plants[Number] = nil
					Player(source)["state"]["Cancel"] = true
					Player(source)["state"]["Buttons"] = true
					TriggerClientEvent("dynamic:closeSystem",source)
					TriggerClientEvent("Progress",source,"Clonando",10000)
					vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)

					Wait(10000)

					local Points = parseInt(Temporary["Points"]) + 1
					if Points > 100 then
						Points = 100
					end

					vRP.GenerateItem(Passport,"weedclone-"..Points,2,true)
					
					vRP.SendWebhook(webhookClonar, "LOGs Clonar Planta", "**Passaporte: **"..Passport.."\n**Coordenada: **"..CoordsLog, 10357504)
					
					TriggerClientEvent("plants:Remover",-1,Number)
					Player(source)["state"]["Buttons"] = false
					Player(source)["state"]["Cancel"] = false
					vRPC.removeObjects(source)
				else
					TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("plants:Removing")
AddEventHandler("plants:Removing",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	local Ped = GetPlayerPed(source)
	local CoordsLog = GetEntityCoords(Ped)
	Number = tonumber(Number)

	if not Passport or not Plants[Number] then return end

	Player(source)["state"]["Cancel"] = true
	Player(source)["state"]["Buttons"] = true
	TriggerClientEvent("dynamic:closeSystem",source)
	TriggerClientEvent("Progress",source,"Destruindo",3000)
	vRPC.playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
	Wait(3000)
	
	vRP.SendWebhook(webhookDestruirPlanta, "LOGs Destruir Maconha", "**Passaporte: **"..Passport.."\n**Destruiu: **"..phases[Plants[Number]["Phase"]].."\n**Coordenada: **"..CoordsLog, 10357504)
	
	RemoveDB(Number,'Destruida por alguém')
	Plants[Number] = nil
	TriggerClientEvent("plants:Remover",-1,Number)
	Player(source)["state"]["Buttons"] = false
	Player(source)["state"]["Cancel"] = false
	vRPC.removeObjects(source)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Informations(Number)
	Number = tonumber(Number)
	if Plants[Number] then
		if (os.time() - Plants[Number]["Time"]) > 3600 then
			RemoveDB(Number,'Apodreceu quando player verificou')
			Plants[Number] = nil
			TriggerClientEvent("plants:Remover",-1,Number)		
			TriggerClientEvent("dynamic:closeSystem",source)
			TriggerClientEvent("Notify",source,"vermelho","A plantação apodreceu.",5000)
		else
			local Collect = "A coleta está disponível"
			if os.time() < Plants[Number]["Time"] then
				Collect = "Aguarde "..Calculate(Plants[Number]["Time"] - os.time())
			end

			local Cloning = "A clonagem está disponível"
			if os.time() < Plants[Number]["Time"]  then
				Cloning = "Aguarde "..Calculate(Plants[Number]["Time"] - os.time())
			end

			return { Collect,Cloning }
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.isPolice()
	local src = source
	local charId = vRP.Passport(src)
	return vRP.HasPermission(charId,'Police')
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET PLANTS FROM DB
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Plants = GetDB()
	-- print(json.encode(Plants))

	SetTimeout(2500,function()
		local cPlants = Plants
		for k,v in pairs(cPlants) do
			cPlants[k].Object = phases[cPlants[k]['Phase']]
			TriggerClientEvent("syncarea",-1,v["Coords"][1],v["Coords"][2],v["Coords"][3],1)
		end
		TriggerClientEvent("plants:Table",-1,cPlants)
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE PHASE AND DESTROY AFTER SOME TIME
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(Plants) do
			if os.time() >= v.startingPoint + growthTime / #phases and os.time() < v.Time then
				Plants[k].Phase = Plants[k].Phase + 1
				Plants[k].startingPoint = os.time()
				
				TriggerClientEvent("plants:Remover",-1,k)
				TriggerClientEvent("plants:New",-1,k,Plants[k],phases[Plants[k]['Phase']])
				UpdateDB(k)
			end
			if (os.time() - Plants[k]["Time"]) > timeInSecondsToDestroy then
				RemoveDB(k,'Apodreceu e sumiu')
				Plants[k] = nil
				TriggerClientEvent("plants:Remover",-1,k)
			end
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local cPlants = Plants
	for k,v in pairs(cPlants) do
		cPlants[k].Object = phases[cPlants[k]['Phase']]
	end
	TriggerClientEvent("plants:Table",source,Plants)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCULATE
-----------------------------------------------------------------------------------------------------------------------------------------
function Calculate(Seconds)
	local Days = math.floor(Seconds / 86400)
	Seconds = Seconds - Days * 86400
	local Hours = math.floor(Seconds / 3600)
	Seconds = Seconds - Hours * 3600
	local Minutes = math.floor(Seconds / 60)
	Seconds = Seconds - Minutes * 60

	if Days > 0 then
		return string.format("%d Dia, %d Hora, %d Minutos",Days,Hours,Minutes)
	elseif Hours > 0 then
		return string.format("%d Hora, %d Minutos e %d Segundos",Hours,Minutes,Seconds)
	elseif Minutes > 0 then
		return string.format("%d Minutos e %d Segundos",Minutes,Seconds)
	elseif Seconds > 0 then
		return string.format("%d Segundos",Seconds)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DB FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local sql = exports.oxmysql
UpdateDB = function(id)
	local nRow = Plants[id]
	sql:execute("UPDATE planting SET startingPoint ="..nRow.startingPoint..", Coords = '"..json.encode(nRow.Coords).."', Object = '"..phases[nRow.Phase].."', Phase = "..nRow.Phase.." WHERE id = "..id)
end
RemoveDB = function(id,motive)
	sql:execute('DELETE FROM planting WHERE id = '..id)
	vRP.Archive('RemovePlant.lua','Data/Horário: '..os.date('%x'..' %X'))
	vRP.Archive('RemovePlant.lua','infos: ['..id..'] = '..motive..'\n\n')
end
CreateDB = function(row,id)
	sql:execute("INSERT INTO planting (id,startingPoint,Coords,`Time`,Route,Object,Points,`Phase`) VALUES ("..id..", "..row.startingPoint..", '"..json.encode(row.Coords).."', "..row.Time..", "..row.Route..", '"..phases[row.Phase].."', "..row.Points..", "..row.Phase..");")
	vRP.Archive('CreatePlant.lua','Data/Horário: '..os.date('%x'..' %X'))
	vRP.Archive('CreatePlant.lua','infos: ['..id..'] = {'..json.encode(row)..'}\n\n')
end
GetDB = function()
	local allRows = sql:query_async('SELECT * FROM planting')
	local nPlants = {}
	for k,v in pairs(allRows) do
		nPlants[v.id] = {}
		nPlants[v.id].startingPoint = v.startingPoint
		nPlants[v.id].Coords = {}
		for i,j in pairs(json.decode(v.Coords)) do
			nPlants[v.id].Coords[i] = j
		end
		nPlants[v.id].Time = v.Time
		nPlants[v.id].Route = v.Route
		nPlants[v.id].Object = v.Object
		nPlants[v.id].Points = v.Points
		nPlants[v.id].Phase = v.Phase
	end
	return nPlants
end