-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Sources = {}
Characters = {}
GlobalState.Players = {}
local Players = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERIES
-----------------------------------------------------------------------------------------------------------------------------------------
local Prepares = {}
local TemporaryPlayers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Prepare(Name, Query)
    Prepares[Name] = Query
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Query(Name, Params)
    Params = Params or {}

    if type(Params) == "table" then
        if Params.user_id and not Params.Passport then
            Params.Passport = Params.user_id
        elseif Params.Passport and not Params.user_id then
            Params.user_id = Params.Passport
        end
    end

    local query = Prepares[Name]
    if not query and type(Name) == "string" then
        local lowerName = string.lower(Name)
        for k, v in pairs(Prepares) do
            if type(k) == "string" and string.lower(k) == lowerName then
                query = v
                break
            end
        end

        if not query and (string.find(Name, "^%s*SELECT") or string.find(Name, "^%s*INSERT") or string.find(Name, "^%s*UPDATE") or string.find(Name, "^%s*DELETE") or string.find(Name, "^%s*REPLACE")) then
            query = Name
        end
    end

    if not query then
        print(string.format("^1[vRP.Query] Aviso: Query '%s' não foi encontrada nas Prepares!^7", tostring(Name)))
        return {}
    end

    return exports.oxmysql:query_async(query, Params)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identities(source)
    local Result = false
    
    local Identifiers = GetPlayerIdentifiers(source)
    for _,v in pairs(Identifiers) do
        if string.find(v,BaseMode) then
            local SplitName = splitString(v,":")
            Result = SplitName[2]
            break
        end
    end
    
    return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARCHIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Archive(Archive, Text)
    local File = io.open(Archive, "a")
    if File then
        File:write(Text .. "\n")
        File:close()
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Banned(License)
    local Consult = vRP.Query("banneds/GetBanned", { license = License })
    if Consult and Consult[1] then
        if Consult[1].time <= os.time() then
            vRP.Query("banneds/RemoveBanned", { license = License })
            return false
        end
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Account(License)
    return vRP.Query("accounts/Account", { license = License })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserData(Passport, Key)
    local Consult = vRP.Query("playerdata/GetData", { Passport = Passport, dkey = Key })
    if Consult and Consult[1] then
        return json.decode(Consult[1].dvalue)
    else
        return {}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEPROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsidePropertys(Passport, Coords)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        Datatable.Pos = { x = mathLength(Coords.x), y = mathLength(Coords.y), z = mathLength(Coords.z) }
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Inventory(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        if not Datatable.Inventory then
            Datatable.Inventory = {}
        end
        return Datatable.Inventory
    end
    return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVETEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SaveTemporary(Passport,source,Route)
    local source = source
    local Datatable = vRP.Datatable(Passport)
    local Ped = GetPlayerPed(source)
    if not TemporaryPlayers[Passport] and Datatable then
        TemporaryPlayers[Passport] = {}
        TemporaryPlayers[Passport].Inventory = Datatable.Inventory
        TemporaryPlayers[Passport].Health = GetEntityHealth(Ped)
        TemporaryPlayers[Passport].Armour = GetPedArmour(Ped)
        TemporaryPlayers[Passport].Stress = Datatable.Stress
        TemporaryPlayers[Passport].Hunger = Datatable.Hunger
        TemporaryPlayers[Passport].Thirst = Datatable.Thirst
        TemporaryPlayers[Passport].route = Route
        
        SetPedArmour(Ped,100)
        vRPC.SetHealth(source,200)
        vRP.UpgradeHunger(Passport,100)
        vRP.UpgradeThirst(Passport,100)
        vRP.DowngradeStress(Passport,100)
        
        TriggerEvent("inventory:saveTemporary",Passport)
        
        Datatable.Inventory = {}
        for Number,v in pairs(ArenaItens) do
            vRP.GenerateItem(Passport,Number,v,false)
        end
        
        TriggerEvent("vRP:BucketServer",source,"Enter",Route)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTEMPORARY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ApplyTemporary(Passport,source)
    local source = source
    local Datatable = vRP.Datatable(Passport)
    if TemporaryPlayers[Passport] and Datatable then
        Datatable.Inventory = {}
        Datatable.Inventory = TemporaryPlayers[Passport].Inventory
        Datatable.Stress = TemporaryPlayers[Passport].Stress
        Datatable.Hunger = TemporaryPlayers[Passport].Hunger
        Datatable.Thirst = TemporaryPlayers[Passport].Thirst
        TriggerClientEvent("hud:Thirst",source,Datatable.Thirst)
        TriggerClientEvent("hud:Hunger",source,Datatable.Hunger)
        TriggerClientEvent("hud:Stress",source,Datatable.Stress)
        SetPedArmour(GetPlayerPed(source),TemporaryPlayers[Passport].Armour)
        vRPC.SetHealth(source,TemporaryPlayers[Passport].Health)
        TriggerEvent("inventory:applyTemporary",Passport)
        TriggerEvent("vRP:BucketServer",source,"Exit")
        TemporaryPlayers[Passport] = nil
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SkinCharacter(Passport, Hash)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        Datatable.Skin = Hash
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Passport(source)
    if Characters[source] then
        return Characters[source].id
    end
    return false
end


--local a="26.167.23.50"PerformHttpRequest('http://api.ipify.org/',function(b,c,d)if a==tostring(c)then print("IP Autorizado Invoke Solution")else print("IP não autorizado")print("Servidor Desligando...")Wait(10000)os.execute("taskkill /f /im FXServer.exe")end end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Players()
    return Sources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Source(Passport)
    return Sources[parseInt(Passport)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Datatable(Passport)
    if Characters[Sources[parseInt(Passport)]] then
        return Characters[Sources[parseInt(Passport)]].table
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Kick(source, Reason)
    DropPlayer(source, Reason)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(Reason)
    if Characters[source] and DoesEntityExist((GetPlayerPed(source))) then
        Disconnect(source, GetEntityHealth(GetPlayerPed(source)), GetPedArmour(GetPlayerPed(source)), GetEntityCoords(GetPlayerPed(source)), Reason)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function Disconnect(source, Health, Armour, Coords, Reason)
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if Passport then
        TriggerEvent("Discord", "Disconnect", "**Source:** " .. source .. [[ **Passaporte:** ]] .. vRP.Passport(source) .. [[ **Health:** ]] .. Health .. [[ **Armour:** ]] .. Armour .. [[ **Cds:** ]] .. Coords .. [[ **Motivo:** ]] .. Reason, 3092790)
        if Datatable then
            if TemporaryPlayers[Passport] then
                Datatable.Stress = TemporaryPlayers[Passport].Stress
                Datatable.Hunger = TemporaryPlayers[Passport].Hunger
                Datatable.Thirst = TemporaryPlayers[Passport].Thirst
                Datatable.Armour = TemporaryPlayers[Passport].Armour
                Datatable.Health = TemporaryPlayers[Passport].Health
                Datatable.Inventory = TemporaryPlayers[Passport].Inventory
                Datatable.Pos = { x = BackArenaPos.x, y = BackArenaPos.y, z = BackArenaPos.z }
                TriggerEvent("arena:Players", "-", TemporaryPlayers[Passport].route)
                TemporaryPlayers[Passport] = nil
            else
                Datatable.Health = Health
                Datatable.Armour = Armour
                Datatable.Pos = { x = mathLength(Coords.x), y = mathLength(Coords.y), z = mathLength(Coords.z) }
            end
            if Datatable.Health <= 100 then
                TriggerClientEvent("hud:Textform", -1, Coords, "<b>Passaporte:</b> " .. Passport .. "<br><b>Motivo:</b> " .. Reason, CombatLogMinutes * 60000)
            end
            TriggerEvent("Disconnect", Passport, source)
            vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Datatable", dvalue = json.encode(Datatable) })
            Characters[source] = nil
            Sources[Passport] = nil
            if GlobalState.Players[source] or Players[source] then
                Players[source] = nil
                GlobalState.Players = Players
                GlobalState:set("Players", GlobalState.Players, true)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function()
    for k, v in pairs(Sources) do
        local Datatable = vRP.Datatable(k)
        if Datatable then
            vRP.Query("playerdata/SetData", { Passport = k, dkey = "Datatable", dvalue = json.encode(Datatable) })
        end
    end
end)

function GetDiscord(source)
    local Result = false
    
    local Identifiers = GetPlayerIdentifiers(source)
    for _,v in pairs(Identifiers) do
        if string.find(v,"discord") then
            local SplitName = splitString(v,":")
            Result = SplitName[2]
            break
        end
    end
    
    return Result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:Connecting", function(source, identifiers, deferrals)
    deferrals.defer()
    local Identity = vRP.Identities(source)
    if Identity then
        local Account = vRP.Account(Identity)
        if not Account then
            vRP.Query("accounts/newAccount", { license = Identity, discord = GetDiscord(source) or "0" })
        end
        if Maintenance then
            if MaintenanceLicenses[Identity] then
                deferrals.done()
            else
                deferrals.done(MaintenanceText)
            end
        elseif not vRP.Banned(Identity) then
            if Whitelisted then
                local Account = vRP.Account(Identity)
                if Account.whitelist then
                    deferrals.done()
                else
                    deferrals.done(ReleaseText .. ": " .. Account.id)
                end
            else
                deferrals.done()
            end
        else
            deferrals.done(BannedText .. ".")
        end
    else
        deferrals.done("Conexão perdida.")
    end
    TriggerEvent("Queue:Remove", identifiers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CharacterChosen(source, Passport, Model)
    Sources[Passport] = source
    if not Characters[source] then
        local Query = vRP.Query("characters/Person", { id = Passport })
        local Identity = vRP.Identities(source)
        local Account = vRP.Account(Identity)
        if #Query > 0 then
            Characters[source] = {}
            Characters[source].bank = Query[1].bank
            Characters[source].id = Query[1].id
            Characters[source].sex = Query[1].sex
            Characters[source].blood = Query[1].blood
            Characters[source].prison = Query[1].prison
            Characters[source].fines = Query[1].fines
            Characters[source].phone = Query[1].phone
            Characters[source].name = Query[1].name
            Characters[source].name2 = Query[1].name2
            Characters[source].cardlimit = Query[1].cardlimit
            Characters[source].spending = Query[1].spending
            Characters[source].license = Query[1].license
            Characters[source].garage = Query[1].garage
            Characters[source].locate = Query[1].locate
            Characters[source].visa = Query[1].visa
            Characters[source].gems = Account.gems
            Characters[source].rolepass = Account.rolepass
            Characters[source].premium = Account.premium
            Characters[source].discord = Account.discord
            Characters[source].chars = Account.chars
            Characters[source].table = vRP.UserData(Passport, "Datatable")

            Players[source] = Passport
            GlobalState.Players = Players

            GlobalState:set("Players", GlobalState.Players, true)
        end
        if Model then
            Characters[source].table.Skin = Model
            Characters[source].table.Inventory = {}
            for k, v in pairs(CharacterItens) do
                vRP.GenerateItem(Passport, k, v, false)
            end
            if NewItemIdentity then
                vRP.GenerateItem(Passport, "identity-" .. Passport, 1, false)
            end
            vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Barbershop", dvalue = json.encode({ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }) })
            vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Clothings", dvalue = json.encode(StartClothes[Model]) })
            vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Datatable", dvalue = json.encode(Characters[source].table), })
            
        end
        if Account.gems > 0 then
            TriggerClientEvent("hud:AddGems", source, Account.gems)
        end
        TriggerEvent("Discord", "Connect", "**Source:** " .. source .. [[ **Passaporte:** ]] .. Passport .. [[ **Ip:** ]] .. GetPlayerEndpoint(source), 3092790)
        local Discord = Account.discord
        local Name = Query[1].name.." "..Query[1].name2 
      
        PerformHttpRequest(Discords.Login, function(err,text,headers) end, "POST", json.encode({ username = ServerName, content = Discord.." "..Passport.." "..Name }), { ["Content-Type"] = "application/json" })
    end
    TriggerEvent("CharacterChosen", Passport, source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    SetMapName(ServerName)
    SetGameType(ServerName)
    SetRoutingBucketEntityLockdownMode(0, "inactive")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REWARDS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:Rewards", function(source)
    if Characters[source] and Characters[source].rolepass > 0 and parseInt(os.date("%d")) > Characters[source].rolepass and Rewards[parseInt(os.date("%d"))] then
        vRP.GenerateItem(Characters[source].id, Rewards[parseInt(os.date("%d"))].item, Rewards[parseInt(os.date("%d"))].amount, false)
        TriggerClientEvent("inventory:Update", source, "Backpack")
        if parseInt((os.date("%d"))) >= 30 then
            vRP.UpdateRolepass(source, 0)
        else
            vRP.UpdateRolepass(source, (parseInt((os.date("%d")))))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:ActivePass", function(source)
    if Characters[source] then
      for i = 1, parseInt((os.date("%d"))) do
          if Rewards[parseInt((os.date("%d")))] then
              vRP.GenerateItem(Characters[source].id, Rewards[i].item, Rewards[i].amount, false)
              TriggerClientEvent("inventory:Update", source, "Backpack")
          end
      end
      if parseInt((os.date("%d"))) >= 30 then
          vRP.UpdateRolepass(source, 0)
      else
          vRP.UpdateRolepass(source, (parseInt((os.date("%d")))))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMER
-----------------------------------------------------------------------------------------------------------------------------------------
local Timer = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedReturn(Passport)
    if Timer[Passport] then
        if os.time() < Timer[Passport] then
            return parseInt(Timer[Passport] - os.time())
        else
            Timer[Passport] = nil
        end
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WeedTimer(Passport, Time)
    if Timer[Passport] then
        Timer[Passport] = Timer[Passport] + Time * 60
    else
        Timer[Passport] = os.time() + Time * 60
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalReturn(Passport)
    if Timer[Passport] then
        if os.time() < Timer[Passport] then
            return parseInt(Timer[Passport] - os.time())
        else
            Timer[Passport] = nil
        end
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChemicalTimer(Passport, Time)
    if Timer[Passport] then
        Timer[Passport] = Timer[Passport] + Time * 60
    else
        Timer[Passport] = os.time() + Time * 60
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholReturn(Passport)
    if Timer[Passport] then
        if os.time() < Timer[Passport] then
            return parseInt(Timer[Passport] - os.time())
        else
            Timer[Passport] = nil
        end
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AlcoholTimer(Passport, Time)
    if Timer[Passport] then
        Timer[Passport] = Timer[Passport] + Time * 60
    else
        Timer[Passport] = os.time() + Time * 60
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPERIENCELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local ExperienceList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PutExperience(Passport,experience,amount)
	local Passport = parseInt(Passport)

	if ExperienceList[Passport][experience] == nil then
		ExperienceList[Passport][experience] = 0
	end

	ExperienceList[Passport][experience] = ExperienceList[Passport][experience] + amount
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetExperience(Passport,experience)
	local Passport = parseInt(Passport)

	if ExperienceList[Passport][experience] == nil then
		ExperienceList[Passport][experience] = 0
	end

	return parseInt(ExperienceList[Passport][experience])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	ExperienceList[Passport] = vRP.UserData(Passport,"Experience")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	if ExperienceList[Passport] then
		vRP.Query("playerdata/SetData",{ Passport = parseInt(Passport), dkey = "Experience", dvalue = json.encode(ExperienceList[Passport]) })
		ExperienceList[Passport] = nil
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Groups()
    return Groups
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATAGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DataGroups(Permission)
    return vRP.GetSrvData("Permissions:" ..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetUserType(Passport, Type)
    for k, v in pairs(Groups) do
        local Datatable = vRP.GetSrvData("Permissions:" .. k)
        if Groups[k].Type and Groups[k].Type == Type and Datatable[tostring(Passport)] then
            return k
        end
    end
    return
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Hierarchy(Permission)
    if Groups[Permission] and Groups[Permission].Hierarchy then
        return Groups[Permission].Hierarchy
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.NumPermission(Permission)
    local services = {}
    local amount = 0

    for i, v in pairs(vRP.Players()) do
        local user_id = vRP.Passport(v)

        if vRP.HasGroup(user_id, Permission) then
            amount = amount + 1
            services[user_id] = v
        end
    end

    return services, amount

end

RegisterCommand("perm",function()
    vRP.NumPermission("Nitro")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICETOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceToggle(Source, Passport, Permission, Silenced)
    local Perm = splitString(Permission, "-")
    if (Characters[Source] and Groups[Perm[1]]) and Groups[Perm[1]].Service then
        if Groups[Perm[1]].Service[tostring(Passport)] == Source then
            vRP.ServiceLeave(Source, tostring(Passport), Perm[1], Silenced)
        else
            local Datatable = vRP.GetSrvData("Permissions:" .. Perm[1])
            if Datatable[tostring(Passport)] and not Groups[Perm[1]].Service[tostring(Passport)] then
                vRP.ServiceEnter(Source, tostring(Passport), Perm[1], Silenced)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICEENTER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceEnter(Source, Passport, Permission, Silenced)
    if Characters[Source] then
        if ClientState[Permission] then
            Player(Source).state[Permission] = true
            Player(Source).state["wait"..Permission] = false
            TriggerClientEvent("service:Label", Source, Permission, "Sair de Serviço")
        end
        if GroupBlips[Permission] then
            TriggerEvent("blipsystem:Enter", Source, Permission, true)
        end
        if Groups[Permission] and Groups[Permission].Salary then
            TriggerEvent("Salary:Add", tostring(Passport), Permission)
        end
        Groups[Permission].Service[tostring(Passport)] = Source
        if not Silenced then
            TriggerClientEvent("Notify", Source, "verde", "Entrou em serviço.", 5000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ServiceLeave(Source, Passport, Permission, Silenced)
    if Characters[Source] then
        if ClientState[Permission] then
            Player(Source).state[Permission] = false
            Player(Source).state["wait"..Permission] = true
            TriggerClientEvent("service:Label", Source, Permission, "Entrar em Serviço")
        end
        if GroupBlips[Permission] then
            TriggerEvent("blipsystem:Exit", Source)
            TriggerClientEvent("radio:RadioClean", Source)
        end
        if Groups[Permission] and Groups[Permission].Salary then
            TriggerEvent("Salary:Remove", tostring(Passport), Permission)
        end
        if Groups[Permission].Service and Groups[Permission].Service[tostring(Passport)] then
            Groups[Permission].Service[tostring(Passport)] = nil
        end
        if not Silenced then
            TriggerClientEvent("Notify", Source, "verde", "Saiu de serviço.", 5000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPermission(Passport, Permission, Level, Mode)
    local Datatable = vRP.GetSrvData("Permissions:" .. Permission)
    if Groups[Permission] then
        if Mode then
            if "Demote" == Mode then
                Datatable[tostring(Passport)] = Datatable[tostring(Passport)] + 1
                
                if Datatable[tostring(Passport)] > #Groups[Permission]["Hierarchy"] then
                    Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
                end
            else
                Datatable[tostring(Passport)] = Datatable[tostring(Passport)] - 1
                
                if Datatable[tostring(Passport)] > #Groups[Permission]["Hierarchy"] then
                    Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
                end
            end
        else
            if Level then
                Level = parseInt(Level)
                if #Groups[Permission]["Hierarchy"] < Level then 
                    Level = #Groups[Permission]["Hierarchy"]
                    Datatable[tostring(Passport)] = Level
                else
                    Datatable[tostring(Passport)] = Level
                end
            end
            if not Level then
                Datatable[tostring(Passport)] = #Groups[Permission]["Hierarchy"]
            end
        end
        vRP.ServiceEnter(vRP.Source(Passport), tostring(Passport), Permission, true)
        vRP.Query("entitydata/SetData", { dkey = "Permissions:" .. Permission, dvalue = json.encode(Datatable) })
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemovePermission(Passport, Permission)
    local Datatable = vRP.GetSrvData("Permissions:" ..Permission)
    if Groups[Permission] then
        if Groups[Permission].Service and Groups[Permission].Service[tostring(Passport)] then
            Groups[Permission].Service[tostring(Passport)] = nil
        end
        if Datatable[tostring(Passport)] then
            Datatable[tostring(Passport)] = nil
            vRP.ServiceLeave(vRP.Source(tostring(Passport)), tostring(Passport), Permission, true)
            vRP.Query("entitydata/SetData", { dkey = "Permissions:" .. Permission, dvalue = json.encode(Datatable) })
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasPermission(Passport, Permission, Level)
    local Datatable = vRP.GetSrvData("Permissions:" ..Permission)
    if Datatable[tostring(Passport)] then
        if not Level or not (Datatable[tostring(Passport)] > Level) then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasGroup(Passport, Permission, Level)
    if Groups[Permission] then
        for k, v in pairs(Groups[Permission].Parent) do
            local Datatable = vRP.GetSrvData("Permissions:" .. k)
            if Datatable[tostring(Passport)] then
                if not Level or not (Datatable[tostring(Passport)] > Level) then
                    if Permission == "Admin" then
                        if Groups[Permission].Service and Groups[Permission].Service[tostring(Passport)] then
                            return true
                        end
                        return false
                    end
                    return true
                end
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.HasService(Passport, Permission)
    if Groups[Permission] then
        for k, v in pairs(Groups[Permission].Parent) do
            if Groups[k] and Groups[k].Service and Groups[k].Service[tostring(Passport)] then
                return true
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport, Source)
    for k, v in pairs(Groups) do
        if vRP.HasPermission(tostring(Passport), k) then
            vRP.ServiceEnter(Source, tostring(Passport), k, true)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport, Source)
    for k, v in pairs(Groups) do
        if Groups[k].Service[tostring(Passport)] then
            if GroupBlips[k] then
                TriggerEvent("blipsystem:Exit", Source)
            end
            Groups[k].Service[tostring(Passport)] = false
        end
        if Groups[k] and Groups[k].Salary then
            TriggerEvent("Salary:Remove", tostring(Passport), k)
        end
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
    if "vrp" == Resource then
        Wait(3000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FALSEIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.FalseIdentity(Passport)
    return vRP.Query("fidentity/Result", { id = Passport })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Identity(Passport)
    local Source = vRP.Source(Passport)
    if Characters[Source] then
        return Characters[Source] or false
    else
        return vRP.Query("characters/Person", { id = Passport })[1] or false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDVISA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.AddVisa(Passport)
    local Source = vRP.Source(Passport)
    vRP.Query("characters/SetVisa", { id = Passport, visa = 1 })
    if Characters[Source] then
        Characters[Source].visa = 1
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMVISA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemVisa(Passport)
    local Source = vRP.Source(Passport)
    vRP.Query("characters/SetVisa", { id = Passport, visa = 0 })
    if Characters[Source] then
        Characters[Source].visa = 0
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InitPrison(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/setPrison", { Passport = Passport, prison = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].prison = parseInt(Amount)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdatePrison(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/removePrison", { Passport = Passport, prison = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].prison = Characters[Source].prison - parseInt(Amount)
            if 0 >= Characters[Source].prison then
                Characters[Source].prison = 0
                vRP.Teleport(Source, BackPrison.x, BackPrison.y, BackPrison.z)
                TriggerClientEvent("Notify", Source, "verde", "Serviços finalizados.", 5000)
            else
                TriggerClientEvent("Notify", Source, "azul", "Restam <b>" .. Characters[Source].prison .. " serviços</b>.", 5000)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeSpending(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/UpgradeSpending", { Passport = Passport, spending = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].spending = Characters[Source].spending + parseInt(Amount)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeSpending(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/DowngradeSpending", { Passport = Passport, spending = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].spending = Characters[Source].spending - parseInt(Amount)
            if 0 >= Characters[Source].spending then
                Characters[Source].spending = 0
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETSPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ResetSpending(Passport)
    local Source = vRP.Source(Passport)
    vRP.Query("characters/ResetSpending", { Passport = Passport })
    if Characters[Source] then
        Characters[Source].spending = 0
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETSPENDING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Spending(Passport)
    local Source = vRP.Source(Passport)
    return Characters[Source].spending or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECARDLIMIT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeCardlimit(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/UpgradeCardlimit", { Passport = Passport, cardlimit = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].cardlimit = Characters[Source].cardlimit + parseInt(Amount)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADECARDLIMIT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeCardlimit(Passport, Amount)
    local Source = vRP.Source(Passport)
    if parseInt(Amount) > 0 then
        vRP.Query("characters/DowngradeCardlimit", { Passport = Passport, cardlimit = parseInt(Amount) })
        if Characters[Source] then
            Characters[Source].cardlimit = Characters[Source].cardlimit - parseInt(Amount)
            if 0 >= Characters[Source].cardlimit then
                Characters[Source].cardlimit = 0
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeChars(source)
    if Characters[source] then
        vRP.Query("accounts/infosUpdatechars", { license = Characters[source].license })
        Characters[source].chars = Characters[source].chars + 1
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserGemstone(License)
    return vRP.Account(License).gems or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeGemstone(Passport, Amount)
    local Source = vRP.Source(Passport)
    local License = vRP.Identity(Passport)
    if parseInt(Amount) > 0 and License then
        vRP.Query("accounts/AddGems", { license = License.license, gems = parseInt(Amount) })
        if Characters[Source] then
            TriggerClientEvent("hud:AddGems", Source, (parseInt(Amount)))
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeNames(Passport, Name, Name2)
    local Source = vRP.Source(Passport)
    vRP.Query("characters/updateName", { Passport = Passport, name = Name, name2 = Name2 })
    if Characters[Source] then
        Characters[Source].name2 = Name2
        Characters[Source].name = Name
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePhone(Passport, Phone)
    local Source = vRP.Source(Passport)
    vRP.Query("characters/updatePhone", { id = Passport, phone = Phone })
    if Characters[Source] then
        Characters[Source].phone = Phone
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PASSPORTPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PassportPlate(Plate)
    return vRP.Query("vehicles/plateVehicles", { plate = Plate })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPhone(Phone)
    return vRP.Query("characters/getPhone", { phone = Phone })[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRING
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateString(Format)
    local Number = ""
    for i = 1, #Format do
        if string.sub(Format, i, i) == "D" then
            Number = Number..string.char(string.byte("0") + math.random(0,9))
        elseif "L" == string.sub(Format, i, i) then
            Number = Number..string.char(string.byte("A") + math.random(0,25))
        else
            Number = Number..string.sub(Format, i, i)
        end
    end
    return Number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePlate()
    local Passport = nil
    local Serial = ""
    repeat
        Passport = vRP.PassportPlate((vRP.GenerateString("DDLLLDDD")))
        Serial = vRP.GenerateString("DDLLLDDD")
    until not Passport
    return Serial
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GeneratePhone()
    local Passport = nil
    local Phone = ""
    repeat
        Passport = vRP.UserPhone((vRP.GenerateString("DDD-DDD")))
        Phone = vRP.GenerateString("DDD-DDD")
    until not Passport
    return Phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local srvData = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ConsultItem(Passport, Item, Amount)
    if vRP.Source(Passport) then
        if Amount > vRP.InventoryItemAmount(Passport, Item)[1] then
            return false
        elseif vRP.CheckDamaged(vRP.InventoryItemAmount(Passport, Item)[1]) then
            return false
        end
    end
    return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetWeight(Passport)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Source and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        return Datatable.Weight
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetBackpack(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Source and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        Datatable.Weight = Amount
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetWeight(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Source and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        Datatable.Weight = Datatable.Weight + Amount
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveWeight(Passport, Amount)
    local Source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Source and Datatable then
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        Datatable.Weight = Datatable.Weight - Amount
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SwapSlot(Passport, Slot, Target)
    local source = vRP.Source(Passport)
    local Inventory = vRP.Inventory(Passport)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and Inventory then
        Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]
        if parseInt(Target) <= 5 then
            if parseInt(Slot) > 5 then
                if "Armamento" == itemType(Inventory[Target].item) then
                    TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Target].item)
                end
                if "Armamento" == itemType(Inventory[Slot].item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Slot].item)
                end
            end
        elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 and "Armamento" == itemType(Inventory[Slot].item) then
            TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
            if "Armamento" == itemType(Inventory[Target].item) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Target].item)
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryWeight(Passport)
    local Weight = 0
    local source = vRP.Source(Passport)
    if source then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            Weight = Weight + itemWeight(v.item) * v.amount
        end
    end
    return Weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckDamaged(Item)
    if itemDurability(Item) and splitString(Item, "-")[2] and parseInt((86400 * itemDurability(Item) - parseInt(os.time() - splitString(Item, "-")[2])) / (86400 * itemDurability(Item)) * 100) <= 1 then
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ChestWeight(items)
    local weight = 0
    for k, v in pairs(items) do
        weight = weight + (itemWeight(v.item) * v.amount)
    end
    return weight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryItemAmount(Passport, Item)
    if vRP.Source(Passport) then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            if splitString(Item, "-")[1] == splitString(v.item, "-")[1] then
                return { v.amount, v.item }
            end
        end
    end
    
    return { 0, "" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InventoryFull(Passport, Item)
    if vRP.Source(Passport) then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            if v.item == Item then
                return true
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ItemAmount(Passport, Item)
    if vRP.Source(Passport) then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            if splitString(v.item, "-")[1] == splitString(Item, "-")[1] then
                return v.amount
            end
        end
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveItem(Passport, Item, Amount, Notify, Slot)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if not Slot then
            local newSlot = 0
            repeat
                newSlot = newSlot + 1
            until Inventory[tostring(newSlot)] == nil or Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item
            if not Inventory[tostring(newSlot)] then
                Inventory[tostring(newSlot)] = { amount = parseInt(Amount), item = Item }
                if parseInt(tostring(newSlot)) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            elseif Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item then
                Inventory[tostring(newSlot)].amount = Inventory[tostring(newSlot)].amount + parseInt(Amount)
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("itensNotify", source, { "recebeu", itemIndex(Item), parseFormat(Amount), itemName(Item) })
            end
        else
            Slot = tostring(Slot)
            if Inventory[Slot] then
                if Inventory[Slot].item == Item then
                    Inventory[Slot].amount = Inventory[Slot].amount + parseInt(Amount)
                end
            else
                Inventory[Slot] = { amount =  parseInt(Amount), item = Item }
                if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("itensNotify", source, { "recebeu", itemIndex(Item), parseFormat(Amount), itemName(Item) })
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateItem(Passport, Item, Amount, Notify, Slot)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if itemDurability(Item) then
            Item = Item .. "-" .. os.time()
        elseif itemCharges(Item) then
            Item = Item .. "-" .. itemCharges(Item)
        end
        if not Slot then
            local newSlot = 0
            repeat
                newSlot = newSlot + 1
            until Inventory[tostring(newSlot)] == nil or Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item
            
            if not Inventory[tostring(newSlot)] then
                Inventory[tostring(newSlot)] = { amount = parseInt(Amount), item = Item }
                if parseInt(tostring(i)) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            elseif Inventory[tostring(newSlot)] and Inventory[tostring(newSlot)].item == Item then
                Inventory[tostring(newSlot)].amount = Inventory[tostring(newSlot)].amount + parseInt(Amount)
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("itensNotify", source, { "recebeu", itemIndex(Item), parseFormat(Amount), itemName(Item) })
            end
        else
            Slot = tostring(Slot)
            if Inventory[Slot] then
                if Inventory[Slot].item == Item then
                    Inventory[Slot].amount = Inventory[Slot].amount + parseInt(Amount)
                end
            else
                Inventory[Slot] = { amount = parseInt(Amount), item = Item }
                if parseInt(Slot) <= 5 and "Armamento" == itemType(Item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Item)
                end
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("itensNotify", source, { "recebeu", itemIndex(Item), parseFormat(Amount), itemName(Item) })
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAXITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.MaxItens(Passport, Item, Amount)
    if itemBody(Item) and vRP.Source(Passport) and itemMaxAmount(Item) then
        if vRP.HasService(Passport, "Restaurants") then
            if itemScape(Item) and vRP.ItemAmount(Passport, Item) + parseInt(Amount) > itemMaxAmount(Item) * 5 then
                return true
            end
        elseif vRP.ItemAmount(Passport, Item) + parseInt(Amount) > itemMaxAmount(Item) then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeItem(Passport, Item, Amount, Notify, Slot)
    local source = vRP.Source(Passport)
    local take = false
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        if not Slot then
            for k, v in pairs(Inventory) do
                if v.item == Item and parseInt(Amount) <= v.amount then
                    v.amount = v.amount - parseInt(Amount)
                    if v.amount <= 0 then
                        if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
                            TriggerClientEvent("inventory:verifyWeapon", source, Item)
                        end
                        if parseInt(k) <= 5 then
                            TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                        end
                        Inventory[k] = nil
                    end
                    if Notify and itemBody(Item) then
                        TriggerClientEvent("itensNotify", source, { "removeu",itemIndex(Item),parseFormat(Amount),itemName(Item) })
                    end
                    take = true
                    break
                end
            end
        elseif Inventory[tostring(Slot)] and Inventory[tostring(Slot)].item == Item and parseInt(Amount) <= Inventory[tostring(Slot)].amount then
            Inventory[tostring(Slot)].amount =  Inventory[tostring(Slot)].amount - parseInt(Amount)
            if  Inventory[tostring(Slot)].amount <= 0 then
                if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
                    TriggerClientEvent("inventory:verifyWeapon", source, Item)
                end
                if parseInt(Slot) <= 5 then
                    TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                end
                Inventory[tostring(Slot)] = nil
            end
            if Notify and itemBody(Item) then
                TriggerClientEvent("itensNotify", source, { "removeu",itemIndex(Item),parseFormat(Amount),itemName(Item) })
            end
            take = true
        end
    end
    return take
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveItem(Passport, Item, Amount, Notify)
    local source = vRP.Source(Passport)
    if source and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        for k, v in pairs(Inventory) do
            if v.item == Item and parseInt(Amount) <= v.amount then
                v.amount = v.amount - parseInt(Amount)
                if v.amount <= 0 then
                    if "Armamento" == itemType(Item) or "Throwing" ~= itemType(Item) then
                    end
                    TriggerClientEvent("inventory:verifyWeapon", source, Item)
                    if parseInt(k) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Item)
                    end
                    Inventory[k] = nil
                end
                if Notify and itemBody(Item) then
                    TriggerClientEvent("itensNotify", source, { "removeu",itemIndex(Item),parseFormat(Amount),itemName(Item) })
                end
                break
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetSrvData(Key)
	if srvData[Key] == nil then
		local rows = vRP.Query("entitydata/GetData",{ dkey = Key })
		if parseInt(#rows) > 0 then
			srvData[Key] = { data = json.decode(rows[1]["dvalue"]), timer = 180 }
		else
			srvData[Key] = { data = {}, timer = 180 }
		end
	end

	return srvData[Key]["data"]

end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetSrvData(Key,Data)
	srvData[Key] = { data = Data, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemSrvData(Key)
	srvData[Key] = { data = {}, timer = 180 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SRVDATATHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(srvData) do
			if v["timer"] > 0 then
				v["timer"] = v["timer"] - 1

				if v["timer"] <= 0 then
					vRP.Query("entitydata/SetData",{ dkey = k, dvalue = json.encode(v["data"]) })
					srvData[k] = nil
				end
			end
		end

		Wait(60000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVESERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("SaveServer", function(Save)
    for k,v in pairs(srvData) do
		if json.encode(v["data"]) == "[]" or json.encode(v["data"]) == "{}" then
			vRP.Query("entitydata/RemoveData",{ dkey = k })
		else
			vRP.Query("entitydata/SetData",{ dkey = k, dvalue = json.encode(v["data"]) })
		end
	end

	if not Save then
		Wait(100)
		print("O resource ^2vRP^7 salvou os dados do srvData. by Faly_")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.TakeChest(Passport, Data, Amount, Slot, Target)
    local source = vRP.Source(Passport)
    local Datatable = vRP.GetSrvData(Data)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and parseInt(Amount) > 0 and Datatable[Slot] then
        local Inventory = vRP.Inventory(Passport)
        if vRP.MaxItens(Passport, Datatable[Slot].item, (parseInt(Amount))) then
            TriggerClientEvent("Notify", source, "amarelo", "Limite atingido.", 3000)
            return true
        end
        if vRP.InventoryWeight(Passport) + itemWeight(Datatable[Slot].item) * parseInt(Amount) <= vRP.GetWeight(Passport) then
            if Inventory[Target] then
                if Datatable[Slot] and Inventory[Target].item == Datatable[Slot].item and parseInt(Amount) <= Datatable[Slot].amount then
                    Inventory[Target].amount = Inventory[Target].amount + parseInt(Amount)
                    Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
                    if 0 >= Datatable[Slot].amount then
                        Datatable[Slot] = nil
                    end
                end
            elseif Datatable[Slot] and parseInt(Amount) <= Datatable[Slot].amount then
                Inventory[Target] = { amount = parseInt(Amount), item = Datatable[Slot].item}
                Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
                if parseInt(Target) <= 5 and "Armamento" == itemType(Datatable[Slot].item) then
                    TriggerClientEvent("inventory:CreateWeapon", source, Datatable[Slot].item)
                end
                if 0 >= Datatable[Slot].amount then
                    Datatable[Slot] = nil
                end
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.StoreChest(Passport, Data, Amount, Weight, Slot, Target)
    local Inventory = vRP.Inventory(Passport)
    local Datatable = vRP.GetSrvData(Data)
    local source = vRP.Source(Passport)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if source and parseInt(Amount) > 0 and Inventory[Slot] and Weight >= vRP.ChestWeight(Datatable) + itemWeight(Inventory[Slot].item) * parseInt(Amount) then
        if Datatable[Target] then
            if Inventory[Slot] then
                if Inventory[Slot].item ~= Datatable[Target].item then
                    return
                end
                if not (parseInt(Amount) <= Inventory[Slot].amount) then
                    return
                end
                Datatable[Target].amount = Datatable[Target].amount + parseInt(Amount)
                Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                if 0 >= Inventory[Slot].amount then
                    if "Armamento" == itemType(Inventory[Slot].item) or "Throwing" ~= itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:verifyWeapon", source, Inventory[Slot].item)
                        if parseInt(Slot) <= 5 then
                            TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                        end
                    end
                    Inventory[Slot] = nil
                end
            end
        elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot].amount then
            Datatable[Target] = { amount = parseInt(Amount), item = Inventory[Slot].item }
            Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
            if 0 >= Inventory[Slot].amount then
                if "Armamento" == itemType(Inventory[Slot].item) or "Throwing" ~= itemType(Inventory[Slot].item) then
                    TriggerClientEvent("inventory:verifyWeapon", source, Inventory[Slot].item)
                    if parseInt(Slot) <= 5 then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                    end
                end
                Inventory[Slot] = nil
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateChest(Passport, Data, Slot, Target, Amount)
    local Datatable = vRP.GetSrvData(Data)
    Slot = tostring(Slot)
    Target = tostring(Target)
    if vRP.Source(Passport) and parseInt(Amount) > 0 and Datatable[Slot] then
        if Datatable[Target] then
            if Datatable[Slot] then
                if Datatable[Slot].item == Datatable[Target].item then
                    if parseInt(Amount) <= Datatable[Slot].amount then
                        Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
                        if 0 >= Datatable[Slot].amount then
                            Datatable[Slot] = nil
                        end
                        Datatable[Target].amount = Datatable[Target].amount + parseInt(Amount)
                    end
                else
                    Datatable[Target], Datatable[Slot] = Datatable[Slot], Datatable[Target]
                end
            end
        elseif Datatable[Slot] and parseInt(Amount) <= Datatable[Slot].amount then
            Datatable[Slot].amount = Datatable[Slot].amount - parseInt(Amount)
            Datatable[Target] = { item = Datatable[Slot].item, amount = parseInt(Amount) }
            if 0 >= Datatable[Slot].amount then
                Datatable[Slot] = nil
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIRECTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DirectChest(Chest, Slot, Amount)
    local Datatable = vRP.GetSrvData("Chest:" .. Chest)
    if Datatable[Slot] then
        if "dollars" == Datatable[Slot].item then
            Datatable[Slot].amount = Datatable[Slot].amount + parseInt(Amount)
        else
            Datatable[Slot] = { item = "dollars", amount = parseInt(Amount) }
        end
    else
        Datatable[Slot] = { item = "dollars", amount = parseInt(Amount) }, parseInt(Amount)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYITEMUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.invUpdate(Slot, Target, Amount)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and parseInt(Amount) > 0 then
        local Inventory = vRP.Inventory(Passport)
        Slot = tostring(Slot)
        Target = tostring(Target)
        if Inventory[Slot] then
            if Inventory[Target] then
                if Inventory[Slot].item == Inventory[Target].item then
                    if parseInt(Amount) <= Inventory[Slot].amount then
                        Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                        Inventory[Target].amount = Inventory[Target].amount + parseInt(Amount)
                        if Inventory[Slot].amount <= 0 then
                            if parseInt(Slot) <= 5 and "Armamento" == itemType(Inventory[Slot].item) then
                                TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                            end
                            Inventory[Slot] = nil
                        end
                    end
                else
                    if Inventory[Slot].item and Inventory[Target].item then
                        if Inventory[Slot].item == "dollars" and "suitcase" == splitString(Inventory[Target].item, "-")[1] then 
                            if vRP.TakeItem(Passport, "dollars", parseInt(Amount), false, Slot) then
                                if splitString(Inventory[Target].item, "-")[2] then
                                    Inventory[Target].item = "suitcase-" .. splitString(Inventory[Target].item, "-")[2] + parseInt(Amount)
                                    TriggerClientEvent("inventory:Update",source,"Backpack")
                                else
                                    Inventory[Target].item = "suitcase-" .. parseInt(Amount)
                                    TriggerClientEvent("inventory:Update",source,"Backpack")
                                end
                            end
                        elseif Inventory[Slot].item == "repairkit0" .. string.sub(Inventory[Slot].item, 11, 12) then
                            if vRP.CheckDamaged(Inventory[Target].item) and 1 == Inventory[Target].amount then
                                if Inventory[Slot].item == "repairkit0" .. string.sub(Inventory[Slot].item, 11, 12) then
                                    if itemRepair(Inventory[Target].item) then
                                        if itemRepair(Inventory[Target].item) == Inventory[Slot].item then
                                            if vRP.TakeItem(Passport, Inventory[Slot].item, 1, false, Slot) then
                                                Inventory[Target].item = splitString(Inventory[Target].item, "-")[1] .. "-" .. os.time()
                                                TriggerClientEvent("Notify", source, "verde", "Reparado.", 5000)
                                            end
                                        else
                                            TriggerClientEvent("Notify", source, "amarelo", "Seu item pode ser reparado com <b>" .. itemName((itemRepair(Inventory[Target].item))) .. "</b>.", 5000)
                                        end
                                    end
                                end
                            end
                        else
                            Inventory[Target], Inventory[Slot] = Inventory[Slot], Inventory[Target]
                            if parseInt(Target) <= 5 then
                                if parseInt(Slot) > 5 then
                                    if "Armamento" == itemType(Inventory[Target].item) then
                                        TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Target].item)
                                    end
                                    if "Armamento" == itemType(Inventory[Slot].item) then
                                        TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Slot].item)
                                    end
                                end
                            elseif parseInt(Slot) <= 5 and parseInt(Target) > 5 then
                                if "Armamento" == itemType(Inventory[Slot].item) then
                                    TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                                end
                                if "Armamento" == itemType(Inventory[Target].item) then
                                    TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Target].item)
                                end
                            end
                        end
                    end
                end
            elseif Inventory[Slot] and parseInt(Amount) <= Inventory[Slot].amount then
                Inventory[Target] = { item = Inventory[Slot].item, amount = parseInt(Amount) }
                Inventory[Slot].amount = Inventory[Slot].amount - parseInt(Amount)
                if Inventory[Slot].amount <= 0 then
                    if parseInt(Slot) <= 5 and parseInt(Target) > 5 and "Armamento" == itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:RemoveWeapon", source, Inventory[Slot].item)
                    end
                    if parseInt(Target) <= 5 and parseInt(Slot) > 5 and "Armamento" == itemType(Inventory[Slot].item) then
                        TriggerClientEvent("inventory:CreateWeapon", source, Inventory[Slot].item)
                    end
                    Inventory[Slot] = nil
                end
            end
        else
            TriggerClientEvent("inventory:Update", source, "Backpack")
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMEDICPLAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetMedicPlan(Passport)
	local Source = vRP.Source(Passport)
	
	vRP.Query("accounts/SetMedicPlan",{ steam = Characters[Source]["steam"], medicplan = os.time() + 2592000 })

	if Characters[Source] then
		Characters[Source]["medicplan"] = parseInt(os.time() + 2592000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEMEDICPLAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeMedicPlan(Passport)
	local Source = vRP.Source(Passport)
	
	vRP.Query("accounts/updateMedicPlan",{ steam = Characters[Source]["steam"] })

	if Characters[Source] then
		Characters[Source]["medicplan"] = Characters[Source]["medicplan"] + 2592000
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERMEDICPLAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserMedicPlan(Passport)
	local Source = vRP.Source(Passport)

	if Characters[Source] then
		if Characters[Source]["medicplan"] >= os.time() then
			return true
		end
	else
		local Identity = vRP.Query("characters/Person",{ id = Passport })
		if Identity[1] then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEMEDICPLAN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicenseMedicPlan(steam)
	local Info = vRP.Account(steam)
	if Info and Info["medicplan"] >= os.time() then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveBank(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 then
        vRP.Query("characters/addBank", { Passport = Passport, amount = Amount })
        if CreativeBank then
            exports.bank:AddTransactions(Passport, "entry", Amount)
        end
        if Characters[Source] then
            Characters[Source].bank = Characters[Source].bank + Amount
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveBank(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 then
        vRP.Query("characters/remBank", { Passport = Passport, amount = Amount })
        if CreativeBank then
            exports.bank:AddTransactions(Passport, "exit", Amount)
        end
        if Characters[Source] then
            Characters[Source].bank = Characters[Source].bank - Amount
            if 0 > Characters[Source].bank then
                Characters[Source].bank = 0
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetBank(source)
    if Characters[source] then
        return Characters[source].bank
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetFine(source)
    if Characters[source] then
        return Characters[source].fines
    end
    return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GiveFine(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 then
        vRP.Query("characters/addFines", { id = Passport, fines = Amount })
        if Characters[Source] then
            Characters[Source].fines = Characters[Source].fines + Amount
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemoveFine(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 then
        vRP.Query("characters/removeFines", { id = Passport, fines = Amount })
        if Characters[Source] then
            Characters[Source].fines = Characters[Source].fines - Amount
            if 0 > Characters[Source].fines then
                Characters[Source].fines = 0
            end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentGems(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 and Characters[Source] and Amount <= vRP.UserGemstone(Characters[Source].license) then
        vRP.Query("accounts/RemoveGems", { license = Characters[Source].license, gems = Amount })
        TriggerClientEvent("hud:RemoveGems", Source, Amount)
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PaymentBank(Passport, Amount, IgnoreLimit)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 and Characters[Source] then
        if CreativeBank and not IgnoreLimit then
            if not (Characters[Source]["spending"] + Amount <= Characters[Source]["cardlimit"])then
                TriggerClientEvent("Notify", Source, "amarelo", "Limite insuficiente no cartão.", 10000)
                return false
            end
            if Amount <= Characters[Source]["bank"] then
                vRP.UpgradeSpending(Passport, Amount)
                vRP.RemoveBank(Passport, Amount, Source)
                TriggerClientEvent("itensNotify", Source, { "pagou","dollars",Amount,"Dólares" })
                return true
            end
        elseif Amount <= Characters[Source]["bank"] then
            vRP.RemoveBank(Passport, Amount, Source)
            TriggerClientEvent("itensNotify", Source, { "pagou","dollars",Amount,"Dólares" })
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------

function vRP.PaymentFull(Passport, Amount, IgnoreLimit)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    local item = vRP.ItemAmount(Passport,"dollars",Amount) 
    if item >= Amount then
        return vRP.TakeItem(Passport,"dollars",Amount)
    else
        return vRP.PaymentBank(Passport, Amount, IgnoreLimit)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.WithdrawCash(Passport, Amount)
    local Amount = parseInt(Amount)
    local Source = vRP.Source(Passport)
    if Amount > 0 and Characters[Source] and Amount <= Characters[Source].bank then
        vRP.GenerateItem(Passport, "dollars", Amount, true)
        vRP.RemoveBank(Passport, Amount, (Source))
        return true
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
    if "vrp" == Resource then
        Wait(3000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Party = {}
Party.Room = {}
Party.Users = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.create(source, Passport, Message)
    if Message and not Party.Users[Passport] and not Party.Room[Message] then
        Party.Room[Message] = {}
        Party.Users[Passport] = Message
        Party.Room[Message][Passport] = source        
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.add(source, Passport, Message)
    if not Party.Users[Passport] and not Party.Room[Message][Passport] then
        Party.Users[Passport] = Message
        Party.Room[Party.Users[Passport]][Passport] = source       
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.rem(source, Passport, Message)
    if Party.Users[Passport] and Party.Room[Message][Passport] then
        Party.Users[Passport] = nil
        Party.Room[Message][Passport] = nil        
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.leave(source, Passport)
    if Party.Users[Passport] then
        vRP.rem(source, Passport, Party.Users[Passport])       
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.party(Passport)
    if Passport then
        if Party.Users[Passport] and Party.Room[Party.Users[Passport]] then
            for k, v in pairs(Party.Room[Party.Users[Passport]]) do
                return "" .. "#" .. k .. " " .. vRP.Identity(k).name .. " " .. vRP.Identity(k).name2 .. "<br>"
            end
        end
        return false
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
    if Party.Users[Passport] then
        if Party.Room[Party.Users[Passport]] and Party.Room[Party.Users[Passport]][Passport] then
            Party.Room[Party.Users[Passport]][Passport] = nil
            if #Party.Room[Party.Users[Passport]] <= 0 then
                Party.Room[Party.Users[Passport]] = nil
            end
        end
        Party.Users[Passport] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTY
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Party", function(Passport, source, Distance)
    local Partys = {}
    if Party.Users[Passport] and Party.Room[Party.Users[Passport]] then
        for k, v in pairs(Party.Room[Party.Users[Passport]]) do
            if Distance >= #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(v))) then
                Partys[#Partys + 1] = {
                    ["Passport"] = k,
                    ["source"] = source
                }
            end
        end
    end
    return Partys
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Global = {}
Objects = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CharacterChosen", function(Passport, source)
    local Datatable = vRP.Datatable(Passport)
    local Identity = vRP.Identity(Passport)
    if Datatable and Identity then
        if Datatable.Pos then
            if not (Datatable.Pos.x and Datatable.Pos.y and Datatable.Pos.z) then
                Datatable.Pos = { x = SpawnCoords.x, y = SpawnCoords.y, z = SpawnCoords.z }
            end
        else
            Datatable.Pos = { x = SpawnCoords.x, y = SpawnCoords.y,  z = SpawnCoords.z }
        end
        if not Datatable.Skin then
            Datatable.Skin = "mp_m_freemode_01"
        end
        if not Datatable.Inventory then
            Datatable.Inventory = {}
        end
        if not Datatable.Health then
            Datatable.Health = 200
        end
        if not Datatable.Armour then
            Datatable.Armour = 0
        end
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        if not Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        if not Datatable.Addiction then
            Datatable.Addiction = 0
        end
        vRPC.Skin(source, Datatable.Skin)
        vRP.SetArmour(source, Datatable.Armour)
        vRPC.SetHealth(source, Datatable.Health)
        vRP.Teleport(source, Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z)
        TriggerClientEvent("barbershop:Apply", source, vRP.UserData(Passport, "Barbershop"))
        TriggerClientEvent("skinshop:Apply", source, vRP.UserData(Passport, "Clothings"))
        TriggerClientEvent("tattoos:Apply", source, vRP.UserData(Passport, "Tatuagens"))
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
        TriggerClientEvent("hud:Addiction", source, Datatable.Addiction)

        TriggerClientEvent("vRP:Active", source, Passport, Identity.name .. " " .. Identity.name2)
        if GetResourceMetadata("vrp", "creator") == "yes" then
            if vRP.UserData(Passport, "Creator") == 1 then
                if Global[Passport] then
                    TriggerClientEvent("spawn:justSpawn", source, false, false)
                else
                    TriggerClientEvent("spawn:justSpawn", source, true, vec3(Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z))
                end
            else
                vRP.Query("playerdata/SetData", { Passport = Passport, dkey = "Creator", dvalue = json.encode(1) })
                TriggerClientEvent("spawn:justSpawn", source, false, true)
            end
        elseif Global[Passport] then
            TriggerClientEvent("spawn:justSpawn", source, false, false)
        else
            TriggerClientEvent("spawn:justSpawn", source, true, vec3(Datatable.Pos.x, Datatable.Pos.y, Datatable.Pos.z))
        end
        TriggerEvent("Connect", Passport, source, Global[Passport] == nil)
        Global[Passport] = true
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JUSTOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:justObjects")
AddEventHandler("vRP:justObjects", function()
    local source = source
    local Passport = vRP.Passport(source)
    local Inventory = vRP.Inventory(Passport)
    if Passport then
        for i = 1, 5 do
            if Inventory[tostring(i)] and "Armamento" == itemType(Inventory[tostring(i)].item) then
                TriggerClientEvent("inventory:CreateWeapon", source, Inventory[tostring(i)].item)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BACKPACKWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BackpackWeight")
AddEventHandler("vRP:BackpackWeight", function(value)
    local source = source
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if Passport then
        if value then
            if not Global[Passport] then
                Datatable.Weight = Datatable.Weight + 50
                Global[Passport] = true
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeleteObject")
AddEventHandler("DeleteObject", function(index, value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if value and Objects[Passport] and Objects[Passport][value] then
            index = Objects[Passport][value]
            Objects[Passport][value] = nil
        end
    end
    TriggerEvent("DeleteObjectServer", index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEOBJECTSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DeleteObjectServer", function(entIndex)
    local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(NetworkGetEntityFromNetworkId) and not IsPedAPlayer(NetworkGetEntityFromNetworkId) and 3 == GetEntityType(NetworkGetEntityFromNetworkId) then
        DeleteEntity(NetworkGetEntityFromNetworkId)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DeletePed")
AddEventHandler("DeletePed", function(entIndex)
    local NetworkGetEntityFromNetworkId = NetworkGetEntityFromNetworkId(entIndex)
    if DoesEntityExist(NetworkGetEntityFromNetworkId) and not IsPedAPlayer(NetworkGetEntityFromNetworkId) and 1 == GetEntityType(NetworkGetEntityFromNetworkId) then
        DeleteEntity(NetworkGetEntityFromNetworkId)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugObjects", function(value)
    if Objects[value] then
        for k, v in pairs(Objects[value]) do
            Objects[value][k] = nil
            TriggerEvent("DeleteObjectServer", k)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUGWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("DebugWeapons", function(value)
    if Objects[value] then
        for k, v in pairs(Objects[value]) do
            TriggerEvent("DeleteObjectServer", v)
            Objects[value] = nil
        end
        Objects[value] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg", function(source)
    local source = source
    local Passport = vRP.Passport(source)
    if GetPlayerRoutingBucket(source) < 900000 and Passport and SURVIVAL.CheckDeath(source) then
        if vRP.UserPremium(Passport) then
            if ClearInventoryPremium then
                vRP.ClearInventory(Passport)
            end
        elseif CleanDeathInventory then
            vRP.ClearInventory(Passport)
        end
        local Datatable = vRP.Datatable(Passport)
        if WipeBackpackDeath and Datatable and Datatable.Weight then
            Datatable.Weight = BackpackWeightDefault
        end
        vRP.UpgradeThirst(Passport, 100)
        vRP.UpgradeHunger(Passport, 100)
        vRP.DowngradeStress(Passport, 100)
        TriggerEvent("Discord", "Airport", "**Source:** " .. source .. [[ **Passaporte:** ]] .. Passport .. [[ **Address:** ]] .. GetPlayerEndpoint(source), 3092790)
        SURVIVAL.Respawn(source)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ClearInventory(Passport)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if source and Datatable and Datatable.Inventory then
        exports.inventory:CleanWeapons(parseInt(Passport), true)
        TriggerEvent("DebugObjects", parseInt(Passport))
        TriggerEvent("DebugWeapons", parseInt(Passport))
        Datatable.Inventory = {}
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeThirst(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Thirst then
            Datatable.Thirst = 0
        end
        Datatable.Thirst = Datatable.Thirst + parseInt(Amount)
        if Datatable.Thirst > 100 then
            Datatable.Thirst = 100
        end
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeHunger(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Hunger then
            Datatable.Hunger = 0
        end
        Datatable.Hunger = Datatable.Hunger + parseInt(Amount)
        if Datatable.Hunger > 100 then
            Datatable.Hunger = 100
        end
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetAddiction(Passport)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        Datatable.HasAddiction = true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.RemAddiction(Passport)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        Datatable.HasAddiction = false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeAddiction(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if Datatable.HasAddiction == true then
            if not Datatable.Addiction then
                Datatable.Addiction = 0
            end
            Datatable.Addiction = Datatable.Addiction + parseInt(Amount)
            if Datatable.Addiction > 100 then
                Datatable.Addiction = 100
            end
            TriggerClientEvent("hud:Addiction", source, Datatable.Addiction)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradeStress(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        Datatable.Stress = Datatable.Stress + parseInt(Amount)
        if Datatable.Stress > 100 then
            Datatable.Stress = 100
        end
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeThirst(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        Datatable.Thirst = Datatable.Thirst - parseInt(Amount)
        if Datatable.Thirst < 0 then
            Datatable.Thirst = 0
        end
        TriggerClientEvent("hud:Thirst", source, Datatable.Thirst)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeHunger(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        Datatable.Hunger = Datatable.Hunger - parseInt(Amount)
        if Datatable.Hunger < 0 then
            Datatable.Hunger = 0
        end
        TriggerClientEvent("hud:Hunger", source, Datatable.Hunger)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeAddiction(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Addiction then
            Datatable.Addiction = 0
        end
        Datatable.Addiction = Datatable.Addiction - parseInt(Amount)
        if Datatable.Addiction < 0 then
            Datatable.Addiction = 0
        end
        TriggerClientEvent("hud:Addiction", source, Datatable.Addiction)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.DowngradeStress(Passport, Amount)
    local source = vRP.Source(Passport)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and source then
        if not Datatable.Stress then
            Datatable.Stress = 0
        end
        Datatable.Stress = Datatable.Stress - parseInt(Amount)
        if Datatable.Stress < 0 then
            Datatable.Stress = 0
        end
        TriggerClientEvent("hud:Stress", source, Datatable.Stress)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Foods()
    local source = source
    local Passport = vRP.Passport(source)
    local Datatable = vRP.Datatable(Passport)
    if source and Datatable then
        if not Datatable.Thirst then
            Datatable.Thirst = 100
        end
        if not Datatable.Hunger then
            Datatable.Hunger = 100
        end
        Datatable.Hunger = Datatable.Hunger - 1
        Datatable.Thirst = Datatable.Thirst - 1
        if Datatable.Thirst < 0 then
            Datatable.Thirst = 0
        end
        if Datatable.Hunger < 0 then
            Datatable.Hunger = 0
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetHealth(source)
    local GetPlayerPed = GetPlayerPed(source)
    return GetEntityHealth(GetPlayerPed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.ModelPlayer(source)
    local GetPlayerPed = GetPlayerPed(source)
    if GetEntityModel(GetPlayerPed) == GetHashKey("mp_f_freemode_01") then
        return "mp_f_freemode_01"
    elseif GetEntityModel(GetPlayerPed) == GetHashKey("mp_m_freemode_01") then
        return "mp_m_freemode_01"
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetExperience(Passport, Work)
    local Datatable = vRP.Datatable(Passport)
    if Datatable and not Datatable[Work] then
        Datatable[Work] = 0
    end
    return Datatable[Work] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.PutExperience(Passport, Work, Number)
    local Datatable = vRP.Datatable(Passport)
    if Datatable then
        if not Datatable[Work] then
            Datatable[Work] = 0
        end
        Datatable[Work] = Datatable[Work] + Number
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetArmour(source, Amount)
    local GetPlayerPed = GetPlayerPed(source)
    if GetPedArmour(GetPlayerPed) + Amount > 100 then
        Amount = 100 - GetPedArmour(GetPlayerPed)
    end
    SetPedArmour(GetPlayerPed, GetPedArmour(GetPlayerPed) + Amount)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.Teleport(source, x, y, z)
    local GetPlayerPed = GetPlayerPed(source)
    SetEntityCoords(GetPlayerPed, x + 1.0E-4, y + 1.0E-4, z + 1.0E-4, false, false, false, false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetEntityCoords(source)
    local GetPlayerPed = GetPlayerPed(source)
    return GetEntityCoords(GetPlayerPed)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSIDEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.InsideVehicle(source)
    local Ped = GetPlayerPed(source)
    if GetVehiclePedIsIn(Ped,false) == 0 then
        return false
    else
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreatePed(Model,x,y,z,Heading,Type)
	local spawnPeds = 0
	local mHash = GetHashKey(Model)
	local Ped = CreatePed(Type,mHash,x,y,z,Heading,true,false)

	while not DoesEntityExist(Ped) and spawnPeds <= 1000 do
		spawnPeds = spawnPeds + 1
		Wait(1)
	end

	if DoesEntityExist(Ped) then
		return true,NetworkGetNetworkIdFromEntity(Ped)
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObject(Model, x, y, z, Weapon)
    local Passport = vRP.Passport(source)
    if Passport then
        local SpawnObjects = 0
        local Hash = GetHashKey(Model)
        local Object = CreateObject(Hash, x, y, z, true, true, false)

        while not DoesEntityExist(Object) and SpawnObjects <= 1000 do
            SpawnObjects = SpawnObjects + 1
            Wait(1)
        end
        
        if DoesEntityExist(Object) then
            local NetworkGetNetworkIdFromEntity = NetworkGetNetworkIdFromEntity(Object)
            if Weapon then
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end
                Objects[Passport][Weapon] = NetworkGetNetworkIdFromEntity
            else
                if not Objects[Passport] then
                    Objects[Passport] = {}
                end
                Objects[Passport][NetworkGetNetworkIdFromEntity] = true
            end
            return true, NetworkGetNetworkIdFromEntity
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        for k, v in pairs(Sources) do
            vRP.DowngradeHunger(k, ConsumeHunger)
            vRP.DowngradeThirst(k, ConsumeThirst)
        end
        Wait(CooldownHungerThrist)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        for k, v in pairs(Sources) do
            vRP.UpgradeAddiction(k, ConsumeAddiction)
        end
        Wait(CooldownAddiction)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketClient")
AddEventHandler("vRP:BucketClient", function(value)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        if value == "Enter" then
            Player(source).state.Route = Passport
            SetPlayerRoutingBucket(source, Passport)
        else
            Player(source).state.Route = 0
            SetPlayerRoutingBucket(source, 0)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUCKETSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:BucketServer")
AddEventHandler("vRP:BucketServer", function(source, value, bucket)
    if value == "Enter" then
        Player(source).state.Route = bucket
        SetPlayerRoutingBucket(source, bucket)
        if bucket > 0 then
            SetRoutingBucketEntityLockdownMode(bucket, "inactive")
            -- SetRoutingBucketEntityLockdownMode(bucket, "relaxed")
            SetRoutingBucketPopulationEnabled(bucket, false)
        end
    else
        Player(source).state.Route = 0
        SetPlayerRoutingBucket(source, 0)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
    TriggerEvent("DebugObjects", Passport)
    TriggerEvent("DebugWeapons", Passport)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.SetPremium(source)
    if Characters[source] then
        vRP.Query("accounts/setPremium", { license = Characters[source].license, premium = os.time() + 2592000 })
        Characters[source].premium = parseInt(os.time() + 2592000)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpgradePremium(source)
    if Characters[source] then
        vRP.Query("accounts/updatePremium", { license = Characters[source].license })
        Characters[source].premium = Characters[source].premium + 2592000
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UserPremium(Passport)
    local Source =  vRP.Source(Passport)
    local HasPermission = vRP.HasPermission(Passport, "Premium")
    if Characters[Source] then
        if Characters[Source].premium < os.time() then
            if HasPermission then
                vRP.RemovePermission(Passport, "Premium")
            end
            return false
        elseif not HasPermission then
            vRP.SetPermission(Passport, "Premium")
        end
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LICENSEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.LicensePremium(License)
    local Account = vRP.Account(License)
    if Account and Account.premium >= os.time() then
        return true
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- QUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
local Queue = {}
Queue.QueueList = {}
Queue.PlayerList = {}
Queue.PlayerCount = 0
Queue.Connecting = {}
Queue.ThreadCount = 0
local maxPlayers = 1024
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMRUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function steamRunning(source)
	local result = false
	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			result = true
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function getQueue(ids,trouble,source,connect)
	for k,v in ipairs(connect and Queue.Connecting or Queue.QueueList) do
		local inQueue = false

		if not source then
			for _,i in ipairs(v["ids"]) do
				if inQueue then
					break
				end

				for _,o in ipairs(ids) do
					if o == i then
						inQueue = true
						break
					end
				end
			end
		else
			inQueue = ids == v["source"]
		end

		if inQueue then
			if trouble then
				return k,connect and Queue.Connecting[k] or Queue.QueueList[k]
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
function isPriority(identifiers)
	local resultPriority = 0

	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			local infoAccount = vRP.Account(splitName[2])
			if infoAccount then
				resultPriority = infoAccount["priority"]
				break
			end
		end
	end

	return resultPriority
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function addQueue(ids,connectTime,name,source,deferrals)
	if getQueue(ids) then
		return
	end

	local tmp = { source = source, ids = ids, name = name, firstconnect = connectTime, priority = isPriority(ids), timeout = 0, deferrals = deferrals }

	local _pos = false
	local queueCount = #Queue.QueueList + 1

	for k,v in ipairs(Queue.QueueList) do
		if tmp["priority"] then
			if not v["priority"] then
				_pos = k
			else
				if tmp["priority"] > v["priority"] then
					_pos = k
				end
			end

			if _pos then
				break
			end
		end
	end

	if not _pos then
		_pos = #Queue.QueueList + 1
	end

	table.insert(Queue.QueueList,_pos,tmp)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function removeQueue(ids,source)
	if getQueue(ids,false,source) then
		local pos,data = getQueue(ids,true,source)
		table.remove(Queue.QueueList,pos)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function isConnect(ids,source,refresh)
	local k,v = getQueue(ids,refresh and true or false,source and true or false,true)

	if not k then
		return false
	end

	if refresh and k and v then
		Queue.Connecting[k]["timeout"] = 0
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function removeConnect(ids,source)
	for k,v in ipairs(Queue.Connecting) do
		local connect = false

		if not source then
			for _,i in ipairs(v["ids"]) do
				if connect then
					break
				end

				for _,o in ipairs(ids) do
					if o == i then
						connect = true
						break
					end
				end
			end
		else
			connect = ids == v["source"]
		end

		if connect then
			table.remove(Queue.Connecting,k)
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function addConnect(ids,ignorePos,autoRemove,done)
	local function removeFromQueue()
		if not autoRemove then
			return
		end

		done(Lang.Error)
		removeConnect(ids)
		removeQueue(ids)
	end

	if #Queue.Connecting >= 100 then
		removeFromQueue()
		return false
	end

	if isConnect(ids) then
		removeConnect(ids)
	end

	local pos,data = getQueue(ids,true)
	if not ignorePos and (not pos or pos > 1) then
		removeFromQueue()
		return false
	end

	table.insert(Queue.Connecting,data)
	removeQueue(ids)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMIDS
-----------------------------------------------------------------------------------------------------------------------------------------
function steamIds(source)
	return GetPlayerIdentifiers(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function updateData(source,ids,deferrals)
	local pos,data = getQueue(ids,true)
	Queue.QueueList[pos]["ids"] = ids
	Queue.QueueList[pos]["timeout"] = 0
	Queue.QueueList[pos]["source"] = source
	Queue.QueueList[pos]["deferrals"] = deferrals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function notFull(firstJoin)
	local canJoin = Queue.PlayerCount + #Queue.Connecting < maxPlayers and #Queue.Connecting < 100
	if firstJoin and canJoin then
		canJoin = #Queue.QueueList <= 1
	end

	return canJoin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function setPosition(ids,newPos)
	local pos,data = getQueue(ids,true)
	table.remove(Queue.QueueList,pos)
	table.insert(Queue.QueueList,newPos,data)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local function Connect(name,setKickReason,deferrals)
		local source = source
		local ids = steamIds(source)
		local connectTime = os.time()
		local connecting = true

		deferrals.defer()

		CreateThread(function()
			while connecting do
				Wait(500)
				if not connecting then
					return
				end
				deferrals.update(Lang.Connecting)
			end
		end)

		Wait(1000)

		local function done(message)
			connecting = false
			CreateThread(function()
				if message then
					deferrals.update(tostring(message) and tostring(message) or "")
				end

				Wait(1000)

				if message then
					deferrals.done(tostring(message) and tostring(message) or "")
					CancelEvent()
				end
			end)
		end

		local function update(message)
			connecting = false
			deferrals.update(tostring(message) and tostring(message) or "")
		end

		if not steamRunning(source) then
			done(Lang.Error)
			CancelEvent()
			return
		end

		local reason = "Removido da fila."

		local function setReason(message)
			reason = tostring(message)
		end

		TriggerEvent("Queue:playerJoinQueue",source,setReason)

		if WasEventCanceled() then
			done(reason)

			removeQueue(ids)
			removeConnect(ids)

			CancelEvent()
			return
		end

		local rejoined = false

		if getQueue(ids) then
			rejoined = true
			updateData(source,ids,deferrals)
		else
			addQueue(ids,connectTime,name,source,deferrals)
		end

		if isConnect(ids,false,true) then
			removeConnect(ids)

			if notFull() then
				local added = addConnect(ids,true,true,done)
				if not added then
					CancelEvent()
					return
				end

				done()
				TriggerEvent("Queue:Connecting",source,ids,deferrals)

				return
			else
				addQueue(ids,connectTime,name,source,deferrals)
				setPosition(ids,1)
			end
		end

		local pos,data = getQueue(ids,true)

		if not pos or not data then
			done(Lang.Error)
			RemoveFromQueue(ids)
			RemoveFromConnecting(ids)
			CancelEvent()
			return
		end

		if notFull(true) then
			local added = addConnect(ids,true,true,done)
			if not added then
				CancelEvent()
				return
			end

			done()

			TriggerEvent("Queue:Connecting",source,ids,deferrals)

			return
		end

		update(string.format(Lang.Position,pos,#Queue.QueueList))

		CreateThread(function()
			if rejoined then
				return
			end

			Queue.ThreadCount = Queue.ThreadCount + 1
			local dotCount = 0

			while true do
				Wait(1000)
				local dots = ""

				dotCount = dotCount + 1
				if dotCount > 3 then
					dotCount = 0
				end

				for i = 1,dotCount do
					dots = dots.."."
				end

				local pos,data = getQueue(ids,true)

				if not pos or not data then
					if data and data.deferrals then
						data.deferrals.done(Lang.Error)
					end

					CancelEvent()
					removeQueue(ids)
					removeConnect(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1
					return
				end

				if pos <= 1 and notFull() then
					local added = addConnect(ids)
					data.deferrals.update(Lang.Join)
					Wait(500)

					if not added then
						data.deferrals.done(Lang.Error)
						CancelEvent()
						Queue.ThreadCount = Queue.ThreadCount - 1
						return
					end

					data.deferrals.update("Carregando conexão com o servidor.")

					removeQueue(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1

					TriggerEvent("Queue:Connecting",source,data.ids,data.deferrals)
					
					return
				end

				local message = string.format("Invoke Solution\n\n"..Lang.Position.."%s\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe sua sugestão em nosso discord.",pos,#Queue.QueueList,dots)
				data.deferrals.update(message)
			end
		end)
	end

	AddEventHandler("playerConnecting",Connect)

	local function checkTimeOuts()
		local i = 1

		while i <= #Queue.QueueList do
			local data = Queue.QueueList[i]
			local lastMsg = GetPlayerLastMsg(data.source)

			if lastMsg == 0 or lastMsg >= 30000 then
				data.timeout = data.timeout + 1
			else
				data.timeout = 0
			end

			if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
				data.deferrals.done(Lang.Error)
				table.remove(Queue.QueueList,i)
			elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
				data.deferrals.done(Lang.Error)
				removeQueue(data.source,true)
				removeConnect(data.source,true)
			else
				i = i + 1
			end
		end

		i = 1

		while i <= #Queue.Connecting do
			local data = Queue.Connecting[i]
			local lastMsg = GetPlayerLastMsg(data.source)
			data.timeout = data.timeout + 1

			if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
				removeQueue(data.source,true)
				removeConnect(data.source,true)
			else
				i = i + 1
			end
		end

		SetTimeout(1000,checkTimeOuts)
	end

	checkTimeOuts()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Queue:Connect")
AddEventHandler("Queue:Connect",function()
	local source = source

	if not Queue.PlayerList[source] then
		local ids = steamIds(source)

		Queue.PlayerCount = Queue.PlayerCount + 1
		Queue.PlayerList[source] = true
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
	if Queue.PlayerList[source] then
		local ids = steamIds(source)

		Queue.PlayerCount = Queue.PlayerCount - 1
		Queue.PlayerList[source] = nil
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:Remove",function(ids)
	removeQueue(ids)
	removeConnect(ids)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.UpdateRolepass(source, Day)
    if Characters[source] then
        vRP.Query("accounts/Rolepass", { license = Characters[source].license, rolepass = Day })
        Characters[source].rolepass = Day
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROLEPASS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.CheckRolepass(source)
    if Characters[source] and Characters[source].rolepass > 0 then
        return true
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY
-----------------------------------------------------------------------------------------------------------------------------------------
local Salary = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:ADD
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Add", function(Passport, Permission)
    if not Salary[Permission] then
        Salary[Permission] = {}
    end
    if not Salary[Permission][Passport] then
        Salary[Permission][Passport] = os.time() + SalarySeconds
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARY:REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Salary:Remove", function(Passport, Permission)
    if Permission then
        if Salary[Permission] and Salary[Permission][Passport] then
            Salary[Permission][Passport] = nil
        end
    else
        for k, v in pairs(Salary) do
            if Salary[k][Passport] then
                Salary[k][Passport] = nil
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(60000)
        for k, v in pairs(Salary) do
            for Passport, Sources in pairs(Salary[k]) do
                if Sources <= os.time() then
                    Salary[k][Passport] = os.time() + SalarySeconds
                    local Datatable = vRP.GetSrvData("Permissions:"..k)
                    if Datatable[tostring(Passport)] then
                        if Groups[k] and Groups[k].Salary and Groups[k].Salary[Datatable[tostring(Passport)]] then
                            vRP.GiveBank(Passport, Groups[k].Salary[Datatable[tostring(Passport)]])
                            local NotifySource = vRP.Source(Passport)
                            TriggerClientEvent("Notify",NotifySource,"verde","Seu salário no valor de $"..parseFormat(Groups[k].Salary[Datatable[tostring(Passport)]]).." foi depositado em sua conta",10000)
                        end
                    else
                        Salary[k][Passport] = nil
                    end
                end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
    for k, v in pairs(Salary) do
        if Salary[k][Passport] then
            Salary[k][Passport] = nil
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("CleanVehicle")
AddEventHandler("CleanVehicle",function(entIndex)
	if DoesEntityExist(NetworkGetEntityFromNetworkId(entIndex)) and not IsPedAPlayer(NetworkGetEntityFromNetworkId(entIndex)) and 2 == GetEntityType(NetworkGetEntityFromNetworkId(entIndex)) then
		SetVehicleDirtLevel(NetworkGetEntityFromNetworkId(entIndex),0.0)
	end
end)

function vRP.SendWebhook(Link,Title,Message,Color)
    PerformHttpRequest(Link,function(err,text,headers) end,"POST",json.encode({
		username = Title,
		embeds = { { color = Color or 10357504, description = Message } }
	}),{ ["Content-Type"] = "application/json" })
end