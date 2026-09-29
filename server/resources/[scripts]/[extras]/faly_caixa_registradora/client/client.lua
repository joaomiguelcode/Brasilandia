-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("faly_caixa_registradora",cRP)
vSERVER = Tunnel.getInterface("faly_caixa_registradora")

RegisterNetEvent("registradora:roubar")
AddEventHandler("registradora:roubar", function(Entity)
	local model = Entity[2]
	local coords = Entity[4]

    makeEntityFaceEntity(PlayerPedId(), Entity[1])

    vSERVER.checkCanStart(mode, coords)
	
end)

function makeEntityFaceEntity( entity1, entity2 )
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( entity1, heading )
end

function cRP.startLockpick()
    vRP._playAnim(true, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
    inactivePlayer()
    
    if exports["lockpick"].startLockpick(cfg.tries) then
        activePlayer()
        vRP._playAnim(false, { "oddjobs@shop_robbery@rob_till", "loop" }, true)
        TriggerEvent("Progress","Roubando Registradora",30000)
        robbing = true
        Wait(cfg.tempoRoubo)
        if robbing then
            vRP._stopAnim(false)
            robbing = false
        end
        return true
    else
        vRP._stopAnim(false)
        activePlayer()
        return false
    end
end

CreateThread(function()
    while true do
        if robbing then
            local ped = PlayerPedId()
            repeat
                vSERVER.rewardPlayer()
                Wait(2500)
            until not robbing
        end
        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        if robbing then
            repeat
                Wait(0)
                if IsControlJustPressed(0, 167) then
                    TriggerEvent("Progress","Roubando Registradora",10)
                    vRP._stopAnim(false)
                    robbing = false
                end
            until not robbing
        end
        Wait(1000)
    end
end)

function inactivePlayer()
    LocalPlayer["state"]["Cancel"] = true
    LocalPlayer["state"]["Commands"] = true
end

function activePlayer()
    LocalPlayer["state"]["Cancel"] = false
    LocalPlayer["state"]["Commands"] = false
end

-- RegisterCommand("panim", function(src, args)
--     print(json.encode(args))
--     vRP._playAnim(args[3], {args[1], args[2]}, true)
-- end)