player = {}

headOverlays = {
    [0] = "blemishes",
    [1] = "facialHair",
    [2] = "eyebrows",
    [3] = "ageing",
    [4] = "makeup",
    [5] = "blush",
    [6] = "complexion",
    [7] = "sunDamage",
    [8] = "lipstick",
    [9] = "freckles",
    [10] = "chestHair",
    [11] = "bodyBlemishes",
    [12] = "addBodyBlemishes",
}

faceFeatures = {
    [0] = "noseWidth",
    [1] = "nosePeakHeight",
    [2] = "nosePeakLength",
    [3] = "noseBoneHigh",
    [4] = "nosePeakLowering",
    [5] = "noseBoneTwist",
    [6] = "eyeBrownHigh",
    [7] = "eyeBrownForward",
    [8] = "cheeksBoneHigh",
    [9] = "cheeksBoneWidth",
    [10] = "cheeksWidth",
    [11] = "eyesOpenning",
    [12] = "lipsThickness",
    [13] = "jawBoneWidth",
    [14] = "jawBoneBackLength",
    [15] = "chinBoneLowering",
    [16] = "chinBoneLength",
    [17] = "chinBoneWidth",
    [18] = "chinHole",
    [19] = "neckThickness"
}


function getHeadOverlayIndex(overlay)
    for k,v in pairs(headOverlays) do
        if v == overlay or overlay == v.."-color" or overlay == v.."-opacity" then
            return k
        end
    end
end


function getFaceFeatureIndex(faceFeature)
    for k,v in pairs(faceFeatures) do
        if v == faceFeature then
            return k
        end
    end
end



local updateHair = function()
    local ped = PlayerPedId()
    SetPedComponentVariation(ped, 2, player["hair"], 0, 0)
    SetPedHairColor(ped, player["hair-color"], player["hair-highlightcolor"])
    ClearPedDecorationsLeaveScars(ped)
    if GetResourceState("nation_tattoos") == "started" then
        return exports["nation_tattoos"]:setTattoos({ tattoos = player.tattoos, overlay = player.overlay })
    end
    if player.overlay and player.overlay > 0 then
        local decoration = getOverlayByIndex(player.overlay)
        if decoration then
            local collection = GetHashKey(decoration.collection)
            local overlay = GetHashKey(decoration.overlay)
            AddPedDecorationFromHashesInCorona(ped, collection, overlay)
        end
    end
end


local actions = {
    gender = function(key, gender)
        if player.gender == gender then return end
        player[key] = gender
        setGender(player[key])
        local ped = PlayerPedId()
        freezeAnim("move_f@multiplayer", "idle")
        SetFacialIdleAnimOverride(ped, "pose_normal_1", 0)
        player = getPlayerChar(ped, true)
        SendNUIMessage({action = "updatePlayer", player = player})
    end,


    headBlendData = function(key, value)
        if (key == "shapeMix" or key == "skinMix") then
            player[key] = parseFloat(value)
        else
            player[key] = value
        end
        SetPedHeadBlendData(PlayerPedId(), player.shapeFirst, player.shapeSecond, player.shapeThird or 0, player.skinFirst, player.skinSecond, player.skinThird or 0, player.shapeMix, player.skinMix, player.thirdMix or f(0), false)
    end,


    headOverlays = function(key, value)
        local overlayId = getHeadOverlayIndex(key)
        if overlayId then
            player[key] = value
            local colourType = 0
            if key:find("eyebrows") or key:find("facialHair") or key:find("chestHair") then
                colourType = 1
            elseif key:find("blush") or key:find("lipstick") or key:find("makeup") then
                colourType = 2
            end
            if key:find("-color") then
                if player[key] == -1 then
                    colourType = 0
                    player[key] = -1
                    SetPedHeadOverlayColor(PlayerPedId(), overlayId, colourType, 0, 0)
                end
                key = key:gsub("-color", "")
            elseif key:find("-opacity") then
                player[key] = parseFloat(value)
                key = key:gsub("-opacity", "")
            end
            SetPedHeadOverlay(PlayerPedId(), overlayId, player[key], player[key.."-opacity"])
            SetPedHeadOverlayColor(PlayerPedId(), overlayId, colourType, player[key.."-color"], player[key.."-color"])
        end
    end,


    faceFeatures = function(key, value)
        local index = getFaceFeatureIndex(key)
        if index then
            player[key] = parseFloat(value)
            SetPedFaceFeature(PlayerPedId(), index, player[key])
        end
    end,

    eyes = function(key, value)
        player[key] = value
        SetPedEyeColor(PlayerPedId(), player[key])
    end,

    hair = function(key, value)
        player[key] = value
        updateHair()
    end,


}



function getActionByKey(key)
    local blendData = { "shapeFirst",  "shapeSecond", "shapeMix", "skinFirst", "skinSecond", "skinMix" }
    for i, v in ipairs(blendData) do
        if key == v then
            return "headBlendData"
        end
    end
    if getHeadOverlayIndex(key) then
        return "headOverlays"
    end
    if getFaceFeatureIndex(key) then
        return "faceFeatures"
    end

    if key:find("hair") then
        return "hair"
    end
    return key
end




getGender = function(ped)
    if not ped then ped = PlayerPedId() end
    if GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        return "female"
    end
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        return "male"
    end
    return ""
end






getPlayerChar = function(ped, total)
    local char = {}
    local headBlendData = GetHeadBlendData(ped)
    for k,v in pairs(headBlendData) do
        char[k] = v
    end
    for k,v in pairs(headOverlays) do
        local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(ped, k)
        if success then
            if overlayValue == 255 then overlayValue = -1 end
            char[v] = overlayValue
            char[v.."-color"] = firstColour
            char[v.."-opacity"] = f(overlayOpacity)
            if v == "makeup" and colourType == 0 then
                char[v.."-color"] = -1
            end
            if total then
                char[v.."-max"] = GetPedHeadOverlayNum(k)
            end
        end
    end
    for k,v in pairs(faceFeatures) do
        char[v] = f(GetPedFaceFeature(ped, k))
    end
    char.gender = getGender(ped)
    char.eyes = GetPedEyeColor(ped)
    if char.eyes == -1 or char.eyes > 31 then
        SetPedEyeColor(ped, 0)
        char.eyes = 0
    end
    char.hair = GetPedDrawableVariation(ped,2)
    char["hair-color"] = GetPedHairColor(ped)
    char["hair-highlightcolor"] = GetPedHairHighlightColor(ped)
    if char["hair-color"] == -1 then char["hair-color"] = 0 end
    if char["hair-highlightcolor"] == -1 then char["hair-highlightcolor"] = 0 end
    SetPedHairColor(ped, char["hair-color"], char["hair-highlightcolor"])

    if GetResourceState("nation_tattoos") == "started" then
        char.tattoos, char.overlay = exports["nation_tattoos"]:getTattoos()
    else
        char.tattoos, char.overlay = {}, player.overlay or func.getOverlay()
    end
    if total then
        char["eyes-min"] = 0
        char["eyes-max"] = 32
        char["hair-min"] = 0
        char["hair-max"] = GetNumberOfPedDrawableVariations(ped, 2)
        char["overlay-min"] = 0
        char["overlay-max"] = #getOverlays()

        for k,v in ipairs({ "shapeFirst",  "shapeSecond", "shapeMix", "skinFirst", "skinSecond", "skinMix" }) do
            char[v.."-min"] = 0
        end

        char.overlay = 0
    else
        char.overlay = player.overlay or func.getOverlay() 
    end
    return char
end


setPlayerChar = function(char, forceGender)
    player = char
    if char.gender ~= getGender(PlayerPedId()) or forceGender then
        setGender(char.gender)
    end
    for k,v in pairs(char) do
        if k ~= "gender" then
            local action = getActionByKey(k)
            local f = actions[action]
            if f then f(k, v) end
        end
    end
    if inMenu then
        setCameraCoords("body")
    end
end

fclient.setPlayerChar = setPlayerChar






components = {
    [1] = "masks",
    [3] = "torsos",
    [4] = "legs",
    [5] = "bags",
    [6] = "shoes",
    [7] = "accessories",
    [8] = "undershirts",
    [9] = "bodyArmors",
    [10] = "decals",
    [11] = "tops",
    ["p"..(0)] = "hats",
    ["p"..(1)] = "glasses",
    ["p"..(2)] = "ears",
    ["p"..(6)] = "watches",
    ["p"..(7)] = "bracelets",
}


getComponentKey = function(component)
    for key, comp in pairs(components) do
        if comp == component then return key end
    end
    return component
end

parse_part = function(component)
    local key = getComponentKey(component)
    if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

setClothes = function(custom)
    local ped = PlayerPedId()
    for k,v in pairs(custom or {}) do
        if type(v) == "table" and v[1] then
            local isprop, index = parse_part(k)
            if isprop then
                if v[1] < 0 then
                    ClearPedProp(ped,index)
                else
                    SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
                end
            else
                SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
            end
        end
    end
end






rotate = function(data)
    if not inMenu and not inMultiChar then return end
    local ped = PlayerPedId()
    local amount = 5
    if data.increase then amount = -amount end
    SetEntityHeading(ped, GetEntityHeading(ped) + amount)
end

setCameraCoords = function(preset)
    if not DoesCamExist(fixedCam) then
        createCamera()
    end
    interpCamera(preset)
end

deleteCam = function()
    DestroyCam(fixedCam)
	DestroyAllCams(true)
    RenderScriptCams(false, true, 500, true, true)
end

changeCam = function(data)
    if data.cam and inMenu then 
        setCameraCoords(data.cam)
    end
end

requestPopup = function(data, cb)
    if inMenu then
        local success, message = getPopupText(data)
        cb({success = success, message = message})
        return
    end
    cb({message = "ERROR!"})
end

local requestAuth = function()
    while not loaded do
        Wait(1000)
        SendNUIMessage({message = "authenticated " })
    end
end





local changeChar = function(data)
    if not inMenu or (not data or not data.key) then return end
    local key, value = data.key, data.value
    local action = getActionByKey(key)
    local f = actions[action]
    if f then f(key, value) end
end


local finishCreation = function(data, cb)
    if not inMenu then return cb(false, "ERROR") end
    if func.saveChar(name, lastName, age, getPlayerChar(PlayerPedId())) then
        cb(true)
        Wait(3000)
        closeMenu()
        finishCreator()
    end
end



function getRgbColors(makeup)
    local colors = {}
    local f = GetPedHairRgbColor
    if makeup then 
        f = GetPedMakeupRgbColor
    end
    for i = 0, 63 do
        local r,g,b = f(i)
        table.insert(colors, {r,g,b})
    end
    return colors
end

inMenu = false
startCreator = function()
    if inMenu or inMultiChar then return end
    inMenu = true
    initCreator()
    local colors, makeUpColors = getRgbColors(false), getRgbColors(true)
    player = getPlayerChar(PlayerPedId(), true)
    SetNuiFocus(true, true)
    SendNUIMessage({action = "show", player = player, componentCams = componentCams, colors = colors, makeUpColors = makeUpColors})
    setCameraCoords("body")
end

fclient.startCreator = startCreator

closeMenu = function() 
    SetNuiFocus(false, false)
    SendNUIMessage({action = "hide"})
    deleteCam()
    ClearPedTasks(PlayerPedId())
    ClearFacialIdleAnimOverride(PlayerPedId())
    inMenu = false
end


RegisterNUICallback("close", closeMenu)
RegisterNUICallback("rotate", rotate)
RegisterNUICallback("changeCam", changeCam)
RegisterNUICallback("change", changeChar)
RegisterNUICallback("requestPopup", requestPopup)
RegisterNUICallback("finish", finishCreation)
RegisterNUICallback("requestAuth", requestAuth)

RegisterNUICallback("loaded", function(data, cb)
    if loaded then return end
    loaded = true
end)

CreateThread(requestAuth)

-----------------------------------------------------------------------------------------
-------------------------------------- MULTI CHAR --------------------------------------
-----------------------------------------------------------------------------------------

inMultiChar = false
function toggleMultiChar()
    ShutdownLoadingScreenNui()
    if inMenu then return end
    inMultiChar = not inMultiChar
    if inMultiChar then
        initMultiChar()
        SetNuiFocus(true, true)
        TriggerEvent('hud:Active', false)
        myChars = func.getCharsInfo()
        SendNUIMessage({action = "showMultiChar", charInfos = myChars})
    else 
        SetNuiFocus(false, false)
        TriggerEvent('hud:Active', true)
        SendNUIMessage({action = "hideMultiChar"})
        leaveMultiChar()
    end
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

local multiCharButtons = {
    selectChar = function(data, cb)
        if not inMultiChar then return end
        local index = data.char+1
        local chars = myChars.chars
        selectCharacter(chars[index])
    end,

    playChar = function(data)
        if not inMultiChar then return end
        local index = data.char+1
        local chars = myChars.chars
        playChar(chars[index])
    end,

    createChar = function(data)
        if not inMultiChar then return end
        createChar()
    end,

    tryDeleteChar = function(data, cb)
        if not inMultiChar then return end
        local index = data.char+1
        local chars = myChars.chars
        local success, message = getDeleteCharMessage(chars[index])
        cb({success=success, message=message, char = index})
    end,

    deleteChar = function(data, cb)
        if not inMultiChar then return end
        local index = data.char
        local char = myChars.chars[index]
        local success, message = tryDeleteChar(char)
        cb({success=success, message=message})
        if success then
            myChars = func.getCharsInfo()
            SendNUIMessage({action = "showMultiChar", charInfos = myChars})
            selectCharacter()
        end
    end
}

for btn, f in pairs(multiCharButtons) do
    RegisterNUICallback(btn, f)
end


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------




inLoginMenu = false
function toggleLogin(stats)
    if inMenu or inMultiChar then return end
    if stats ~= nil then 
        inLoginMenu = stats
    else
        inLoginMenu = not inLoginMenu
    end
    if inLoginMenu then
        func.getUserLastPosition()
        SetNuiFocus(true, true)
        SendNUIMessage({action = "showLogin", spawns = spawns})
    else 
        SetNuiFocus(false, false)
        SendNUIMessage({action = "hideLogin"})
    end
end


activeSpawnCam = -1
RegisterNUICallback("changeSpawnCam", function(data, cb)
    if not inLoginMenu then return end
    local spawn = spawns[data.spawn]
    if spawn and activeSpawnCam ~= data.spawn and not changingSpawnCam then
        cb(true)
        activeSpawnCam = data.spawn
        local x,y,z = table.unpack(spawn.coords)
        changeLoginCam(x,y,z)
        return
    end
    cb(false)
end)

RegisterNUICallback("spawnChar", function(data)
    if not inLoginMenu then return end
    local spawn = spawns[data.spawn]
    if spawn and not changingSpawnCam then
        local x,y,z = table.unpack(spawn.coords)
        loginSpawn(false)
        activeSpawnCam = -1
    end
end)



