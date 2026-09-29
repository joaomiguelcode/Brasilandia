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
Tunnel.bindInterface("faly_pagamento",cRP)
vCLIENT = Tunnel.getInterface("faly_pagamento")

local webhookPagamentos = ""

function format(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HandlePayment
---@param location { cds: number[], label: string, permission: string, item: {index: string, qtd: number }  }
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.handlePayment(location)
    local source = source
    local Passport = vRP.Passport(source)
    
    if not vRP.HasGroup(Passport, location.permission) then
        return
    end 

    local nuser_id = vKEYBOARD.keyArea(source, "Qual o final do cartão?", 0)

    if nuser_id then
        nuser_id = tonumber(nuser_id[1])
    
        if not nuser_id then
            TriggerClientEvent("Notify", source, "vermelho", "Cartão inválido", 5000)
            return
        end
        local nsource = vRP.UserSource(nuser_id)
        if not nsource then
            TriggerClientEvent("Notify", source, "vermelho", "Não foi possível localizar essa pessoa", 5000)
            return
        end
        local amount = vKEYBOARD.keyArea(source, "Qual o valor que deseja cobrar?", 0)
        if amount then
            amount = tonumber(amount[1])
            if amount then
                if amount < cfg.minAmount then
                    TriggerClientEvent("Notify", source, "vermelho", "O valor mínimo de cobrança é de $"..cfg.minAmount, 5000)
                    return
                end
                if vRP.Request(nsource, "Deseja pagar "..format(amount).."?", "Sim", "Não") then
                    if (vRP.PaymentFull(nuser_id, amount)) then
                        SendWebhook(webhookPagamentos, "LOGs Pagamentos", "**Passaporte:** "..Passport.."\n**Cobrou:** "..amount.."\n**De:** "..nuser_id.."\n**Permissao:** "..location.permission)
                        vRP.addBank(cfg.permissions[location.permission].owner, amount)
                        TriggerClientEvent("Notify", source, "verde", "Transação realizada com sucesso!", 5000)
                        vRP.GenerateItem(Passport, location.item.index, location.item.qtd, true)
                    else
                        TriggerClientEvent("Notify", source, "vermelho", "A transação falhou", 5000)
                        return
                    end
                else
                    TriggerClientEvent("Notify", source, "vermelho", "A transação falhou", 5000)
                    return
                end
            end
        end
    end
end

cRP.hasAnyPerm = function ()
    local src = source
    local Passport = vRP.Passport(src)

    local hasAnyPerm = false
    for k,v in pairs(cfg.locations) do
        if vRP.HasGroup(Passport, v.permission) then
            hasAnyPerm = v
            break
        end
    end
    
    return hasAnyPerm
end

function SendWebhook(webhook, webhookName, message, color)
	if not color then color = 3042892 end
	
	PerformHttpRequest(webhook,function(err,text,headers) end,"POST",json.encode({
		username = webhookName,
		embeds = { { color = color, description = message..os.date("\n**Data:** %d/%m/%Y **Hora:** %H:%M:%S") } }
	}),{ ["Content-Type"] = "application/json" })
end