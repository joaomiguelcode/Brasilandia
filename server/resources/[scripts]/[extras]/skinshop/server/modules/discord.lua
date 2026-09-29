

function SendDiscordsSkinshop(WebHooks, Passport, Title, Description, Color, Image)
    local player = vRP.Source(Passport)
    local Author = emoji(Passport) .. ' › **Passaporte: ` ' .. Passport .. ' `**'
    local cmdIdentity = vRP.Identity(Passport)
    local cmdName = cmdIdentity.name .. ' ' .. cmdIdentity.name2
    local cmdPed = GetPlayerPed(player)
    local cmdCoords = GetEntityCoords(cmdPed)
    local InfoPlayer = '  › Passaporte: ' .. Passport .. '\n    › Nome: ' .. emoji(Passport) .. ' ' .. cmdName .. '\n    › Cordenadas: ' .. mathLength(cmdCoords['x']) .. ',' .. mathLength(cmdCoords['y']) .. ',' .. mathLength(cmdCoords['z']) .. '\n'
    local Message = Author .. ' ```' .. Title .. '\n--------------------------------------------- \n' .. InfoPlayer .. '```\n' .. Description .. '\n '    
    TriggerEvent('DiscordsSkinshop', WebHooks, Message, Color, Image) 
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD ADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('DiscordsSkinshop',function(WebHooks,Message,Color,Image)
	PerformHttpRequest(DiscordsSkinshop[WebHooks],function(err,text,headers) end,'POST',json.encode({
		avatar_url = 'https://cdn.discordapp.com/attachments/1073567170400878723/1073569568339017829/iconrotas.png',
		username = 'ROUTES',
		embeds = { { color = Color, description = Message, image = { url = Image }  } }
	}),{ ['Content-Type'] = 'application/json' })
end)

