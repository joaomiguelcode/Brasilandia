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
Badfellas = {}
Tunnel.bindInterface("badfellas_jackpotting",Badfellas)
vCLIENT = Tunnel.getInterface("badfellas_jackpotting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = {}


function inactivePlayer(source)
	Player(source)["state"]["Cancel"] = true
	Player(source)["state"]["Commands"] = true
end

function activePlayer(source)
	Player(source)["state"]["Cancel"] = false
	Player(source)["state"]["Commands"] = false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTBOX
-----------------------------------------------------------------------------------------------------------------------------------------
function startAtm(atmId)
    local source = source
    if Config.base == "creative_network" then
        local user_id = vRP.Passport(source)
        if user_id then
            atmTimers[atmId] = os.time() + parseInt(Config.timeToRobbery)

            if math.random(100) >= parseInt(Config.percentPolice) then
                local Ped = GetPlayerPed(source)
                local Coords = GetEntityCoords(Ped)

                local Service = vRP.NumPermission("Police")
                for Passports,Sources in pairs(Service) do
                    async(function()
                        vRPC.PlaySound(Sources,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
                        TriggerClientEvent("NotifyPush",Sources,{ code = 20, title = "ATM", x = Coords["x"], y = Coords["y"], z = Coords["z"], criminal = "Sistema de Segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
                    end)
                end
            end

            vRP.RemoveItem(user_id,Config.itemUsed,1,false)

            TriggerClientEvent("Progress",source,"Plugando Pen-Drive",15*1000)
            vRPC.playAnim(source,false,{Config.animationStartDict,Config.animationStartName},false)
			inactivePlayer(source)

            SetTimeout(15*1000,function()
                vRPC.removeObjects(source)
                vCLIENT.startRobbery(source)

                vRPC.createObjects(source,Config.animationBaseDict,Config.animationBaseName,Config.animationBaseObject,50,28422)
            end)

            return true
        end
    end
end

function Badfellas.Payment()
	local source = source
	if Config.base == "creative_network" then
		local user_id = vRP.Passport(source)
		if user_id then
			vRP.GenerateItem(user_id,"dollarz",math.random(Config.minPayment,Config.maxPayment),true)

			TriggerClientEvent("Notify",source,"verde","Você conseguiu roubar o caixa!",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("bd_jackpotting:startRobbery")
AddEventHandler("bd_jackpotting:startRobbery",function(atmId)
	local source = source
	if Config.base == "creative_network" then
		local user_id = vRP.Passport(source)
		if user_id then
			if atmTimers[atmId] then
				if os.time() < atmTimers[atmId] then
					TriggerClientEvent("Notify",source,"amarelo","Caixa vazio",5000)
					return false
				else
					local consultItem = vRP.InventoryItemAmount(user_id,Config.itemUsed)
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"amarelo","Você precisa ter <b>1x "..itemName(Config.itemUsed).."</b>.",5000)
						return false
					end

					if vRP.CheckDamaged(consultItem[2]) then
						TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Config.itemUsed).."</b> danificado.",5000)
						return false
					end

					startAtm(atmId)
					return true
				end
			else
				local consultItem = vRP.InventoryItemAmount(user_id,Config.itemUsed)
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"amarelo","Você precisa ter <b>1x "..itemName(Config.itemUsed).."</b>.",5000)
					return false
				end

				if vRP.CheckDamaged(consultItem[2]) then
					TriggerClientEvent("Notify",source,"vermelho","<b>"..itemName(Config.itemUsed).."</b> danificado.",5000)
					return false
				end

				startAtm(atmId)
				return true
			end
		end
	end
end)