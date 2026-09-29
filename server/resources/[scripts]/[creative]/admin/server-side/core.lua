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
Creative = {}
Tunnel.bindInterface("admin",Creative)
vCLIENT = Tunnel.getInterface("admin")
vKEYBOARD = Tunnel.getInterface("keyboard")

local webhookItem = "https://discord.com/api/webhooks/1155796767238000773/khMWkpY1JXnhlVimUoBY31C9rH7JgXUEVkdmJ3YOmETro8lFboGR6Ean-eFn_nBJzsgO"
local webhookclearinv = "https://discord.com/api/webhooks/1155796871869108226/JlSCMJrUw6f68aUhIAt7gAYIhLFSvQW7lGGysTfP-GmFBvPGgW-wXIX8KEedhrAZPEgk"
local webhookblips = "https://discord.com/api/webhooks/1155797276795621499/2IL4tO_oXy7_PDHEdx7-GBKO7jGhuzQpnmEd_9a7RekaioCVAaaO0Z3nOvZhK0Fy6JkJ"
local webhookanunciar = "https://discord.com/api/webhooks/1155797861741641728/B5UH4UbBbYYY6UxdulE1KwRrDOMMtn4WLm_BoMn0uVfaIp3r1yXrceVyyibcPfPOJhv8"
local webhookgod = "https://discord.com/api/webhooks/1155798011398586398/thfIDi5U0bcwkKsIlmf5he1xJfgDq-C4_GsYWmGn0rTBRTgvxap2_BW35LeeNIQwjxnF"
local webhooknc = "https://discord.com/api/webhooks/1155798115908071465/NpeP9sZqs1__pxHUN5zzoFJQReJIbAoHLVeirtwy7PYPLL0zruWgLmaHFdWr2VnA7PJz"
local webhookkick = "https://discord.com/api/webhooks/1155798263480463441/an6UQtnuEkVM2_yXsfRUb4OmC4_4vsUsAGO_aUgKSdC65AqUlUDIVK1825BUecdGVL9n"
local webhooktpway = "https://discord.com/api/webhooks/1155798471907999784/wI9D1nJi0D56VDXmM69czXgSarZDRQuyE-QzgtQOG_zcqChRqjD89OoYTRHib0MUOkCB"
local webhookfix = "https://discord.com/api/webhooks/1155799105235337256/2foJWclq51vPrxTF1eEOAQSRj98wc0LGsb0gH6LzJ5Gvbi1M6ADs7WY5FKe61WJDqy50"
local webhookannounce = "https://discord.com/api/webhooks/1155799330519781407/ASEUJEICMS02HRGUFVcaBngyOUJXwmInwJPV-Gr0ToeI2W8bKYZqIqiTg-L8QTTi2b-K"
local webhookannouncepolice = "https://discord.com/api/webhooks/1155799588247191614/hnpIY8Suxj8MbNTlWIezyF0jRoaQig2x271hlwa4y78E4OmdF0w4Y9HPJ_49L1WvqHzg"
local webhookitemall = "https://discord.com/api/webhooks/1155799860503658547/MJyYfFjszXZ5mn3830Z2kjRA8tQsNU8sX1-j-Pe5C_ttnCF65RpqIA_mxi0I6_mrUNP-"
local webhookaddcar = "https://discord.com/api/webhooks/1155799951062863914/vHTRkwQ4h_OVTfPHXlm8Xo6VkMtUwMgW-o6egwrMmAe8h0yBlHyFT6gOzCIFp8XBKY0b"
local webhookbanimentos = "https://discord.com/api/webhooks/1155800093824401431/g5TVwKcxG6e9ga4TvhaobBQscXIm5gK6P5rMesx3ODebgidoqYvHC7dYlTPAQCOvc9Es"
local webhookdesbanimentos = "https://discord.com/api/webhooks/1155800192986132520/UOpRXa10lgJO7rCVE0Ot7KkCLTr4HRsUiF_bISTkvBmyPsdzif1-o65hJc5h-EDGkWkU"
local webhooktpcds = "https://discord.com/api/webhooks/1155800349823750196/nc56-g56I0DEBdmNx_-9KoCkwuU5acY1tS22qLXIlPjE6rbwJ0TLHZFyRrYdMqRJ9gud"
local webhooktptome = "https://discord.com/api/webhooks/1155800434309611540/hhhe2Esk6xriXwNeZfPrPmJ5zqb5RvWf7iBZHVDbA-DTXwAuAwqZ7YgjqP9DHhitHfAp"
local webhooktpto = "https://discord.com/api/webhooks/1155800555709538385/sYFqtn11IsiSXXpGGxNwRE-GJ8zcejAHlZTpeyuuBYBLhKNhbOiewr5adpv3sypd77O-"
local webhookspectate = "https://discord.com/api/webhooks/1155800742339289211/PvE3orDliW0JuUjy4qk2g_xy5F9flioTEK9-0oJoPfNZEv00bugPv4fUR4AniES0nWRM"
local webhookgiveitem = "https://discord.com/api/webhooks/1155800937466691605/qWpUMTTmvHCXJVM9HndCPoGMdu-U4qcGMGtcYJ3rkOxnSb9LeVWT-1TPjdwEZxZWFixX"
local webhookvisto = "https://discord.com/api/webhooks/1155800937466691605/qWpUMTTmvHCXJVM9HndCPoGMdu-U4qcGMGtcYJ3rkOxnSb9LeVWT-1TPjdwEZxZWFixX"




-----------------------------------------------------------------------------------------------------------------------------------------
-- UGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("checkgroup",function(source,Message)    --------------- checar grupo de um ID  checkgroup ID 
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport, "Admin", 3) then
		if Passport and parseInt(Message[1]) > 0 then
			local Messages = ""
			local Groups = vRP.Groups()
			local OtherPassport = Message[1]
			for Permission,_ in pairs(Groups) do
				local Data = vRP.DataGroups(Permission)
				if Data[OtherPassport] then
					Messages = Messages..Permission.."<br>"
				end
			end
	
			if Messages ~= "" then
				TriggerClientEvent("Notify",source,"verde",Messages,10000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARINV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("clearinv",function(source,Message)   ----------- limpar inventario de ID
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin", 2) and parseInt(Message[1]) > 0 then
			TriggerClientEvent("Notify",source,"verde","Limpeza concluída.",5000)
			vRP.ClearInventory(Message[1])
			vRP.SendWebhook(webhookclearinv, "LOGs Clear INV", "**Passaporte: **"..Passport.."\n**Limpou o inv. de: ** "..Message[1], 3558275)
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- GEM
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pordimas",function(source,Message)     ----------- por moeda diamante em ID cargo Owner  /pordimas ID quantidade
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Owner") and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Amount = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				TriggerClientEvent("Notify",source,"verde","Gemas entregues.",5000)
				vRP.Query("accounts/AddGems",{ license = Identity["license"], gems = Amount })
				TriggerEvent("Discord","Gemstone","**Source:** "..source.."\n**Passaporte:** "..Passport.."\n**Para:** "..OtherPassport.."\n**Gemas:** "..Amount.."\n**Address:** "..GetPlayerEndpoint(source),3092790)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wall",function(source)   ---------- LIGAR WALL  
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			vRPC.BlipAdmin(source)
			vRP.SendWebhook(webhookblips, "LOGs blips", "**Passaporte: **"..Passport, 3558275)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciar",function(source)   ----------- /anunciar 
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Anúncio:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"admin",Keyboard[1].."<br><b>Anúncio Prefeitura</b>",40000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,Message)   -------- Levanta player desmaiado apenas.
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					-- vRP.RemAddiction(Passport)
					-- vRP.DowngradeAddiction(OtherPassport,100)
					vRP.Revive(ClosestPed,150)
				end
				vRP.SendWebhook(webhookgod, "LOGs god", "**Passaporte: **"..Passport.."\n**Deu GOD em: **"..Message[1], 10357504)
			else
				vRP.Revive(source,150)
				-- vRP.RemAddiction(Passport)
				-- vRP.DowngradeAddiction(Passport,100)

				TriggerClientEvent("paramedic:Reset",source)
				vRP.SendWebhook(webhookgod, "LOGs god", "**Passaporte: **"..Passport.."\n**Deu GOD em: ** nele mesmo", 10357504)

				vRPC.removeObjects(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("good",function(source,Message)   ---------- levante player desmaiado e restaura fome sede e colete /good ID 
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.UpgradeThirst(OtherPassport,100)
					vRP.UpgradeHunger(OtherPassport,100)
					vRP.DowngradeStress(OtherPassport,100)
					vRP.RemAddiction(OtherPassport)
					vRP.DowngradeAddiction(OtherPassport,100)
					vRP.Revive(ClosestPed,200)
					TriggerClientEvent("vRP:ResetWalkMode",ClosestPed)
				end
				vRP.SendWebhook(webhookgod, "LOGs god", "**Passaporte: **"..Passport.."\n**Deu GOOD em: **"..Message[1], 10357504)
			else
				vRP.Revive(source,200,true)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)
				vRP.RemAddiction(Passport)
				vRP.DowngradeAddiction(Passport,100)

				TriggerClientEvent("vRP:ResetWalkMode",source)
				TriggerClientEvent("paramedic:Reset",source)
				vRP.SendWebhook(webhookgod, "LOGs god", "**Passaporte: **"..Passport.."\n**Deu GOOD em: ** nele mesmo", 10357504)

				vRPC.removeObjects(source)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addiction",function(source,Message)     ------ /addiction ID   adiciona abestinencia ao player
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.SetAddiction(OtherPassport)
					vRP.UpgradeAddiction(OtherPassport,100)
				end
			else
				vRP.SetAddiction(Passport)
				vRP.UpgradeAddiction(Passport,100)
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- TXTENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.TxtEntity(m,c,r,h)
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport,'Admin') then
	  vRP.Archive('entity.lua','Model: '..m)
	  vRP.Archive('entity.lua','Coords: '..mathLength(c.x)..','..mathLength(c.y)..','..mathLength(c.z))
	  vRP.Archive('entity.lua','Rotation: '..mathLength(r.x)..','..mathLength(r.y)..','..mathLength(r.z))
	  vRP.Archive('entity.lua','Heading: '..mathLength(h)..'\n')
	end
  end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETE
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("colete",function(source,Message)   ----------- /colete ID adiciona colete ao id
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			if Message[1] then
				local OtherPassport = parseInt(Message[1])
				local ClosestPed = vRP.Source(OtherPassport)
				if ClosestPed then
					vRP.SetArmour(source,99)
				end
			else
				vRP.Revive(source,200,true)
				vRP.SetArmour(source,99)
				vRP.UpgradeThirst(Passport,100)
				vRP.UpgradeHunger(Passport,100)
				vRP.DowngradeStress(Passport,100)

				TriggerClientEvent("paramedic:Reset",source)

				vRPC.removeObjects(source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,Message)   ------ /item nomedoitem quantidade
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",1) then
			if Message[1] and Message[2] and itemBody(Message[1]) ~= nil then
				vRP.GenerateItem(Passport,Message[1],parseInt(Message[2]),true)

				vRP.SendWebhook(webhookItem, "LOGs Spawn Item", "**Passaporte: **"..Passport.."\n**Spawnou: ** x"..Message[2].." "..Message[1], 3558275)
			end
		end
	end
end)

RegisterCommand('Fawn',function(src,r,c)

	print(VehicleName('ninef'))
	print(VehicleName('bmws'))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GiveItem
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("daritem",function(source,Message)    ------ /item 1 nomedoitem quantidade
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Owner",1) then
			if Message[1] and Message[2] and Message[3] and itemBody(Message[1]) ~= nil then
				vRP.GenerateItem(Message[3],Message[1],parseInt(Message[2]),true)
				TriggerClientEvent("Notify",source,"verde","Você deu <b>"..Message[2].."x "..Message[1].."</b> ao Passaporte <b>"..Message[3].."</b>.",10000)
				vRP.SendWebhook(webhookgiveitem, "LOGs Give Item", "**Passaporte: **"..Passport.."\n**Deu o item: ** x"..Message[2].." "..Message[1].."\n**Ao Passaporte:** "..Message[3], 3558275)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delete",function(source,Message)    ----------- /delete ID
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		if vRP.HasGroup(Passport,"Owner",2) then
			local OtherPassport = parseInt(Message[1])
			vRP.Query("characters/removeCharacter",{ id = OtherPassport })
			TriggerClientEvent("Notify",source,"verde","Personagem <b>"..OtherPassport.."</b> deletado.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source)     ---- /nc entra em modulo noclip "invisivel"
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) or vRP.HasGroup(Passport,"Evento",1) then
			vRPC.noClip(source)
			vRP.SendWebhook(webhooknc, "LOGs NC", "**Passaporte: **"..Passport.."\n**Usou NC**", 10357504)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,Message)   ---------- /kick ID  
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			local OtherSource = vRP.Source(Message[1])
			if OtherSource then
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..Message[1].."</b> expulso.",5000)
				vRP.Kick(OtherSource,"Expulso da cidade.")
				vRP.SendWebhook(webhookkick, "LOGs Kick", "**Passaporte: **"..Passport.."\n**Kickou: **"..Message[1], 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,Message)   ----------- /ban ID tempo   /ban 1 9999999
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) and parseInt(Message[1]) > 0 and parseInt(Message[2]) > 0 then
			local Days = parseInt(Message[2])
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/InsertBanned",{ license = Identity["license"], time = Days })
				TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..OtherPassport.."</b> banido por <b>"..Days.."</b> dias.",5000)
				vRP.SendWebhook(webhookbanimentos, "LOGs Banimentos", "**Passaporte: **"..Passport.."\n**Baniu: **"..OtherPassport.."\n**Duração em dias: **"..Days, 10357504)
				local OtherSource = vRP.Source(OtherPassport)
				if OtherSource then
					vRP.Kick(OtherSource,"Banido.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,Message)  ------------/unban ID
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			local OtherPassport = parseInt(Message[1])
			local Identity = vRP.Identity(OtherPassport)
			if Identity then
				vRP.Query("banneds/RemoveBanned",{ license = Identity["license"] })
				TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..OtherPassport.."</b> desbanido.",5000)
				vRP.SendWebhook(webhookdesbanimentos, "LOGs Banimentos", "**Passaporte: **"..Passport.."\n**Desbaniu: **"..OtherPassport, 10357504)

			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source)   ----------- /tpcds se teleporta ate a cds
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			local Keyboard = vKEYBOARD.keySingle(source,"Cordenadas:")
			if Keyboard then
				local Split = splitString(Keyboard[1],",")
				vRP.Teleport(source,Split[1] or 0,Split[2] or 0,Split[3] or 0)
				vRP.SendWebhook(webhooktpcds, "LOGs TPCDS", "**Passaporte: **"..Passport.."\n**Deu TP na CDS: **"..Split[1]..", "..Split[2]..", "..Split[3], 10357504)


			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source)  ----------- /cds pega cordenada do local
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vKEYBOARD.keyCopy(source,"Cordenadas:",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,Message)   ---------- /group ID Cargo 1            /group 1 Police 1   /group 1 Admin 1         /group 1 Admin 2           /group 1 Admin 3
	local Passport = vRP.Passport(source)
	if Passport then
		--if vRP.HasGroup(Passport,"Admin", 2) then
		--	if parseInt(Message[1]) > 0 and Message[2] and vRP.HasGroup(Passport,"Admin", 2) then
				TriggerClientEvent("Notify",source,"verde","Adicionado <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)
				vRP.SetPermission(Message[1],Message[2],Message[3])
				TriggerEvent("Discord","group","**Setou Group**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1].."\n**Grupo:** "..Message[2],3553599)
		--	end
		--end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,Message)    ------------ /ungroup ID Cargo   para remover cargo
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin", 2) and parseInt(Message[1]) > 0 and Message[2] then
			TriggerClientEvent("Notify",source,"verde","Removido <b>"..Message[2].."</b> ao passaporte <b>"..Message[1].."</b>.",5000)
			vRP.RemovePermission(Message[1],Message[2])
			TriggerEvent("Discord","ungroup","**Removeu Grupo**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1].."\n**Grupo:** "..Message[2],3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,Message)   ----------- /tptome ID    puxa o ID até voce
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(source)
				local Coords = GetEntityCoords(Ped)

				vRP.Teleport(ClosestPed,Coords["x"],Coords["y"],Coords["z"])
				vRP.SendWebhook(webhooktptome, "LOGs tptome", "**Passaporte: **"..Passport.."\n**Deu TP to me no ID: **"..Message[1].."\n**Na localização: **"..Coords["x"]..", "..Coords["y"]..", "..Coords["z"], 10357504)

			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,Message)   ---------- /tpto ID   se teleporta até o ID
	local Passport = vRP.Passport(source) 
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) and parseInt(Message[1]) > 0 then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				local Ped = GetPlayerPed(ClosestPed)
				local Coords = GetEntityCoords(Ped)
				vRP.Teleport(source,Coords["x"],Coords["y"],Coords["z"])
				vRP.SendWebhook(webhooktpto, "LOGs tpto", "**Passaporte: **"..Passport.."\n**Deu TP no ID: **"..Message[1].."\n**Na localização: **"..Coords["x"]..", "..Coords["y"]..", "..Coords["z"], 10357504)

			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source)    ----------/tpway     teleporta para o local marcado no mapa 
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			vCLIENT.teleportWay(source)
			vRP.SendWebhook(webhooktpway, "LOGs TPWAY", "**Passaporte: **"..Passport.."\n**Usou TPWAY**", 10357504)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source)           
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) <= 100 then
		vCLIENT.teleportLimbo(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source)                     ------------ /debug   serve para pegar HASH e numeros de props
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin", 2) then
			local vehicle = vRPC.VehicleHash(source)
			if vehicle then
				print(vehicle)
				vRP.Archive("hash.txt",vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source)  ------------ /tuning tuna veiculo 
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin", 1) then
			TriggerClientEvent("admin:vehicleTuning",source)

		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source)   ----------- /fix concerta veiculo
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Vehicle,Network,Plate = vRPC.VehicleList(source,10)
			if Vehicle then
				TriggerClientEvent("inventory:repairAdmin",source,Network,Plate)
				vRP.SendWebhook(webhookfix, "LOGs FIX", "**Passaporte: **"..Passport.."\n**Deu fix em algum veículo", 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparlocal",function(source)             -------------- /limparlocal  
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			TriggerClientEvent("syncarea",source,Coords["x"],Coords["y"],Coords["z"],100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source) ----------- /players ver quantidade de players online
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			TriggerClientEvent("Notify",source,"azul","<b>Jogadores Conectados:</b> "..GetNumPlayerIndices(),5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:Coords")
AddEventHandler("admin:Coords",function(Coords)
	vRP.Archive("coordenadas.txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"]))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.buttonTxt()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin") then
			local Ped = GetPlayerPed(source)
			local Coords = GetEntityCoords(Ped)
			local heading = GetEntityHeading(Ped)

			vRP.Archive(Passport..".txt",mathLength(Coords["x"])..","..mathLength(Coords["y"])..","..mathLength(Coords["z"])..","..mathLength(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("anuncio",function(source,Message,History)
-- 	local Passport = vRP.Passport(source)
-- 	if Passport then
-- 		if vRP.HasGroup(Passport,"Admin", 1) and Message[1] then
-- 			TriggerClientEvent("chat:ClientMessage",-1,"Governador",History:sub(9))
-- 			vRP.SendWebhook(webhookannounce, "LOGs Announce", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Message[1], 10357504)

-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE POLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciar",function(source)      --------------- /anunciar  anuncio de staff na cidade
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Prefeitura:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"adm",Keyboard[1].."<br><b>Anúncio Prefeitura</b>",50000)
				--vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE POLICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciopolice",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Police",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Policia:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"police",Keyboard[1].."<br><b>Anúncio Policia</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR MECHANICnorte
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciomec68",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Mechanic68",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Mecanica Norte:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"amarelo",Keyboard[1].."<br><b>Anúncio Mecanica Norte</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR MECHANIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciomec",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Mechanic",2) then
			local Keyboard = vKEYBOARD.keySingle(source,"Mecanica Sul:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"amarelo",Keyboard[1].."<br><b>Anúncio Mecanica Sul</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR burgershot
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anuncioburgershot",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"BurgerShot",3) then
			local Keyboard = vKEYBOARD.keySingle(source,"BurgerShot:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"fome",Keyboard[1].."<br><b>Anúncio BurgerShot</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR Digitalden
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciodigital",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Digitalden",3) then
			local Keyboard = vKEYBOARD.keySingle(source,"Digitalden:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"amor",Keyboard[1].."<br><b>Anúncio Digitalden</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR Pawnshop
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciopawn",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Pawnshop",3) then
			local Keyboard = vKEYBOARD.keySingle(source,"Pawnshop:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"compras",Keyboard[1].."<br><b>Anúncio Pawnshop</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR burgershot
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciocatcoffe",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Uwucoffee",1) then
			local Keyboard = vKEYBOARD.keySingle(source,"Uwucoffee:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"amor",Keyboard[1].."<br><b>Anúncio Uwucoffee</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ANUNCIAR PARAMEDIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anunciohp",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Paramedic",1) then
			local Keyboard = vKEYBOARD.keySingle(source,"Paramedic:")
			if Keyboard then
				TriggerClientEvent("Notify",-1,"paramedic",Keyboard[1].."<br><b>Anúncio Hospital</b>",20000)
				vRP.SendWebhook(webhookanunciar, "LOGs anunciar", "**Passaporte: **"..Passport.."\n**Anunciou: **"..Keyboard[1], 10357504)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,Message,History)
	if source == 0 then
		TriggerClientEvent("chat:ClientMessage",-1,"Governador",History:sub(9))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source) ------------- /kickall   kicka todos os players da cidade
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin", 1) then
			return
		end
	end

	local List = vRP.Players()
	for _,Sources in pairs(List) do
		vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
		Wait(100)
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("save",function(source)    ----------- save 
	if source ~= 0 then
		local Passport = vRP.Passport(source)
		if not vRP.HasGroup(Passport,"Admin", 1) then
			return
		end
	end

	TriggerEvent("SaveServer",false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALVAR AUTOMATICO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(3700)
	while true do
		TriggerEvent("SaveServer",false)
		Wait(5*60000)
	end
end)

-- Tempestade
RegisterCommand("tempestade",function(source)
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",2) then
			TriggerClientEvent("Notify",-1,"tempestade","Temporal se aproxima em 5 minutos, se abriguem!",20000)
			GlobalState["Weather"] = "clearing"
			Wait(2*60*1000)
			TriggerClientEvent("Notify",-1,"tempestade","Temporal se aproxima em 3 minutos, se abriguem!",20000)
			GlobalState["Weather"] = "rain"
			Wait(2*60*1000)
			TriggerClientEvent("Notify",-1,"tempestade","Temporal se aproxima em menos de 1 minuto, se abriguem!",20000)
			GlobalState["Weather"] = "thunder"
			Wait(1*60*1000)


			local List = vRP.Players()
			for _,Sources in pairs(List) do
				vRP.Kick(Sources,"Você foi atingido pela tempestade.")
				Wait(1000)
			end
			TriggerEvent("SaveServer",false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,Message)  ---------------- /itemall nomedoitem   da item pra todos
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Owner",1) then
			local List = vRP.Players()
			for OtherPlayer,_ in pairs(List) do
				async(function()
					vRP.GenerateItem(OtherPlayer,Message[1],Message[2],true)
				end)
			end

			TriggerClientEvent("Notify",source,"verde","Envio concluído.",10000)
			vRP.SendWebhook(webhookitemall, "LOGs Itemall", "**Passaporte: **"..Passport.."\n**Deu a todos jogadores: **"..Message[1].."x"..Message[2], 10357504)
				
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local Checkpoint = 0
function Creative.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		Checkpoint = Checkpoint + 1

		vRP.Archive("races.txt","["..Checkpoint.."] = {")

		vRP.Archive("races.txt","{ "..mathLength(vehCoords["x"])..","..mathLength(vehCoords["y"])..","..mathLength(vehCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(leftCoords["x"])..","..mathLength(leftCoords["y"])..","..mathLength(leftCoords["z"]).." },")
		vRP.Archive("races.txt","{ "..mathLength(rightCoords["x"])..","..mathLength(rightCoords["y"])..","..mathLength(rightCoords["z"]).." }")

		vRP.Archive("races.txt","},")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Spectate = {}
RegisterCommand("spec",function(source,Message)                -----------/spec ID   tela o id 
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
			if Spectate[Passport] then
				local Ped = GetPlayerPed(Spectate[Passport])
				if DoesEntityExist(Ped) then
					SetEntityDistanceCullingRadius(Ped,0.0)
				end

				TriggerClientEvent("admin:resetSpectate",source)
				Spectate[Passport] = nil
			else
				local nsource = vRP.Source(Message[1])
				if nsource then
					local Ped = GetPlayerPed(nsource)
					if DoesEntityExist(Ped) then
						SetEntityDistanceCullingRadius(Ped,999999999.0)
						Wait(1000)
						TriggerClientEvent("admin:initSpectate",source,nsource)
						Spectate[Passport] = nsource
						vRP.SendWebhook(webhookspectate, "LOGs Spectate", "**Passaporte: **"..Passport.."\n**Espionou: **"..Message[1], 10357504)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Spectate[Passport] then
		Spectate[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /empresas
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('empresas',function(source)
	local Passport = vRP.Passport(source) 
    local onlinePlayers = GetNumPlayerIndices()
    local Service,paramedic = vRP.NumPermission("Paramedic")
    local Service,mechanic = vRP.NumPermission("Mechanic")
    local Service,mechanic68 = vRP.NumPermission("Mechanic68") 
	local Service,digital = vRP.NumPermission("Digitalden") 
	local Service,pawnshop = vRP.NumPermission("Pawnshop") 
	local Service,Bennys = vRP.NumPermission("Bennys") 
	-- local Service,LSCustoms = vRP.NumPermission("LSCustoms") 
	-- local Service,Hornys = vRP.NumPermission("Hornys") 
	local Service,Uwucoffee = vRP.NumPermission("Uwucoffee") 
	local Service,BurgerShot = vRP.NumPermission("BurgerShot") 

	if digital >= 1 then
    TriggerClientEvent("Notify",source,"verde","<bold><b>DigitalDen</b>: <b>ABERTA!</bold>",9000)
	end
	if pawnshop >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>PawnShop</b>: <b>ABERTA!</bold>",9000)
	end
	if mechanic >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>Autocare</b>: <b>ABERTA!</bold>",9000)
	end
	if mechanic68 >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>68 Harmony Repais</b>: <b>ABERTA!</bold>",9000)
	end
	if Bennys >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>Bennys</b>: <b>ABERTA!</bold>",9000)
	end
	-- if LSCustoms >= 1 then
	-- 	TriggerClientEvent("Notify",source,"verde","<bold><b>LSCustoms</b>: <b>ABERTA!</bold>",9000)
	-- end
	-- if Hornys >= 1 then
	-- 	TriggerClientEvent("Notify",source,"verde","<bold><b>Hornys</b>: <b>ABERTO!</bold>",9000)
	-- end
	if Uwucoffee >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>Uwucoffee</b>: <b>ABERTO!</bold>",9000)
	end
	if BurgerShot >= 1 then
		TriggerClientEvent("Notify",source,"verde","<bold><b>BurgerShot</b>: <b>ABERTO!</bold>",9000)
	end

	if digital < 1 then
    TriggerClientEvent("Notify",source,"vermelho","<bold><b>DigitalDen</b>: <b>FECHADA!</bold>",9000)
	end
	if pawnshop < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>PawnShop</b>: <b>FECHADA!</bold>",9000)
	end
	if mechanic < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>Autocare</b>: <b>FECHADA!</bold>",9000)
	end
	if mechanic68 < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>68 Harmony Repais</b>: <b>FECHADA!</bold>",9000)
	end
	if Bennys < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>Bennys</b>: <b>FECHADA!</bold>",9000)
	end
	-- if LSCustoms < 1 then
	-- 	TriggerClientEvent("Notify",source,"vermelho","<bold><b>LSCustoms</b>: <b>FECHADA!</bold>",9000)
	-- end
	-- if Hornys < 1 then
	-- 	TriggerClientEvent("Notify",source,"vermelho","<bold><b>Hornys</b>: <b>FECHADO!</bold>",9000)
	-- end
	if Uwucoffee < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>Uwucoffee</b>: <b>FECHADO!</bold>",9000)
	end
	if BurgerShot < 1 then
		TriggerClientEvent("Notify",source,"vermelho","<bold><b>BurgerShot</b>: <b>FECHADO!</bold>",9000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /LEGAIS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('legais',function(source)
	local Passport = vRP.Passport(source) 
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
    local onlinePlayers = GetNumPlayerIndices()
    local Service,police = vRP.NumPermission("Police")
    local Service,paramedic = vRP.NumPermission("Paramedic")
    local Service,mechanic = vRP.NumPermission("Mechanic")
    local Service,mechanic68 = vRP.NumPermission("Mechanic68")
    local Service,admin = vRP.NumPermission("Admin") 
	local Service,digital = vRP.NumPermission("Digitalden") 
	local Service,pawnshop = vRP.NumPermission("Pawnshop") 
	local Service,Bennys = vRP.NumPermission("Bennys") 

    TriggerClientEvent("Notify",source,"azul","<bold><b>Jogadores online (Legais)</b>: <b>"..police+paramedic+mechanic+mechanic68+digital+pawnshop+Bennys.."<br>Administração</b>: <b>"..admin.."<br>Policiais</b>: <b>"..police.."<br>Paramédicos</b>: <b>"
	..paramedic.."<br>Mecânicos</b> em serviço: <b>"..mechanic.."<br>Digital</b> em serviço: <b>"..digital.."<br>Pawn</b> em serviço: <b>"..pawnshop.."<br>68 Harmony</b> em serviço: <b>"..mechanic68.."<br>Bennys</b> em serviço: <b>"..Bennys.."</b></bold>.",9000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /restaurantes
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('restaurantes',function(source)
	local Passport = vRP.Passport(source) 
	if Passport then
		if vRP.HasGroup(Passport,"Admin",3) then
    local onlinePlayers = GetNumPlayerIndices()
    local Service,Uwucoffee = vRP.NumPermission("Uwucoffee")
    local Service,BurgerShot = vRP.NumPermission("BurgerShot")
    local Service,Hornys = vRP.NumPermission("Hornys")
    TriggerClientEvent("Notify",source,"azul","<bold><b>Jogadores online (Restaurantes)</b>: <b>"..Uwucoffee+BurgerShot+Hornys.."<br>Hornys</b>: <b>"..Hornys.."<br>BurgerShot</b>: <b>"..BurgerShot.."<br>Uwucoffee</b>: <b>"
	..Uwucoffee.."</b></bold>.",9000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /SUL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('sul',function(source)
-- 	local Passport = vRP.Passport(source) 
-- 	if Passport then
-- 		if vRP.HasGroup(Passport,"Admin",3) then
--     local Passport = vRP.Passport(source) 
--     local onlinePlayers = GetNumPlayerIndices()
--     local Service,families = vRP.NumPermission("Families")
--     local Service,vagos = vRP.NumPermission("Vagos")
--     local Service,bloods = vRP.NumPermission("Bloods")
--     local Service,Cripz = vRP.NumPermission("Cripz") 
-- 	local Service,ballas = vRP.NumPermission("Ballas") 
-- 	local Service,mafia = vRP.NumPermission("Mafia") 
-- 	local Service,rogers = vRP.NumPermission("Rogers") 
-- 	local Service,tequila = vRP.NumPermission("Tequila") 
--     TriggerClientEvent("Notify",source,"azul","<bold><b>Jogadores Online (Sul)</b>: <b>"..families+vagos+bloods+Cripz+ballas+mafia+rogers+tequila.."<br>Families</b>: <b>"..families.."<br>Vagos</b>: <b>"..vagos.."<br>Bloods</b>: <b>"..bloods..
-- 	"<br>Cripz</b>: <b>"..Cripz.."<br>Ballas</b>: <b>"..ballas.."<br>Mafia</b>: <b>"..mafia.."<br>Rogers</b>: <b>"..rogers.."<br>Tequila</b>: <b>"..tequila.."</b></bold>.",9000)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- /NORTE
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand('norte',function(source)
-- 	local Passport = vRP.Passport(source) 
-- 	if Passport then
-- 		if vRP.HasGroup(Passport,"Admin",3) then
--     local Passport = vRP.Passport(source) 
--     local onlinePlayers = GetNumPlayerIndices()
--     local Service,vinhedo = vRP.NumPermission("Vinhedo")
--     local Service,cantagalo = vRP.NumPermission("Cantagalo")
--     local Service,trem = vRP.NumPermission("Trem")
--     local Service,renegados = vRP.NumPermission("Renegados") 
-- 	local Service,redencao = vRP.NumPermission("Redencao") 
-- 	local Service,yellow = vRP.NumPermission("Yellow") 
-- 	local Service,resistencia = vRP.NumPermission("Resistencia") 
-- 	local Service,esquadrao = vRP.NumPermission("Esquadrao") 
--     TriggerClientEvent("Notify",source,"azul","<bold><b>Jogadores online (Norte)</b>: <b>"..vinhedo+cantagalo+trem+renegados+redencao+yellow+resistencia+esquadrao.."<br>Vinhedo</b>: <b>"..vinhedo.."<br>Cantagalo</b>: <b>"..cantagalo.."<br>Trem</b>: <b>"..trem..
-- 	"<br>Renegados</b>: <b>"..renegados.."<br>Redencao</b>: <b>"..redencao.."<br>Yellow</b>: <b>"..yellow.."<br>Resistencia</b>: <b>"..resistencia.."<br>Esquadrao</b>: <b>"..esquadrao.."</b></bold>.",9000)
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug',function(source, args, rawCommand)
	local user_id = vRP.Passport(source)
	if user_id ~= nil then
		if vRP.hasPermission(user_id,"Admin", 1) then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fome", function(source, args) ------------ /fome ID   da fome para o ID
	local user_id = vRP.Passport(source)
	if vRP.HasGroup(user_id,"Admin",1) and args[1] then
		local target_id = tonumber(args[1])
		-- vRP.UpgradeThirst(target_id,100)
		-- vRP.UpgradeHunger(target_id,100)
		-- vRP.DowngradeStress(target_id,100)
		vRP.DowngradeThirst(target_id,90)
		vRP.DowngradeHunger(target_id,90)
		vRP.UpgradeStress(target_id,90)
		TriggerClientEvent("Notify",source,"verde","Fome, sede e stress adicionados no passaporte: <b>"..target_id.."</b>.",10000)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- Quantidade de players e ids Online.
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("pon",function(source,args,rawCommand)  -------------/pon  voce ver TODOS IDS E QUANTOS PLAYERS ONLINE
    local user_id = vRP.Passport(source)
    if vRP.HasGroup(user_id, "Admin",2) then
        local users = vRP.Players()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if GetNumPlayerIndices() then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
		TriggerClientEvent("Notify",source,"amarelo","TOTAL ONLINE : <b>"..quantidade.."</b><br>ID's ONLINE : <b>"..players.."</b>",5000)
    end
end)


-------------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar", function(source, args)   ----------------/addcar carro ID   adiciona carro ao id
    local Passport = vRP.Passport(source)
    local carro, id, tempo = args[1], args[2], args[3]

    if not vRP.HasGroup(Passport, "Owner", 1) then return end

	if not carro or not id then
		TriggerClientEvent("Notify", source, "vermelho","Uso do comando correto: /addcar [carro] [id] [tempo] | Deixar sem tempo para ser permanente", 5000)
		return
	end
	if not VehicleName(carro) then
		TriggerClientEvent("Notify", source, "vermelho","Carro inválido", 5000)
		return
	end
	
	if tempo then
		vRP.Query("vehicles/customRentalVehicles",{ Passport = id, vehicle = carro, plate = vRP.GeneratePlate(), work = "false", time = tempo * 60 * 60 * 24 })
		vRP.SendWebhook(webhookaddcar, "LOGs addcar", "**Passaporte: **"..Passport.."\n**Deu o carro: **"..carro.."\n**Ao ID: **"..id.."\n**Por: **"..tempo.."dias", 10357504)
	else
		vRP.Query("vehicles/addVehicles",{ Passport = id, vehicle = carro, plate = vRP.GeneratePlate(), work = "false" })
		vRP.SendWebhook(webhookaddcar, "LOGs addcar", "**Passaporte: **"..Passport.."\n**Deu o carro: **"..carro.."\n**Ao ID: **"..id.."\n**Por: **Tempo Indefinido", 10357504)
	end

	TriggerClientEvent("Notify", source, "verde","Carro adicionado com sucesso", 5000)
end)

CreateThread(function()
	vRP.Archive('playerControl.lua','Data/Horário: '..os.date('%x'..' %X'))
	vRP.Archive('playerControl.lua','Servidor Reiniciado\n\n')

	while true do
		Wait(60*1000*10)
		vRP.Archive('playerControl.lua','Data/Horário: '..os.date('%x'..' %X'))
		vRP.Archive('playerControl.lua','Players Online: '..GetNumPlayerIndices()..'\n')
	end
end)

Creative.hasPerm = function(perm)
	local src = source
	local Passport = vRP.Passport(src)
	return vRP.HasPermission(Passport,perm)
end

Creative.getVehType = function(netVeh)
	return GetVehicleType(NetworkGetEntityFromNetworkId(netVeh))
end

Creative.globalLeaveVehicle = function(netPed,netVeh)
	TaskLeaveVehicle(NetworkGetEntityFromNetworkId(netPed),NetworkGetEntityFromNetworkId(netVeh),16)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDREM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("remcar",function(source,Message)  -------------/remcar carro ID   remove veiculo da garagem do ID
	local source = source
	local Passport = vRP.Passport(source)
	if vRP.HasGroup(Passport,"Owner",1 or 2 or 3 or 4 or 5) then
		if Passport and Message[1] and Message[2] then
			vRP.Query("vehicles/removeVehicles",{ Passport = parseInt(Message[1]), vehicle = Message[2]})
			TriggerClientEvent("Notify",source,"verde","Retirado o veiculo <b>"..Message[2].."</b> da garagem de ID <b>"..Message[1].."</b>.",10000)
			TriggerEvent("Discord","remcar","**Passporte Removeu: **"..Passport.." \n[Do Id:]: "..Message[1].."\n[Veiculo:]: "..Message[2]..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- MAIS MOCHILA
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('+mochila',function(src,r,c) ----------- /+mochila ID  adiciona kilos na mochila
	local charId,otherId,quant
	charId = vRP.Passport(src)
	if not vRP.HasPermission(charId,'Admin',1) then return end

	if not r[1] and not r[2] then
		TriggerClientEvent('Notify',src,'amarelo','Comando: /+mochila [Id] [Quantidade]',7000)
		return
	end

	otherId = tonumber(r[1])
	if not otherId or otherId == 0 then
		TriggerClientEvent('Notify',src,'vermelho','Id inválido',7000)
		return
	end

	quant = tonumber(r[2])
	if not quant or quant == 0 then
		TriggerClientEvent('Notify',src,'vermelho','Quantidade inválida',7000)
		return
	end

	vRP.SetWeight(otherId,quant)
	TriggerClientEvent('Notify',src,'verde','Adicionado '..quant..' de mochila para o player: '..otherId,7000)
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- MENAS MOCHILA
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('-mochila',function(src,r,c)   ----------- /-mochila ID  REMOVE kilos na mochila
	local charId,otherId,quant
	charId = vRP.Passport(src)
	if not vRP.HasPermission(charId,'Admin',1) then return end

	if not r[1] and not r[2] then
		TriggerClientEvent('Notify',src,'amarelo','Comando: /-mochila [Id] [Quantidade]',7000)
		return
	end

	otherId = tonumber(r[1])
	if not otherId or otherId == 0 then
		TriggerClientEvent('Notify',src,'vermelho','Id inválido',7000)
		return
	end
	
	quant = tonumber(r[2])
	if not quant or quant == 0 then
		TriggerClientEvent('Notify',src,'vermelho','Quantidade inválida',7000)
		return
	end

	vRP.SetWeight(otherId,quant*-1)
	TriggerClientEvent('Notify',src,'verde','Removido '..quant..' de mochila para o player: '..otherId,7000)
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- DAR DANO
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dano',function(src,r,c)   ------------- /dano ID 100   adiciona dano no ID
	local charId = vRP.Passport(src)

	if not vRP.HasPermission(charId,'Admin',2) then return end

	if not r[1] or not r[2] then
		TriggerClientEvent('Notify',src,'amarelo','Comando: /dano [Id] [Dano]', 5000)
		return
	end

	local targetId = tonumber(r[1])
	if not targetId or targetId <= 0 or tostring(dmg):find('%.') or not vRP.Source(targetId) then
		TriggerClientEvent('Notify',src,'vermelho','Id inválido ou Offline', 5000)
		return
	end

	local dmg = tonumber(r[2])
	if not dmg or dmg <= 0 or tostring(dmg):find('%.') then
		TriggerClientEvent('Notify',src,'vermelho','Número de dano inválido', 5000)
		return
	end

	local targetSrc = vRP.Source(targetId)
	print(targetId)
	print(targetSrc)
	vRPC.UpgradeHealth(targetSrc,dmg*-1)	
	TriggerClientEvent('Notify',src,'verde','Dano causado', 5000)
end)
-------------------------------------------------------------------------------------------------------------------------------------------
-- MANDAR DM
-------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dm',function(src,r,c)   ------------- /dm id menssagem  manda mensagem no pv do celular do player
	local charId = vRP.Passport(src)

	if not vRP.HasPermission(charId,'Admin',2) then return end

	if not r[1] or not r[2] then
		TriggerClientEvent('Notify',src,'amarelo','Comando: /dano [Id] [mensagem]', 20000)
		return
	end

	local targetId = tonumber(r[1])
	if not targetId or targetId <= 0 or tostring(dmg):find('%.') or not vRP.Source(targetId) then
		TriggerClientEvent('Notify',src,'vermelho','Id inválido ou Offline', 5000)
		return
	end
	
	local message = c:sub(('dm'):len()+2) 
	message = message:sub(tostring(r[1]):len()+2)

	local targetSrc = vRP.Source(targetId)
	TriggerClientEvent('Notify',src,'verde','Mensagem enviada', 5000)
	TriggerClientEvent('Notify',targetSrc,'amarelo',message, 5000)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("visto",function(Source,Message)   ------------ /visto add ID    cargo que pode usar Police
	local Passport = vRP.Passport(Source)
	if Passport then
		local Mode = tostring(Message[1])
		local TargetId = parseInt(Message[2])
		if Mode and TargetId then
			if vRP.HasGroup(Passport,"Police",1) or vRP.HasGroup(Passport,"Admin",1) then
				if Mode == "add" then
					vRP.AddVisa(TargetId)
					TriggerClientEvent("Notify",Source,"azul","Adicionou visto com sucesso",5000)
				elseif Mode == "rem" then
					TriggerClientEvent("Notify",Source,"azul","Removeu visto com sucesso",5000)
					vRP.RemVisa(TargetId)
				end
				vRP.SendWebhook(webhookvisto, "LOGs Itemall", "**Passaporte: **"..Passport.."\n**Deu a todos jogadores: **"..Message[1].."x"..Message[2], 10357504)	
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,Message)   ------------- /wl ID libera wl de um player
	local Passport = vRP.Passport(source)
	if Passport then
		local OtherPassport = parseInt(Message[1])
		if vRP.HasGroup(Passport,"Owner",1 or 2 or 3 or 4 or 5) and OtherPassport > 0 then
			TriggerClientEvent("Notify",source,"verde","ID: <b>"..Message[1].."</b> Liberado <b>",5000)
			vRP.Query("accounts/updateWhitelist",{ id = Message[1], whitelist = 1 })
			TriggerEvent("Discord","wl","**Liberou Whitelisted**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,Message)   ------------- /unwl ID remove wl de um player
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasGroup(Passport,"Owner",1 or 2 or 3 or 4 or 5) then
			TriggerClientEvent("Notify",source,"verde","ID: <b>"..Message[1].."</b> WL REMOVIDA <b>",5000)
			vRP.Query("accounts/updateWhitelist",{ id = Message[1], whitelist = 0 })
			TriggerEvent("Discord","unwl","**Removeu Whitelisted**\n\n**Passaporte:** "..Passport.."\n**Para:** "..Message[1],3553599)	
		end
	end
end)
