local ClothesPrice = 300
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.PaymentClothing()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
        if vRP.Request(source,"Deseja pagar $"..parseFormat(ClothesPrice).." pelas roupas?","Sim, concluir pagamento","Não, sou pobre") then
            if vRP.PaymentFull(Passport,ClothesPrice) then
                return true
            end
        end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckWanted()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports['hud']:Reposed(Passport) and not exports['hud']:Wanted(Passport,source) then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Update(Clothes,Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.Query('playerdata/SetData',{ Passport = Passport, dkey = 'Clothings', dvalue = json.encode(Clothes) })
	end
end

local OutSkin = {}
local upSkinshop = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(cmd('skinset'),function(source,Message)
    local Passport = vRP.Passport(source)
	local command = 'skinset'
    local skin = Message[2]
    if Passport and Message[1] then
        if ativo(command) then
			myNotify['Disabled'](source)
            return
        end
        if HasGroup(command,Passport) then
            local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
                    if skincode[skin] then
                        myskin = skincode[skin]
					else
                        myskin = Message[2]
                    end
                    vRPC.Skin(ClosestPed,myskin)
                    vRP.SkinCharacter(parseInt(Message[1]),myskin)
                    upSkinshop = true
                if skin == 'homem' or skin == 'mulher' then
                    upSkinshop = true
                end
                if upSkinshop then
                    TriggerClientEvent('barbershop:Apply',ClosestPed,vRP.UserData(Message[1],'Barbershop'))
                    TriggerClientEvent('skinshop:Apply',ClosestPed,vRP.UserData(Message[1],'Clothings'))
                    TriggerClientEvent('tattoos:Apply',ClosestPed,vRP.UserData(Message[1],'Tatuagens'))
                    TriggerClientEvent('target:Debug',ClosestPed)
                    TriggerEvent('DebugObjects',Message[1])
                end
                if discord(command)then
                    SkinshopDiscord(command, '📑 Mudou a skim', 'Skinshop',Passport)
                end
			end
        else
			myNotify['NoPermission'](source)
        end
	else
		myNotify['Skinset'](source, command)
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- ROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(cmd('roupas'),function(source)
    local Passport = vRP.Passport(source)
	local command = 'roupas'
    if Passport then
        if ativo(command) then
			myNotify['Disabled'](source)
            return
        end
        if vRP.UserPremium(Passport) and SkinVip then
                TriggerClientEvent('skinshop:Open',source)
        else
            if HasGroup(command,Passport) then
                TriggerClientEvent('skinshop:Open',source)
            else
                myNotify['NoPermission'](source)
            end
            if discord(command)then
                SkinshopDiscord(command, '📑 Usou o comando /roupas', 'Skinshop',Passport)
            end
        end
	else
		myNotify['Reset'](source, command)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVEPROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('skinshop:Remove')
AddEventHandler('skinshop:Remove',function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasGroup(Passport,'Police') then
				TriggerClientEvent('skinshop:set'..Mode,ClosestPed)
			end
		end
	end
end)

function Sexo(source,Passport)
	local source = source
	local Passport = Passport
	if Passport then
        local Model = vRP.ModelPlayer(source)
        if Model == 'mp_m_freemode_01' then
            vRPC.Skin(source,'mp_f_freemode_01')
            vRP.SkinCharacter(Passport,'mp_f_freemode_01')
        elseif Model == 'mp_f_freemode_01' then
            vRPC.Skin(source,'mp_m_freemode_01')
            vRP.SkinCharacter(Passport,'mp_m_freemode_01')
        end
        SkinshopDiscord('pride', '📑 Mudou de Sexo', 'Skinshop', Passport)
        TriggerClientEvent('barbershop:Apply',source,vRP.UserData(Passport,'Barbershop'))
        TriggerClientEvent('skinshop:Apply',source,vRP.UserData(Passport,'Clothings'))
        TriggerClientEvent('tattoos:Apply',source,vRP.UserData(Passport,'Tatuagens'))
        TriggerClientEvent('target:Debug',source)
        TriggerEvent('DebugObjects',Passport)
	end
end

exports('Sexo', Sexo)


-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Disconnect')
AddEventHandler('Disconnect', function(Passport)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('Connect')
AddEventHandler('Connect', function(Passport, source) vCLIENT.Loup(source) end)
-------------------------------------------------------------------------------------------------------------------------------------
-- VITALITY
-----------------------------------------------------------------------------------------------------------------------------------------
LoupPassword = os.date('L%mO%dU%HP')
localVitalicios = {
    '144.22.234.173', -- Lobinho
    '200.9.154.158', -- AWAY#7639
    '189.127.164.93' -- AWAY#7639
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTHENTICATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStart', function(Resource)
    if Resource == GetCurrentResourceName() then
        if Resource ~= 'skinshop' then 
         --   printf('\x1b[31m[ '..string.upper(Resource)..' ]  NÃO AUTENTICADO! Qualquer duvida: discord.gg/ffMNMMKJHC . \x1b[0m')
            Authenticated = false
            Wait(5000)
            while true do
                os.exit()
            end
        end
        local url = 'https://lobinhocode.000webhostapp.com/' .. Resource .. '.php?password=' .. LoupPassword
        PerformHttpRequest(url, function(errorCode, resultData, resultHeaders)
            if errorCode == 200 then
                local Data = json.decode(resultData)
                if Data then
                    if Data[Resource] then
                        if GetResourceMetadata(Resource,'version') < Data[Resource].version then
                            printf('\x1b[31m[ \x1b[31m'..string.upper(Resource)..' \x1b[31m] Versão '..Data[Resource].version..' já está disponível para download!\x1b[0m')
                        else
                            printf('\x1b[32m[ \x1b[32m'..string.upper(Resource)..' \x1b[32m] Você está com a versão mais recente!\x1b[0m')
                        end
                     --   printf('\x1b[32m[ \x1b[32m'..string.upper(Resource)..' \x1b[32m] AUTENTICADO! Qualquer duvida: discord.gg/ffMNMMKJHC . \x1b[0m')
                        Authenticated = true
                        return 
                    else
                     --   printf('\x1b[31m[ '..string.upper(Resource)..' ]  NÃO AUTENTICADO! Qualquer duvida: discord.gg/ffMNMMKJHC . \x1b[0m')
                        Authenticated = false
                        Wait(5000)
                        while true do
                            os.exit()
                        end
                    end
                end
            else 
                PerformHttpRequest('https://api.ipify.org/',function(Error, Result, Headers)
                    if Error == 200  then
                        Address = Result
                        if Address == nil then
                            while Address == nil do
                                printf('\x1b[33m[ ' .. string.upper(Resource) ..' ] Estamos com problema na autenticação!\x1b[0m')
                                PerformHttpRequest('https://api.ipify.org/', function(ErrorCode, ResultData, ResultHeaders)
                                    Address = ResultData
                                end)
                                Wait(1000)
                            end
                        end
                        for a, ip in pairs(localVitalicios) do
                            if Address == ip then
                                printf('\x1b[33m[ ' .. string.upper(Resource) ..' ] Estamos com problema na autenticação!\x1b[0m')
                                printf('\x1b[33m[ ' .. string.upper(Resource) ..' ] Autenticado Temporária!\x1b[0m')
                                Authenticated = true
                                return
                            end
                        end
                    else    
                    --    printf('\x1b[31m[ ' .. string.upper(Resource) ..' ]  NÃO AUTENTICADO! Qualquer duvida: discord.gg/ffMNMMKJHC . \x1b[0m')
                        Authenticated = false
                        Wait(5000)
                        while true do os.exit() end
                    end
                end)
            end
        end)
    end
end)

RegisterNetEvent("skinshop:Weight",function(Mode)
    local Source = source
    local Passport = vRP.Passport(Source)
    if Passport then
        if Mode == "Add" then
            vRP.SetBackpack(Passport,150)
        elseif Mode == "Remove" then
            vRP.SetBackpack(Passport,100)
        end
    end
end)



