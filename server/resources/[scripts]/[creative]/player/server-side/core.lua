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
Tunnel.bindInterface("player",Creative)
vCLIENT = Tunnel.getInterface("player")
vSKINSHOP = Tunnel.getInterface("skinshop")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
RegisterServerEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not Debug[Passport] or os.time() > Debug[Passport] then
		TriggerClientEvent("barbershop:Apply",source,vRP.UserData(Passport,"Barbershop"))
		TriggerClientEvent("skinshop:Apply",source,vRP.UserData(Passport,"Clothings"))
		TriggerClientEvent("tattoos:Apply",source,vRP.UserData(Passport,"Tatuagens"))
		TriggerClientEvent("target:Debug",source)
		TriggerEvent("DebugObjects",Passport)

		Debug[Passport] = os.time() + 10
	end
end)

function Creative.BypassInvi()
	local source = source
	--exports["blazeit_props"]:SetTempPermission(source, "Client",  "BypassInvisible", true)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if Debug[Passport] then
		Debug[Passport] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and Message[2] then
		if vRP.HasGroup(Passport,"Admin", 2) then
			local ClosestPed = vRP.Source(Message[1])
			if ClosestPed then
				vRPC.Skin(ClosestPed,Message[2])
				vRP.SkinCharacter(parseInt(Message[1]),Message[2])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUITEXTURES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {
	["MRPD"] = {
		["Distance"] = 1.50,
		["Dimension"] = 1.25,
		["Label"] = "Quadro Branco",
		["Coords"] = vec3(439.47,-985.85,35.99),
		["Link"] = "https://creative-rp.com/Quadro.png",
		["Dict"] = "prop_planning_b1",
		["Texture"] = "prop_base_white_01b",
		["Width"] = 550,
		["Weight"] = 450
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:TEXTURE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Texture")
AddEventHandler("player:Texture",function(Name)
	local source = source
	local Keyboard = vKEYBOARD.keySingle(source,"Link:")
	if Keyboard then
		DuiTextures[Name]["Link"] = Keyboard[1]
		TriggerClientEvent("player:DuiUpdate",-1,Name,DuiTextures[Name])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Stress")
AddEventHandler("player:Stress",function(Number)
	local source = source
	local Number = parseInt(Number)
	local Passport = vRP.Passport(source)
	if Passport then
		vRP.DowngradeStress(Passport,Number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] then
		local message = string.sub(History:sub(4),1,100)

		local Players = vRPC.Players(source)
		for _,v in pairs(Players) do
			async(function()
				TriggerClientEvent("showme:pressMe",v,source,message,10)
			end)
		end
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------
-- E
---------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if Message[2] == "friend" then
			local ClosestPed = vRPC.ClosestPed(source,2)
			if ClosestPed then
				if vRP.GetHealth(ClosestPed) > 100 and not Player(ClosestPed)["state"]["Handcuff"] then
					local Identity = vRP.Identity(Passport)
					if vRP.Request(ClosestPed,"Pedido de <b>"..Identity["name"].."</b> da animação <b>"..Message[1].."</b>?","Sim, iniciar animação","Não, sai fora") then
						TriggerClientEvent("emotes",ClosestPed,Message[1])
						TriggerClientEvent("emotes",source,Message[1])
					end
				end
			end
		else
			TriggerClientEvent("emotes",source,Message[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		local ClosestPed = vRPC.ClosestPed(source,2)
		if ClosestPed then
			if vRP.HasService(Passport,"Paramedic") then
				TriggerClientEvent("emotes",ClosestPed,Message[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- E3
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e3",function(source,Message)
	local Passport = vRP.Passport(source)
	if Passport and vRP.GetHealth(source) > 100 then
		if vRP.HasGroup(Passport,"Admin",2) then
			local Players = vRPC.ClosestPeds(source,50)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("emotes",v,Message[1])
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Doors")
AddEventHandler("player:Doors",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local Vehicle,Network = vRPC.VehicleList(source,5)
		if Vehicle then
			local Players = vRPC.Players(source)
			for _,v in pairs(Players) do
				async(function()
					TriggerClientEvent("player:syncDoors",v,Network,Number)
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Police") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Police")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("chat:ClientMessage",Sources,Identity["name"],History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,Message,History)
	local Passport = vRP.Passport(source)
	if Passport and Message[1] and vRP.GetHealth(source) > 100 then
		if vRP.HasService(Passport,"Paramedic") then
			local Identity = vRP.Identity(Passport)
			local Service = vRP.NumPermission("Paramedic")
			for Passports,Sources in pairs(Service) do
				async(function()
					TriggerClientEvent("Datatable",Sources,Identity["name"].." "..Identity["name2"],History:sub(4))
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.shotsFired(Vehicle)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if Vehicle then
			Vehicle = "Disparos de um veículo"
		else
			Vehicle = "Disparos com arma de fogo"
		end

		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Service = vRP.NumPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				TriggerClientEvent("NotifyPush",Sources,{ code = 10, title = Vehicle, x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 6 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = {}
RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer",function()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not vRP.InsideVehicle(source) then
			if playerCarry[Passport] then
				TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
				TriggerClientEvent("player:Commands",playerCarry[Passport],false)
				playerCarry[Passport] = nil
			else
				local ClosestPed = vRPC.ClosestPed(source,2)
				if ClosestPed then
					playerCarry[Passport] = ClosestPed

					TriggerClientEvent("player:playerCarry",playerCarry[Passport],source)
					TriggerClientEvent("player:Commands",playerCarry[Passport],true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(Mode)
	local source = source
	local vehicle,Network = vRPC.VehicleList(source,10)
	if vehicle then
		TriggerClientEvent("player:syncWins",source,Network,Mode)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions",function(Mode)
	local Distance = 1
	local source = source

	if Mode == "rv" then
		Distance = 10
	end

	local ClosestPed = vRPC.ClosestPed(source,Distance)
	if ClosestPed then
		local Passport = vRP.Passport(source)
		local Consult = vRP.InventoryItemAmount(Passport,"rope")
		if vRP.HasService(Passport,"Emergency") or Consult[1] >= 1 then
			local Vehicle,Network = vRPC.VehicleList(source,5)
			if Vehicle then
				local Networked = NetworkGetEntityFromNetworkId(Network)
				local Door = GetVehicleDoorLockStatus(Networked)

				if parseInt(Door) <= 1 then
					if Mode == "rv" then
						vCLIENT.removeVehicle(ClosestPed)
					elseif Mode == "cv" then
						vCLIENT.putVehicle(ClosestPed,Network)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },    -- Chapeus
            ["pants"] = { item = 55, texture = 0 },  -- Calças
            ["vest"] = { item = 29, texture = 0 },   -- Coletes
            ["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
            ["backpack"] = { item = 73, texture = 0 }, -- Mochila
            ["decals"] = { item = 44, texture = 0 }, -- Adsivo
            ["mask"] = { item = 58, texture = 1 }, -- Mascara
            ["shoes"] = { item = 25, texture = 0 }, -- Sapato
            ["tshirt"] = { item = 55, texture = 0 }, -- Camisa
            ["torso"] = { item = 296, texture = 10 }, -- Jaqueta
            ["accessory"] = { item = 45, texture = 0 }, -- Acessorio
            ["watch"] = { item = -1, texture = 0 }, -- Relogio
            ["arms"] = { item = 0, texture = 0 }, -- Braços
            ["glass"] = { item = 0, texture = 0 }, -- Oculos
            ["ear"] = { item = -1, texture = 0 } -- Brincos
        },
        ["mp_f_freemode_01"] = {
            ["hat"] = { item = -1, texture = 0 },
            ["pants"] = { item = 54, texture = 0 },
            ["vest"] = { item = 19, texture = 1 },
            ["bracelet"] = { item = -1, texture = 0 },
            ["backpack"] = { item = 0, texture = 0 },
            ["decals"] = { item = 0, texture = 0 },
            ["mask"] = { item = 0, texture = 0 },
            ["shoes"] = { item = 25, texture = 0 },
            ["tshirt"] = { item = 35, texture = 0 },
            ["torso"] = { item = 92, texture = 2 },
            ["accessory"] = { item = 8, texture = 0 },
            ["watch"] = { item = -1, texture = 0 },
            ["arms"] = { item = 31, texture = 0 },
            ["glass"] = { item = 0, texture = 0 },
            ["ear"] = { item = -1, texture = 0 }
        }
	},
	["2"] = { -- Força Tatica
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 35, texture = 0 },
			["vest"] = { item = 31, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 52, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 58, texture = 2 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 55, texture = 0 },
			["torso"] = { item = 14, texture = 0 },
			["accessory"] = { item = 1, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 1 },
			["pants"] = { item = 54, texture = 1 },
			["vest"] = { item = 4, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 3 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 35, texture = 0 },
			["torso"] = { item = 92, texture = 0 },
			["accessory"] = { item = 8, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 31, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["3"] = { --Baep
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },    -- Chapeus
		["pants"] = { item = 35, texture = 0 },  -- Calças
		["vest"] = { item = 14, texture = 0 },   -- Coletes
		["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
		["backpack"] = { item = 53, texture = 0 }, -- Mochila
		["decals"] = { item = 45, texture = 13 }, -- Adsivo
		["mask"] = { item = 58, texture = 0 }, -- Mascara
		["shoes"] = { item = 25, texture = 0 }, -- Sapato
		["tshirt"] = { item = 55, texture = 0 }, -- Camisa
		["torso"] = { item = 14, texture = 0 }, -- Jaqueta
		["accessory"] = { item = 1, texture = 0 }, -- Acessorio
		["watch"] = { item = 1, texture = 0 }, -- Relogio
		["arms"] = { item = 0, texture = 0 }, -- Braços
		["glass"] = { item = 0, texture = 0 }, -- Oculos
		["ear"] = { item = -1, texture = 0 } -- Brincos
	},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 12, texture = 2 },
			["pants"] = { item = 151, texture = 3 },
			["vest"] = { item = 58, texture = 3 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 141, texture = 5 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 106, texture = 0 },
			["tshirt"] = { item = 237, texture = 0 },
			["torso"] = { item = 415, texture = 9 },
			["accessory"] = { item = 121, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 23, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["4"] = { --ROCAM PMESP
	["mp_m_freemode_01"] = {
		["hat"] = { item = 17, texture = 0 },    -- Chapeus
		["pants"] = { item = 32, texture = 0 },  -- Calças
		["vest"] = { item = 34, texture = 0 },   -- Coletes
		["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
		["backpack"] = { item = 36, texture = 0 }, -- Mochila
		["decals"] = { item = 45, texture = 13 }, -- Adsivo
		["mask"] = { item = 0, texture = 0 }, -- Mascara
		["shoes"] = { item = 18, texture = 0 }, -- Sapato
		["tshirt"] = { item = 55, texture = 0 }, -- Camisa
		["torso"] = { item = 14, texture = 0 }, -- Jaqueta
		["accessory"] = { item = 1, texture = 0 }, -- Acessorio
		["watch"] = { item = 1, texture = 0 }, -- Relogio
		["arms"] = { item = 0, texture = 0 }, -- Braços
		["glass"] = { item = 0, texture = 0 }, -- Oculos
		["ear"] = { item = -1, texture = 0 } -- Brincos
	},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 10, texture = 0 },
			["pants"] = { item = 151, texture = 1 },
			["vest"] = { item = 58, texture = 1 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 140, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 106, texture = 0 },
			["tshirt"] = { item = 237, texture = 0 },
			["torso"] = { item = 415, texture = 3 },
			["accessory"] = { item = 121, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 23, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["5"] = { --SOLDADO
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 1 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 55, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 0 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = 10, texture = 0 },
			["pants"] = { item = 151, texture = 1 },
			["vest"] = { item = 57, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 121, texture = 0 },
			["shoes"] = { item = 106, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 416, texture = 0 },
			["accessory"] = { item = 121, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 23, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["6"] = { --GARRA
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 130, texture = 1 },  -- Calças
			["vest"] = { item = 40, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 0, texture = 0 }, -- Mochila
			["decals"] = { item = 0, texture = 0 }, -- Adsivo
			["mask"] = { item = 52, texture = 10 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 56, texture = 0 }, -- Camisa
			["torso"] = { item = 228, texture = 0 }, -- Jaqueta
			["accessory"] = { item = 1, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 36, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 5 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
	["7"] = { --CABO
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 2 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 55, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 0 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 4 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
	["8"] = {
		["mp_m_freemode_01"] = { --SARGENTO
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 3 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 56, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 0 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 3 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
	["9"] = { --TENENTE
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 9 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 56, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 2 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 2 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
	["10"] = { --CAPITÃO
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 10 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 56, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 2 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 1 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
		["11"] = { --major
			["mp_m_freemode_01"] = {
				["hat"] = { item = 0, texture = 0 },    -- Chapeus
				["pants"] = { item = 35, texture = 0 },  -- Calças
				["vest"] = { item = 8, texture = 0 },   -- Coletes
				["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
				["backpack"] = { item = 74, texture = 0 }, -- Mochila
				["decals"] = { item = 45, texture = 11 }, -- Adsivo
				["mask"] = { item = 58, texture = 0 }, -- Mascara
				["shoes"] = { item = 25, texture = 0 }, -- Sapato
				["tshirt"] = { item = 56, texture = 0 }, -- Camisa
				["torso"] = { item = 14, texture = 2 }, -- Jaqueta
				["accessory"] = { item = 42, texture = 0 }, -- Acessorio
				["watch"] = { item = 1, texture = 0 }, -- Relogio
				["arms"] = { item = 0, texture = 0 }, -- Braços
				["glass"] = { item = 0, texture = 0 }, -- Oculos
				["ear"] = { item = -1, texture = 0 } -- Brincos
			},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 105, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			-- ["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 25, texture = 0 },
			["tshirt"] = { item = 6, texture = 0 },
			["torso"] = { item = 217, texture = 0 },
			["accessory"] = { item = 96, texture = 0 },
			-- ["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 106, texture = 0 },
			-- ["glass"] = { item = 0, texture = 0 },
			-- ["ear"] = { item = -1, texture = 0 }
		}
	},
	["12"] = { --CORONEL
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 8, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 74, texture = 0 }, -- Mochila
			["decals"] = { item = 45, texture = 13 }, -- Adsivo
			["mask"] = { item = 58, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 56, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 2 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 105, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		-- ["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 6, texture = 0 },
		["torso"] = { item = 217, texture = 0 },
		["accessory"] = { item = 96, texture = 0 },
		-- ["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 106, texture = 0 },
		-- ["glass"] = { item = 0, texture = 0 },
		-- ["ear"] = { item = -1, texture = 0 }
	   }
    },
	["13"] = { --COMANDO
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },    -- Chapeus
			["pants"] = { item = 35, texture = 0 },  -- Calças
			["vest"] = { item = 0, texture = 0 },   -- Coletes
			["bracelet"] = { item = -1, texture = 0 }, -- Pulseira
			["backpack"] = { item = 0, texture = 0 }, -- Mochila
			["decals"] = { item = 11, texture = 5 }, -- Adsivo
			["mask"] = { item = 0, texture = 0 }, -- Mascara
			["shoes"] = { item = 25, texture = 0 }, -- Sapato
			["tshirt"] = { item = 55, texture = 0 }, -- Camisa
			["torso"] = { item = 14, texture = 1 }, -- Jaqueta
			["accessory"] = { item = 42, texture = 0 }, -- Acessorio
			["watch"] = { item = 1, texture = 0 }, -- Relogio
			["arms"] = { item = 0, texture = 0 }, -- Braços
			["glass"] = { item = 0, texture = 0 }, -- Oculos
			["ear"] = { item = -1, texture = 0 } -- Brincos
		},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 105, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		-- ["bracelet"] = { item = -1, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 6, texture = 0 },
		["torso"] = { item = 217, texture = 0 },
		["accessory"] = { item = 96, texture = 0 },
		-- ["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 106, texture = 0 },
		-- ["glass"] = { item = 0, texture = 0 },
		-- ["ear"] = { item = -1, texture = 0 }
	   }
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Preset")
AddEventHandler("player:Preset",function(Number)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if vRP.HasService(Passport,"Emergency") then
			local Model = vRP.ModelPlayer(source)

			if Model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,preset[Number][Model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrunk",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:checkTrash")
AddEventHandler("player:checkTrash",function()
	local source = source
	local ClosestPed = vRPC.ClosestPed(source,2)
	if ClosestPed then
		TriggerClientEvent("player:checkTrash",ClosestPed)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local UniqueShoes = {}
RegisterServerEvent("player:checkShoes")
AddEventHandler("player:checkShoes",function(Entity)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		if not UniqueShoes[Entity] then
			UniqueShoes[Entity] = os.time()
		end

		if os.time() >= UniqueShoes[Entity] then
			if vSKINSHOP.checkShoes(Entity) then
				vRP.GenerateItem(Passport,"WEAPON_SHOES",2,true)
				UniqueShoes[Entity] = os.time() + 300
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
local removeFit = {
	["homem"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mulher"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 14, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["backpack"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 5, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 15, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 15, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:OUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit",function(Mode)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
		if Mode == "aplicar" then
			local result = vRP.GetSrvData("Outfit:"..Passport,true)
			if result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif Mode == "salvar" then
			local custom = vSKINSHOP.Customization(source)
			if custom then
				vRP.SetSrvData("Outfit:"..Passport,custom,true)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
			end
		elseif Mode == "aplicarpremium" then
			local result = vRP.GetSrvData("PremiumOutfit:"..Passport,true)
			if result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif Mode == "salvarpremium" then
			local custom = vSKINSHOP.Customization(source)
			if custom then
				vRP.SetSrvData("PremiumOutfit:"..Passport,custom,true)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
			end
		elseif Mode == "remover" then
			local Model = vRP.ModelPlayer(source)
			if Model == "mp_m_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,removeFit["homem"])
			elseif Model == "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,removeFit["mulher"])
			end
		else
			TriggerClientEvent("skinshop:set"..Mode,source)
		end
	end
end) ]]

RegisterServerEvent("player:Outfit")
AddEventHandler("player:Outfit",function(Mode)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport and not exports["hud"]:Reposed(Passport) and not exports["hud"]:Wanted(Passport) then
        if Mode == "aplicar" then
            local result = vRP.GetSrvData("Outfit:"..Passport,true)
            if result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,result)
                TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
            else
                TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
            end
        elseif Mode == "salvar" then
            local custom = vSKINSHOP.getCustomization(source)
            if custom then
                vRP.SetSrvData("Outfit:"..Passport, custom, true)
                TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
            end
		elseif Mode == "aplicarpremium" then
			local result = vRP.GetSrvData("PremiumOutfit:"..Passport,true)
			if result["pants"] ~= nil then
				TriggerClientEvent("skinshop:Apply",source,result)
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif Mode == "salvarpremium" then
			local custom = vSKINSHOP.getCustomization(source)
			if custom then
				vRP.SetSrvData("PremiumOutfit:"..Passport,custom,true)
				TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
			end
        elseif Mode == "remover" then
            local Model = vRP.ModelPlayer(source)
            if Model == "mp_m_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,removeFit["homem"])
            elseif Model == "mp_f_freemode_01" then
				TriggerClientEvent("skinshop:Apply",source,removeFit["mulher"])
            end
        else
            TriggerClientEvent("skinshop:set"..Mode,source)
        end
    end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:Death")
AddEventHandler("player:Death",function(nsource)
	local source = source
	local Passport = vRP.Passport(source)
	if Passport and source ~= nsource then
		local OtherPassport = vRP.Passport(nsource)
		if OtherPassport then
			if GetPlayerRoutingBucket(source) < 900000 then
				TriggerEvent("Discord","Deaths","**Matou:** "..Passport.."\n**Morreu:** "..OtherPassport,3092790)
			else
				local Name = "Individuo Indigente"
				local Name2 = "Individuo Indigente"
				local Identity = vRP.Identity(Passport)
				local nIdentity = vRP.Identity(OtherPassport)

				if Identity and nIdentity then
					Name = Identity["name"].." "..Identity["name2"]
					Name2 = nIdentity["name"].." "..nIdentity["name2"]

					TriggerClientEvent("Notify",source,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
					TriggerClientEvent("Notify",nsource,"amarelo","<b>"..Name.."</b> matou <b>"..Name2.."</b>",10000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKEPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Bikepack()
	local source = source
	local Passport = vRP.Passport(source)
	if Passport then
		local amountWeight = 10
		local myWeight = vRP.GetWeight(Passport)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.SetWeight(Passport,amountWeight)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect",function(Passport,source)
	TriggerClientEvent("player:DuiTable",source,DuiTextures)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport)
	if playerCarry[Passport] then
		TriggerClientEvent("player:Commands",playerCarry[Passport],false)
		playerCarry[Passport] = nil
	end
end)
-------------------------
-- CARREGAR - POLICIA
-------------------------
Creative.hasPolPerm = function()
	local src = source
	local charId = vRP.Passport(src)
	if vRP.hasPermission(charId,'Police') or vRP.hasPermission(charId,'Paramedic') or vRP.hasPermission(charId,'Admin') then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID PROXIMO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("id", function(source, args)
	local source = source
	-- local user_id = vRP.Passport(source)
	local ClosestPed = vRPC.ClosestPed(source,3)
	if ClosestPed then
		local nuser_id = vRP.Passport(ClosestPed)
		TriggerClientEvent("Notify",source,"amarelo","Passaporte:"..nuser_id.."",7000)
		TriggerClientEvent("Notify",ClosestPed,"amarelo","Foi feito uma busca em seu passaporte",7000)
		--TriggerEvent("Discord","comando-id","**Passaporte:** "..Passport.."\n**Verificou o passaporte do:** "..parseFormat(nuser_id).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
	end
end)