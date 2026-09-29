-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- VARIABLES
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- local Default = 1920 / 1080
-- local OffsetX,OffsetY = 0,0
-- local ResolutionX,ResolutionY = GetActiveScreenResolution()
-- local AspectRatio = ResolutionX / ResolutionY
-- local AspectDiff = Default - AspectRatio
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSTART
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
--     if LoadTexture("circleminimap") then
--         SetMinimapClipType(1)
--         UpdatePosition()
--     end

--     while true do
--         local ActualX,ActualY = GetActiveScreenResolution()
--         if ResolutionX ~= ActualX or ResolutionY ~= ActualY then
--             UpdatePosition()
--         end

--         Wait(10000)
--     end
-- end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- UPDATEPOSITION
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- function UpdatePosition()
--     ResolutionX,ResolutionY = GetActiveScreenResolution()

--     if AspectRatio > Default then
--         AspectDiff = Default - AspectRatio
--         OffsetX = AspectDiff / 3.6
--     end

--     AddReplaceTexture("platform:/textures/graphics","radarmasksm","circleminimap","radarmasksm")

--     SetMinimapComponentPosition("minimap","L","B",-0.0045 + OffsetX,-0.035 + OffsetY,0.175,0.225)
--     SetMinimapComponentPosition("minimap_mask","L","B",0.020 + OffsetX,0.105 + OffsetY,0.110,0.150)
--     SetMinimapComponentPosition("minimap_blur","L","B",-0.02 + OffsetX,-0.02 + OffsetY,0.265,0.225)

--     SetBigmapActive(true,false)

--     repeat
--         Wait(100)
--         SetBigmapActive(false,false)
--     until not IsBigmapActive()
-- end

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)