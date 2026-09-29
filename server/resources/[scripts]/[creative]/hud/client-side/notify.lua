-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
Player = GetPlayerServerId(PlayerId())

local ValidNotify = {
    ["vermelho"] = true,
    ["verde"] = true,
    ["amarelo"] = true,
    ["azul"] = true,
    ["sangramento"] = true,
    ["compras"] = true,
    ["fome"] = true,
    ["sede"] = true,
    ["police"] = true,
    ["paramedic"] = true,
    ["admin"] = true,
    ["dica"] = true,
    ["amor"] = true,
    ["airdrop"] = true,
    ["hungry"] = true,
    ["thirst"] = true,
}

local equivalentNotifies = {
    negado = "vermelho",
    sucesso = "verde",
    importante = "azul",
    aviso = "amarelo"
}

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(Css,Message,Timer,Title)
    Css = equivalentNotifies[Css] or Css
    Timer = Timer or 5000
    if ValidNotify[Css] then
        SendNUIMessage({ typeId = "Notify", Css = Css, Message = Message, Timer = Timer, Title = Title })
    else
        SendNUIMessage({ typeId = "Notify", Css = "vermelho", Message = Message, Title = Title, Timer = Timer })
    end
end)

RegisterNetEvent("Notify:Text")
AddEventHandler("Notify:Text",function(Text)
    SendNUIMessage({ typeId = "Text", Message = Text})
end)

RegisterNetEvent("Announce")
AddEventHandler("Announce",function(Css,Message,Timer,Title)
    if ValidNotify[Css] then
        SendNUIMessage({ typeId = "Announce", Css = Css, Message = Message, Timer = Timer or 5000, Title = Title })
    else
        SendNUIMessage({ typeId = "Announce", Css = "Staff", Message = Message, Title = Title, Timer = Timer or 5000 })
    end
end)

local infoHelp = false
function openCloseShortCuts()
    TriggerEvent("help:open")
    infoHelp = not infoHelp
    SendNUIMessage({ typeId = "Tutorial", Status = infoHelp})
end

RegisterCommand("help2",openCloseShortCuts)
RegisterKeyMapping("help2","Open/Close HELP","keyboard","EQUALS") 

RegisterNetEvent("notify:Tutorial")
AddEventHandler("notify:Tutorial",function()
    openCloseShortCuts()
end)


-- local HelpNotify = {
--     "Você sabia que não pode ser assaltado enquanto estiver no modo safe?",
--     "Trabalho de Pescador, Minerador, Agricultor e Taxista estão bufados! [Procure no Mapa]",
--     "Você pode fazer TestDrive de carros vips diretamente na concessionária da cidade!",
--     "Você pode denúnciar um jogador que deslogou em meio a uma ação através da box deixada no local da morte!",
--     "Você sabia que carros vip além de te dar mais respeito com os amigos correm mais que os demais carros da cidade?",
--     "Você sabia que pode abrir a loja vip da cidade no banco flecca da praça?",
--     "Recrutamentos para a polícia são feitos diariamente na DP!",
--     "Jogadores ganham benefícios por recrutar iniciantes para Polícia, Hospital e Ilegal!",
--     "Você ganha benefícios gratuitamente por estar online através do BattlePass! /recompensa",
--     "Você sabia que Médico é uma profissão legal que paga muito bem?",
--     "Você sabia que pode salvar sua o preset da sua roupa atual e voltar facilmente pra ela depois? [F9/Roupas/Guardar]"
-- }

-- local HelpDone = {}

-- AddStateBagChangeHandler('Active',('player:%s'):format(Player) , function(_, _, Value)
--     local Ped = PlayerPedId()
--     if Value then
--         CreateThread(function()
--             Wait(2500)
--             while true do
--                 -- if not LocalPlayer["state"]["Newbie"] then
--                 --     return
--                 -- end
--                 ::Another::
--                 if #HelpDone == #HelpNotify then
--                     HelpDone = {}
--                 end
--                 local Random = math.random(1,#HelpNotify)
--                 if HelpDone[Random] then
--                     goto Another
--                 end
--                 HelpDone[Random] = true
--                 TriggerEvent("Notify","dica",HelpNotify[Random],30000,"Dicas")
--                 Wait(1*1*5)
--             end
--         end)
--     end 
-- -- end)

RegisterCommand('testenotifymtt', function(source, args)
    local typeNotify = args[1]
    TriggerEvent('Notify', "hungry", 'Para aumentar o espaço entre o ícone.', 15000)
    TriggerEvent('Notify', "thirst", 'Para aumentar o espaço entre o ícone.', 15000)
end)