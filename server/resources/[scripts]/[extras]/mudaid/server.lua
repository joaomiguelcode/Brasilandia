
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------
--Durateston Connection------------------------------------------------------------------
-----------------------------------------------------------------------------------------
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

MudarID = {}
Tunnel.bindInterface(GetCurrentResourceName(),MudarID)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Extract Discord
-----------------------------------------------------------------------------------------------------------------------------------------
local function extractDiscord(src)
    local discord = ""

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id,"discord") then
            discord = id
        end
    end

    return discord
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRACTIDENTIFIERS
-----------------------------------------------------------------------------------------------------------------------------------------
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end


function sendLogs(user_id,data)
    local source = source
    local user_id = parseInt(user_id)
    local identity = Identity(user_id) or {name= "Não registrado", firstname= "Não registrado"}
    local sourceUser = Source(user_id)
    local infos 
    if not sourceUser then
        infos = 'Sem discord discord:'
    else
        infos = extractDiscord((user_id))
    end
    
    PerformHttpRequest(Config.Logs[data.webhook], function(err, text, headers)
    end, "POST", json.encode({
        embeds = {
            {
                title = "LOGS",
                -- title = ..identity.name.." ".. identity.firstname..),
                --    description = "**ID:** "..user_id.."\n**NOME:** "..identity.name.." ".. identity.firstname.."\n**DISCORD:** <@"..infos:gsub("discord:", "")..">\n\n```"..data.text.."\n```",
                description = " Passaporte: "..user_id.."\nNome: "..identity.name.." \nDiscord: <@"..infos:gsub("discord:", "")..">\n\n"..data.text.."\n",
                thumbnail = {
                    url = ""
                },
                footer = {
                    text = ''..os.date("\n[Data]: %d/%m/%Y | [Hora]: %H:%M:%S"),
                    icon_url = ""
                },
                color = 3092790
            }
        }}), { ['Content-Type'] = 'application/json' })
    end
    
    

 
function KickPlayer(nuser_id)
    local source = Source(tonumber(nuser_id))
    DropPlayer(source,"Mudando ID")
end
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
Notify = function(source,type,text,time)
    TriggerClientEvent("Notify",source,tipo,text,time)
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

getUserId = function(source)
    if Config.FrameWork == "network" then
        return vRP.Passport(source)
    elseif Config.FrameWork == "v5" then
        return vRP.getUserId(source) 
    elseif Config.FrameWork == "vrpex" then
        return vRP.getUserId(source)
    end
    print("Error FrameWork não foi informado Corretamente, FrameWorks Corretos: Creative network = network,   Vrpex = vrpex,   Creative v5 = v5")
    return false
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

HasGroup = function(user_id,group)
    if Config.FrameWork == "network" then
        return vRP.HasGroup(user_id,group,1)
    elseif Config.FrameWork == "v5" then
        return vRP.HasGroup(user_id,group)
    elseif Config.FrameWork == "vrpex" then
        return true---vRP.HasGroup(user_id,group)
    end
    print("Error ao tentar Identificar o FrameWork Erro: HasGroup")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

Source = function(user_id)
    if Config.FrameWork == "network" then
        return vRP.Source(tonumber(user_id))
    elseif Config.FrameWork == "v5" then
        return Source(tonumber(user_id))
    elseif Config.FrameWork == "vrpex" then
        return Source(tonumber(user_id))
    end
    print("Error ao tentar Identificar o FrameWork Erro: Source Player")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

getBankMoney = function(user_id)
    local user_id = tonumber(user_id)
    if Config.FrameWork == "network" then
        local source = Source(user_id)
        return vRP.GetBank(source)
    elseif Config.FrameWork == "v5" then
        return 
    elseif Config.FrameWork == "vrpex" then
        return vRP.getBankMoney(user_id)
    end
    print("Error ao tentar Identificar o FrameWork Erro: GetBankMoney")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

RequestSystem = function(source,msg)
    if Config.FrameWork == "network" then
        return vRP.Request(source,msg,"Sim, aceito","Não, obrigado")
    elseif Config.FrameWork == "v5" then
        return vRP.request(source,msg,"Sim, aceito","Não, obrigado")
    elseif Config.FrameWork == "vrpex" then
        return vRP.request(source,"<b>"..msg.."</b> ?",30)
    end
    print("Error ao tentar Identificar o FrameWork Erro: GetMoney")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--asdasdas--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

PaymentBank = function(user_id,value)
    if Config.FrameWork == "network" then
        return vRP.RemoveBank(user_id,value)
    elseif Config.FrameWork == "v5" then
        return 
    elseif Config.FrameWork == "vrpex" then
        return vRP.tryPayment(user_id,value)
    end
    print("Error ao tentar Identificar o FrameWork Erro: Payment")
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Identity--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------
Identity = function(user_id)
    local emptyTable = {}
    local user_id = tonumber(user_id)
    if Config.FrameWork == "network" then
        local identity = vRP.Identity(user_id)
        if identity then
            emptyTable = {
                ["name"] = "Nome: "..identity.name.." "..identity.name2,
                ["phone"] = "Phone: "..identity.phone,
                ["bank"] = "Bank: "..identity.bank,
                ["sex"] = " ", --  se na sua base tiver o sexo do jogador coloque aqui
            }
        else
            emptyTable = {
                ["name"] = "Nome: Desconhecido",
                ["phone"] = "Phone: Desconhecido",
                ["bank"] = "Banco: Desconhecido",
                ["sex"] = " ", --  se na sua base tiver o sexo do jogador coloque aqui
            }
        end
        return emptyTable
        
    elseif Config.FrameWork == "v5" then
        return 
    elseif Config.FrameWork == "vrpex" then
        local query = exports["oxmysql"]:executeSync("SELECT * FROM vrp_user_identities WHERE user_id = ?",{user_id})  
        if query[1] then
           for k,v in pairs(query) do
            emptList = {
                ["name"] = "Nome: "..v.name.." "..v.firstname,
                ["phone"] = "Phone: "..v.phone,
                ["bank"] = "Bank: "..getBankMoney(user_id),
                ["sex"] = " ", --  se na sua base tiver o sexo do jogador coloque aqui
            }
           end  
            return emptList
        else
        emptList = {
            ["name"] = "Nome: Desconhecido",
            ["phone"] = "Nome: Desconhecido",
            ["bank"] = "Nome: Desconhecido",
            ["sex"] = " ", --  se na sua base tiver o sexo do jogador coloque aqui
        }
        return emptList
        end
    end
    print("Error ao tentar Identificar o FrameWork Erro: Identity")
end


function GenerateRelatoryVehicles(old_id,new_id)
    local newIdExist = exports["oxmysql"]:executeSync("SELECT * FROM vehicles WHERE Passport = @old_id", { old_id = old_id})
    local emptyString = ""
    if newIdExist[1] then
        emptyString = emptyString.."Passaporte "..old_id.." \n" .."Veiculos Registrados e Passados para o "..new_id.." \n"
        for k,v in pairs(newIdExist) do
            emptyString = emptyString.."\n Nome do Veiculo: "..v.vehicle.." \n ".." Taxa: "..v.tax.." \n ".." Placa: "..v.plate.." \n Vehicle Rental "..v.rental.." \n Vehicle Arrest "..v.arrest.."\n-----------------------------------------------"
        end
    else
        sendLogs(old_id,{webhook = "relatory",text = "Jogador Não possui veiculos no nome"})
        return
    end
    sendLogs(old_id,{webhook = "relatory",text = emptyString})
end

function generatyRelatoryinfosPlayer(old_id,new_id)
    local newIdExist = exports["oxmysql"]:executeSync("SELECT * FROM characters WHERE id = @old_id", { old_id = old_id})
    local emptyString = ""
    if newIdExist[1] then
        emptyString = emptyString.."Passaporte "..old_id.." \n" .."Informações Registrados e Passados para o "..new_id.." \n"
        for k,v in pairs(newIdExist) do
            emptyString = emptyString.."\n Nome do Jogador: "..v.name.." "..v.name2.." \n ".." Banco: "..v.bank.." \n ".." SEX: "..v.sex.." \n Fines: "..v.fines.." \n-----------------------------------------------"
        end
    else
        sendLogs(old_id,{webhook = "relatory",text = "Jogador Não possui veiculos no nome"})
        return
    end
    sendLogs(old_id,{webhook = "relatory",text = emptyString})
end


function generateGroupsInfo(old_id,new_id)
    local emptyString = ""
    emptyString = emptyString.."Passaporte "..old_id.." \n" .."Grupos Registrados e Passados para o "..new_id.." \n"
    local Groups = vRP.Groups()
    for Permission,_ in pairs(Groups) do
        local Data = vRP.DataGroups(Permission)
        if Data[tostring(old_id)] then
            emptyString = emptyString.."\n Grupo: "..Permission.." ".." Hierarquia: "..Groups[Permission]["Hierarchy"][tonumber(Data[tostring(old_id)])]
        end
    end
    sendLogs(old_id,{webhook = "relatory",text = emptyString})
end

function generateRelatoryPropertys(old_id,new_id)
    local emptyString = ""
    local newIdExist = exports["oxmysql"]:executeSync("SELECT * FROM propertys WHERE Passport = @old_id", { old_id = old_id})
    if newIdExist[1] then
        emptyString = emptyString.."Passaporte Antigo: "..old_id.." \n" .." Casas Registradas e Passados para o "..new_id.." \n"
        for k,v in pairs(newIdExist) do
            emptyString = emptyString.."\n Id da casa: "..v.id.." \n Nome do Interior: "..v.Interior.." \n ".." Taxa em os.time(): "..v.Tax.."\n-----------------------------------------------"
        end
    else
        sendLogs(old_id,{webhook = "relatory",text = "Jogador não possui residencias"})
        return
    end
    sendLogs(old_id,{webhook = "relatory",text = emptyString})
end

---------------------------------------
-------- Mudar ID ---------------------
---------------------------------------
function MudarID.UpdateID(old_id,newID)
    local old_id = tonumber(old_id)
    local newId = tonumber(newID)
    local source = source
    local user_id = getUserId(source)
    local permission = false
    if user_id then
        for k,v in pairs(Config.PermissionUpdateID) do
            if HasGroup(user_id,v) then
                permission = true
            end
        end

        if permission then
            if RequestSystem(source,"Deseja realmente Mudar o ID do Cidadão de "..old_id.." Para "..newId) then
                
                if not old_id or not newId then
                    TriggerClientEvent("Notify", source, "amarelo", "Alguns Dados estão faltando", 5000)
                    print("^1[ERRO] ^7Alguns dados estão faltando.")
                    return
                end
                
                local newIdExist = exports["oxmysql"]:executeSync("SELECT id FROM characters WHERE id = @newId", { newId = newId})
                if newIdExist[1] then
                    TriggerClientEvent("Notify", source, "amarelo", "O Novo id informado ja existe", 5000)
                    print("O Novo Id Recebido Ja existe")
                    return
                end
                
                if Source(old_id) then
                    TriggerClientEvent("Notify", source, "amarelo", "Mudando Id não entre", 5000)
                    DropPlayer(Source(old_id),"Mudando ID Não entre em 1 minuto")
                end
                
                Citizen.Wait(5000)
                print("iniciando alteração")
                if Config.FrameWork == "vrpex" then
                    exports["oxmysql"]:query("UPDATE `vrp_user_identities` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vrp_user_data` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vrp_user_moneys` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vrp_user_vehicles` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payee_id` = @newId WHERE `payee_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payer_id` = @newId WHERE `payer_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_blocks` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_gallery` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_instagram` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_olx` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_tinder` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_twitter_profiles` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                elseif Config.FrameWork == "network" then
                    GenerateRelatoryVehicles(old_id,newId)
                    Citizen.Wait(2000)
                    generatyRelatoryinfosPlayer(old_id,newId)
                    Citizen.Wait(2000)
                    generateGroupsInfo(old_id,newId)
                    Citizen.Wait(2000)
                    generateRelatoryPropertys(old_id,newId)
                    Citizen.Wait(5000)
                    local Groups = vRP.Groups()
                    for Permission,_ in pairs(Groups) do
                        local Data = vRP.DataGroups(Permission)
                        if Data[tostring(old_id)] then
                            vRP.SetPermission(newId,Permission,tonumber(Data[old_id]))
                            Citizen.Wait(500)
                            vRP.RemovePermission(old_id, Permission)
                        end
                    end
                    Citizen.Wait(5000)
                    exports["oxmysql"]:query("UPDATE `characters` SET `id` = @newId WHERE `id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `playerdata` SET `Passport` = @newId WHERE `Passport` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `propertys` SET `Passport` = @newId WHERE `Passport` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vehicles` SET `Passport` = @newId WHERE `Passport` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payee_id` = @newId WHERE `payee_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payer_id` = @newId WHERE `payer_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_blocks` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_gallery` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_instagram` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_olx` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_tinder` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_twitter_profiles` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    Citizen.Wait(1000)
                    print("alterado com sucesso")
                elseif Config.FrameWork == "creativev5" then
                    exports["oxmysql"]:query("UPDATE `characters` SET `id` = @newId WHERE `id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vrp_user_data` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vrp_user_moneys` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query("UPDATE `vehicles` SET `Passport` = @newId WHERE `Passport` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payee_id` = @newId WHERE `payee_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_bank_invoices` SET `payer_id` = @newId WHERE `payer_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_blocks` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_gallery` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_instagram` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_olx` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_tinder` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                    exports["oxmysql"]:query_async("UPDATE `smartphone_twitter_profiles` SET `user_id` = @newId WHERE `user_id` = @old_id",{ newId = newId, old_id = old_id })
                end
            end
        end
    end
end

---------------------------------------
-------- Mudar Numero de Telefone ----
---------------------------------------
function MudarID.UpdatePhone(nuser_id,old_phone,new_phone)
    local nuser_id = tonumer(nuser_id)
    local source = source
    local user_id = getUserId(source)
    local permission = false
    if user_id then
        for k,v in pairs(Config.PermissionUpdateID) do
            if HasGroup(user_id,v) then
                permission = true
            end
        end
        if permission then
            if Config.FrameWork == "vrpex" then
                KickPlayer(nuser_id)
                Citizen.Wait(500)
                local userPhone = exports["oxmysql"]:executeSync([[SELECT `phone` FROM vrp_user_identities WHERE `user_id` = :user_id]], { user_id = user_id})[1].phone
                if userPhone then 
                    local queries = {
                        { query = 'UPDATE smartphone_contacts SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_whatsapp SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_calls SET `initiator` = :phone WHERE `initiator` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_calls SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_whatsapp_groups SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE smartphone_whatsapp_messages SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                        { query = 'UPDATE vrp_user_identities SET `phone` = :phone WHERE user_id = :user_id', values = { ['phone'] = new_phone, ['user_id'] = user_id, ['oldPhone'] = old_phone } },
                    }
                    local result = exports.oxmysql:transactionSync(queries)
                end
            elseif Config.FrameWork == "network" then
                KickPlayer(nuser_id)
                Citizen.Wait(500)
                local userPhone = exports["oxmysql"]:executeSync([[SELECT `phone` FROM characters WHERE `id` = :user_id]], { user_id = user_id})[1].phone
                if userPhone then 
                    local queries = {
                        { query = 'UPDATE smartphone_contacts SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_calls SET `initiator` = :phone WHERE `initiator` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_calls SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_groups SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_messages SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE vrp_user_identities SET `phone` = :phone WHERE user_id = :user_id', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                    }
                    local result = exports.oxmysql:transactionSync(queries)
                end
            elseif Config.FrameWork == "creativev5" then
                KickPlayer(nuser_id)
                Citizen.Wait(500)
                local userPhone = exports["oxmysql"]:executeSync([[SELECT `phone` FROM vrp_user_identities WHERE `user_id` = :user_id]], { user_id = user_id})[1].phone
                if userPhone then 
                    local queries = {
                        { query = 'UPDATE smartphone_contacts SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_calls SET `initiator` = :phone WHERE `initiator` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_calls SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_channels SET `target` = :phone WHERE `target` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_groups SET `owner` = :phone WHERE `owner` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE smartphone_whatsapp_messages SET `sender` = :phone WHERE `sender` = :oldPhone', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                        { query = 'UPDATE vrp_user_identities SET `phone` = :phone WHERE user_id = :user_id', values = { ['phone'] = phone, ['user_id'] = user_id, ['oldPhone'] = userPhone } },
                    }
                    local result = exports.oxmysql:transactionSync(queries)
                end
            else
                print("FrameWork Informado Incorreto tente : vrpex,creativev5,network")
            end
        end
    end
end


RegisterCommand(Config.CommandUpdateId,function(source)
    local source = source
    local user_id = getUserId(source)
    local permission = false
    if user_id then
        for k,v in pairs(Config.PermissionUpdateID) do 
            if HasGroup(user_id,v) then
                permission = true
            end
        end
        if permission then
            vCLIENT.OpenSistem(source,"mudarID")
        end
    end
end)



RegisterCommand(Config.CommandUpdatePhone,function(source)
    local source = source
    local user_id = getUserId(source)
    local permission = false
    if user_id then
        for k,v in pairs(Config.PermissionUpdateID) do 
            if HasGroup(user_id,v) then
                permission = true
            end
        end
        if permission then
            vCLIENT.OpenSistem(source,"MudarPhone")
        end
    end
end)


function MudarID.getPlayerInfo(id)
    local id = tonumber(id)
    local source = source
    local user_id = getUserId(source)
    if user_id then
        return Identity(tonumber(id))
    end
end