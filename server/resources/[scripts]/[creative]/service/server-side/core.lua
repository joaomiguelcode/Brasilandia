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
Tunnel.bindInterface("service",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Panel = {}
local webhookservices = "https://discord.com/api/webhooks/1189582034755133461/KJl4qWR2SZuO_eLtFLagKTo_xANtCAFnqEZaSW1HrElcvXzRiRm2GeA4r2-meM21M3J1"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
local toggle = {}
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then

		local Split = splitString(Service,"-")
		local serviceIdentifier = Split[1]

		local services = {
			Police = Player(source).state.Police,
			Paramedic = Player(source).state.Paramedic,
			Mechanic = Player(source).state.Mechanic,
			Admin = Player(source).state.Admin,
		}

		if services[serviceIdentifier] ~= nil then
			if services[serviceIdentifier] then
				vRP.SendWebhook(webhookservices, "LOGs Servicos", "**Passaporte: **"..Passport.."\n**Entrou em serviço em: **"..serviceIdentifier, 43776)
			else
				vRP.SendWebhook(webhookservices, "LOGs Servicos", "**Passaporte: **"..Passport.."\n**Entrou em serviço em: **"..serviceIdentifier, 43776)
			end
		else
			if toggle[Passport] then
				toggle[Passport] = false
				vRP.SendWebhook(webhookservices, "LOGs Servicos", "**Passaporte: **"..Passport.."\n**Entrou em serviço em: **"..serviceIdentifier, 43776)
			else
				toggle[Passport] = true
				vRP.SendWebhook(webhookservices, "LOGs Servicos", "**Passaporte: **"..Passport.."\n**Entrou em serviço em: **"..serviceIdentifier, 43776)
			end
		end

		vRP.ServiceToggle(source,Passport,Service,false)
	end
end)

-- CreateThread(function()
-- 	local Passport = 1
-- 	local Source = vRP.Source(Passport)
-- 	vRP.ServiceToggle(Source, Passport, "Admin-1", false)
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAINEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("paineladm",function(source,Message)
	local Passport = vRP.Passport(source)
	if Message[1] == 'Premium' and vRP.HasPermission(Passport,"Admin",3) then
		Panel[Passport] = Message[1]
		TriggerClientEvent("service:Open",source,Message[1])
		return
	end
	if Passport and Message[1] and Message[1] ~= "Premium" and Message[1] ~= "Instagram" and Message[1] ~= "Spotify" then
		if vRP.HasGroup(Passport,Message[1]) or vRP.HasPermission(Passport,"Admin",2) then
			Panel[Passport] = Message[1]
			TriggerClientEvent("service:Open",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Request()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Panel[Passport] then
		local Identity = vRP.Identity(Passport)
		local Members = {}
		local Sources = vRP.Players()
		local Entitys = vRP.DataGroups(Panel[Passport])
		local Hierarchy = vRP.Hierarchy(Panel[Passport])

		for Number,v in pairs(Entitys) do
			local Number = parseInt(Number)
			local nIdentity = vRP.Identity(Number)
			if nIdentity then
				local me = false
				if Identity["id"] == nIdentity["id"] then
					me = true
				end

				Hierarchy = vRP.Hierarchy(Panel[Passport])
				local lastHierarchy = Hierarchy and #Hierarchy or 0
				local minHierarchy = false
				local maxHierarchy = false
				if v == lastHierarchy then
					minHierarchy = true
				end
				if v == 1 then
					maxHierarchy = true
				end

				Members[#Members + 1] = {
					["Me"] = me,
					["Name"] = nIdentity["name"].." "..nIdentity["name2"],
					["Phone"] = nIdentity["phone"],
					["Status"] = Sources[Number],
					["Passport"] = Number,
					["Hierarchy"] = Hierarchy[v] or Hierarchy,
					["minHierarchy"] = minHierarchy,
					["maxHierarchy"] = maxHierarchy
				}
			end
		end

		return Members
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Remove")
AddEventHandler("service:Remove",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport and Panel[Passport] and Number > 1 and Passport ~= Number then
		if vRP.HasPermission(Passport,Panel[Passport],1) or vRP.HasPermission(Passport,Panel[Passport],2) or vRP.HasPermission(Passport,Panel[Passport],3) or vRP.HasPermission(Passport,"Admin",2) then
			vRP.RemovePermission(Number,Panel[Passport])
			TriggerClientEvent("service:Update",source)
			TriggerClientEvent("Notify",source,"verde","Passaporte removido.",5000)
			vRP.SendLog('painel','[ID]: '..Passport..' \n[DEMITIU]: '..Number, true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Add")
AddEventHandler("service:Add",function(Number)
    local source = source
    local Number = parseInt(Number)
    local Passport = vRP.Passport(source)
    if Passport and Panel[Passport] and Number > 1 and Passport ~= Number and vRP.Identity(Number) then
        if vRP.HasPermission(Passport,Panel[Passport],1) or vRP.HasPermission(Passport,Panel[Passport],2) or vRP.HasPermission(Passport,Panel[Passport],3) or vRP.HasPermission(Passport,"Admin",2) then
			local Hierarchy = vRP.Hierarchy(Panel[Passport])
            vRP.SetPermission(Number,Panel[Passport],#Hierarchy)
			
            TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..Number.."</b> adicionado.",5000)
            TriggerClientEvent("service:Update",source)
			vRP.SendLog('painel','[ID]: '..Passport..' \n[CONTRATOU]: '..Number, true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Hierarchy")
AddEventHandler("service:Hierarchy",function(OtherPassport,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and Panel[Passport] and OtherPassport > 1 and Passport ~= OtherPassport and vRP.Identity(OtherPassport) then
		if vRP.HasPermission(Passport,Panel[Passport],1) or vRP.HasPermission(Passport,Panel[Passport],2) or vRP.HasPermission(Passport,Panel[Passport],3) or vRP.HasPermission(Passport,"Admin",2) then
			vRP.SetPermission(OtherPassport,Panel[Passport],nil,Mode)

			TriggerClientEvent("Notify",source,"verde","Hierarquia atualizada.",5000)
			TriggerClientEvent("service:Update",source)
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- DISCONNECT
-- -----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
    local Services = { "Police" , "Mechanic"}
    for _, Group in ipairs(Services) do
        if vRP.HasGroup(Passport, Group) then
            vRP.ServiceLeave(source, Passport, Group, true)
        end
    end
end)