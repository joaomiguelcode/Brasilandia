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
Sirene = {}
Tunnel.bindInterface(GetCurrentResourceName(),Sirene)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local isOpen = false

-- Tabelas de estado por veículo (Lógica do Luxart)
local state_siren = {}  -- Estado da sirene (0-3)
local state_horn = {}   -- Estado do HORN (0-1)
local state_pial = {}   -- Estado do PIAL (0-1)
local state_lights = {} -- Estado das luzes (0=off, 1=on)
local state_priority = {} -- Estado do modo prioridade (0=off, 1=on)

-- Tabelas de sons por veículo (Lógica do Luxart)
local snd_siren = {}    -- Som da sirene
local snd_horn = {}     -- Som do HORN
local snd_pial = {}     -- Som do PIAL

-- Estados pausados temporariamente
local pausedSirenStates = {}

-- Timer de limpeza de sons (Lógica do Luxart)
local count_sndclean_timer = 0
local delay_sndclean_timer = 400  -- 400ms (mesma lógica do Luxart)

-- Estado do modo de giroflex por veículo
local state_giroflex_mode = {} -- Modo atual de giroflex (0, 1, 2, 3, etc.)

-- OTIMIZAÇÃO: Cache de estados anteriores para detectar mudanças
local last_broadcast_state = {}

-- OTIMIZAÇÃO: Controle de debouncing
local last_state_change = {}
local DEBOUNCE_TIME = 100 -- ms
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO DE EXTRAS DE GIROFLEX
-----------------------------------------------------------------------------------------------------------------------------------------
local vehicleGiroflexExtras = {
    -- ========================================
    -- [[ PMESP - 18º BPM ]]
    -- ========================================
    [GetHashKey("t20")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("cretapmesp")] = {
        [1] = {1, 2},
        [2] = {3, 4},
        [3] = {5, 6},
    },
    [GetHashKey("dusterpmesp")] = {
        [1] = {1},
        [2] = {2, 3, 6},
        [3] = {4},
        [4] = {5},
    },
    [GetHashKey("dusterpmesp2")] = {
        [1] = {1,2},
        [2] = {3,4},
    },
    [GetHashKey("hiluxpmesp")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("landerpmesp")] = {
        [1] = {1, 2},
        [2] = {3, 4},
    },
    [GetHashKey("rangerpmesp")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("s10pmesp")] = {
        [0] = {0},
    },
    [GetHashKey("s10pmesp2")] = {
        [1] = {1,2},
        [2] = {3},
    },
    [GetHashKey("spinpmesp2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("spinpmesp24")] = {
        [1] = {5},
        [2] = {6},
        [3] = {1,2,3},
        [4] = {4},
        [5] = {6},
    },
    [GetHashKey("spinpmesp3")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("spinpmesp4")] = {
        [1] = {5},
        [2] = {6},
        [3] = {1,2,3},
        [4] = {4},
        [5] = {6},
    },
    [GetHashKey("spinpmesp5")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("spinpmesp6")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("sprinterpmesp")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
        [5] = {5},
        [6] = {6},
    },
    [GetHashKey("sw4pmesp")] = {
        [0] = {0},
    },
    [GetHashKey("tigerbaep")] = {
        [1] = {1,2},
        [2] = {3,4},
    },
    [GetHashKey("tigerchoque")] = {
        [1] = {1,2},
        [2] = {3,4},
    },
    [GetHashKey("tigerpmesp")] = {
        [1] = {1,2},
        [2] = {3,4},
    },
    [GetHashKey("trail22ft")] = {
        [1] = {2},
        [2] = {1,3,5},
        [3] = {1,4,5},
    },
    [GetHashKey("traildpm")] = {
        [1] = {1},
        [2] = {2, 3},
    },
    [GetHashKey("trailpmesp")] = {
        [1] = {1},
        [2] = {2, 3},
    },
    [GetHashKey("trailpmesp2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailpmesp24")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailpmesp26")] = {
        [1] = {1, 2},
        [2] = {3, 4},
        [3] = {5, 6},
    },
    [GetHashKey("trailpmesp3")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailpmesp4")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {5},
    },
    [GetHashKey("trailpmesp5")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {5},
    },
    [GetHashKey("xrepmesp")] = {
        [1] = {1, 2, 3},
        [2] = {4, 5},
    },
    [GetHashKey("xtpmesp")] = {
        [1] = {1, 2},
        [2] = {3, 4},
    },

    -- ========================================
    -- [[ BAEP - Batalhão de Ações Especiais ]]
    -- ========================================
    [GetHashKey("f850baep")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailbaep")] = {
        [1] = {1},
        [2] = {2, 3},
    },
    [GetHashKey("trailbaep2")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailbaep25")] = {
        [1] = {1, 2},
        [2] = {5, 6},
        [3] = {3, 4},
    },
    [GetHashKey("trailbaep3")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailbaep4")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {2,5},
    },

    -- ========================================
    -- [[ BOMBEIROS - Corpo de Bombeiros ]]
    -- ========================================
    [GetHashKey("autoescada")] = {
        [0] = {0},
    },
    [GetHashKey("landercbmesp")] = {
        [1] = {1, 2},
        [2] = {3, 4},
        [3] = {3, 4, 5},
        [4] = {1, 2, 5},
    },
    [GetHashKey("pajerogb")] = {
        [1] = {1},
    },
    [GetHashKey("rangerbomb")] = {
        [1] = {1},
    },
    [GetHashKey("s10cbmesp")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("spartan")] = {
        [0] = {0},
    },
    [GetHashKey("sprintergb")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("sprintergb2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("sprinteruta")] = {
        [0] = {0},
    },
    [GetHashKey("trailcbmesp")] = {
        [1] = {1},
    },

    -- ========================================
    -- [[ BPRV - Batalhão de Polícia Rodoviária ]]
    -- ========================================
    [GetHashKey("commanderbprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
        [4] = {2, 4, 5},
        [5] = {1, 4, 5},
    },
    [GetHashKey("commanderbprv2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
    },
    [GetHashKey("corollabprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
    },
    [GetHashKey("corollabprv2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
        [4] = {2, 4, 5},
        [5] = {1, 4, 5},
    },
    [GetHashKey("f800pre")] = {
        [1] = {1},
    },
    [GetHashKey("hiluxbprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
        [4] = {2, 4, 5},
        [5] = {1, 4, 5},
    },
    [GetHashKey("onixbprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("spinbprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
        [4] = {2, 4, 5},
        [5] = {1, 4, 5},
    },
    [GetHashKey("sw4bprv")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
    },
    [GetHashKey("trailtor")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailtor2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
        [4] = {2, 4, 5},
        [5] = {1, 4, 5},
    },
    [GetHashKey("virtuspmesp")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3, 4, 5},
    },

    -- ========================================
    -- [[ BPTRAN - Batalhão de Polícia de Trânsito ]]
    -- ========================================
    [GetHashKey("dusterbptran")] = {
        [1] = {1},
        [2] = {2, 3, 6},
        [3] = {4},
        [4] = {5},
    },
    [GetHashKey("f850bptran")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("rangerbptran")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("s10bptran")] = {
        [0] = {0},
    },
    [GetHashKey("f850bptran")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("rangerbptran")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("spinbptran")] = {
        [1] = {5},
        [2] = {6},
        [3] = {1,2,3},
        [4] = {4},
        [5] = {6},
    },

    -- ========================================
    -- [[ CAEP - Companhia de Ações Especiais ]]
    -- ========================================
    [GetHashKey("trailcaep")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailcaep2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailcaep25")] = {
        [1] = {1, 2},
        [2] = {3, 4},
        [3] = {5, 6},
    },
    [GetHashKey("trailcaep3")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailcaep4")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },

    -- ========================================
    -- [[ CHOQUE - Batalhão de Choque ]]
    -- ========================================
    [GetHashKey("f850choque")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("hiluxcoe")] = {
        [1] = {1},
        [2] = {2, 3, 6},
        [3] = {4},
        [4] = {5},
    },
    [GetHashKey("hiluxgate")] = {
        [1] = {1},
        [2] = {2, 3, 6},
        [3] = {4},
        [4] = {5},
    },
    [GetHashKey("sw4canil")] = {
        [0] = {0},
    },
    [GetHashKey("sw4chq")] = {
        [0] = {0},
    },
    [GetHashKey("sw4humaita")] = {
        [0] = {0},
    },
    [GetHashKey("trailcanil")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailchq")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailchq2")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailchq3")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailchq4")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailchq5")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailchq6")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailcmd")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailcoe")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailcomando")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {2,5},
    },
    [GetHashKey("trailgate")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailgate2")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailhumaita")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {2,5},
    },
    [GetHashKey("trailhumaita2")] = {
        [1] = {1},
        [2] = {2,3},
    },
    [GetHashKey("trailrota")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailrota2")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("trailrota3")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("trailrota4")] = {
        [1] = {1},
        [2] = {2,3,4},
        [3] = {2,5},
    },
    [GetHashKey("trailrota5")] = {
        [1] = {2},
        [2] = {1,3,5},
        [3] = {1,4,5},
    },
    [GetHashKey("trailrotaorg")] = {
        [0] = {0},
    },

    -- ========================================
    -- [[ GCM - Guarda Civil Metropolitana ]]
    -- ========================================
    [GetHashKey("aircrossgcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("cb500gcm")] = {
        [1] = {1, 2, 3},
        [2] = {4, 5},
    },
    [GetHashKey("js4gcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("s10gcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("s10gcm2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("spingcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("sprintergcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
        [5] = {5},
        [6] = {6},
    },
    [GetHashKey("sw4gcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("tiggogcm")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
        [4] = {4},
    },
    [GetHashKey("vstromgcm")] = {
        [0] = {0},
    },
    [GetHashKey("xregcm")] = {
        [1] = {1, 2, 3},
        [2] = {4, 5},
    },
    [GetHashKey("yarisgcm")] = {
        [1] = {3,4,5},
        [2] = {1,4,5},
        [3] = {2,4,5},
        [4] = {2},
    },

    -- ========================================
    -- [[ PCESP - Polícia Civil ]]
    -- ========================================
    [GetHashKey("dusterpcesp")] = {
        [0] = {0},
    },
    [GetHashKey("dusterpericia")] = {
        [1] = {1},
        [2] = {2, 3, 6},
        [3] = {4},
        [4] = {5},
    },
    [GetHashKey("pajeropcesp")] = {
        [0] = {0},
    },
    [GetHashKey("s10pcesp")] = {
        [0] = {0},
    },
    [GetHashKey("s10pericia")] = {
        [1] = {1},
        [2] = {2},
    },
    [GetHashKey("spinpcesp")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("spinpcesp2")] = {
        [1] = {1},
        [2] = {2},
        [3] = {3},
    },
    [GetHashKey("sw4pcesp")] = {
        [0] = {0},
    },
    [GetHashKey("trailgarra")] = {
        [0] = {0},
    },
    [GetHashKey("trailpcesp")] = {
        [1] = {1},
    },
    [GetHashKey("trailpcesp2")] = {
        [1] = {1},
    },
    [GetHashKey("trailpcesp3")] = {
        [1] = {1},
    },
    [GetHashKey("trailpcesp4")] = {
        [0] = {0},
    },
    [GetHashKey("trailpcesp5")] = {
        [0] = {0},
    },
    [GetHashKey("vaniml")] = {
        [0] = {0},
    },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
-- Evento para abrir o módulo de sirene (pode ser trigado de outros scripts)
RegisterNetEvent("sirene:toggleModule")
AddEventHandler("sirene:toggleModule", function()
	if not isOpen then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped,false)
		
		if vehicle ~= 0 then
			-- VERIFICAÇÃO 1: Bloquear motos (2 rodas)
			local numberOfWheels = GetVehicleNumberOfWheels(vehicle)
			if numberOfWheels == 2 then
				TriggerEvent("Notify","negado","Este sistema não é compatível com motocicletas.",5000)
				return
			end
			
			-- VERIFICAÇÃO 2: Veículo deve estar na tabela de configuração
			local model = GetEntityModel(vehicle)
			if not vehicleGiroflexExtras[model] then
				TriggerEvent("Notify","negado","Este veículo não possui sistema de sirene compatível.",5000)
				return
			end
			
			-- VERIFICAÇÃO DE PERMISSÃO:
			-- 1. Se TEM passageiro → APENAS passageiro pode usar
			-- 2. Se NÃO TEM passageiro → Motorista pode usar
			local passengerSeat = GetPedInVehicleSeat(vehicle, 0)
			local driverSeat = GetPedInVehicleSeat(vehicle, -1)
			
			local hasPassenger = (passengerSeat ~= 0)
			local isPassenger = (passengerSeat == ped)
			local isDriver = (driverSeat == ped)
			
			if hasPassenger then
				-- TEM passageiro → Apenas ele pode usar
				if not isPassenger then
					TriggerEvent("Notify","negado","Apenas o encarregado pode utilizar o módulo no momento.",5000)
					return
				end
			else
				-- NÃO TEM passageiro → Motorista pode usar
				if not isDriver then
					TriggerEvent("Notify","negado","Apenas o motorista pode utilizar o módulo quando não há passageiro.",5000)
					return
				end
			end
			
			ToggleUI(true)
		else
			TriggerEvent("Notify","negado","Você precisa estar em um veículo para usar o módulo.",5000)
		end
	end
end)

-- Comando mantido para retrocompatibilidade
RegisterCommand("modulomtt",function()
	TriggerEvent("sirene:toggleModule")
end)

RegisterCommand("sirene",function()
	TriggerEvent("sirene:toggleModule")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function ToggleUI(isOpenState)
	isOpen = isOpenState
	SetNuiFocus(isOpen,isOpen)
	SendNUIMessage({ action = "setVisible", payload = isOpen })
end

-- Mutar sirene padrão do veículo (Lógica do Luxart)
local function TogMuteDfltSrnForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		SetVehicleHasMutedSirens(veh, toggle)
	end
end

-- OTIMIZAÇÃO: Função para fazer broadcast APENAS se houver mudança
local function BroadcastStateIfChanged(veh, stateType, newState)
	if not last_broadcast_state[veh] then
		last_broadcast_state[veh] = {}
	end
	
	if last_broadcast_state[veh][stateType] ~= newState then
		last_broadcast_state[veh][stateType] = newState
		
		if stateType == "siren" then
			TriggerServerEvent('sirene:SetSirenState_s', newState)
		elseif stateType == "horn" then
			TriggerServerEvent('sirene:SetHornState_s', newState)
		elseif stateType == "pial" then
			TriggerServerEvent('sirene:SetPialState_s', newState)
		elseif stateType == "lights" then
			TriggerServerEvent('sirene:SetLightsState_s', newState)
		elseif stateType == "priority" then
			TriggerServerEvent('sirene:SetPriorityState_s', newState)
		elseif stateType == "giroflex_mode" then
			TriggerServerEvent('sirene:SetGiroflexMode_s', newState, nil, true)
		elseif stateType == "mute" then
			TriggerServerEvent('sirene:TogMuteSiren_s')
		end
		
		return true
	end
	
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("post:closeUi",function(data,cb)
	ToggleUI(false)
	SetNuiFocus(false,false)
	cb(true)
end)

RegisterNUICallback("get:colors",function(data,cb)
	cb({
		primaryColor = "#47E0FF",
		secondaryColor = "#47E0FF",
		thirdyColor = "#47E0FF"
	})
end)

RegisterNUICallback("triggerButton",function(data,cb)
	if data and data.button then
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped,false)
		
		if vehicle ~= 0 then
			-- VERIFICAÇÃO DE PERMISSÃO:
			-- 1. Se TEM passageiro → APENAS passageiro pode usar
			-- 2. Se NÃO TEM passageiro → Motorista pode usar
			local passengerSeat = GetPedInVehicleSeat(vehicle, 0)
			local driverSeat = GetPedInVehicleSeat(vehicle, -1)
			
			local hasPassenger = (passengerSeat ~= 0)
			local isPassenger = (passengerSeat == ped)
			local isDriver = (driverSeat == ped)
			
			if hasPassenger then
				-- TEM passageiro → Apenas ele pode usar
				if not isPassenger then
					TriggerEvent("Notify","negado","Apenas o passageiro pode utilizar o módulo.",5000)
					cb("error")
					return
				end
			else
				-- NÃO TEM passageiro → Motorista pode usar
				if not isDriver then
					TriggerEvent("Notify","negado","Apenas o motorista pode utilizar o módulo quando não há passageiro.",5000)
					cb("error")
					return
				end
			end
			
			-- BLOQUEIO ESPECÍFICO: Botões de EXTRAS requerem motorista na viatura
			local driver = GetPedInVehicleSeat(vehicle, -1)
			local hasDriver = (driver and driver ~= 0)
			
			-- ARROWS sempre requer motorista
			if data.button == "arrows" then
				if not hasDriver then
					TriggerEvent("Notify","negado","Trocar modos de giroflex requer um motorista na viatura.",5000)
					cb("error")
					return
				end
			end
			
			-- GIROFLEX requer motorista APENAS se o veículo tiver extras configurados
			if data.button == "giroflex" then
				local model = GetEntityModel(vehicle)
				local hasExtrasConfig = (vehicleGiroflexExtras[model] ~= nil)
				
				if hasExtrasConfig and not hasDriver then
					TriggerEvent("Notify","negado","Operar giroflex requer um motorista na viatura.",5000)
					cb("error")
					return
				end
			end
			
			-- Inicializar estados se não existirem
			if state_siren[vehicle] == nil then
				state_siren[vehicle] = 0
			end
			if state_horn[vehicle] == nil then
				state_horn[vehicle] = 0
			end
			if state_pial[vehicle] == nil then
				state_pial[vehicle] = 0
			end
			if state_lights[vehicle] == nil then
				state_lights[vehicle] = 0
			end
			if state_priority[vehicle] == nil then
				state_priority[vehicle] = 0
			end
			
			local action = data.action or "click"
			
			-- Processar botão localmente (Lógica do Luxart)
			HandleButtonPress(data.button, action, vehicle)
			
			-- OTIMIZAÇÃO: Broadcast removido daqui, será feito pela thread principal apenas quando houver mudança
			cb("ok")
		else
			cb("error")
		end
	else
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO DE CONTROLE DE EXTRAS DE GIROFLEX
-----------------------------------------------------------------------------------------------------------------------------------------
function setVehicleSiren(veh, mode, playSound)
    if not mode or not DoesEntityExist(veh) then
        return false
    end

    local model = GetEntityModel(veh)
    SetVehicleAutoRepairDisabled(veh, true)
    
    local config = vehicleGiroflexExtras[model]
    
    if not config or not config[mode] then
        if playSound then
            PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
        end
        return false
    end

    -- Desligar todos os extras (1-7)
    for i = 1, 7 do
        if DoesExtraExist(veh, i) then
            SetVehicleExtra(veh, i, 1) -- 1 = desligado
        end
    end

    -- Ligar apenas os extras do modo selecionado
    for _, extraID in pairs(config[mode]) do
        if DoesExtraExist(veh, extraID) then
            SetVehicleExtra(veh, extraID, 0) -- 0 = ligado
        end
    end

    -- Som APENAS se for ação local do jogador
    if playSound then
        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
    end
    
    return true
end

-- Função para obter o número máximo de modos de giroflex para um veículo
function getMaxGiroflexModes(veh)
    if not DoesEntityExist(veh) then
        return 0
    end
    
    local model = GetEntityModel(veh)
    local config = vehicleGiroflexExtras[model]
    
    if not config then
        return 0
    end
    
    local maxMode = 0
    for mode, _ in pairs(config) do
        if mode > maxMode then
            maxMode = mode
        end
    end
    
    return maxMode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON HANDLERS (Lógica Local + Broadcast)
-----------------------------------------------------------------------------------------------------------------------------------------
function HandleButtonPress(button, action, veh)
	if button == "sirene" then
		-- Inicializar estado se não existir
		if not state_siren[veh] then
			state_siren[veh] = 0
		end
		
		-- Limpar estado pausado
		if pausedSirenStates[veh] then
			pausedSirenStates[veh] = nil
		end
		
		-- Calcular próximo estado: 0 -> 1 -> 2 -> 3 -> 0
		local newState = state_siren[veh] + 1
		if newState > 3 then
			newState = 0
		end
		
		-- Aplicar localmente (SetSirenStateForVeh vai atualizar state_siren[veh])
		SetSirenStateForVeh(veh, newState)
		
	elseif button == "horn" then
		if action == "press" then
			-- Pausar sirene se ativa
			if state_siren[veh] and state_siren[veh] > 0 then
				pausedSirenStates[veh] = state_siren[veh]
				SetSirenStateForVeh(veh, 0)
				TriggerServerEvent('sirene:SetSirenState_s', 0)
			end
			-- Ativar HORN
			SetHornStateForVeh(veh, 1)
			-- Broadcast IMEDIATO para HORN (evento rápido)
			TriggerServerEvent('sirene:SetHornState_s', 1)
			
		elseif action == "release" then
			-- Desativar HORN
			SetHornStateForVeh(veh, 0)
			-- Broadcast IMEDIATO para HORN (evento rápido)
			TriggerServerEvent('sirene:SetHornState_s', 0)
			-- Restaurar sirene se havia uma pausada
			if pausedSirenStates[veh] then
				local restoredState = pausedSirenStates[veh]
				SetSirenStateForVeh(veh, restoredState)
				pausedSirenStates[veh] = nil
				-- Broadcast sirene restaurada
				TriggerServerEvent('sirene:SetSirenState_s', restoredState)
			end
		end
		
	elseif button == "pial" then
		if action == "press" then
			-- Se há sirene ativa, avançar para próximo modo
			if state_siren[veh] and state_siren[veh] > 0 then
				pausedSirenStates[veh] = state_siren[veh]
				local nextState = state_siren[veh] + 1
				if nextState > 3 then
					nextState = 1
				end
				SetSirenStateForVeh(veh, nextState)
				-- Broadcast sirene mudou
				TriggerServerEvent('sirene:SetSirenState_s', nextState)
			else
				-- Ativar PIAL
				SetPialStateForVeh(veh, 1)
				-- Broadcast IMEDIATO para PIAL (evento rápido)
				TriggerServerEvent('sirene:SetPialState_s', 1)
			end
			
		elseif action == "release" then
			-- Desativar PIAL
			SetPialStateForVeh(veh, 0)
			-- Broadcast IMEDIATO para PIAL (evento rápido)
			TriggerServerEvent('sirene:SetPialState_s', 0)
			-- Restaurar sirene se havia uma pausada
			if pausedSirenStates[veh] then
				local restoredState = pausedSirenStates[veh]
				SetSirenStateForVeh(veh, restoredState)
				pausedSirenStates[veh] = nil
				-- Broadcast sirene restaurada
				TriggerServerEvent('sirene:SetSirenState_s', restoredState)
			end
		end
		
	elseif button == "giroflex" then
		-- Verificar se é PASSAGEIRO ou MOTORISTA
		local ped = PlayerPedId()
		local driver = GetPedInVehicleSeat(veh, -1)
		local isDriver = (driver == ped)
		
		-- Inicializar estado se não existir
		if not state_lights[veh] then
			state_lights[veh] = 0
		end
		
		-- Alternar estado: 0 -> 1 -> 0
		local newState = state_lights[veh] == 0 and 1 or 0
		
		if isDriver then
			-- MOTORISTA: Executa tudo localmente
			SetLightsStateForVeh(veh, newState)
			
		else
			-- PASSAGEIRO: Atualiza estado local + envia para MOTORISTA executar
			-- Atualizar estado local para feedback visual imediato
			state_lights[veh] = newState
			
			-- Atualizar NUI
			SendNUIMessage({
				action = "setGiroflex",
				state = (newState == 1)
			})
			
			-- Enviar comando para motorista aplicar extras (como owner)
			if driver and driver ~= 0 then
				local driverPlayer = NetworkGetPlayerIndexFromPed(driver)
				if driverPlayer ~= -1 then
					local driverServerId = GetPlayerServerId(driverPlayer)
					TriggerServerEvent('sirene:PassengerRequestGiroflexToggle_s', driverServerId, newState)
					
				end
			end
		end
		
	elseif button == "arrows" then
		-- ALTERAR MODO DE GIROFLEX (EXTRAS)
		-- Verificar se o veículo tem configuração de giroflex
		local maxModes = getMaxGiroflexModes(veh)
		
		if maxModes == 0 then
			-- Veículo não tem configuração de giroflex extras
			PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
			return
		end
		
		-- Inicializar estado se não existir
		if not state_giroflex_mode[veh] then
			state_giroflex_mode[veh] = 0
		end
		
		-- Se o giroflex estiver desligado, não fazer nada
		if not state_lights[veh] or state_lights[veh] == 0 then
			PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
			return
		end
		
		-- Avançar para o próximo modo: 0 -> 1 -> 2 -> ... -> maxModes -> 1
		local newMode = state_giroflex_mode[veh] + 1
		if newMode > maxModes then
			newMode = 1
		end
		
		-- Atualizar estado local (para todos)
		state_giroflex_mode[veh] = newMode
		
		-- Verificar se é PASSAGEIRO ou MOTORISTA
		local ped = PlayerPedId()
		local driver = GetPedInVehicleSeat(veh, -1)
		local isDriver = (driver == ped)
		
		if isDriver then
			-- MOTORISTA: Aplica extras localmente
			setVehicleSiren(veh, newMode, true)
			
			-- NÃO fazer broadcast manual aqui!
			-- O loop periódico (a cada 500ms) já faz o broadcast automaticamente
			
		else
			-- PASSAGEIRO: Som local + envia para MOTORISTA aplicar extras
			PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			
			if driver and driver ~= 0 then
				local driverPlayer = NetworkGetPlayerIndexFromPed(driver)
				if driverPlayer ~= -1 then
					local driverServerId = GetPlayerServerId(driverPlayer)
					TriggerServerEvent('sirene:PassengerRequestGiroflexMode_s', driverServerId, newMode)
					
				end
			end
		end
		
	elseif button == "prioridade" then
		-- VALIDAÇÃO: Prioridade requer motorista na viatura
		local driver = GetPedInVehicleSeat(veh, -1)
		local hasDriver = (driver and driver ~= 0)
		
		if not hasDriver then
			TriggerEvent("Notify","negado","Modo prioridade requer um motorista na viatura.",5000)
			return
		end
		
		-- Inicializar estado se não existir
		if not state_priority[veh] then
			state_priority[veh] = 0
		end
		
		-- Verificar se é PASSAGEIRO ou MOTORISTA
		local ped = PlayerPedId()
		local isDriver = (driver == ped)
		
		-- Função para ativar/desativar prioridade localmente
		local function ExecutarPrioridade(ativar)
			if ativar then
				-- ATIVAR PRIORIDADE: Desliga tudo e liga giroflex + sirene modo 3
				-- Desligar HORN e PIAL se ativos
				if state_horn[veh] and state_horn[veh] > 0 then
					SetHornStateForVeh(veh, 0)
				end
				if state_pial[veh] and state_pial[veh] > 0 then
					SetPialStateForVeh(veh, 0)
				end
				
			-- Limpar estados pausados
			pausedSirenStates[veh] = nil
			
			-- Ativar giroflex
			SetLightsStateForVeh(veh, 1)
			
			-- Ativar sirene modo 3
			-- Parar som anterior se existir
			if snd_siren[veh] ~= nil then
				StopSound(snd_siren[veh])
				ReleaseSoundId(snd_siren[veh])
				snd_siren[veh] = nil
			end
			
			-- Forçar atualização do estado
			state_siren[veh] = 0
			
			-- Agora ativar modo 3 (igual ao button-8)
			SetSirenStateForVeh(veh, 3)
			
			
			-- Marcar prioridade como ativa
			state_priority[veh] = 1
			else
				-- DESATIVAR PRIORIDADE: Desliga giroflex e sirene
				SetLightsStateForVeh(veh, 0)
				SetSirenStateForVeh(veh, 0)
				
				-- Marcar prioridade como inativa
				state_priority[veh] = 0
			end
		end
		
		if isDriver then
			-- MOTORISTA: Executa localmente
			local novoEstado = state_priority[veh] == 0
			ExecutarPrioridade(novoEstado)
			
	else
		-- PASSAGEIRO: Executa TUDO localmente (sirene + giroflex visual)
		-- E pede ao motorista para aplicar os extras (replicação)
		local novoEstado = state_priority[veh] == 0
		
		-- Executar localmente (igual ao button-8 da sirene - SOM replica automaticamente)
		ExecutarPrioridade(novoEstado)
		
		
		-- Enviar comando para motorista APENAS aplicar extras do giroflex
		if driver and driver ~= 0 then
			local driverPlayer = NetworkGetPlayerIndexFromPed(driver)
			if driverPlayer ~= -1 then
				local driverServerId = GetPlayerServerId(driverPlayer)
				TriggerServerEvent('sirene:PassengerRequestPrioridade_s', driverServerId, novoEstado)
			end
		end
	end
		
		-- Notificar NUI sobre estado de prioridade
		if IsPedInAnyVehicle(ped, false) then
			local playerVeh = GetVehiclePedIsUsing(ped)
			if playerVeh == veh then
				SendNUIMessage({
					action = "setPriority",
					payload = state_priority[veh] == 1
				})
			end
		end
		
	elseif button == "desligar_tudo" then
		-- DESLIGAR TUDO: Desliga todos os sistemas da viatura
		-- Verificar se é PASSAGEIRO ou MOTORISTA
		local ped = PlayerPedId()
		local driver = GetPedInVehicleSeat(veh, -1)
		local isDriver = (driver == ped)
		
		-- Função para desligar tudo localmente
		local function DesligarTudoLocal()
			-- Desligar HORN
			if state_horn[veh] and state_horn[veh] > 0 then
				SetHornStateForVeh(veh, 0)
			end
			
			-- Desligar PIAL
			if state_pial[veh] and state_pial[veh] > 0 then
				SetPialStateForVeh(veh, 0)
			end
			
			-- Desligar sirene
			if state_siren[veh] and state_siren[veh] > 0 then
				SetSirenStateForVeh(veh, 0)
			end
			
			-- Desligar giroflex
			if state_lights[veh] and state_lights[veh] > 0 then
				SetLightsStateForVeh(veh, 0)
			end
			
			-- Desligar prioridade
			if state_priority[veh] and state_priority[veh] > 0 then
				state_priority[veh] = 0
				-- Notificar NUI
				if IsPedInAnyVehicle(ped, false) then
					local playerVeh = GetVehiclePedIsUsing(ped)
					if playerVeh == veh then
						SendNUIMessage({
							action = "setPriority",
							payload = false
						})
					end
				end
			end
		end
		
		if isDriver then
			-- MOTORISTA: Executa localmente
			DesligarTudoLocal()
		else
			-- PASSAGEIRO: Desliga localmente + envia para motorista
			DesligarTudoLocal()
			
			-- Enviar comando para MOTORISTA também desligar
			if driver and driver ~= 0 then
				local driverPlayer = NetworkGetPlayerIndexFromPed(driver)
				if driverPlayer ~= -1 then
					local driverServerId = GetPlayerServerId(driverPlayer)
					TriggerServerEvent('sirene:PassengerRequestDesligarTudo_s', driverServerId)
					
				end
			end
		end
		
		-- Limpar estados pausados
		pausedSirenStates[veh] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SIREN CONTROL FUNCTIONS (Lógica do Luxart)
-----------------------------------------------------------------------------------------------------------------------------------------
function SetSirenStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_siren[veh] and newstate ~= nil then
			-- Parar som anterior
			if snd_siren[veh] ~= nil then
				StopSound(snd_siren[veh])
				ReleaseSoundId(snd_siren[veh])
				snd_siren[veh] = nil
			end
			
			-- Tocar novo som
			if newstate ~= 0 then
				snd_siren[veh] = GetSoundId()
				if newstate == 1 then
					PlaySoundFromEntity(snd_siren[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
				elseif newstate == 2 then
					PlaySoundFromEntity(snd_siren[veh], "VEHICLES_HORNS_SIREN_2", veh, 0, 0, 0)
				elseif newstate == 3 then
					PlaySoundFromEntity(snd_siren[veh], "VEHICLES_HORNS_POLICE_WARNING", veh, 0, 0, 0)
				end
				TogMuteDfltSrnForVeh(veh, true)
			end
			
			-- Atualizar estado
			state_siren[veh] = newstate
			
			-- Notificar NUI se for o veículo do jogador local
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped, false) then
				local playerVeh = GetVehiclePedIsUsing(ped)
				if playerVeh == veh then
					SendNUIMessage({ 
						action = "setSirenActive", 
						payload = newstate > 0 
					})
				end
			end
		end
	end
end

function SetHornStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_horn[veh] and newstate ~= nil then
			-- Parar som anterior
			if snd_horn[veh] ~= nil then
				StopSound(snd_horn[veh])
				ReleaseSoundId(snd_horn[veh])
				snd_horn[veh] = nil
			end
			
			-- Tocar novo som
			if newstate == 1 then
				snd_horn[veh] = GetSoundId()
				PlaySoundFromEntity(snd_horn[veh], "SIRENS_AIRHORN", veh, 0, 0, 0)
			end
			
			-- Atualizar estado
			state_horn[veh] = newstate
		end
	end
end

function SetPialStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_pial[veh] and newstate ~= nil then
			-- Parar som anterior
			if snd_pial[veh] ~= nil then
				StopSound(snd_pial[veh])
				ReleaseSoundId(snd_pial[veh])
				snd_pial[veh] = nil
			end
			
			-- Tocar novo som
			if newstate == 1 then
				snd_pial[veh] = GetSoundId()
				PlaySoundFromEntity(snd_pial[veh], "VEHICLES_HORNS_SIREN_1", veh, 0, 0, 0)
			end
			
			-- Atualizar estado
			state_pial[veh] = newstate
		end
	end
end

function SetLightsStateForVeh(veh, newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lights[veh] and newstate ~= nil then
			
			-- Ligar ou desligar luzes de emergência
			if newstate == 1 then
				SetVehicleSiren(veh, true)
				
				-- Se o veículo tem configuração de extras, aplicar o modo atual
				-- APENAS o MOTORISTA executa esta função (passageiro envia comando via evento)
				local maxModes = getMaxGiroflexModes(veh)
				if maxModes > 0 then
					-- Se não tem modo definido, usar modo 1 como padrão
					local wasZero = (not state_giroflex_mode[veh] or state_giroflex_mode[veh] == 0)
					if wasZero then
						state_giroflex_mode[veh] = 1
					end
					
					
					-- Aplicar extras (motorista é owner = replicação garantida)
					setVehicleSiren(veh, state_giroflex_mode[veh], false)
					
					-- Broadcast do modo
					TriggerServerEvent('sirene:SetGiroflexMode_s', state_giroflex_mode[veh], nil, true)
				end
			else
				SetVehicleSiren(veh, false)
				
				-- Desligar todos os extras ao desligar giroflex
				local maxModes = getMaxGiroflexModes(veh)
				if maxModes > 0 then
					for i = 1, 7 do
						if DoesExtraExist(veh, i) then
							SetVehicleExtra(veh, i, 1) -- 1 = desligado
						end
					end
					-- NÃO resetar o modo aqui, para manter o modo ao religar
					-- state_giroflex_mode[veh] = 0
				end
			end
			
			-- Atualizar estado
			state_lights[veh] = newstate
			
			-- Notificar NUI se for o veículo do jogador local
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped, false) then
				local playerVeh = GetVehiclePedIsUsing(ped)
				if playerVeh == veh then
					SendNUIMessage({ 
						action = "setGiroflex", 
						payload = newstate == 1 
					})
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORK SYNC (Lógica do Luxart - Receber estados de outros jogadores)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('sirene:SetSirenState_c')
AddEventHandler('sirene:SetSirenState_c', function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				
				SetSirenStateForVeh(veh, newstate)
			end
		end
	end
end)

RegisterNetEvent('sirene:SetHornState_c')
AddEventHandler('sirene:SetHornState_c', function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				
				SetHornStateForVeh(veh, newstate)
			end
		end
	end
end)

RegisterNetEvent('sirene:SetPialState_c')
AddEventHandler('sirene:SetPialState_c', function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				
				SetPialStateForVeh(veh, newstate)
			end
		end
	end
end)

RegisterNetEvent('sirene:SetLightsState_c')
AddEventHandler('sirene:SetLightsState_c', function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		local myPed = PlayerPedId()
		if ped_s ~= myPed then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				-- IGNORAR se EU estou no mesmo veículo (como motorista ou passageiro)
				if IsPedInAnyVehicle(myPed, false) then
					local myVeh = GetVehiclePedIsUsing(myPed)
					if myVeh == veh then
						return  -- IGNORAR - estou no mesmo veículo
					end
				end
				
			
			-- ATUALIZAR ESTADO e aplicar extras localmente para visualização
			if newstate ~= state_lights[veh] then
				state_lights[veh] = newstate
				
				
				-- Ligar/desligar sirene nativa
				SetVehicleSiren(veh, newstate == 1)
				
				-- APLICAR EXTRAS LOCALMENTE para players ao redor visualizarem corretamente
				if newstate == 1 then
					-- Verificar se veículo tem extras configurados
					local maxModes = getMaxGiroflexModes(veh)
					
					if maxModes > 0 then
						-- Se modo não está definido ou é 0, inicializar como modo 1
						if not state_giroflex_mode[veh] or state_giroflex_mode[veh] == 0 then
							state_giroflex_mode[veh] = 1
						end
						
						
						-- Aplicar extras do modo atual
						local result = setVehicleSiren(veh, state_giroflex_mode[veh], false)
						
					else
					end
				else
					-- Desligar todos os extras
					local maxModes = getMaxGiroflexModes(veh)
					if maxModes > 0 then
						for i = 1, 7 do
							if DoesExtraExist(veh, i) then
								SetVehicleExtra(veh, i, 1) -- 1 = desligado
							end
						end
					end
				end
			end
		end  -- Fecha if IsPedInAnyVehicle(ped_s, false)
	end  -- Fecha if ped_s ~= myPed
	end  -- Fecha if DoesEntityExist(ped_s)
end)

-- Evento para MOTORISTA aplicar os extras (como owner da entidade)
RegisterNetEvent('sirene:ApplyGiroflexMode_c')
AddEventHandler('sirene:ApplyGiroflexMode_c', function(mode)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		
		-- Verificar se é o MOTORISTA
		local driver = GetPedInVehicleSeat(veh, -1)
		if driver == ped then
			
			-- Atualizar estado
			state_giroflex_mode[veh] = mode
			
			-- Aplicar extras (como owner, vai replicar automaticamente)
			if state_lights[veh] == 1 and mode > 0 then
				setVehicleSiren(veh, mode, false)
			end
		end
	end
end)

-- Evento de sincronização de estado (não aplica extras, apenas atualiza estado)
RegisterNetEvent('sirene:SetGiroflexMode_c')
AddEventHandler('sirene:SetGiroflexMode_c', function(sender, mode)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		local myPed = PlayerPedId()
		if ped_s ~= myPed then  -- IGNORAR o próprio jogador (evita loop)
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				-- IGNORAR se EU estou no mesmo veículo (como motorista ou passageiro)
				if IsPedInAnyVehicle(myPed, false) then
					local myVeh = GetVehiclePedIsUsing(myPed)
					if myVeh == veh then
						return  -- IGNORAR - estou no mesmo veículo
					end
				end
				
				
			-- Atualizar o estado e APLICAR EXTRAS LOCALMENTE
			state_giroflex_mode[veh] = mode
			
			-- Se giroflex está ligado, aplicar os extras para visualização local
			if state_lights[veh] == 1 and mode > 0 then
				setVehicleSiren(veh, mode, false)
			end
			end
		end
	end
end)

-- MOTORISTA recebe requisição do PASSAGEIRO para alternar giroflex
RegisterNetEvent('sirene:DriverExecuteGiroflexToggle_c')
AddEventHandler('sirene:DriverExecuteGiroflexToggle_c', function(newState)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		local driver = GetPedInVehicleSeat(veh, -1)
		
		-- Confirmar que é o motorista
		if driver == ped then
			
			-- Executar localmente (replicação garantida)
			SetLightsStateForVeh(veh, newState)
			
			-- NÃO fazer broadcast manual aqui!
			-- O loop periódico (a cada 500ms) já faz o broadcast automaticamente
		end
	end
end)

-- MOTORISTA recebe requisição do PASSAGEIRO para trocar modo de giroflex
RegisterNetEvent('sirene:DriverExecuteGiroflexMode_c')
AddEventHandler('sirene:DriverExecuteGiroflexMode_c', function(newMode)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		local driver = GetPedInVehicleSeat(veh, -1)
		
		-- Confirmar que é o motorista
		if driver == ped then
			
			-- Atualizar estado e aplicar extras
			state_giroflex_mode[veh] = newMode
			setVehicleSiren(veh, newMode, true)
			
			-- NÃO fazer broadcast manual aqui!
			-- O loop periódico (a cada 500ms) já faz o broadcast automaticamente
		end
	end
end)

-- MOTORISTA recebe requisição do PASSAGEIRO para desligar tudo
RegisterNetEvent('sirene:DriverExecuteDesligarTudo_c')
AddEventHandler('sirene:DriverExecuteDesligarTudo_c', function()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		local driver = GetPedInVehicleSeat(veh, -1)
		
		-- Confirmar que é o motorista
		if driver == ped then
			
			-- Desligar HORN
			if state_horn[veh] and state_horn[veh] > 0 then
				SetHornStateForVeh(veh, 0)
			end
			
			-- Desligar PIAL
			if state_pial[veh] and state_pial[veh] > 0 then
				SetPialStateForVeh(veh, 0)
			end
			
			-- Desligar sirene
			if state_siren[veh] and state_siren[veh] > 0 then
				SetSirenStateForVeh(veh, 0)
			end
			
			-- Desligar giroflex
			if state_lights[veh] and state_lights[veh] > 0 then
				SetLightsStateForVeh(veh, 0)
			end
			
		-- Desligar prioridade
		if state_priority[veh] and state_priority[veh] > 0 then
			state_priority[veh] = 0
			-- Notificar NUI
			SendNUIMessage({
				action = "setPriority",
				payload = false
			})
		end
		
		-- NÃO fazer broadcast manual aqui!
		-- O loop periódico (a cada 500ms) já faz o broadcast automaticamente
		-- Isso evita conflitos e mantém a mesma lógica do button-1 (giroflex) que funciona perfeitamente
		end
	end
end)

-- MOTORISTA recebe requisição do PASSAGEIRO para ativar/desativar prioridade
RegisterNetEvent('sirene:DriverExecutePrioridade_c')
AddEventHandler('sirene:DriverExecutePrioridade_c', function(ativar)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsUsing(ped)
		local driver = GetPedInVehicleSeat(veh, -1)
		
	-- Confirmar que é o motorista
	if driver == ped then
		
		if ativar then
			-- ATIVAR PRIORIDADE
			-- Desligar HORN e PIAL se ativos
			if state_horn[veh] and state_horn[veh] > 0 then
				SetHornStateForVeh(veh, 0)
			end
			if state_pial[veh] and state_pial[veh] > 0 then
				SetPialStateForVeh(veh, 0)
			end
			
			-- Limpar estados pausados
			pausedSirenStates[veh] = nil
			
			-- Ativar giroflex
			SetLightsStateForVeh(veh, 1)
			
			-- Ativar sirene modo 3
			-- Parar som anterior se existir
			if snd_siren[veh] ~= nil then
				StopSound(snd_siren[veh])
				ReleaseSoundId(snd_siren[veh])
				snd_siren[veh] = nil
			end
			
			-- Forçar atualização do estado
			state_siren[veh] = 0
			
			-- Agora ativar modo 3 (igual ao button-8)
			SetSirenStateForVeh(veh, 3)
			
			
			-- Marcar prioridade como ativa
			state_priority[veh] = 1
		else
			-- DESATIVAR PRIORIDADE
			SetLightsStateForVeh(veh, 0)
			SetSirenStateForVeh(veh, 0)
			state_priority[veh] = 0
		end
		
		-- NÃO fazer broadcast manual aqui!
		-- O loop periódico (a cada 500ms) já faz o broadcast automaticamente
		-- Isso evita conflitos e mantém a mesma lógica do button-1 (giroflex) que funciona perfeitamente
	end
	end
end)

RegisterNetEvent('sirene:SetPriorityState_c')
AddEventHandler('sirene:SetPriorityState_c', function(sender, newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				
				
				-- Apenas atualizar o estado de prioridade (sirene e luzes já foram sincronizadas)
				state_priority[veh] = newstate
			end
		end
	end
end)

RegisterNetEvent('sirene:TogMuteSiren_c')
AddEventHandler('sirene:TogMuteSiren_c', function(sender)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then  -- NÃO é o jogador local
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh, true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREAD (Lógica do Luxart)
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local sleep = 500  -- Sleep padrão (quando não está em veículo)
		
		-- Se está em um veículo
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsUsing(ped)
			
			-- VERIFICAÇÃO: Passageiro (se existir) ou Motorista (se não tiver passageiro)
			local passengerSeat = GetPedInVehicleSeat(veh, 0)
			local driverSeat = GetPedInVehicleSeat(veh, -1)
			
			local hasPassenger = (passengerSeat ~= 0)
			local isPassenger = (passengerSeat == ped)
			local isDriver = (driverSeat == ped)
			
			-- Pode fazer broadcast se:
			-- 1. É passageiro (quando tem passageiro)
			-- 2. É motorista E não tem passageiro
			local canBroadcast = (hasPassenger and isPassenger) or (not hasPassenger and isDriver)
			
			-- Inicializar estados se não existirem
			if state_siren[veh] == nil then
				state_siren[veh] = 0
			end
			if state_horn[veh] == nil then
				state_horn[veh] = 0
			end
			if state_pial[veh] == nil then
				state_pial[veh] = 0
			end
			if state_lights[veh] == nil then
				state_lights[veh] = 0
			end
			if state_priority[veh] == nil then
				state_priority[veh] = 0
			end
			
		-- OTIMIZAÇÃO: BROADCAST APENAS SE MUDOU
		if canBroadcast then
			BroadcastStateIfChanged(veh, "siren", state_siren[veh])
			-- HORN e PIAL têm broadcast imediato no HandleButtonPress
			BroadcastStateIfChanged(veh, "lights", state_lights[veh])
			BroadcastStateIfChanged(veh, "priority", state_priority[veh])
			
			if state_lights[veh] == 1 and state_giroflex_mode[veh] and state_giroflex_mode[veh] > 0 then
				BroadcastStateIfChanged(veh, "giroflex_mode", state_giroflex_mode[veh])
			end
			
			BroadcastStateIfChanged(veh, "mute", true)
		end
		
		-- OTIMIZAÇÃO: Sleep dinâmico
		if state_siren[veh] == 0 and state_horn[veh] == 0 and state_pial[veh] == 0 and 
		   state_lights[veh] == 0 and state_priority[veh] == 0 then
			sleep = 1000 -- Tudo desligado
		else
			sleep = 500 -- Algo ativo
		end
		end
		
		Wait(sleep)
	end
end)

-- THREAD SEPARADA PARA CLEANUP (otimizado - a cada 400ms)
CreateThread(function()
	while true do
		Wait(400)
		CleanupSounds()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD DE BLOQUEIO DE CONTROLES (Otimizado - Igual Luxart)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOQUEIA TECLAS PADRÕES DO GTA quando em veículo de emergência (Class 18)
-- Isso garante que APENAS o script controla sirene/giroflex via NUI
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local shouldDisableControls = false
		
		-- Se está em um veículo
		if IsPedInAnyVehicle(ped, false) then
			local veh = GetVehiclePedIsUsing(ped)
			local driverSeat = GetPedInVehicleSeat(veh, -1)
			local isDriver = (driverSeat == ped)
			
			-- BLOQUEAR se for MOTORISTA de VEÍCULO EMERGENCIAL (Class 18)
			if isDriver and GetVehicleClass(veh) == 18 then
				shouldDisableControls = true
				
				-- BLOQUEAR TECLAS CRÍTICAS DO GTA (Igual Luxart)
				DisableControlAction(0, 80, true)   -- INPUT_VEH_CIN_CAM (ALT/R - Sirene)
				DisableControlAction(0, 86, true)   -- INPUT_VEH_HORN (E/Q - Giroflex)
				DisableControlAction(0, 172, true)  -- INPUT_CELLPHONE_UP (Arrow UP)
				
				-- FORÇAR ESTADO DO VEÍCULO (reverter ações nativas do GTA)
				SetVehicleHasMutedSirens(veh, true)
				DisableVehicleImpactExplosionActivation(veh, true)
			end
		end
		
		-- WAIT OTIMIZADO:
		-- - Wait(1) quando está bloqueando controles (igual Luxart)
		-- - Wait(500) quando não está bloqueando
		if shouldDisableControls then
			Wait(1)  -- Igual Luxart - suficiente para bloqueios
		else
			Wait(500)  -- Economiza recursos quando não está em emergencial
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANUP FUNCTION (Lógica do Luxart)
-----------------------------------------------------------------------------------------------------------------------------------------
function CleanupSounds()
	-- Limpar sons de sirene
	for k, v in pairs(state_siren) do
		if v > 0 then
			if not DoesEntityExist(k) or IsEntityDead(k) then
				if snd_siren[k] ~= nil then
					StopSound(snd_siren[k])
					ReleaseSoundId(snd_siren[k])
					snd_siren[k] = nil
					state_siren[k] = nil
				end
			end
		end
	end
	
	-- Limpar sons de HORN
	for k, v in pairs(state_horn) do
		if v > 0 then
			if not DoesEntityExist(k) or IsEntityDead(k) then
				if snd_horn[k] ~= nil then
					StopSound(snd_horn[k])
					ReleaseSoundId(snd_horn[k])
					snd_horn[k] = nil
					state_horn[k] = nil
				end
			end
		end
	end
	
	-- Limpar sons de PIAL
	for k, v in pairs(state_pial) do
		if v > 0 then
			if not DoesEntityExist(k) or IsEntityDead(k) then
				if snd_pial[k] ~= nil then
					StopSound(snd_pial[k])
					ReleaseSoundId(snd_pial[k])
					snd_pial[k] = nil
					state_pial[k] = nil
				end
			end
		end
	end
	
	-- Limpar estados de luzes
	for k, v in pairs(state_lights) do
		if v > 0 then
			if not DoesEntityExist(k) or IsEntityDead(k) then
				state_lights[k] = nil
			end
		end
	end
	
	-- Limpar estados de prioridade
	for k, v in pairs(state_priority) do
		if v > 0 then
			if not DoesEntityExist(k) or IsEntityDead(k) then
				state_priority[k] = nil
			end
		end
	end
	
	-- OTIMIZAÇÃO: Limpar cache de broadcast
	for k, _ in pairs(last_broadcast_state) do
		if not DoesEntityExist(k) or IsEntityDead(k) then
			last_broadcast_state[k] = nil
		end
	end
	
	for k, _ in pairs(last_state_change) do
		if not DoesEntityExist(k) or IsEntityDead(k) then
			last_state_change[k] = nil
		end
	end
end
