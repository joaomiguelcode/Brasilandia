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
cRP = {}
Tunnel.bindInterface("police",cRP)
vCLIENT = Tunnel.getInterface("police")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPRARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("prison/cleanRecords","DELETE FROM prison WHERE nuser_id = @nuser_id")
vRP.Prepare("prison/getRecords","SELECT * FROM prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.Prepare("prison/getRecords2","SELECT * FROM prison WHERE id = @id ORDER BY id DESC")
vRP.Prepare("prison/insertPrison","INSERT INTO prison(police,nuser_id,services,fines,text,date,cops,association,residual,url) VALUES(@police,@nuser_id,@services,@fines,@text,@date,@cops,@association,@residual,@url)")

vRP.Prepare("prison/insertPort","INSERT INTO port(identity,user_id,portType,serial,nidentity,date,exam) VALUES(@identity,@user_id,@portType,@serial,@nidentity,@date,@exam)")
vRP.Prepare("prison/getPorts","SELECT * FROM port ORDER BY portId DESC")
vRP.Prepare("prison/getPorts2","SELECT * FROM port WHERE portId = @portId")
vRP.Prepare("prison/updatePort","UPDATE port SET identity = @identity,user_id = @user_id,portType = @portType,serial = @serial,nidentity = @nidentity,date = @date,exam = @exam WHERE portId = @portId")
vRP.Prepare("prison/deletePort","DELETE FROM port WHERE portId = @portId")

vRP.Prepare("prison/getReports","SELECT * FROM reports ORDER BY id DESC")
vRP.Prepare("prison/setReportSolved","UPDATE reports SET solved = 0, updated_at = @updated_at WHERE id = @id")
vRP.Prepare("prison/insertReport","INSERT INTO reports(victim_id, police_name, solved, victim_name, created_at, victim_report, updated_at) VALUES(@victim_id, @police_name, @solved, @victim_name, @created_at, @victim_report, @updated_at)")
vRP.Prepare("prison/deleteReport","DELETE FROM reports WHERE id = @id")

vRP.Prepare("prison/getWarrants","SELECT * FROM warrants ORDER BY id DESC")
vRP.Prepare("prison/getWarrants2","SELECT * FROM warrants WHERE id = @id")
vRP.Prepare("prison/deleteWarrant","DELETE FROM warrants WHERE id = @id")
vRP.Prepare("prison/insertWarrant","INSERT INTO warrants(user_id, identity, status, nidentity, timeStamp, reason) VALUES(@user_id, @identity, @status, @nidentity, @timeStamp, @reason)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATETABLE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare('prison/createPrison',[[CREATE TABLE IF NOT EXISTS `prison` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
  `police` varchar(255) DEFAULT '0',
  `nuser_id` int(11) NOT NULL DEFAULT 0,
  `services` int(11) NOT NULL DEFAULT 0,
  `fines` int(20) NOT NULL DEFAULT 0,
  `text` longtext DEFAULT NULL,
  `date` text DEFAULT NULL,
  `cops` varchar(50) DEFAULT NULL,
  `association` varchar(50) DEFAULT NULL,
  `residual` varchar(50) DEFAULT NULL,
  `url` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])

vRP.Prepare('prison/createPort',[[CREATE TABLE IF NOT EXISTS `port` (
		`portId` int(11) NOT NULL AUTO_INCREMENT,
		`identity` longtext,
		`user_id` text,
		`portType` longtext,
		`serial` longtext,
		`nidentity` longtext,
		`exam` longtext,
		`date` text,
		PRIMARY KEY (`portId`),
		KEY `portId` (`portId`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])

vRP.Prepare('prison/createReports',[[CREATE TABLE IF NOT EXISTS `reports` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`victim_id` text,
		`police_name` text,
		`solved` text,
		`victim_name` text,
		`created_at` text,
		`victim_report` text,
		`updated_at` text,
		PRIMARY KEY (`id`),
		KEY `portId` (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])

vRP.Prepare('prison/createWarrants',[[CREATE TABLE IF NOT EXISTS `warrants` (
		`id` int(11) NOT NULL AUTO_INCREMENT,
		`user_id` text,
		`identity` text,
		`status` text,
		`nidentity` text,
		`timeStamp` text,
		`reason` text,
		PRIMARY KEY (`id`),
		KEY `portId` (`id`)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;
]])

CreateThread(function()
	vRP.Query('prison/createPrison')
	vRP.Query('prison/createPort')
	vRP.Query('prison/createReports')
	vRP.Query('prison/createWarrants')
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local Preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 145, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 395, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 83, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 152, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 418, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 86, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local mHash = vRP.ModelPlayer(entity[1])
		if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
			TriggerClientEvent("updateRoupas",entity[1],Preset[mHash])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANREC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cleanrec",function(source,args,rawCommand)
	local Passport = vRP.Passport(source)
	if Passport and args[1] then
		if vRP.HasPermission(Passport,"Police", 1) then
			local nuser_id = parseInt(args[1])
			if nuser_id > 0 then
				vRP.Query("prison/cleanRecords",{ nuser_id = nuser_id })
				TriggerClientEvent("Notify",source,"verde","Limpeza efetuada.",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(nuser_id,services,fines,text,association,residual,url,cops)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if actived[Passport] == nil then
			actived[Passport] = true

			local Identity = vRP.Identity(Passport)
			if Identity then
				local otherPlayer = vRP.Source(nuser_id)
				if otherPlayer then
					vCLIENT.syncPrison(otherPlayer,true,false)
					TriggerClientEvent("hud:RadioClean",otherPlayer)
				end

				vRP.Query("prison/insertPrison",{ 
					police = Identity["name"].." "..Identity["name2"], 
					nuser_id = parseInt(nuser_id), 
					services = services,
					fines = fines, 
					text = text, 
					date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M"),
					cops = cops,
					association = association,
					residual = residual,
					url = url
				})

				vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
				TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
				TriggerClientEvent("police:Update",source,"reloadPrison")
				vRP.InitPrison(nuser_id,services)

				if fines > 0 then
					vRP.GiveFine(nuser_id,fines)
				end

				TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,13541152)
			end

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(nuser_id)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local nuser_id = parseInt(nuser_id)
		local Identity = vRP.Identity(nuser_id)
		if Identity then
			local fines = vRP.GetFine(nuser_id)
			local records = vRP.Query("prison/getRecords",{ nuser_id = parseInt(nuser_id) })
			local ports = vRP.Query("prison/getPorts")
			return { 
				true,
				Identity["name"].." "..Identity["name2"],
				Identity["phone"],
				fines,
				records,
				false,
				ports,
				0
			}
		end
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISIONID
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPrisionId(prisonId)
	local records = vRP.Query("prison/getRecords2",{ id = parseInt(prisonId) })

	if records[1] then
		return { 
			true,
			{},
			records[1]
		}
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(nuser_id,fines,text)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and fines > 0 then
		if actived[Passport] == nil then
			actived[Passport] = true

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(Passport).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			vRP.GiveFine(nuser_id,fines)

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.Source(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.UpdatePrison(Passport,math.random(2))

		local Identity = vRP.Identity(Passport)
		if parseInt(Identity["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,true)
		else
			vCLIENT.asyncServices(source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchPort()
	local ports = vRP.Query("prison/getPorts")
	if ports[1] then
		return {
			true,
			ports
		}
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.givePort(user_id,serial,status,exame)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if actived[Passport] == nil and vRP.HasPermission(Passport,"Police",1) then
			actived[Passport] = true

			local Identity = vRP.Identity(Passport)
			local Identit = vRP.Identity(user_id)
			if Identity and Identit then
				vRP.Query("prison/insertPort",{ 
					identity = Identit["name"].." "..Identit["name2"],
					user_id = user_id,
					portType = status,
					serial = serial,
					exam = exame,
					nidentity = Identity["name"].." "..Identity["name2"], 
					date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M")
				})
			end

			TriggerClientEvent("Notify",source,"verde","Porte adicionado.",5000)
			TriggerClientEvent("police:Update",source,"reloadPortes")

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPORTBYID
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getPortById(portId)
	local port = vRP.Query("prison/getPorts2",{ portId = parseInt(portId) })

	if port[1] then
		return { 
			true,
			port[1]
		}
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EDITPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.editPort(portId, user_id, serial, status, exame)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if actived[Passport] == nil and vRP.HasPermission(Passport,"Police",1) then
			actived[Passport] = true

			local Identity = vRP.Identity(Passport)
			local Identit = vRP.Identity(user_id)
			if Identity and Identit then
				vRP.Query("prison/updatePort",{ 
					portId = portId,
					identity = Identit["name"].." "..Identit["name2"],
					user_id = user_id,
					portType = status,
					serial = serial,
					exam = exame,
					nidentity = Identity["name"].." "..Identity["name2"], 
					date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M")
				})
			end

			TriggerClientEvent("Notify",source,"verde","Porte atualiado.",5000)
			TriggerClientEvent("police:Update",source,"reloadPortes")

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deletePort(portId)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if actived[Passport] == nil and vRP.HasPermission(Passport,"Police",1) then
			actived[Passport] = true

			vRP.Query("prison/deletePort",{ portId = portId })

			TriggerClientEvent("Notify",source,"verde","Porte deletado.",5000)
			TriggerClientEvent("police:Update",source,"reloadPortes")

			actived[Passport] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWARRANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getWarrants()
	local warrant = vRP.Query("prison/getWarrants")
	if warrant[1] then
		return {
			true,
			warrant
		}
	end

	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWARRANTID
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWarrantId(id)
	local warrant = vRP.Query("prison/getWarrants2", { id = id })
	if warrant[1] then
		return { 
			true,
			warrant[1]["identity"],
			warrant[1]
		}
	end
	return { false }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEWARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteWarrant(id)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasPermission(Passport, "Police", 1) then
		vRP.Query("prison/deleteWarrant", { id = id })
		
		TriggerClientEvent("police:Update",source,"reloadProcurados")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWARRANT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setWarrant(user_id,reason)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasPermission(Passport, "Police", 1) then
		local Identity = vRP.Identity(Passport)
		local Identit = vRP.Identity(user_id)
		if Identity and Identit then
			vRP.Query("prison/insertWarrant", {
				user_id = user_id,
				identity = Identit.name.." "..Identit.name2, 
				status = "Procurado",
				nidentity = Identity.name.." "..Identity.name2, 
				timeStamp = os.date("%d/%m/%Y").." ás "..os.date("%H:%M"),
				reason = reason
			})
			
			TriggerClientEvent("police:Update",source,"reloadProcurados")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETREPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getReports()
	local report = vRP.Query("prison/getReports")
	return report
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDREPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.addReport(data)
	if data.victim_id and data.victim_report and data.victim_name then
		local source = source
		local Passport = vRP.Passport(source)
		if Passport then
			if actived[Passport] == nil then
				actived[Passport] = true

				local Identity = vRP.Identity(Passport)
				if Identity then
					vRP.Query("prison/insertReport", {
						victim_id = data.victim_id, 
						police_name = Identity.name.." "..Identity.name2, 
						solved = nil,
						victim_name = data.victim_name, 
						created_at = os.date("%d/%m/%Y").." ás "..os.date("%H:%M"), 
						victim_report = data.victim_report, 
						updated_at = os.date("%d/%m/%Y").." ás "..os.date("%H:%M")
					})
				end
				actived[Passport] = nil
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETREPORTSOLVED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setReportSolved(id)
	local update = os.date("%d/%m/%Y").." ás "..os.date("%H:%M")
	vRP.Query("prison/setReportSolved", { id = id, updated_at = update })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETREPORTREMOVED
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setReportRemoved(id)
	vRP.Query("prison/deleteReport", { id = id })
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
---------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	local Identity = vRP.Identity(Passport)
	if parseInt(Identity["prison"]) > 0 then
		TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(Identity["prison"]).." serviços</b>.",5000)
		vCLIENT.syncPrison(source,true,true)
	end
end)