local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_creator")
fclient = {}
Tunnel.bindInterface("nation_creator", fclient)

nation_skinshop = false -- deixe true caso use o script nation_skinshop

creatorCoords = vec3(-765.16,329.12,175.39)
creatorHeading = 272.13
-- 229.61

spawnCoords = vec3(272.46,-1201.88,29.28)
spawnHeading = 351.5

maxHealth = 200 -- vida máxima do player

---------------------------------------------------------------------------
-----------------------ANIMAÇÃO DE PARADO---------------------------
---------------------------------------------------------------------------

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function freezeAnim(dict, anim, flag, keep)
    if not keep then
        ClearPedTasks(PlayerPedId())
    end
    LoadAnim(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 2.0, 2.0, -1, flag or 1, 0, false, false, false)
    RemoveAnimDict(dict)
end



---------------------------------------------------------------------------
-----------------------ROUPAAS PADRÕES PARA A CRIAÇÃO--------------------------
---------------------------------------------------------------------------

resetCloths = function()
    local clothes = {
        [GetHashKey("mp_m_freemode_01")] = {
            ["gender"] = "male",
            ["bodyArmors"] = { 0, 0, 0 },
            ["torsos"] = { 15, 0, 2 },
            ["accessories"] = { -1, 0, 2 },
            ["hats"] = { -1,0 },
            ["masks"] = { 0,0,0 },
            ["undershirts"] = { 15, 0, 2 },
            ["shoes"] = { 34, 0, 2 },
            ["bracelets"] = { -1,0 },
            ["tops"] = { 15, 0, 2 },
            ["bags"] = { 0,0,0 },
            ["ears"] = { -1,0 },
            ["decals"] = { 0,0,0 },
            ["legs"] = { 61, 0, 2 },
            ["watches"] = { -1,0 },
            ["glasses"] = { -1,0 },
        },

        [GetHashKey("mp_f_freemode_01")] = {
            ["gender"] = "female",
            ["bodyArmors"] = { 0, 0, 0 },
            ["torsos"] = { 15, 0, 2 },
            ["accessories"] = { -1, 0, 2 },
            ["hats"] = { -1,0 },
            ["masks"] = { 0,0,0 },
            ["undershirts"] = { 14, 0, 2 },
            ["shoes"] = { 35, 0, 2 },
            ["bracelets"] = { -1,0 },
            ["tops"] = { 15, 0, 2 },
            ["bags"] = { 0,0,0 },
            ["ears"] = { -1,0 },
            ["decals"] = { 0,0,0 },
            ["legs"] = { 15, 0, 2 },
            ["watches"] = { -1,0 },
            ["glasses"] = { -1,0 },
        },
    }
    local model = GetEntityModel(PlayerPedId())
    setClothes(clothes[model] or {})
end




---------------------------------------------------------------------------
-----------------------ROUPAAS SETADAS APÓS CRIAR--------------------------
---------------------------------------------------------------------------

setCloths = function()
    local clothes = {
        [GetHashKey("mp_m_freemode_01")] = {
            ["gender"] = "male",
            ["bodyArmors"] = { 0, 0, 0 },
            ["torsos"] = { 0, 0, 2 },
            ["accessories"] = { -1, 0, 2 },
            ["hats"] = { -1,0 },
            ["masks"] = { 0,0,2 },
            ["undershirts"] = { 15, 0, 2 },
            ["shoes"] = { 1, 0, 2 },
            ["bracelets"] = { -1,0 },
            ["tops"] = { 16, 2, 2 },
            ["bags"] = { 0,0,0 },
            ["ears"] = { -1,0 },
            ["decals"] = { 0,0,0 },
            ["legs"] = { 4, 1, 2 },
            ["watches"] = { -1,0 },
            ["glasses"] = { -1,0 },
        },

        [GetHashKey("mp_f_freemode_01")] = {
            ["gender"] = "female",
            ["bodyArmors"] = { 0, 0, 0 },
            ["torsos"] = { 14, 0, 2 },
            ["accessories"] = { 0, 0, 2 },
            ["hats"] = { -1,0 },
            ["masks"] = { 0,0,0 },
            ["undershirts"] = { 6, 0, 2 },
            ["shoes"] = { 49, 0, 2 },
            ["bracelets"] = { -1,0 },
            ["tops"] = { 338, 7, 2 },
            ["bags"] = { 0,0,0 },
            ["ears"] = { -1,0 },
            ["decals"] = { 0,0,0 },
            ["legs"] = { 110, 0, 2 },
            ["watches"] = { -1,0 },
            ["glasses"] = { -1,0 },
        },
    }
    local model = GetEntityModel(PlayerPedId())
    setClothes(clothes[model] or {})
end




---------------------------------------------------------------------------
-----------------------CÂMERAS--------------------------
---------------------------------------------------------------------------

local cameras = {
    body = { coords = vec3(0.0, 2.5, 0.8), point = vec3(0.0,0.0,0.0), f = function() freezeAnim("move_f@multiplayer", "idle") end }, 
    head = { coords = vec3(0.0, 0.5, 0.7), point = vec3(0.0,0.0,0.67), f = function() freezeAnim("mp_sleep", "bind_pose_180", 1, true) end },
    eye = { coords = vec3(0.0, 0.27, 0.7), point = vec3(0.0,0.0,0.7), f = function() freezeAnim("mp_sleep", "bind_pose_180", 1, true) end },
    mouth = { coords = vec3(0.0, 0.27, 0.63), point = vec3(0.0,0.0,0.63), f = function() freezeAnim("mp_sleep", "bind_pose_180", 1, true) end },
    chest = { coords = vec3(0.0, 1.2, 0.4), point = vec3(0.0,0.0,0.2), f = function() freezeAnim("mp_sleep", "bind_pose_180", 1, true) end }, 
}


componentCams = {
    ["chestHair"] = "chest",
    ["hair"] = "head",
    ["facialHair"] = "head",
    ["blush"] = "head",
    ["lipstick"] = "mouth",
    ["makeup"] = "head",
}

local activeCam

function interpCamera(cameraName)
    if cameras[cameraName] then
        if cameraName == activeCam then return end
        activeCam = cameraName
        local ped = PlayerPedId()
        SetEntityHeading(ped, creatorHeading)
        local cam = cameras[cameraName]
        local coord = GetOffsetFromEntityInWorldCoords(ped,cam.coords)
        local tempCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
        local pointCoords = GetOffsetFromEntityInWorldCoords(ped,cam.point)
        SetCamActive(tempCam, true)
        SetCamActiveWithInterp(tempCam, fixedCam, 600, true, true)
        PointCamAtCoord(tempCam, pointCoords)
        if cam.f then cam.f() end
        CreateThread(function()
            Wait(600)
            DestroyCam(fixedCam)
            fixedCam = tempCam
        end)
    end
end



function createCamera()
    local ped = PlayerPedId()
    local groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    AttachCamToEntity(groundCam, ped, 0.0, -2.0, 0.0)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    activeCam = "body"
    local cam = cameras[activeCam]
    local coord = GetOffsetFromEntityInWorldCoords(ped,cam.coords)
    fixedCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
    local pointCoords = GetOffsetFromEntityInWorldCoords(ped,cam.point)
    PointCamAtCoord(fixedCam, pointCoords)
    SetCamActive(fixedCam, true)
    SetCamActiveWithInterp(fixedCam, groundCam, 1000, true, true)
    if cam.f then cam.f() end
    CreateThread(function()
        Wait(1000)
        DestroyCam(groundCam)
    end)
end






getPopupText = function(data) -- TEXTO QUE VAI APARECER NO POPUP NA HORA DE FINALIZAR A CRIAÇÃO
    name, lastName, age = data.name, data.lastName, math.floor(tonumber(data.age or 0) or 0)
    if not name or name:len() < 2 or name:len() > 16 or name:find(" ") or name:match("%d+") then
        return false , "nome inválido"
    end

    if not lastName or lastName:len() < 2 or lastName:len() > 16 or lastName:find(" ") or lastName:match("%d+") then
        return false , "sobrenome inválido"
    end

    if not age or age < 20 or age > 70 then
        return false , "idade inválida"
    end
    return true, "deseja criar o personagem "..data.name.." "..data.lastName.." ("..age.." anos) ?"
end




function teleport(ply,x, y, z)
    if type(x) == "vector3" then
        x,y,z = table.unpack(x)
    end
    FreezeEntityPosition(ply, true)
    SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    local timer = 10
    while not HasCollisionLoadedAroundEntity(ply) and timer > 0 do
        FreezeEntityPosition(ply, true)
        SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
        RequestCollisionAtCoord(x, y, z)
        Wait(500)
        timer = timer - 1
    end
    SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
    FreezeEntityPosition(ply, false)
    Wait(1000)
end





function initCreator()
    loadingPlayer(true)
    TriggerEvent('hud:Active', false)
    TriggerEvent("nation_barbershop:stop")
    func._changeSession(GetPlayerServerId(PlayerId()))
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(500)
    teleport(ped, creatorCoords)
    SetEntityHeading(ped, creatorHeading)
    setGender("male")
    TriggerEvent("reloadtattos", { tattoos = {}, overlay = 0 })
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    resetCloths()
    SetFacialIdleAnimOverride(PlayerPedId(), "pose_normal_1", 0)
    Wait(1000)
    DoScreenFadeIn(1000)
end


function finishCreator()
    changeClothes() -- nation_skinshop
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1500)
    teleport(ped, spawnCoords)
    SetEntityHeading(ped, spawnHeading)
    FreezeEntityPosition(ped, false)
    SetEntityHealth(ped, GetPedMaxHealth(ped))
    func._updateLogin()
    func._changeSession(0)
    Wait(1000)
    DoScreenFadeIn(1000)
    TriggerEvent('hud:Active', true)
end

RegisterNetEvent("nation_creator:finishClothes")
AddEventHandler("nation_creator:finishClothes", function()
    clothesFinished = true
    Wait(5000)
    clothesFinished = false
end)



function changeClothes()
    if nation_skinshop and GetResourceState("nation_skinshop") == "started" then
        TriggerEvent("nation_skinshop:toggleMenu", "nation_creator")
        while not clothesFinished do
            Wait(500)
        end
    else
        setCloths()
        func._saveClothes(getCloths())
    end
end


function setGender(gender)    
    local model = "mp_m_freemode_01"
    if gender == "female" then
        model = "mp_f_freemode_01"
    elseif gender ~= "male" then
        model = gender
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(100)   
    end
    local ped = PlayerPedId()
    local currentHealth, currentMaxHealth, currentArmour = GetEntityHealth(ped), GetPedMaxHealth(ped), GetPedArmour(ped)
    local weapons = vRP.getWeapons() or {}
    SetPlayerModel(PlayerId(), model)
    ped = PlayerPedId()
    SetPedMaxHealth(ped, maxHealth) -- setar vida maxima 
    SetEntityHealth(ped, currentHealth)
    SetPedArmour(ped, currentArmour)
    --vRP.giveWeapons(weapons,true)
    resetCloths()
    if gender == "male" then
        SetPedHeadBlendData(ped, 21, 0, 0, 21, 0, 0, 0.8, 0.8, 0.0, false)
    else
        SetPedHeadBlendData(ped, 21, 0, 0, 21, 0, 0, 0.2, 0.2, 0.0, false)
    end
end





function fclient.spawnPlayer(firstspawn)
    loginSpawn(not firstspawn)
end


function loadingPlayer(stats)
    TriggerEvent('hud:Active', false)
    TriggerEvent("forcereloadtattos")
    local ped = PlayerPedId()
    SetEntityInvincible(ped,false)
    SetEntityVisible(ped,stats)
    LocalPlayer["state"]["Invisible"] = not stats
    FreezeEntityPosition(ped,not stats)
end

function parseFloat(num)
    local n = tonumber(num..".0")
    if not n then n = tonumber(num) or num end
    return n
end

function f(num)
    local n = parseFloat(string.format("%.2f", tostring(num)))
    return n
end


local overlays = {
    [GetHashKey("mp_m_freemode_01")] = {
        { collection = 'mpbeach_overlays', overlay = 'FM_Hair_Fuzz' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_003' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_004' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_005' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_006' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_008' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_009' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_013' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_011' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_012' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGInd_M_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_001' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_002' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_004' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_005' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_006' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_005_M' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_003' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_004' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_005' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_006' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_008' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_009' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_013' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_011' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_012' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGInd_M_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_001' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_002' },
        { collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_004' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_005' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_006' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_M' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_005_M' },
        { collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_M_000_M'},
        { collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_M_001_M'}
    },

    [GetHashKey("mp_f_freemode_01")] = {
        { collection = 'mpbeach_overlays', overlay = 'FM_Hair_Fuzz' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_004' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_005' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_006' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_008' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_009' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_010' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_011' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_012' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_013' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGInd_F_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_001' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_002' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_004' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_006' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_F' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_006_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_F' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_002' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_004' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_005' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_006' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_008' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_009' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_010' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_011' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_012' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_013' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014' },
        { collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001' },
        { collection = 'multiplayer_overlays', overlay = 'NGHip_F_Hair_000' },
        { collection = 'multiplayer_overlays', overlay = 'NGInd_F_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_000' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_001' },
        { collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_002' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_004' },
        { collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_006' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_F' },
        { collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_006_F' },
        { collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_F' },
        { collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_F_000_F' },
        { collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_F_001_F' }
    }
}

function getOverlays()
    if GetResourceState("nation_tattoos") == "started" then
        return exports["nation_tattoos"].getOverlays()
    elseif GetResourceState("nation_barbershop") == "started" then
        return exports["nation_barbershop"].getOverlays()
    end
    return {}
end

function getOverlayByIndex(index)
    if GetResourceState("nation_tattoos") == "started" then
        return exports["nation_tattoos"].getOverlayByIndex(index)
    elseif GetResourceState("nation_barbershop") == "started" then
        return exports["nation_barbershop"].getOverlayByIndex(index)
    end
end




----------------------------------------------------------------------------
-------------------------- MULTI CHAR --------------------------------------
----------------------------------------------------------------------------



RegisterNetEvent("spawn:setupChars")
AddEventHandler("spawn:setupChars", function()
    Wait(1000)
    while not loaded do
        Wait(1000)
    end
    toggleMultiChar()
end)



function initMultiChar()
    loadingPlayer(false)
    func._changeSession(GetPlayerServerId(PlayerId()))
    TriggerEvent("nation_barbershop:stop")
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(500)
    FreezeEntityPosition(ped, true)
    local x,y,z = table.unpack(creatorCoords)
    teleport(ped, x,y,z-0.9)
    SetEntityHeading(ped, creatorHeading)
    Wait(1000)
    setCameraCoords("body")
    DoScreenFadeIn(1000)
end


function leaveMultiChar()
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1500)
    FreezeEntityPosition(ped, false)
    func._changeSession(0)
    deleteCam()
    Wait(1000)
end


function selectCharacter(info)
    if info then
        setPlayerChar(info.char)
        setClothing(info.clothes)
        TriggerEvent("nation_barbershop:init", info.char)
        func._setPlayerTattoos(info.user_id)
    end
    loadingPlayer(info ~= nil)
end


function playChar(info)
    if not info then return end
    func._playChar(info)
    toggleMultiChar()
end

function createChar()
    if func.tryCreateChar() then
        toggleMultiChar()
        startCreator()
    end
end

function getDeleteCharMessage(info)
    if info and info.char then
        return true, "deseja realmente deletar o personagem "..info.name.." "..info.id.." ?"
    end
    return false, "error"
end

function tryDeleteChar(info)
    local success, message = func.tryDeleteChar(info)
    return success, message
end


----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------


function setClothing(data)
	local ped = PlayerPedId()
    if not data then
        return resetCloths()
    end
    if not data.pants then
        return setClothes(data)
    end

    if data["backpack"] == nil then
		data["backpack"] = {}
		data["backpack"]["item"] = 0
		data["backpack"]["texture"] = 0
	end

    local components = { mask = 1, arms = 3, pants = 4, backpack = 5, shoes = 6, accessory = 7, tshirt = 8, vest = 9, decals = 10, torso = 11 }
    local props = { hat = 0, glass = 1, ear = 2, watch = 6, bracelet = 7 }
    for comp, i in pairs(components) do
        if data[comp] then
            SetPedComponentVariation(ped,i,data[comp].item,data[comp].texture,2)
        end
    end
    for prop, i in pairs(props) do
        if data[prop] and data[prop].item > 0 then
            SetPedPropIndex(ped,i,data[prop].item,data[prop].texture,2)
        else
            ClearPedProp(ped,i)
        end
    end
end

fclient.setClothing = setClothing






------------------------- CUT SCENE-----------------------------

local sub_b0b5 = {
    [0] = "MP_Plane_Passenger_1",
    [1] = "MP_Plane_Passenger_2",
    [2] = "MP_Plane_Passenger_3",
    [3] = "MP_Plane_Passenger_4",
    [4] = "MP_Plane_Passenger_5",
    [5] = "MP_Plane_Passenger_6",
    [6] = "MP_Plane_Passenger_7"
}

function sub_b747(ped, a_1)
    if a_1 == 0 then
        SetPedComponentVariation(ped, 0, 21, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 9, 0, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 9, 0, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 4, 8, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 15, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 10, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 1 then
        SetPedComponentVariation(ped, 0, 13, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 5, 4, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 10, 0, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 10, 0, 0)
        SetPedComponentVariation(ped, 7, 11, 2, 0)
        SetPedComponentVariation(ped, 8, 13, 6, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 10, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 2 then
        SetPedComponentVariation(ped, 0, 15, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 1, 4, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 0, 1, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 7, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 9, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 6, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 3 then
        SetPedComponentVariation(ped, 0, 14, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 5, 3, 0)
        SetPedComponentVariation(ped, 3, 3, 0, 0)
        SetPedComponentVariation(ped, 4, 1, 6, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 11, 5, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 3, 12, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 4 then
        SetPedComponentVariation(ped, 0, 18, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 15, 3, 0)
        SetPedComponentVariation(ped, 3, 15, 0, 0)
        SetPedComponentVariation(ped, 4, 2, 5, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 4, 6, 0)
        SetPedComponentVariation(ped, 7, 4, 0, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 4, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 5 then
        SetPedComponentVariation(ped, 0, 27, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 7, 3, 0)
        SetPedComponentVariation(ped, 3, 11, 0, 0)
        SetPedComponentVariation(ped, 4, 4, 8, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 13, 14, 0)
        SetPedComponentVariation(ped, 7, 5, 3, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 2, 7, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 6 then
        SetPedComponentVariation(ped, 0, 16, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 15, 1, 0)
        SetPedComponentVariation(ped, 3, 3, 0, 0)
        SetPedComponentVariation(ped, 4, 5, 6, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 2, 8, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 3, 7, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    end
end

function IsMale(ped)
	if IsPedModel(ped, 'mp_m_freemode_01') then
		return true
	else
		return false
	end
end



------------------------------------------------------------------



------------------------- LOGIN-----------------------------

spawns = {
    { name = "Garagem Praça", coords = {55.04,-878.8,30.37,176.39} },
    { name = "Garagem Sandy Shores", coords = {318.1,2623.98,44.47,268.35} },
    { name = "Garagem Paleto", coords = {-772.95,5595.9,33.49,168.85} },
    { name = "Metrô", coords = {-798.69,-99.21,37.62,277.17} },
    { name = "Aeroporto", coords = {-1035.74,-2733.37,13.76,324.76} },
}


function fclient.setPlayerLastCoords(coords)
    if lastCoords then return end
    lastCoords = coords
    table.insert(spawns, { name = "Última Localização", coords = lastCoords })
end





local cam = nil
function loginSpawn(status)
    TriggerEvent('hookSelector',status)
end


function changeLoginCam(x,y,z)
	local ped = PlayerPedId()
    local myCoords = GetEntityCoords(ped)
    if #(myCoords - vec3(x,y,z)) < 3 then return end
    changingSpawnCam = true
    SetEntityCoordsNoOffset(ped, x,y,z)
    local coord = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,200.0)
    local tempCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
    local tempCamPoint = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
    local camPoint = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", myCoords.x, myCoords.y, myCoords.z+200, 0,0,0, 50.0)
    PointCamAtCoord(tempCam, coord)
    PointCamAtCoord(camPoint, coord)
    PointCamAtCoord(tempCamPoint, x,y,z)
    SetCamActive(camPoint, true)
    SetCamActiveWithInterp(camPoint, cam, 500, true, true)
    Wait(500)
    DestroyCam(cam)
    cam = camPoint
    SetCamActive(tempCam, true)
    SetCamActiveWithInterp(tempCam, cam, 1000, true, true)
    Wait(1000)
    DestroyCam(cam)
    cam = tempCam
    SetCamActive(tempCamPoint, true)
    SetCamActiveWithInterp(tempCamPoint, cam, 500, true, true)
    Wait(500)
    DestroyCam(cam)
    cam = tempCamPoint
    changingSpawnCam = false
end

function GetHeadBlendData(ped)
    local p = {Citizen.InvokeNative(0x2746BD9D88C5C5D0, ped, Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueIntInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0), Citizen.PointerValueFloatInitialized(0))}
    local headBlendData = {
        shapeFirst = p[1],
        shapeSecond = p[2],
        shapeThird = p[3],
        skinFirst = p[4],
        skinSecond = p[5],
        skinThird = p[6],
        shapeMix = p[7],
        skinMix = p[8],
        thirdMix = p[9]
    }
    return headBlendData
end

RegisterNetEvent("login:Spawn")
AddEventHandler("login:Spawn",loginSpawn)


RegisterNetEvent("nation_creator:forceSaveChar")
AddEventHandler("nation_creator:forceSaveChar", function(user_id)
    local char = getPlayerChar(PlayerPedId())
    func._saveChar(false, false, false, char, user_id)
    TriggerEvent("nation_barbershop:init", char)
end)


CreateThread(function()
    loadingPlayer(false) -- comentar caso nao queira que o player fique invisível quando spawna
    while true do
        if inMultiChar or inMenu or inLoginMenu or spawnned then
            break
        end
        local ped = PlayerPedId()
        SetEntityInvincible(ped,true)
        SetEntityVisible(ped,false)
        FreezeEntityPosition(ped,true)
        Wait(10)
    end
end)


AddEventHandler("onClientResourceStart",function(Resource)
	if (GetCurrentResourceName() ~= Resource) then
		return
	end
	DoScreenFadeOut(0)
	DisplayRadar(false)
	ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()
	TriggerServerEvent("Queue:Connect")
    TriggerEvent("spawn:setupChars")
end)

local components = {
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

local getMyClothes = function()
    local ped = PlayerPedId()
	local custom = {}
	for i = 0,20 do
        local k = components[i]
        if k then
		    custom[k] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
        end
	end

	for i = 0,10 do
        local k = components["p"..i]
        if k then
		    custom[k] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
        end
	end
	return custom
end

local skinData = {
	["pants"] = "legs",
	["arms"] = "torsos",
	["tshirt"] = "undershirts",
	["torso"] = "tops",
	["vest"] = "bodyArmors",
	["backpack"] = "bags",
	["shoes"] = "shoes",
	["mask"] = "masks",
	["hat"] = "hats",
	["glass"] = "glasses",
	["ear"] = "ears",
	["watch"] = "watches",
	["bracelet"] = "bracelets",
	["accessory"] = "accessories",
	["decals"] = "decals"
}



function getCloths()
    local myCloths = getMyClothes()
    local cloths = {}
    for cloth, comp in pairs(skinData) do
        local item = myCloths[comp][1]
        local texture = myCloths[comp][2]
        cloths[cloth] = { item = item, texture = texture }
    end
    return cloths
end