-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vKEYBOARD = Tunnel.getInterface("keyboard")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("faly_caixa_registradora",cRP)
vCLIENT = Tunnel.getInterface("faly_caixa_registradora")

-- local webhookPagamentos = "https://discord.com/api/webhooks/1156466585964392468/O_j9GF_08juf3n_gwSXHEAYivl1_vl-fjR_w7xG_CRxCg-uwx8UNKDS3VImeUyokEvDF",
-- SendWebhook(webhookPagamentos, "LOGs Pagamentos", "**Passaporte:** "..Passport.."\n**Cobrou:** "..amount.."\n**De:** "..nuser_id.."\n**Permissao:** "..location.permission)

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

local Caixinhas = {}
function cRP.checkCanStart(entity, coords)
    local source = source
    local ped = GetPlayerPed(source)
    local Coords = GetEntityCoords(ped)
    local id = coords[1]..'-'..coords[2]..'-'..coords[3]
    local InService, Police = vRP.numPermission("Police")
    local Passport = vRP.Passport(source)
    
    if Police < cfg.minPolice then
        TriggerClientEvent("Notify", source, "vermelho", "Você não pode fazer isso agora", 5000)
        return
    end
    
    if vRP.ItemAmount(Passport, cfg.reqItem.index, true) < cfg.reqItem.qtd then
        TriggerClientEvent("Notify", source, "vermelho", "Você precisa ter "..cfg.reqItem.qtd.."x "..itemName(cfg.reqItem.index), 5000)
        return
    end

    if Caixinhas[id] then
        if os.time() - Caixinhas[id].time > cfg.cooldownCaixinhas then
            notifyPolice(Coords, InService)
            startRobbery(source, id)
        else
            cantRobbery(source)
        end
    else
        notifyPolice(Coords, InService)
        startRobbery(source, id)
    end 
end

function notifyPolice(Coords, Police)
    for k,v in pairs(Police) do
        async(function()
            TriggerClientEvent("NotifyPush",v,{ code = 1090, title = "Roubo a caixa registradora", x = Coords["x"], y = Coords["y"], z = Coords["z"], blipColor = 46 })
        end)
    end
end

function cRP.rewardPlayer()
    local source = source
    local Passport = vRP.Passport(source)
    local min = tonumber(tostring(cfg.reward.min/12):sub(1,tostring(cfg.reward.min/12):find('%.')-1))
    local max = tonumber(tostring(cfg.reward.max/12):sub(1,tostring(cfg.reward.max/12):find('%.')-1))
    if min <= 0 then min = 1 end
    if max <= 0 then max = 1 end
    local rand = math.random(min, max)

    vRP.GenerateItem(Passport, cfg.reward.item, rand, true)
end

function startRobbery(source, id)
    Caixinhas[id] = {
        time = os.time()
    }
    if not vCLIENT.startLockpick(source) then
        TriggerClientEvent("Notify", source, "vermelho", "Você não conseguiu roubar o caixinha", 5000)
    end
end

function cantRobbery(source)
    TriggerClientEvent("Notify", source, "vermelho", "Esse caixinha está sem dinheiro... Tente novamente mais tarde", 5000)
end

function SendWebhook(webhook, webhookName, message, color)
	if not color then color = 3042892 end
	
	PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({
		username = webhookName,
		embeds = { { color = color, description = message..os.date("\n**Data:** %d/%m/%Y **Hora:** %H:%M:%S") } }
	}),{ ["Content-Type"] = "application/json" })
end