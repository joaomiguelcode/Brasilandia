-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT EVENT HANDLERS
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- TIME/WEATHER CHANGE EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("mTT:setTime")
AddEventHandler("mTT:setTime", function(arg)
    local source = source
    if not arg then return end
    
    if IsPlayerAceAllowed(source, "creative.admin") then
        TriggerClientEvent("mTT:setTime", -1, arg)
        print("[Creative] " .. GetPlayerName(source) .. " changed time to: " .. arg)
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to change time."}})
    end
end)

RegisterServerEvent("mTT:setWeather")
AddEventHandler("mTT:setWeather", function(arg)
    local source = source
    if not arg then return end
    
    if IsPlayerAceAllowed(source, "creative.admin") then
        TriggerClientEvent("mTT:setWeather", -1, arg)
        print("[Creative] " .. GetPlayerName(source) .. " changed weather to: " .. arg)
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to change weather."}})
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICATION SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:notifyAll")
AddEventHandler("creative:notifyAll", function(message, type)
    if message then
        TriggerClientEvent("Notify", -1, type or "azul", message, 5000)
    end
end)

RegisterServerEvent("creative:notifyPlayer")
AddEventHandler("creative:notifyPlayer", function(targetId, message, type)
    local source = source
    if targetId and message then
        if GetPlayerName(targetId) then
            TriggerClientEvent("Notify", targetId, type or "azul", message, 5000)
        else
            TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "Player not found."}})
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT LOGGING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:teleportUsed")
AddEventHandler("creative:teleportUsed", function(fromCoords, toCoords)
    local source = source
    if fromCoords and toCoords then
        print("[Creative] " .. GetPlayerName(source) .. " used teleport from " .. 
              string.format("%.2f, %.2f, %.2f", fromCoords.x, fromCoords.y, fromCoords.z) .. 
              " to " .. 
              string.format("%.2f, %.2f, %.2f", toCoords.x, toCoords.y, toCoords.z))
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT SYSTEM LOGGING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:driftActivated")
AddEventHandler("creative:driftActivated", function(vehicleHash)
    local source = source
    if vehicleHash then
        print("[Creative] " .. GetPlayerName(source) .. " activated drift mode in vehicle: " .. vehicleHash)
    end
end)

RegisterServerEvent("creative:driftDeactivated")
AddEventHandler("creative:driftDeactivated", function(vehicleHash)
    local source = source
    if vehicleHash then
        print("[Creative] " .. GetPlayerName(source) .. " deactivated drift mode in vehicle: " .. vehicleHash)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLE DAMAGE LOGGING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:vehicleDamaged")
AddEventHandler("creative:vehicleDamaged", function(vehicleHash, damageType, damageAmount)
    local source = source
    if vehicleHash and damageType and damageAmount then
        print("[Creative] " .. GetPlayerName(source) .. " vehicle damaged - Hash: " .. vehicleHash .. 
              ", Type: " .. damageType .. ", Amount: " .. damageAmount)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER STATE SYNC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:updatePlayerState")
AddEventHandler("creative:updatePlayerState", function(stateData)
    local source = source
    if stateData then
        -- Update player state on server side
        -- This can be used for admin tools or player tracking
        SetPlayerRoutingBucket(source, stateData.bucket or 0)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("creative_reload", function(source)
    if source == 0 or IsPlayerAceAllowed(source, "creative.admin") then
        print("[Creative] Reloading creative resource...")
        ExecuteCommand("refresh")
        ExecuteCommand("ensure creative")
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to use this command."}})
    end
end, false)

RegisterCommand("creative_status", function(source)
    if source == 0 or IsPlayerAceAllowed(source, "creative.admin") then
        local players = #GetPlayers()
        print("[Creative] Server Status:")
        print("  - Online Players: " .. players)
        print("  - Current Weather: " .. GlobalState["Weather"] or "UNKNOWN")
        print("  - Current Time: " .. (GlobalState["Hours"] or 0) .. ":" .. (GlobalState["Minutes"] or 0))
        
        if source ~= 0 then
            TriggerClientEvent("chat:addMessage", source, { 
                color = {0, 255, 0}, 
                multiline = true, 
                args = {"[Creative]", "Server status printed to console."}
            })
        end
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to use this command."}})
    end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ANTI-CHEAT LOGGING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("creative:suspiciousActivity")
AddEventHandler("creative:suspiciousActivity", function(activityType, details)
    local source = source
    if activityType and details then
        print("[Creative] [ANTI-CHEAT] " .. GetPlayerName(source) .. " - " .. activityType .. ": " .. details)
        
        -- Log to file if needed
        -- You can add webhook or database logging here
    end
end)
