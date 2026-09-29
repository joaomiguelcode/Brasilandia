RegisterServerEvent("bk_flames")
AddEventHandler("bk_flames", function(entity)
	TriggerClientEvent("bk_flames", -1, entity)
end)

RegisterCommand(Config.Comando, function(source, args, rawCommand)
    TriggerClientEvent("2step:ToggleAntiLag", source, 0)
end)