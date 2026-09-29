-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface(GetCurrentResourceName(),Creative)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------

local cam = -1
local Dataset = {}
local animation = false
local previousSkinData = {}
local creatingCharacter = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINDATA
-----------------------------------------------------------------------------------------------------------------------------------------
local Dataset = {
	["pants"] = { item = 1, texture = 0 },
	["arms"] = { item = 0, texture = 0 },
	["tshirt"] = { item = 1, texture = 0 },
	["torso"] = { item = 0, texture = 0 },
	["vest"] = { item = 0, texture = 0 },
	["shoes"] = { item = 0, texture = 0 },
	["mask"] = { item = 0, texture = 0 },
	["backpack"] = { item = 0, texture = 0 },
	["hat"] = { item = -1, texture = 0 },
	["glass"] = { item = 0, texture = 0 },
	["ear"] = { item = -1, texture = 0 },
	["watch"] = { item = -1, texture = 0 },
	["bracelet"] = { item = -1, texture = 0 },
	["accessory"] = { item = 0, texture = 0 },
	["decals"] = { item = 0, texture = 0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:APPLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Apply")
AddEventHandler("skinshop:Apply",function(Table)
	for Index,v in pairs(Dataset) do
		if not Table[Index] then
			Table[Index] = v
		end
	end
	Dataset = Table
	vSERVER.Update(Dataset)
	exports["skinshop"]:Apply()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBERSHOP:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:Open")
AddEventHandler("skinshop:Open",function() 
	openMenu({
		{ menu = "character", label = "Roupas", selected = true },
		{ menu = "accessoires", label = "Utilidades", selected = false }
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function()
	TriggerEvent("dynamic:closeSystem")
	if vSERVER.CheckWanted() then
		openMenu({
			{ menu = "character", label = "Roupas", selected = true },
			{ menu = "accessoires", label = "Utilidades", selected = false }
		})
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETATTOO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:updateTattoo")
AddEventHandler("skinshop:updateTattoo",function()
	ApplyClothings(Dataset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
local Skinshops = Locations
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local Tables = {}
	for Number = 1,#Skinshops do
		Tables[#Tables + 1] = { Skinshops[Number][1],Skinshops[Number][2],Skinshops[Number][3],2.0,"E","Loja de Roupas","Pressione para abrir" }
	end
	TriggerEvent("hoverfy:Insert",Tables)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) and not creatingCharacter then
				local Coords = GetEntityCoords(Ped)
				for k,v in pairs(Skinshops) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 2 then
						TimeDistance = 1
						if IsControlJustPressed(0,38) and vSERVER.CheckWanted() then
							openMenu({
								{ menu = "character", label = "Roupas", selected = true },
								{ menu = "accessoires", label = "Utilidades", selected = false }
							})
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:openShop")
AddEventHandler("skinshop:openShop",function()
	TriggerEvent("dynamic:closeSystem")

	if not creatingCharacter and vSERVER.checkShares() then
		openMenu({
			{ menu = "character", label = "Roupas", selected = true },
			{ menu = "accessoires", label = "Utilidades", selected = false }
		})
	end
end)

RegisterCommand("skd",function()
	TriggerServerEvent("player:Debug")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETOUTFIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("resetOutfit",function(Data,Callback)

	-- ApplyClothings(json.decode(previousSkinData))
	Dataset = json.decode(previousSkinData)
	previousSkinData = {}

	ExecuteCommand("skd")
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(Data,Callback)
	local Ped = PlayerPedId()
	local heading = GetEntityHeading(Ped)
	if Data == "left" then
		SetEntityHeading(Ped,heading + 10)
	elseif Data == "right" then
		SetEntityHeading(Ped,heading - 10)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDSUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("handsup",function(Data,Callback)
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"random@mugging3","handsup_standing_base",3) then
		StopAnimTask(Ped,"random@mugging3","handsup_standing_base",8.0)
		vRP.AnimActive()
	else
		vRP.playAnim(true,{ "random@mugging3","handsup_standing_base" },true)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHINGCATEGORYS
-----------------------------------------------------------------------------------------------------------------------------------------
local clothingCategorys = {
	["arms"] = { type = "variation", id = 3 },
	["backpack"] = { type = "variation", id = 5 },
	["tshirt"] = { type = "variation", id = 8 },
	["torso"] = { type = "variation", id = 11 },
	["pants"] = { type = "variation", id = 4 },
	["vest"] = { type = "variation", id = 9 },
	["shoes"] = { type = "variation", id = 6 },
	["mask"] = { type = "variation", id = 1 },
	["hat"] = { type = "prop", id = 0 },
	["glass"] = { type = "prop", id = 1 },
	["ear"] = { type = "prop", id = 2 },
	["watch"] = { type = "prop", id = 6 },
	["bracelet"] = { type = "prop", id = 7 },
	["accessory"] = { type = "variation", id = 7 },
	["decals"] = { type = "variation", id = 10 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMAXVALUES
-----------------------------------------------------------------------------------------------------------------------------------------
function GetMaxValues()
	maxModelValues = {
		["backpack"] = { type = "character", item = 0, texture = 0 },
		["arms"] = { type = "character", item = 0, texture = 0 },
		["tshirt"] = { type = "character", item = 0, texture = 0 },
		["torso"] = { type = "character", item = 0, texture = 0 },
		["pants"] = { type = "character", item = 0, texture = 0 },
		["shoes"] = { type = "character", item = 0, texture = 0 },
		["vest"] = { type = "character", item = 0, texture = 0 },
		["accessory"] = { type = "character", item = 0, texture = 0 },
		["decals"] = { type = "character", item = 0, texture = 0 },
		["mask"] = { type = "accessoires", item = 0, texture = 0 },
		["hat"] = { type = "accessoires", item = 0, texture = 0 },
		["glass"] = { type = "accessoires", item = 0, texture = 0 },
		["ear"] = { type = "accessoires", item = 0, texture = 0 },
		["watch"] = { type = "accessoires", item = 0, texture = 0 },
		["bracelet"] = { type = "accessoires", item = 0, texture = 0 }
	}

	local Ped = PlayerPedId()
	for k,v in pairs(clothingCategorys) do
		if v["type"] == "variation" then
			maxModelValues[k]["item"] = GetNumberOfPedDrawableVariations(Ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedTextureVariations(Ped,v["id"],GetPedDrawableVariation(Ped,v["id"])) - 1

			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end

		if v["type"] == "prop" then
			maxModelValues[k]["item"] = GetNumberOfPedPropDrawableVariations(Ped,v["id"]) - 1
			maxModelValues[k]["texture"] = GetNumberOfPedPropTextureVariations(Ped,v["id"],GetPedPropIndex(Ped,v["id"])) - 1

			if maxModelValues[k]["texture"] <= 0 then
				maxModelValues[k]["texture"] = 0
			end
		end
	end
	SendNUIMessage({ action = "updateMax", maxValues = maxModelValues })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function openMenu(allowedMenus)
	creatingCharacter = true
	previousSkinData = json.encode(Dataset)

	GetMaxValues()
	SendNUIMessage({ action = "open", menus = allowedMenus, currentClothing = Dataset })

	SetCursorLocation(0.9,0.25)
	SetNuiFocus(true,true)

	enableCam()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENABLECAM
-----------------------------------------------------------------------------------------------------------------------------------------
function enableCam()
	local Ped = PlayerPedId()
	local Pos = GetEntityCoords(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,2.0,0)
	RenderScriptCams(false,false,0,1,0)
	DestroyCam(cam,false)

	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamActive(cam,true)
		RenderScriptCams(true,false,0,true,true)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
		PointCamAtCoord(cam,Pos["x"],Pos["y"],Pos["z"] + 0.15)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATECAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotateCam",function(Data,Callback)
	local Ped = PlayerPedId()
	local rotType = Data["type"]
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,2.0,0)

	if rotType == "left" then
		SetEntityHeading(Ped,GetEntityHeading(Ped) - 10)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(Ped) + 180)
	else
		SetEntityHeading(Ped,GetEntityHeading(Ped) + 10)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
		SetCamRot(cam,0.0,0.0,GetEntityHeading(Ped) + 180)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUPCAM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setupCam",function(Data,Callback)
	local value = Data["value"]
	local Ped = PlayerPedId()
	local Pos = GetEntityCoords(Ped)
	if value == 1 then
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,0.75,0)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.6)
		PointCamAtCoord(cam,Pos["x"],Pos["y"],Pos["z"] + 0.65)
	elseif value == 2 then
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,1.0,0)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.2)
		PointCamAtCoord(cam,Pos["x"],Pos["y"],Pos["z"] + 0.2)
	elseif value == 3 then
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,1.0,0)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] - 0.5)
		PointCamAtCoord(cam,Pos["x"],Pos["y"],Pos["z"] - 0.5)
	else
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0,2.0,0)
		SetCamCoord(cam,Coords["x"],Coords["y"],Coords["z"] + 0.5)
		PointCamAtCoord(cam,Pos["x"],Pos["y"],Pos["z"] + 0.15)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
function closeMenu()
	SendNUIMessage({ action = "close" })
	RenderScriptCams(false,true,250,1,0)
	DestroyCam(cam,false)

	vRP.removeObjects()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYCLOTHINGS
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyClothings(data,Ped)

    if not Ped then
		Ped = PlayerPedId()
	end

	if not data then
		data = Dataset
	end

	for Index,v in pairs(Dataset) do
		if not data[Index] then
			data[Index] = {
				["item"] = v["item"],
				["texture"] = v["texture"]
			}
		end
	end

	SetPedComponentVariation(Ped,4,data["pants"]["item"],data["pants"]["texture"],1)
	SetPedComponentVariation(Ped,3,data["arms"]["item"],data["arms"]["texture"],1)
	SetPedComponentVariation(Ped,5,data["backpack"]["item"],data["backpack"]["texture"],1)
	SetPedComponentVariation(Ped,8,data["tshirt"]["item"],data["tshirt"]["texture"],1)
	SetPedComponentVariation(Ped,9,data["vest"]["item"],data["vest"]["texture"],1)
	SetPedComponentVariation(Ped,11,data["torso"]["item"],data["torso"]["texture"],1)
	SetPedComponentVariation(Ped,6,data["shoes"]["item"],data["shoes"]["texture"],1)
	SetPedComponentVariation(Ped,1,data["mask"]["item"],data["mask"]["texture"],1)
	SetPedComponentVariation(Ped,10,data["decals"]["item"],data["decals"]["texture"],1)
	SetPedComponentVariation(Ped,7,data["accessory"]["item"],data["accessory"]["texture"],1)

	if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
		SetPedPropIndex(Ped,0,data["hat"]["item"],data["hat"]["texture"],1)
	else
		ClearPedProp(Ped,0)
	end

	if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
		SetPedPropIndex(Ped,1,data["glass"]["item"],data["glass"]["texture"],1)
	else
		ClearPedProp(Ped,1)
	end

	if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
		SetPedPropIndex(Ped,2,data["ear"]["item"],data["ear"]["texture"],1)
	else
		ClearPedProp(Ped,2)
	end

	if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
		SetPedPropIndex(Ped,6,data["watch"]["item"],data["watch"]["texture"],1)
	else
		ClearPedProp(Ped,6)
	end

	if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
		SetPedPropIndex(Ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
	else
		ClearPedProp(Ped,7)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	RenderScriptCams(false,true,250,1,0)
	creatingCharacter = false
	SetNuiFocus(false,false)
	DestroyCam(cam,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(Data,Callback)
	ChangeVariation(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKINONINPUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkinOnInput",function(Data,Callback)
	ChangeVariation(Data)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHANGEVARIATION
-----------------------------------------------------------------------------------------------------------------------------------------
function ChangeVariation(data)
	local Ped = PlayerPedId()
	local types = data["type"]
	local item = data["articleNumber"]
	local category = data["clothingType"]

	if category == "pants" then
		if types == "item" then
			SetPedComponentVariation(Ped,4,item,0,1)
			Dataset["pants"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,4,GetPedDrawableVariation(Ped,4),item,1)
			Dataset["pants"]["texture"] = item
		end
	elseif category == "arms" then
		if types == "item" then
			SetPedComponentVariation(Ped,3,item,0,1)
			Dataset["arms"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,3,GetPedDrawableVariation(Ped,3),item,1)
			Dataset["arms"]["texture"] = item
		end

	elseif category == "backpack" then
		if types == "item" then
			SetPedComponentVariation(Ped,5,item,0,1)
			Dataset["backpack"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,5,GetPedDrawableVariation(Ped,5),item,1)
			Dataset["backpack"]["texture"] = item
		end

	elseif category == "tshirt" then
		if types == "item" then
			SetPedComponentVariation(Ped,8,item,0,1)
			Dataset["tshirt"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,8,GetPedDrawableVariation(Ped,8),item,1)
			Dataset["tshirt"]["texture"] = item
		end
	elseif category == "vest" then
		if types == "item" then
			SetPedComponentVariation(Ped,9,item,0,1)
			Dataset["vest"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,9,Dataset["vest"]["item"],item,1)
			Dataset["vest"]["texture"] = item
		end
	elseif category == "decals" then
		if types == "item" then
			SetPedComponentVariation(Ped,10,item,0,1)
			Dataset["decals"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,10,Dataset["decals"]["item"],item,1)
			Dataset["decals"]["texture"] = item
		end
	elseif category == "accessory" then
		if types == "item" then
			SetPedComponentVariation(Ped,7,item,0,1)
			Dataset["accessory"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,7,Dataset["accessory"]["item"],item,1)
			Dataset["accessory"]["texture"] = item
		end
	elseif category == "torso" then
		if types == "item" then
			SetPedComponentVariation(Ped,11,item,0,1)
			Dataset["torso"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,11,GetPedDrawableVariation(Ped,11),item,1)
			Dataset["torso"]["texture"] = item
		end
	elseif category == "shoes" then
		if types == "item" then
			SetPedComponentVariation(Ped,6,item,0,1)
			Dataset["shoes"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,6,GetPedDrawableVariation(Ped,6),item,1)
			Dataset["shoes"]["texture"] = item
		end
	elseif category == "mask" then
		if types == "item" then
			SetPedComponentVariation(Ped,1,item,0,1)
			Dataset["mask"]["item"] = item
		elseif types == "texture" then
			SetPedComponentVariation(Ped,1,GetPedDrawableVariation(Ped,1),item,1)
			Dataset["mask"]["texture"] = item
		end
	elseif category == "hat" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(Ped,0,item,Dataset["hat"]["texture"],1)
			else
				ClearPedProp(Ped,0)
			end

			Dataset["hat"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(Ped,0,Dataset["hat"]["item"],item,1)
			Dataset["hat"]["texture"] = item
		end
	elseif category == "glass" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(Ped,1,item,Dataset["glass"]["texture"],1)
				Dataset["glass"]["item"] = item
			else
				ClearPedProp(Ped,1)
			end
		elseif types == "texture" then
			SetPedPropIndex(Ped,1,Dataset["glass"]["item"],item,1)
			Dataset["glass"]["texture"] = item
		end
	elseif category == "ear" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(Ped,2,item,Dataset["ear"]["texture"],1)
			else
				ClearPedProp(Ped,2)
			end

			Dataset["ear"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(Ped,2,Dataset["ear"]["item"],item,1)
			Dataset["ear"]["texture"] = item
		end
	elseif category == "watch" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(Ped,6,item,Dataset["watch"]["texture"],1)
			else
				ClearPedProp(Ped,6)
			end

			Dataset["watch"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(Ped,6,Dataset["watch"]["item"],item,1)
			Dataset["watch"]["texture"] = item
		end
	elseif category == "bracelet" then
		if types == "item" then
			if item ~= -1 then
				SetPedPropIndex(Ped,7,item,Dataset["bracelet"]["texture"],1)
			else
				ClearPedProp(Ped,7)
			end

			Dataset["bracelet"]["item"] = item
		elseif types == "texture" then
			SetPedPropIndex(Ped,7,Dataset["bracelet"]["item"],item,1)
			Dataset["bracelet"]["texture"] = item
		end
	end

	GetMaxValues()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVECLOTHING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("saveClothing",function(Data,Callback)
	if vSERVER.PaymentClothing() then
		vSERVER.Update(Dataset)
	else
		ExecuteCommand("skd")
	end
	Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setMask")
AddEventHandler("skinshop:setMask",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"missfbi4","takeoff_mask"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedDrawableVariation(Ped,1) == Dataset["mask"]["item"] then
			SetPedComponentVariation(Ped,1,0,0,1)
		else
			SetPedComponentVariation(Ped,1,Dataset["mask"]["item"],Dataset["mask"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setHat")
AddEventHandler("skinshop:setHat",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"mp_masks@standard_car@ds@","put_on_mask"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedPropIndex(Ped,0) == Dataset["hat"]["item"] then
			ClearPedProp(Ped,0)
		else
			SetPedPropIndex(Ped,0,Dataset["hat"]["item"],Dataset["hat"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETGLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:setGlasses")
AddEventHandler("skinshop:setGlasses",function()
	if not Animation and not LocalPlayer["state"]["Buttons"] then
		Animation = true
		vRP.playAnim(true,{"clothingspecs","take_off"},true)

		Wait(1000)

		local Ped = PlayerPedId()
		if GetPedPropIndex(Ped,1) == Dataset["glass"]["item"] then
			ClearPedProp(Ped,1)
		else
			SetPedPropIndex(Ped,1,Dataset["glass"]["item"],Dataset["glass"]["texture"],1)
		end

		vRP.removeObjects()
		Animation = false
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHIRT
-----------------------------------------------------------------------------------------------------------------------------------------
local setShirtM = { -1,0,1 }
local setShirtF = { 14,0,1 }

RegisterNetEvent("skinshop:setShirt")
AddEventHandler("skinshop:setShirt",function()
	if not animation then
		animation = true
		vRP.playAnim(true,{"clothingtie","try_tie_negative_a"},true)
		Wait(4000)

		local Ped = PlayerPedId()

		if GetPedDrawableVariation(Ped,8) == Dataset["tshirt"]["item"] then
			if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(Ped,8,setShirtF[1],setShirtF[2],setShirtF[3])
				SetPedComponentVariation(Ped,3,15,0,1)
			else
				SetPedComponentVariation(Ped,8,setShirtM[1],setShirtM[2],setShirtM[3])
				SetPedComponentVariation(Ped,3,15,0,1)
			end
			
		else
			SetPedComponentVariation(Ped,8,Dataset["tshirt"]["item"],Dataset["tshirt"]["texture"],1)
		end

		vRP.removeObjects()
		animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETJACKET
-----------------------------------------------------------------------------------------------------------------------------------------
local setJacketM = { 15,0,1 }
local setJacketF = { 15,0,1 }

RegisterNetEvent("skinshop:setJacket")
AddEventHandler("skinshop:setJacket",function()
	if not animation then
		animation = true
		vRP.playAnim(true,{"clothingtie","try_tie_negative_a"},true)
		Wait(4000)

		local Ped = PlayerPedId()

		if GetPedDrawableVariation(Ped,11) == Dataset["torso"]["item"] then
			if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(Ped,11,setJacketM[1],setJacketM[2],setJacketM[3])
				SetPedComponentVariation(Ped,3,15,0,1)
			else
				SetPedComponentVariation(Ped,11,setJacketF[1],setJacketF[2],setJacketF[3])
				SetPedComponentVariation(Ped,3,15,0,1)
			end
		else
			SetPedComponentVariation(Ped,11,Dataset["torso"]["item"],Dataset["torso"]["texture"],1)
		end

		vRP.removeObjects()
		animation = false
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSTrousers
-----------------------------------------------------------------------------------------------------------------------------------------
local setPantsM = { 14,0,1 }
local setPantsF = { 15,0,1 }

RegisterNetEvent("skinshop:setPants")
AddEventHandler("skinshop:setPants",function()
	if not animation then
		animation = true
		vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},true)
		Wait(4000)
		local Ped = PlayerPedId()
		if GetPedDrawableVariation(Ped,4) == Dataset["pants"]["item"] then
			if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(Ped,4,setPantsF[1],setPantsF[2],setPantsF[3])
			else
				SetPedComponentVariation(Ped,4,setPantsM[1],setPantsM[2],setPantsM[3])
			end
		else
			SetPedComponentVariation(Ped,4,Dataset["pants"]["item"],Dataset["pants"]["texture"],1)
		end
		vRP.removeObjects()
		animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
local setShoesM = { 34,0,1 }
local setShoesF = { 35,0,1 }

RegisterNetEvent("skinshop:setShoes")
AddEventHandler("skinshop:setShoes",function()
	if not animation then
		animation = true
		vRP.playAnim(true,{"clothingshoes","try_shoes_positive_d"},true)
		Wait(4000)
		local Ped = PlayerPedId()
		if GetPedDrawableVariation(Ped,6) == Dataset["shoes"]["item"] then
			if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(Ped,6,setShoesF[1],setShoesF[2],setShoesF[3])
			else
				SetPedComponentVariation(Ped,6,setShoesM[1],setShoesM[2],setShoesM[3])
			end
		else
			SetPedComponentVariation(Ped,6,Dataset["shoes"]["item"],Dataset["shoes"]["texture"],1)
		end
		vRP.removeObjects()
		animation = false
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMS
-----------------------------------------------------------------------------------------------------------------------------------------
local setArmsM = { 15,0,1 }
local setArmsF = { 15,0,1 }

RegisterNetEvent("skinshop:setArms")
AddEventHandler("skinshop:setArms",function()
	if not animation then
		animation = true
		vRP.playAnim(true,{"clothingtrousers","try_trousers_neutral_c"},true)
		Wait(4000)
		local Ped = PlayerPedId()
		if GetPedDrawableVariation(Ped,3) == Dataset["arms"]["item"] then
			if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
				SetPedComponentVariation(Ped,3,setArmsF[1],setArmsF[2],setArmsF[3])
			else
				SetPedComponentVariation(Ped,3,setArmsM[1],setArmsM[2],setArmsM[3])
			end
		else
			SetPedComponentVariation(Ped,3,Dataset["arms"]["item"],Dataset["arms"]["texture"],1)
		end
		vRP.removeObjects()
		animation = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSHOES
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkShoes()
	local Number = 34
	local Ped = PlayerPedId()
	if GetEntityModel(Ped) == GetHashKey("mp_f_freemode_01") then
		Number = 35
	end

	if Dataset["shoes"]["item"] ~= Number then
		Dataset["shoes"]["item"] = Number
		Dataset["shoes"]["texture"] = 0
		SetPedComponentVariation(Ped,6,Dataset["shoes"]["item"],Dataset["shoes"]["texture"],1)

		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinshop:toggleBackpack")
AddEventHandler("skinshop:toggleBackpack",function(Infos)
	local splitName = splitString(Infos,"-")
	local Modelo = parseInt(splitName[1])
	local Textura = parseInt(splitName[2])

	if Dataset["backpack"]["item"] == Modelo then
		Dataset["backpack"]["item"] = 0
		Dataset["backpack"]["texture"] = 0
		TriggerServerEvent("skinshop:Weight","Remove")
	else
		Dataset["backpack"]["texture"] = Textura
		Dataset["backpack"]["item"] = Modelo
		TriggerServerEvent("skinshop:Weight","Add")
	end

	SetPedComponentVariation(PlayerPedId(),5,Dataset["backpack"]["item"],Dataset["backpack"]["texture"],1)

	vSERVER.Update(Dataset)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.getCustomization()
	return Dataset
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:DEFIBRILLATOR
-----------------------------------------------------------------------------------------------------------------------------------------
local Defibrillator = false
RegisterNetEvent("skinshop:Defibrillator")
AddEventHandler("skinshop:Defibrillator",function()
	if Defibrillator then
		Defibrillator = false
		SetPedComponentVariation(PlayerPedId(),5,0,0,1)
	else
		Defibrillator = true
		SetPedComponentVariation(PlayerPedId(),5,DefibrillatorId,0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEFIBRILLATOR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Defibrillator()
	return Defibrillator
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
local BackWeight = false
CreateThread(function()
	while true do
		if Dataset["backpack"] then
			if Dataset["backpack"]["item"] ~= 0 and Dataset["backpack"]["item"] >= 100 then
				if not BackWeight then
					TriggerServerEvent("vRP:BackpackWeight",true)
					BackWeight = true
				end
			else
				if BackWeight then
					TriggerServerEvent("vRP:BackpackWeight",false)
					BackWeight = false
				end
			end
		end
		Wait(1000)
	end
end)

exports("Apply", ApplyClothings)

