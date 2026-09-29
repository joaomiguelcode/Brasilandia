-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
vSERVER = Tunnel.getInterface("invoke-presets")
Tunnel.bindInterface("invoke-presets",cRP)

Citizen.CreateThread(function()
	exports['target']:AddCircleZone('Clothe:Trasher',vec3(-346.81,-1575.82,25.22),0.5,{ --Coordenada roupa do lixeiro
		name = 'Clothe:Trasher',
		heading = 3374176
	},{
		shop = 'Lixeiro',
		Distance = 1.75,
		options = {
			{
				event = "changeClothesTrasher",
				label = 'Mudar de Roupas',
				tunnel = 'shop'
			}
		}
	})
	exports['target']:AddCircleZone('Clothe:Cacador',vec3(-674.3,5834.23,17.32),0.5,{ --Coordenada roupa do Cacador
		name = 'Clothe:Cacador',
		heading = 3374176
	},{
		shop = 'Cacador',
		Distance = 1.75,
		options = {
			{
				event = "changeClothesCacador",
				label = 'Mudar de Roupas',
				tunnel = 'shop'
			}
		}
	})
	exports['target']:AddCircleZone('Clothe:Transporter',vec3(11.16,-660.01,33.45),0.5,{ --Coordenada roupa do Transporter
	name = 'Clothe:Transporter',
	heading = 3374176
},{
	shop = 'Transporter',
	Distance = 1.75,
	options = {
		{
			event = "changeClothesTransporter",
			label = 'Mudar de Roupas',
			tunnel = 'shop'
		}
	}
})


	
end)


function IsMale(ped)
	if IsPedModel(ped, 'mp_m_freemode_01') then
		return true
	else
		return false
	end
end

AddEventHandler("changeClothesTrasher", function(Job)
	if IsMale(PlayerPedId()) then
		TriggerEvent('skinshop:Apply',clothes[Job].male)
	else
		TriggerEvent('skinshop:Apply',clothes[Job].female)
	end
end)

AddEventHandler("changeClothesCacador", function(Job)
	if IsMale(PlayerPedId()) then
		TriggerEvent('skinshop:Apply',clothes[Job].male)
	else
		TriggerEvent('skinshop:Apply',clothes[Job].female)
	end
end)

AddEventHandler("changeClothesTransporter", function(Job)
	if IsMale(PlayerPedId()) then
		TriggerEvent('skinshop:Apply',clothes[Job].male)
	else
		TriggerEvent('skinshop:Apply',clothes[Job].female)
	end
end)

function cRP.checkClothes(job)
	local PlayerPed = PlayerPedId()

	local pedClothes = {
		["arms"]                            = {item = GetPedDrawableVariation(PlayerPed, 3), texture = GetPedTextureVariation(PlayerPed, 3), color = GetPedPaletteVariation(PlayerPed, 3)},
		["pants"]                           = {item = GetPedDrawableVariation(PlayerPed, 4), texture = GetPedTextureVariation(PlayerPed, 4), color = GetPedPaletteVariation(PlayerPed, 4)},
		["shoes"]                           = {item = GetPedDrawableVariation(PlayerPed, 6), texture = GetPedTextureVariation(PlayerPed, 6), color = GetPedPaletteVariation(PlayerPed, 6)},
		["tshirt"]                          = {item = GetPedDrawableVariation(PlayerPed, 8), texture = GetPedTextureVariation(PlayerPed, 8), color = GetPedPaletteVariation(PlayerPed, 8)},
		["vest"]                           	= {item = GetPedDrawableVariation(PlayerPed, 9), texture = GetPedTextureVariation(PlayerPed, 9), color = GetPedPaletteVariation(PlayerPed, 9)},
		["torso"]                           = {item = GetPedDrawableVariation(PlayerPed, 11),texture =  GetPedTextureVariation(PlayerPed, 11), color = GetPedPaletteVariation(PlayerPed, 11)}
	}

	local res = vSERVER.checkClothes(job, pedClothes, IsMale(PlayerPedId()))

    return res
end