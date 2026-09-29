-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGA EMOJI DO COMANDO
-----------------------------------------------------------------------------------------------------------------------------------------
function emoji(Passport)
	local Pass = tostring(Passport)
	if Staffs[Pass] then
		local emoji = Staffs[Pass].emoji
		if emoji == '' then
			return '🚻'
		else
			return emoji				
		end
	end
	return '🚻'
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MUDA A COR DO DISCORD AZUL E PRETO
-----------------------------------------------------------------------------------------------------------------------------------------
function colorblueblack(last_color)
	local color = math.random(0, 1)
	if color == 0 then
		color = 21247
	else
		color = 2369063
	end
	while color == last_color do
		color = math.random(0, 1)
		if color == 0 then
			color = 21247
		else
			color = 2369063
		end
	end
	return color
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function SkinshopDiscord(WebHooks,Info,Title,Passport)
	
	local source = source
	local Passport =  Passport
    local Image = 'https://cdn.discordapp.com/attachments/1073567170400878723/1074824373959143444/skinshop.png'
	if Passport then
		Color = colorblueblack(Last_Color)
		Last_Color = Color
		Description = '``` \n    › '..Info..' \n ```'
        SendDiscordsSkinshop(WebHooks, Passport, Title, Description, Color, Image)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO
-----------------------------------------------------------------------------------------------------------------------------------------
function cmd(command)
	if commands[command] then
		return commands[command].cmd
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO ATIVO
-----------------------------------------------------------------------------------------------------------------------------------------
function ativo(command)
	if commands[command] then
		if commands[command].ativo == 'true' then
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICA LOG ATIVO
-----------------------------------------------------------------------------------------------------------------------------------------
function discord(command)
	if commands[command] then
		if commands[command].log == 'true' then
			return true
		end
	end
	return false
end

	-----------------------------------------------------------------------------------------------------------------------------------------
	-- VERIFICA PERMISSÃO
	-----------------------------------------------------------------------------------------------------------------------------------------
function HasGroup(command,Passport)
	if commands[command] then
		-------------
		if vRP.HasGroup(Passport, 'off-Admin') and not vRP.HasGroup(Passport, 'Owner') then -- bloqueia o acesso do off-Admin
			return false
		end
		-------------
		local permissions = commands[command].permissions -- pega o permissao do comando
		if permissions == '' then -- se nao tiver permissao libera o acesso
			return true
		else   
			local level = parseInt(commands[command].level)  -- pega o level do comando 1
			if level > 0 then
				if parseInt(vRP.HasPermission(Passport,permissions)) <= level and parseInt(vRP.HasPermission(Passport,permissions)) > 0  then -- verifica se o level do player é menor ou igual ao level do comando
					return true
				elseif Passport == 1 then -- se o player for o dono libera o acesso
					return true
				end
			else
				if vRP.HasGroup(Passport,permissions) then -- verifica se o player tem a permissao do comando
					return true
				end
			end
		end
	end
	return false
end