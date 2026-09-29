local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vCLIENT = Tunnel.getInterface("faly_animacoes")

faly = {}
Tunnel.bindInterface("faly_animacoes",faly)

--[ E ]-- ANIMACAO SOLO
RegisterCommand('a', function(source,args,rawCommand)
	-- if not vRPclient.checkAcao(source) then
		TriggerClientEvent("emotes",source,args[1])
	-- end
end)



--[ E ]-- ANIMACAO SOLO

--[ E2 ]-- ANIMAÇÃO EM 2
RegisterCommand("e2",function(source,args,rawCommand)
	local user_id = vRP.Passport(source)
	if user_id then
		if vRP.HasGroup(user_id,"Admin") then
			if vRPclient.GetHealth(source) > 101 then
				local nplayer = vRPclient.ClosestPed(source,2)
				if nplayer then
					TriggerClientEvent("emotes",nplayer,args[1])
				end
			end
		end
	end
end)
--[ E2 ]-- ANIMAÇÃO EM 2

--[ E3 ]-- FORMAR ANIMAÇÂO EM UM ID
RegisterCommand('e3', function(source,args,rawCommand)
	local source = source
	local user_id = vRP.Passport(source)
	if vRP.HasGroup(user_id,"Admin") then
		local id = tonumber(args[1])
		if id then
			local nplayer = vRP.Source(parseInt(id))
			if nplayer then
				TriggerClientEvent("emotes",nplayer,args[2])
			end
		end
	end
end)
--[ E3 ]-- FORMAR ANIMAÇÂO EM UM ID






--[ REFÉM ]--
RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
	TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
end)
--[ REFÉM ]--


--[ PANO ]--
RegisterServerEvent("tryclean")
AddEventHandler("tryclean",function(nveh)
	TriggerClientEvent("syncclean",-1,nveh)
end)
--[ PANO ]--


--[ ANIM COMPARTILHADA ]--
-- RegisterCommand('beijar', function(source,args,rawCommand)
-- 	local nplayer = vRPclient.getClosestPed(source,2)
-- 	local source = source
-- 	local user_id = vRP.Passport(source)
-- 	local identity = vRP.Identity(user_id)
-- 	if nplayer then
-- 		if vRP.request(nplayer,"Deseja beijar <b>"..identity.name.." "..identity.firstname.."</b> ?", 1500) then
-- 			TriggerClientEvent("syncanim",source, 1.3)
-- 			TriggerClientEvent("beijar",source)
-- 			TriggerClientEvent("beijar",nplayer)
-- 		else
-- 			TriggerClientEvent("Notify",source,"amarelo","A pessoa negou o beijo!",1)
-- 		end
-- 	else
-- 		TriggerClientEvent("Notify",source,"amarelo","Nenhum player próximo!",1)
-- 	end
-- end)


-- RegisterCommand('abracar', function(source,args,rawCommand)
-- 	local nplayer = vRPclient.getClosestPed(source,2)
-- 	local source = source
-- 	local user_id = vRP.Passport(source)
-- 	local identity = vRP.Identity(user_id)
-- 	if vRP.request(nplayer,"Deseja cumprimentar <b>"..identity.name.." "..identity.firstname.."</b> ?",15) then
-- 		TriggerClientEvent("syncanim",source, 0.8)
-- 		TriggerClientEvent("abracar",source)
-- 		TriggerClientEvent("abracar",nplayer)
-- 	else
-- 		TriggerClientEvent("Notify",source,"amarelo","A pessoa negou o abraço!",1)
-- 	end
-- end)
--[ ANIM COMPARTILHADA ]--