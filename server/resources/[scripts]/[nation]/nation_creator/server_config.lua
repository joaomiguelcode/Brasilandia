local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_creator")
func = {}
Tunnel.bindInterface("nation_creator", func)
vHUD = Tunnel.getInterface("hud")
REQUEST = Tunnel.getInterface("request")
vCLIENT = Tunnel.getInterface("nation_creator")
multiCharacter = true

---------------------------------------------------------------------------
-----------------------VERIFICAÇÃO DE PERMISSÃO--------------------------
---------------------------------------------------------------------------

if multiCharacter then
    vRP.Prepare("nation_creator/createAgeColumn","ALTER TABLE characters ADD IF NOT EXISTS age INT(11) NOT NULL DEFAULT 20")
    vRP.Prepare("nation_creator/update_user_first_spawn","UPDATE characters SET name2 = @firstname, name = @name, age = @age, sex = @sex WHERE id = @user_id")
    vRP.Prepare("nation_creator/create_characters","INSERT INTO characters(license,name,name2,phone,blood) VALUES(@steam,@name,@name2,@phone,@blood)")
    vRP.Prepare("nation_creator/remove_characters","UPDATE characters SET deleted = 1 WHERE id = @id")
    vRP.Prepare("nation_creator/get_characters","SELECT * FROM characters WHERE license = @steam and deleted = 0")
    vRP.Prepare("nation_creator/get_character","SELECT * FROM characters WHERE license = @steam and deleted = 0 and id = @user_id")
    vRP.Prepare("nation_creator/get_bank","SELECT * FROM characters WHERE id = @user_id")
    CreateThread(function() vRP.Query("nation_creator/createAgeColumn") end) -- criar coluna idade na db
else
    vRP.Prepare("nation_creator/update_user_first_spawn","UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")
end


function func.checkPermission(permission, src)
    local source = src or source
    local user_id = vRP.Passport(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.HasGroup(user_id, perm, {1,2,3}) then
                return true
            end
        end
        return false
    end
    
    return vRP.HasGroup(user_id, permission, {1,2,3})
end


function func.saveChar(name, lastName, age, char, id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    if char then
        vRP.setUData(user_id, "nation_char", json.encode(char,{indent=false}))
    end
    local sex = "M"
    if name and lastName and age then
        if GetEntityModel(GetPlayerPed(source)) == GetHashKey("mp_f_freemode_01") then
            sex = "F"
        end
        vRP.Query("nation_creator/update_user_first_spawn",{ user_id = user_id, firstname = lastName, name = name, age = age, sex = sex })
    end
    TriggerClientEvent("nation_barbershop:init", source, char)
    local skin = "mp_m_freemode_01"
    if sex == "F" then
        skin = "mp_f_freemode_01"
    end
    vRP.SkinCharacter(user_id, skin)
    vRP.playerDropped(source,"Atualizando Personagem.")
    vRP.CharacterChosen(source,user_id,nil)
    vRP.UpgradeIdentity(user_id)
    return true
end


function getUserChar(user_id, source, nation)
    local char
    local data = vRP.getUData(user_id, "nation_char")
    if data and data.hair then
        char = data
        char.gender = getGender(user_id) or char.gender
    end
    
    return char
end
function func.SavePlayer()
    local source = source
    if source ~= 0 then
        vRP.Kick(source,"Atualizando Personagem !!!")
    end
end

local userlogin = {}
function playerSpawn(user_id, source, first_spawn)
    if first_spawn then
        Wait(1000)
        processSpawnController(source,getUserChar(user_id, source),user_id)
    end
end

AddEventHandler("vRP:playerSpawn",playerSpawn)

function processSpawnController(source,char,user_id)
    getUserLastPosition(source, user_id)
    local source = source
    if char then
        if not userlogin[user_id] then
            userlogin[user_id] = true
            fclient._spawnPlayer(source,false)
        else
            fclient._spawnPlayer(source,true)
        end
        fclient.setPlayerChar(source, char, true)
        TriggerClientEvent("nation_barbershop:init", source, char)
        setPlayerTattoos(source, user_id)
        fclient._setClothing(source, getUserClothes(user_id))
    else
        userlogin[user_id] = true
        local data = vRP.getUData(user_id, "Barbershop")
        if data then 
            local gender = getGender(user_id)
            fclient._spawnPlayer(source,false)
            fclient._setOldChar(source, data, getUserClothes(user_id), gender, user_id)
        else
            fclient._startCreator(source)
        end
    end
end




function setPlayerTattoos(source, user_id)
    TriggerClientEvent("tattoos:Apply", source, getUserTattoos(user_id))
    TriggerClientEvent("reloadtattos", source)
    TriggerEvent('dpn_tattoo:setPedServer', source)
    TriggerClientEvent("nyoModule:tattooUpdate", source, false)
end


function func.setPlayerTattoos(id)
    local source = source
    local user_id = id or vRP.Passport(source)
    if user_id then
        setPlayerTattoos(source, user_id)
    end
end

function getUserLastPosition(source, user_id)
    local coords = {402.76,-996.28,-99.00}
    local datatable = vRP.getUserDataTable(user_id)
    if datatable and datatable.Pos then
        local p = datatable.Pos
        coords = { p.x, p.y, p.z }
    else
        local data = vRP.getUData(user_id, "Datatable")
        if data and data.Pos then
            local p = data.Pos
            coords = { p.x, p.y, p.z }
        end
    end
    fclient._setPlayerLastCoords(source, coords)
    return coords
end


function func.getUserLastPosition()
    local source = source
    local user_id = vRP.Passport(source)
    getUserLastPosition(source, user_id)
end


function format(n)
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end


function func.changeSession(session)
    local source = source
    SetPlayerRoutingBucket(source, session)
end

function func.updateLogin()
    local source = source
    local user_id = vRP.Passport(source)
    if user_id then
        userlogin[user_id] = true
        local char = getUserChar(user_id, source)
        if char then 
            TriggerClientEvent("nation_barbershop:init", source, char)
            setPlayerTattoos(source, user_id)
        end
    end
end



function func.getCharsInfo()
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.Query("nation_creator/get_characters",{ steam = steam })
    local info = { chars = {} }
    for k,v in ipairs(data) do
        local char = getUserChar(v.id, source) or {}
        local clothes = getUserClothes(v.id)
        local gender = v.sex
        if char.gender and char.gender == "F" then
            gender = "feminino"
        elseif char.gender ~= "M" then
            gender = "masculino"
        elseif char.gender ~= "M" or "F" then
            gender = "outros"
        end
        local data = vRP.Query("nation_creator/get_bank",{ user_id = v.id })
        local bank = 0
        if data and data[1] then
            bank = data[1].bank
        end
        info.chars[k] = {
            name = v.name.." "..v.name2, age = v.age.." anos", bank = "$ "..format(bank), clothes = clothes,
            registration = Sanguine(v.blood), phone = v.phone, user_id = v.id, id = "#"..v.id, gender = gender, char = char
        }
    end
    info.maxChars = getUserMaxChars(source) 
    return info
end

function getUserMaxChars(source)
    local steam = getPlayerSteam(source)
    local Account = vRP.Account(steam)
    local amountCharacters = parseInt(Account["chars"])
    if vRP.steamPremium(steam) then
        amountCharacters = amountCharacters + 2
    end
    return amountCharacters 
end

function getUserClothes(user_id)
    local data = vRP.getUData(user_id, "Clothings")
    if data then
        return data
    end
    return {}
end

function getUserTattoos(user_id)
    local data = vRP.getUData(user_id,"Tatuagens")
    if data then
        local custom = data
        return custom or {}
    end
    data = vRP.getUData(user_id,"Tattoos")
    if data then
        local custom = data  
        return custom or {}
    end
    return {}
end

function isEmpty(t)
    if type(t) == "string" and t ~= "" then
        return false
    end
    for k,v in ipairs(t) do
        if v then
            return false
        end
    end
    return true
end

function getGender(user_id)
    local datatable = vRP.getUserDataTable(user_id) or vRP.getUData(user_id, "Datatable")
    -- if type(datatable) == "table" then
    local model = datatable.Skin or datatable.gender
    if model then
        if type(model) == "table" then
            model = model.modelhash or model.model
        end
        if model == GetHashKey("mp_m_freemode_01") or model == "mp_m_freemode_01" then
            return "male"
        elseif model == GetHashKey("mp_f_freemode_01") or model == "mp_f_freemode_01" then
            return "female"
        else
            return model
        end
    end
    -- end
end

function func.getOverlay()
    local source = source
    local user_id = vRP.Passport(source)
    if user_id then
        local char = getUserChar(user_id, source, true)
        if char and char.overlay then
            return char.overlay
        end
    end
    return 0
end




function func.playChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.Query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    if #data > 0 then
        -- TriggerEvent("baseModule:idLoaded",source,info.user_id,nil)
        vRP.CharacterChosen(source,info.user_id,nil)
        local user_id = vRP.Passport(source)
        local ip = GetPlayerEP(source) or '0.0.0.0'
        vRP.sendLog('joins', '[ID]: '..user_id..' \n[IP]: '..ip..' \n[======ENTROU NO SERVIDOR======]'..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), true)
        playerSpawn(info.user_id, source, true)
    end
end


function func.tryDeleteChar(info)
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.Query("nation_creator/get_character",{ steam = steam, user_id = info.user_id })
    return false, "Não permitido"
end

function func.tryCreateChar()
    local source = source
    local steam = getPlayerSteam(source)
    local data = vRP.Query("nation_creator/get_characters",{ steam = steam })
    if #data < getUserMaxChars(source)  then -- limite de personagens
        vRP.Query("nation_creator/create_characters",{ steam = steam, name = "Individuo", name2 = "Indigente", phone = vRP.GeneratePhone(), blood = math.random(4) })
        local myChars = vRP.Query("nation_creator/get_characters",{ steam = steam })
        local user_id = myChars[#myChars].id
        if user_id  then
            local Model = "mp_m_freemode_01"
            vRP.CharacterChosen(source,user_id,Model)
            return true
        end
    end
end


function getPlayerSteam(source)
    --[[ local identifiers = GetPlayerIdentifiers(source)
    for k,v in ipairs(identifiers) do
        if string.sub(v,1,5) == "steam" then
            return splitString(v,":")[2]
        end
    end ]]
    return vRP.Identities(source)
end


--[[RegisterCommand("char", function(source) -- setar as customizações dnv (tipo bvida)
local user_id = vRP.Passport(source)
local char = getUserChar(user_id, source)
if char then
    fclient._setPlayerChar(source, char, true)
    TriggerClientEvent("nation_barbershop:init", source, char)
    setPlayerTattoos(source, user_id)
    fclient._setClothing(source, getUserClothes(user_id))
end
end)]]

RegisterCommand('resetchar',function(source, args) -- COMANDO DE ADMIN PARA RESETAR PERSONAGEM
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport, "Admin", 1) or vRP.HasGroup(Passport, "Moderador") or vRP.HasGroup(Passport, "Suporte") then
        if args[1] then 
            local id = tonumber(args[1])
            if id then
                local src = vRP.Source(id)
                if src and vRP.Request(source, "Deseja resetar o id "..id.." ?", "Sim", "Não") then
                    fclient._startCreator(src)
                end
            end
        elseif 
        vRP.Request(source, "Deseja resetar seu personagem ?", "Sim", "Não") then
            fclient._startCreator(source)
        end
    end
end)

RegisterCommand('spawn',function(source)
    local Passport = vRP.Passport(source)
    if vRP.HasGroup(Passport,"Admin", {1,2,3}) then
        if multiCharacter then
            -- vRP.playerDropped(source,"Trocando Personagem.")
            Wait(1000)
            TriggerClientEvent("spawn:setupChars", source)
        else
            playerSpawn(vRP.Passport(source), source, true)
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REesetandoplayer
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("nation:resetplayer")
AddEventHandler("nation:resetplayer",function(source,user_id)
    if source ~= nil then
        fclient._startCreator(source)
    end
end)







