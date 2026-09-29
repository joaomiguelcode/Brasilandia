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
Tunnel.bindInterface("tencode",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local codes = {
	[10] = {
		text = "Confronto em andamento",
		blip = 6
	},
	[13] = {
		text = "Oficial ferido",
		blip = 1
	},
	[20] = {
		text = "Localização",
		blip = 38
	},
	[32] = {
		text = "Homem armado",
		blip = 83
	},
	[38] = {
		text = "Parando veículo suspeito",
		blip = 61
	},
	[50] = {
		text = "Acidente de trânsito",
		blip = 77
	},
	[78] = {
		text = "Reforço solicitado",
		blip = 4
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.sendCode(code)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Identity = vRP.Identity(Passport)
		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				if code ~= 13 then
					vRPC.PlaySound(Sources,"Event_Start_Text","GTAO_FM_Events_Soundset")
				end

				TriggerClientEvent("NotifyPush",Sources,{ code = code, title = codes[parseInt(code)]["text"], x = Coords["x"], y = Coords["y"], z = Coords["z"], name = Identity["name"].." "..Identity["name2"], time = "Recebido às "..os.date("%H:%M"), blipColor = codes[parseInt(code)]["blip"] })
			end)
		end
	end
end