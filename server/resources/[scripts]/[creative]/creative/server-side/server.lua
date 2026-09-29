-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local GlobalState = GlobalState

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEATHER SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local WeatherTypes = {
    "EXTRASUNNY",
    "CLEAR",
    "CLOUDS",
    "SMOG",
    "FOGGY",
    "OVERCAST",
    "RAIN",
    "THUNDER",
    "CLEARING",
    "NEUTRAL",
    "SNOW",
    "BLIZZARD",
    "SNOWLIGHT",
    "XMAS"
}

local CurrentWeather = "CLEAR"
local CurrentHour = 12
local CurrentMinute = 0

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATE GLOBAL STATE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        -- Update weather
        GlobalState["Weather"] = CurrentWeather
        
        -- Update time
        GlobalState["Hours"] = CurrentHour
        GlobalState["Minutes"] = CurrentMinute
        
        -- Update time every minute
        CurrentMinute = CurrentMinute + 1
        if CurrentMinute >= 60 then
            CurrentMinute = 0
            CurrentHour = CurrentHour + 1
            if CurrentHour >= 24 then
                CurrentHour = 0
            end
        end
        
        Wait(60000) -- Update every minute
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RANDOM WEATHER CHANGE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(1800000) -- Change weather every 30 minutes
        CurrentWeather = WeatherTypes[math.random(#WeatherTypes)]
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER CONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnecting", function()
    local source = source
    print("[Creative] Player connecting: " .. GetPlayerName(source))
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER JOINED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerSpawned", function()
    local source = source
    print("[Creative] Player spawned: " .. GetPlayerName(source))
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DISCONNECTED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped", function(reason)
    local source = source
    print("[Creative] Player disconnected: " .. GetPlayerName(source) .. " - Reason: " .. reason)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCE STOP HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("AnyResourceStop", function(resourceName)
    print("[Creative] Resource stopped: " .. resourceName)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("creative_weather", function(source, args)
    if source == 0 or IsPlayerAceAllowed(source, "creative.admin") then
        if args[1] then
            local weather = string.upper(args[1])
            for _, weatherType in ipairs(WeatherTypes) do
                if weatherType == weather then
                    CurrentWeather = weather
                    print("[Creative] Weather changed to: " .. weather)
                    return
                end
            end
            print("[Creative] Invalid weather type. Available types:")
            for _, weatherType in ipairs(WeatherTypes) do
                print("  - " .. weatherType)
            end
        else
            print("[Creative] Current weather: " .. CurrentWeather)
        end
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to use this command."}})
    end
end, false)

RegisterCommand("creative_time", function(source, args)
    if source == 0 or IsPlayerAceAllowed(source, "creative.admin") then
        if args[1] and args[2] then
            local hour = tonumber(args[1])
            local minute = tonumber(args[2])
            
            if hour and minute and hour >= 0 and hour <= 23 and minute >= 0 and minute <= 59 then
                CurrentHour = hour
                CurrentMinute = minute
                print("[Creative] Time changed to: " .. string.format("%02d:%02d", hour, minute))
            else
                print("[Creative] Invalid time format. Use: /creative_time [hour] [minute] (0-23, 0-59)")
            end
        else
            print("[Creative] Current time: " .. string.format("%02d:%02d", CurrentHour, CurrentMinute))
        end
    else
        TriggerClientEvent("chat:addMessage", source, { color = {255, 0, 0}, multiline = true, args = {"[Creative]", "You don't have permission to use this command."}})
    end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERSION INFO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(3000)
    print("[Creative] Event handlers loaded successfully!")
    Wait(100)
    print("[Creative] Server-side script loaded successfully!")
    Wait(100)
    print("[Creative] Weather system initialized")
    Wait(100)
    print("[Creative] Time system initialized")
    Wait(100)
    print("[Creative] Debug commands registered")
end)
