local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("tratamento:curar")
AddEventHandler("tratamento:curar", function()
    local source = source
    local Passport = vRP.Passport(source)

    if Passport then
        -- Inicia o progresso de tratamento
        TriggerClientEvent("Progress", source, "Tratando", 5000)
        
        -- Trava os botões do player durante o tratamento
        Player(source)["state"]["Buttons"] = true
        
        Wait(5000)

        -- Libera os botões do player
        Player(source)["state"]["Buttons"] = false

        -- Revive e cura o jogador (vRP.Revive seta a vida e remove o coma)
         vRP.Revive(source, 200)
         
         -- Limpa sangramento e ferimentos (compatível com o script paramedic)
        TriggerClientEvent("paramedic:Reset", source)

        -- Notificação de sucesso
        TriggerClientEvent("Notify", source, "verde", "Você foi tratado com sucesso!", 5000)
    end
end)