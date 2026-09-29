-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
vNATION = Proxy.getInterface("nation_skinshop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("inventory",Creative)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Types = ""
local Weapon = ""
local UseSlots = 1
local Actived = false
local Backpack = false
local TakeWeapon = false
local StoreWeapon = false
local Reloaded = GetGameTimer()
local UseCooldown = GetGameTimer()
LocalPlayer["state"]["Buttons"] = false

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel",function()
	vSERVER.Cancel()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:VerifyObjects")
AddEventHandler("inventory:VerifyObjects",function(Entity,Service)
	vSERVER.VerifyObjects(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Loot")
AddEventHandler("inventory:Loot",function(Entity,Service)
	vSERVER.Loot(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StealTrunk")
AddEventHandler("inventory:StealTrunk",function(Entity)
	vSERVER.StealTrunk(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Animals")
AddEventHandler("inventory:Animals",function(Entity,Service)
	vSERVER.Animals(Entity,Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STOREOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:StoreObjects")
AddEventHandler("inventory:StoreObjects",function(Number)
	vSERVER.StoreObjects(Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:MakeProducts")
AddEventHandler("inventory:MakeProducts",function(Service)
	vSERVER.MakeProducts(Service)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle",function(Entity)
	vSERVER.Dismantle(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveTyres")
AddEventHandler("inventory:RemoveTyres",function(Entity)
	vSERVER.RemoveTyres(Entity)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEANWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CleanWeapons")
AddEventHandler("inventory:CleanWeapons",function(Create)
	if Weapon ~= "" then
		if Create and UseSlots <= 5 then
			TriggerEvent("inventory:CreateWeapon",Weapon)
		end

		RemoveAllPedWeapons(PlayerPedId(),true)
	end

	TriggerEvent("hud:Weapon",false)
	TriggerEvent("Weapon","")
	Actived = false
	Weapon = ""
	Types = ""
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)
	vSERVER.EnsureScript()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] then
			TimeDistance = 1
			DisableControlAction(1,75,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(Ped,true)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close",function()
	if Backpack then
		Backpack = false
		SetNuiFocus(false,false)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "hideMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(Data,Callback)
	TriggerEvent("inventory:Close")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Craft",function(Data,Callback)
	Backpack = false
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })

	TriggerEvent("crafting:openSource")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Deliver",function(Data,Callback)
	vSERVER.Deliver(Data["slot"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESTRUIR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Destruir",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Destruir",data["slot"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Slot")
AddEventHandler("inventory:Slot",function(Number,Amount)
	UseSlots = parseInt(Number)
	vSERVER.UseItem(Number,Amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(Data,Callback)
	if GetGameTimer() >= UseCooldown then
		TriggerEvent("inventory:Slot",Data["slot"],Data["amount"])
		UseCooldown = GetGameTimer() + 1000
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(Data,Callback)
	vSERVER.SendItem(Data["slot"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(Data,Callback)
	vRPS.invUpdate(Data["slot"],Data["target"],Data["amount"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon",function(Item)
	local Split = splitString(Item,"-")
	local Name = Split[1]

	if Weapon == Name then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)
		if not vSERVER.verifyWeapon(Weapon,Ammo) then
			TriggerEvent("inventory:CleanWeapons",false)
		end
	else
		if Weapon == "" then
			vSERVER.verifyWeapon(Name)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon",function()
	if Weapon ~= "" then
		local Ped = PlayerPedId()
		local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

		TriggerEvent("inventory:CreateWeapon",Weapon)
		vSERVER.preventWeapon(Weapon,Ammo)
		TriggerEvent("hud:Weapon",false)
		RemoveAllPedWeapons(Ped,true)
		TriggerEvent("Weapon","")

		Actived = false
		Weapon = ""
		Types = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openBackpack",function()
	if not IsPauseMenuActive() and GetEntityHealth(PlayerPedId()) > 100 and not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
		Backpack = true
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openBackpack","Manusear a mochila.","keyboard","OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local vehTyres = {}

				for i = 0,7 do
					local Status = false

					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						Status = true
					end

					vehTyres[i] = Status
				end

				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle,Fuel)

				for Tyre,Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre",function(Vehicle,Tyres,Plate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				for i = 0,7 do
					if GetTyreHealth(Vehicle,i) ~= 1000.0 then
						SetVehicleTyreBurst(Vehicle,i,true,1000.0)
					end
				end

				SetVehicleTyreFixed(Vehicle,Tyres)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleEngineHealth(Vehicle,1000.0)
				SetVehicleBodyHealth(Vehicle,1000.0)
				SetEntityHealth(Vehicle,1000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				local Fuel = GetVehicleFuelLevel(Vehicle)

				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)

				SetVehicleFuelLevel(Vehicle,Fuel)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm",function(Index,Plate)
	if NetworkDoesNetworkIdExist(Index) then
		local Vehicle = NetToEnt(Index)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleAlarm(Vehicle,true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.parachuteColors()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
	vector2(2308.64,3906.11),
	vector2(2180.13,3885.29),
	vector2(2058.22,3883.56),
	vector2(2024.97,3942.53),
	vector2(1748.72,3964.53),
	vector2(1655.65,3886.34),
	vector2(1547.59,3830.17),
	vector2(1540.73,3826.94),
	vector2(1535.67,3816.55),
	vector2(1456.35,3756.87),
	vector2(1263.44,3670.38),
	vector2(1172.99,3648.83),
	vector2(967.98,3653.54),
	vector2(840.55,3679.16),
	vector2(633.13,3600.70),
	vector2(361.73,3626.24),
	vector2(310.58,3571.61),
	vector2(266.92,3493.13),
	vector2(173.49,3421.45),
	vector2(128.16,3442.66),
	vector2(143.41,3743.49),
	vector2(-38.59,3754.16),
	vector2(-132.62,3716.80),
	vector2(-116.73,3805.33),
	vector2(-157.23,3838.81),
	vector2(-204.70,3846.28),
	vector2(-208.28,3873.08),
	vector2(-236.88,4076.58),
	vector2(-184.11,4231.52),
	vector2(-139.54,4253.54),
	vector2(-45.38,4344.43),
	vector2(-5.96,4408.34),
	vector2(38.36,4411.02),
	vector2(150.77,4311.74),
	vector2(216.02,4342.85),
	vector2(294.16,4245.62),
	vector2(396.21,4342.24),
	vector2(438.37,4315.38),
	vector2(505.22,4178.69),
	vector2(606.65,4202.34),
	vector2(684.48,4169.83),
	vector2(773.54,4152.33),
	vector2(877.34,4172.67),
	vector2(912.20,4269.57),
	vector2(850.92,4428.91),
	vector2(922.96,4376.48),
	vector2(941.32,4328.09),
	vector2(995.318,4288.70),
	vector2(1050.33,4215.29),
	vector2(1082.27,4285.61),
	vector2(1060.97,4365.31),
	vector2(1072.62,4372.37),
	vector2(1119.24,4317.53),
	vector2(1275.27,4354.90),
	vector2(1360.96,4285.09),
	vector2(1401.09,4283.69),
	vector2(1422.33,4339.60),
	vector2(1516.60,4393.69),
	vector2(1597.58,4455.65),
	vector2(1650.81,4499.17),
	vector2(1781.12,4525.83),
	vector2(1828.69,4560.26),
	vector2(1866.59,4554.49),
	vector2(2162.70,4664.53),
	vector2(2279.31,4660.26),
	vector2(2290.52,4630.90),
	vector2(2418.64,4613.91),
	vector2(2427.06,4597.69),
	vector2(2449.86,4438.97),
	vector2(2396.62,4353.36),
	vector2(2383.66,4160.74),
	vector2(2383.05,4046.07)
},{ name = "Pescaria" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.fishingCoords()
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)
	if fishCoords:isPointInside(Coords) and IsEntityInWater(Ped) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.fishingAnim()
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.animalAnim()
	local Ped = PlayerPedId()
	if IsEntityPlayingAnim(Ped,"anim@gangops@facility@servers@bodysearch@","player_search",3) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.returnWeapon()
	if Weapon ~= "" then
		return Weapon
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkWeapon(Hash)
	if Weapon == Hash then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAttachs = {
	["attachsFlashlight"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH"
	},
	["attachsMagazine"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_HEAVYPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
		["WEAPON_MINISMG"] = "COMPONENT_MINISMG_CLIP_02",
		["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
		["WEAPON_PISTOL50"] = "COMPONENT_PISTOL50_CLIP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
		["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02"
	},
	["attachsCrosshair"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO"
	},
	["attachsSilencer"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_SUPP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_SUPP"
	},
	["attachsGrip"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02"
	},
	["attachsClip"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_PUMPSHOTGUN_MK2_CLIP_02",
		["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkAttachs(nameItem,nameWeapon)
	return weaponAttachs[nameItem][nameWeapon]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.putAttachs(nameItem,nameWeapon)
	GiveWeaponComponentToPed(PlayerPedId(),nameWeapon,weaponAttachs[nameItem][nameWeapon])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.putWeaponHands(Name,Ammo,Components,Type)
	if not TakeWeapon then
		if not Ammo then
			Ammo = 0
		end

		if Ammo > 0 then
			Actived = true
		end

		TakeWeapon = true
		LocalPlayer["state"]:set("Cancel",true,true)

		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("rcmjosh4") then
				TaskPlayAnim(Ped,"rcmjosh4","josh_leadout_cop2",8.0,8.0,-1,48,0,0,0,0)
			end

			Wait(200)

			Weapon = Name
			TriggerEvent("Weapon",Name)
			TriggerEvent("inventory:RemoveWeapon",Name)
			GiveWeaponToPed(Ped,Name,Ammo,false,true)

			Wait(300)

			ClearPedTasks(Ped)
		else
			Weapon = Name
			TriggerEvent("Weapon",Name)
			TriggerEvent("inventory:RemoveWeapon",Name)
			GiveWeaponToPed(Ped,Name,Ammo,false,true)
		end

		if Components then
			for nameItem,_ in pairs(Components) do
				Creative.putAttachs(nameItem,Name)
			end
		end

		if Type then
			Types = Type
		end

		TakeWeapon = false
		LocalPlayer["state"]:set("Cancel",false,true)

		if itemAmmo(Name) then
			TriggerEvent("hud:Weapon",true,Name)
		end

		if vSERVER.dropWeapons(Name) then
			TriggerEvent("inventory:CleanWeapons",true)
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.storeWeaponHands()
	if not StoreWeapon then
		StoreWeapon = true

		local Last = Weapon
		local Ped = PlayerPedId()
		LocalPlayer["state"]:set("Cancel",true,true)

		if not IsPedInAnyVehicle(Ped) then
			if LoadAnim("weapons@pistol@") then
				TaskPlayAnim(Ped,"weapons@pistol@","aim_2_holster",8.0,8.0,-1,48,0,0,0,0)
			end

			Wait(450)

			ClearPedTasks(Ped)
		end

		local Ammos = GetAmmoInPedWeapon(Ped,Weapon)

		StoreWeapon = false
		TriggerEvent("inventory:CleanWeapons",true)
		LocalPlayer["state"]:set("Cancel",false,true)

		return true,Ammos,Last
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = {
	["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL"
	},
	["WEAPON_PISTOL_POLICE"] = {
		"WEAPON_COMBATPISTOL",
	},
	["WEAPON_NAIL_AMMO"] = {
		"WEAPON_NAILGUN"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_FNFAL",
		"WEAPON_PARAFAL",
		"WEAPON_COLTXM177",
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTSMG",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	},
	["WEAPON_RPG_AMMO"] = {
		"WEAPON_RPG"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.rechargeCheck(ammoType)
	local weaponAmmo = 0
	local weaponHash = nil
	local Ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		weaponAmmo = GetAmmoInPedWeapon(Ped,Weapon)

		for _,v in pairs(weaponAmmos[ammoType]) do
			if Weapon == v then
				weaponHash = Weapon
				weaponStatus = true
				break
			end
		end
	end

	return weaponStatus,weaponHash,weaponAmmo
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.rechargeWeapon(Hash,Ammo)
	AddAmmoToPed(PlayerPedId(),Hash,Ammo)
	Actived = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if Actived and Weapon ~= "" then
			TimeDistance = 10

			local Ped = PlayerPedId()
			local Ammo = GetAmmoInPedWeapon(Ped,Weapon)

			if GetGameTimer() >= Reloaded and IsPedReloading(Ped) then
				vSERVER.preventWeapon(Weapon,Ammo)
				Reloaded = GetGameTimer() + 100
			end

			if Ammo <= 0 or (Weapon == "WEAPON_PETROLCAN" and Ammo <= 135 and IsPedShooting(Ped)) or IsPedSwimming(Ped) then
				if Types ~= "" then
					vSERVER.removeThrowing(Types)
				else
					vSERVER.preventWeapon(Weapon,Ammo)
				end

				TriggerEvent("inventory:CleanWeapons",true)
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local Firecracker = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkCracker()
	if GetGameTimer() <= Firecracker then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker",function()
	if LoadPtfxAsset("scr_indep_fireworks") then
		Firecracker = GetGameTimer() + (5 * 60000)

		local Explosive = 25
		local Ped = PlayerPedId()
		local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.6,0.0)
		local Progression,Network = vRPS.CreateObject("ind_prop_firework_03",Coords["x"],Coords["y"],Coords["z"])
		if Progression then
			local Entity = LoadNetwork(Network)
			FreezeEntityPosition(Entity,true)
			PlaceObjectOnGroundProperly(Entity)
			SetModelAsNoLongerNeeded("ind_prop_firework_03")

			Wait(8000)

			repeat
				Wait(2000)
				Explosive = Explosive - 1
				UseParticleFxAssetNextCall("scr_indep_fireworks")
				StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst",Coords["x"],Coords["y"],Coords["z"],0.0,0.0,0.0,2.5,false,false,false,false)
			until Explosive <= 0

			TriggerServerEvent("DeleteObject",Network)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkWater()
	return IsEntityInWater(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local dropBlacklist = {
	['folhetopd'] = true,
	['folhetoproerd'] = true,
	['folhetolock'] = true,
	['folhetopinxar'] = true,
	['emptybottle'] = true,
}
RegisterNUICallback("dropItem",function(Data,Callback)
	if not TakeWeapon and not StoreWeapon then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local _,Z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

		local itemName = Data.item
		local full = itemName
		if itemName:find('-') then
			itemName = itemName:sub(1,itemName:find('-')-1)
		end
		
		-- print(itemName)
		if dropBlacklist[itemName] or vSERVER.isDamaged(itemName) then
			TriggerEvent("inventory:Close")
			TriggerEvent('Notify','amarelo','Esse item não pode ser dropado',5000)
			return
		end

		vSERVER.Drops(Data["item"],Data["slot"],Data["amount"],Coords["x"],Coords["y"],Z)
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Table")
AddEventHandler("drops:Table",function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar",function(Number,Table)
	Drops[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover",function(Number)
	if Drops[Number] then
		Drops[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Atualizar")
AddEventHandler("drops:Atualizar",function(Number,Amount)
	if Drops[Number] then
		Drops[Number]["amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)

			for _,v in pairs(Drops) do
				local Distance = #(Coords - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
				if Distance <= 50 then
					TimeDistance = 1
					DrawMarker(21,v["Coords"][1],v["Coords"][2],v["Coords"][3] + 0.25,0.0,0.0,0.0,0.0,180.0,0.0,0.25,0.35,0.25,162,124,219,200,0,0,0,1)
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInventory",function(Data,Callback)
	local Items = {}

	if LocalPlayer["state"]["Route"] < 900000 then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		local _,Z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])

		for Index,v in pairs(Drops) do
			local Distance = #(vec3(Coords["x"],Coords["y"],Z) - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
			if Distance <= 0.9 then
				local Number = #Items + 1

				Items[Number] = v
				Items[Number]["id"] = Index
			end
		end
	end

	local inventario,invPeso,invMaxpeso = vSERVER.requestInventory()
	if inventario then
		Callback({ inventario = inventario, drop = Items, invPeso = invPeso, invMaxpeso = invMaxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem",function(Data,Callback)
	vSERVER.Pickup(Data["id"],Data["amount"],Data["target"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.wheelChair(Plate)
	local Ped = PlayerPedId()
	local heading = GetEntityHeading(Ped)
	local Coords = GetOffsetFromEntityInWorldCoords(Ped,0.0,0.75,0.0)
	local myVehicle = vGARAGE.ServerVehicle("wheelchair",Coords["x"],Coords["y"],Coords["z"],heading,Plate,0,nil,1000)

	if NetworkDoesNetworkIdExist(myVehicle) then
		local vehicleNet = NetToEnt(myVehicle)
		if NetworkDoesNetworkIdExist(vehicleNet) then
			SetVehicleOnGroundProperly(vehicleNet)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local Wheelchair = false
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			local Vehicle = GetVehiclePedIsUsing(Ped)
			local Model = GetEntityModel(Vehicle)
			if Model == -1178021069 then
				if not IsEntityPlayingAnim(Ped,"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester",3) then
					vRP.playAnim(true,{"missfinale_c2leadinoutfin_c_int","_leadin_loop2_lester"},true)
					Wheelchair = true
				end
			end
		else
			if Wheelchair then
				vRP.removeObjects("one")
				Wheelchair = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local SoundScanner = 999
local InitScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1234.97,-1858.42,0.73,36.86 },   
	{ -1631.15,-1129.81,0.72,36.86 },
	{ -1613.14,-1137.51,0.99,36.86 },
	{ -1244.32,-1848.17,0.96,36.86 },
	{ -1253.21,-1839.08,0.89,36.86 },
	{ -1608.25,-1154.84,0.33,36.86 },
	{ -1259.74,-1828.54,0.86,36.86 },
	{ -1267.39,-1815.08,0.81,36.86 },
	{ -1594.72,-1168.42,1.06,36.86 },
	{ -1274.08,-1801.67,0.77,36.86 },
	{ -1274.08,-1801.67,0.77,36.86 },
	{ -1274.08,-1801.67,0.77,36.86 },
	{ -1595.85,-1187.23,0.59,36.86 },
	{ -1589.0,-1192.69,0.75,36.86 },
	{ -1279.92,-1793.88,0.64,36.86 },
	{ -1279.92,-1793.88,0.64,36.86 },
	{ -1585.11,-1212.21,0.32,36.86 },
	{ -1282.53,-1789.85,0.65,36.86 },
	{ -1282.53,-1789.85,0.65,36.86 },
	{ -1288.65,-1780.4,0.68,36.86 },
	{ -1574.66,-1219.92,0.36,36.86 },
	{ -1295.36,-1770.62,0.72,36.86 },
	{ -1302.36,-1761.45,0.73,36.86 },
	{ -1572.47,-1229.13,0.32,36.86 },
	{ -1309.65,-1751.53,0.78,36.86 },
	{ -1316.29,-1741.9,0.78,36.86 },
	{ -1555.83,-1234.2,0.81,36.86 },
	{ -1322.7,-1732.8,0.78,36.86 },
	{ -1329.88,-1722.43,0.76,36.86 },
	{ -1549.02,-1250.86,0.84,36.86 },
	{ -1335.23,-1713.68,0.79,36.86 },
	{ -1341.76,-1704.72,0.81,36.86 },
	{ -1349.41,-1694.51,0.75,36.86 },
	{ -1533.83,-1264.75,1.03,36.86 },
	{ -1357.55,-1682.25,0.76,36.86 },
	{ -1537.68,-1279.39,0.34,36.86 },
	{ -1364.65,-1671.28,0.81,36.86 },
	{ -1370.49,-1662.18,0.82,36.86 },
	{ -1527.14,-1292.56,0.9,36.86 },
	{ -1376.53,-1652.48,0.81,36.86 },
	{ -1382.43,-1642.45,0.81,36.86 },
	{ -1529.93,-1313.0,0.54,36.86 },
	{ -1387.85,-1632.3,0.81,36.86 },
	{ -1393.45,-1622.26,0.83,36.86 },
	{ -1398.61,-1613.33,0.81,36.86 },
	{ -1516.3,-1332.68,0.99,36.86 },
	{ -1404.13,-1603.84,0.78,36.86 },
	{ -1411.17,-1590.46,0.81,36.86 },
	{ -1519.21,-1348.42,0.59,36.86 },
	{ -1417.41,-1578.02,0.79,36.86 },
	{ -1422.73,-1567.67,0.78,36.86 },
	{ -1509.67,-1360.51,0.95,36.86 },
	{ -1428.25,-1557.11,0.81,36.86 },
	{ -1511.45,-1374.28,0.56,36.86 },
	{ -1433.91,-1546.27,0.79,36.86 },
	{ -1500.89,-1386.18,0.97,36.86 },
	{ -1439.23,-1535.99,0.75,36.86 },
	{ -1503.88,-1396.34,0.63,36.86 },
	{ -1443.83,-1527.39,0.74,36.86 },
	{ -1447.94,-1518.35,0.72,36.86 },
	{ -1493.37,-1406.92,0.93,36.86 },
	{ -1452.05,-1509.89,0.73,36.86 },
	{ -1496.86,-1415.67,0.56,36.86 },
	{ -1457.45,-1501.56,0.75,36.86 },
	{ -1491.89,-1417.76,0.72,36.86 },
	{ -1468.08,-1493.28,0.79,36.86 },
	{ -1474.71,-1488.47,0.88,36.86 },
	{ -1479.88,-1482.23,1.5,36.86 },
	{ -1483.88,-1472.99,1.4,36.86 },
	{ -1485.62,-1462.8,1.07,36.86 },
	{ -1493.63,-1421.27,0.59,36.86 },
	{ -1493.63,-1421.27,0.59,36.86 },
	{ -1493.63,-1421.27,0.59,36.86 },
	{ -1486.91,-1453.75,0.86,36.86 },
	{ -1487.91,-1443.72,0.65,36.86 },
	{ -1489.23,-1433.91,0.66,36.86 },
	{ -1491.65,-1422.92,0.66,36.86 },
	{ -1493.74,-1414.62,0.71,36.86 },
	{ -1496.72,-1406.23,0.78,36.86 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATESCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner",function(Status)
	InitScanner = Status
	SoundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		if InitScanner then
			local Ped = PlayerPedId()
			if not IsPedInAnyVehicle(Ped) then
				local Coords = GetEntityCoords(Ped)

				for k,v in pairs(scanTable) do
					local Distance = #(Coords - vec3(v[1],v[2],v[3]))
					if Distance <= 10.25 then
						SoundScanner = 1000

						if not initSounds[k] then
							initSounds[k] = true
						end

						if Distance <= 1.25 then
							TimeDistance = 1
							SoundScanner = 250

							if IsControlJustPressed(1,38) then
								TriggerEvent("inventory:MakeProducts","scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								SoundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							SoundScanner = 999
						end
					end
				end
			end
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if InitScanner and (SoundScanner == 1000 or SoundScanner == 250) then
			PlaySoundFrontend(-1,"MP_IDLE_TIMER","HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Wait(SoundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres",function(Network,Plate,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.tyreStatus()
	local Ped = PlayerPedId()
	if not IsPedInAnyVehicle(Ped) then
		local Vehicle = vRP.ClosestVehicle(7)
		if IsEntityAVehicle(Vehicle) then
			local Coords = GetEntityCoords(Ped)

			for Index,Tyre in pairs(tyreList) do
				local Selected = GetEntityBoneIndexByName(Vehicle,Index)
				if Selected ~= -1 then
					local CoordsWheel = GetWorldPositionOfEntityBone(Vehicle,Selected)
					local Distance = #(Coords - CoordsWheel)
					if Distance <= 1.0 then
						return true,Tyre,VehToNet(Vehicle),GetVehicleNumberPlateText(Vehicle)
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.tyreHealth(Network,Tyre)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle,Tyre)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOESOBJECTEXIST
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.objectExist(Coords,Hash)
	return DoesObjectOfTypeExistAtCoords(Coords["x"],Coords["y"],Coords["z"],0.35,Hash,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local ATMList = {
	["1"] = { 121.17,-3019.62,7.04 },
	["2"] = { 797.69,-767.52,26.77 },
	["3"] = { -1431.17,-447.73,35.91 },
	["4"] = { 168.55,6636.81,31.69 },
	["5"] = { -32.08,-1104.32,27.26 },
	["6"] = { 228.18,338.4,105.56 },
	["7"] = { 158.63,234.22,106.63 },
	["8"] = { -57.67,-92.62,57.78 },
	["9"] = { 356.97,173.54,103.07 },
	["10"] = { -1415.94,-212.03,46.51 },
	["11"] = { -1430.2,-211.08,46.51 },
	["12"] = { -1282.54,-210.9,42.44 },
	["13"] = { -1286.25,-213.44,42.44 },
	["14"] = { -1289.32,-226.82,42.44 },
	["15"] = { -1285.58,-224.28,42.44 },
	["16"] = { -1109.8,-1690.82,4.36 },
	["17"] = { 1686.85,4815.82,42.01 },
	["18"] = { 1701.21,6426.57,32.76 },
	["19"] = { 1171.56,2702.58,38.16 },
	["20"] = { 1172.5,2702.59,38.16 },
	["21"] = { -1091.49,2708.66,18.96 },
	["22"] = { -3144.38,1127.6,20.86 },
	["23"] = { 527.36,-160.69,57.09 },
	["24"] = { 285.45,143.39,104.17 },
	["25"] = { -846.27,-341.28,38.67 },
	["26"] = { -846.85,-340.2,38.67 },
	["27"] = { -721.06,-415.56,34.98 },
	["28"] = { -1410.34,-98.75,52.42 },
	["29"] = { -1409.78,-100.49,52.39 },
	["30"] = { -712.9,-818.92,23.72 },
	["31"] = { -710.05,-818.9,23.72 },
	["32"] = { -660.71,-854.07,24.48 },
	["33"] = { -594.58,-1161.29,22.33 },
	["34"] = { -596.09,-1161.28,22.33 },
	["35"] = { -821.64,-1081.91,11.12 },
	["36"] = { 155.93,6642.86,31.59 },
	["37"] = { 174.14,6637.94,31.58 },
	["38"] = { -283.01,6226.11,31.49 },
	["39"] = { -95.55,6457.19,31.46 },
	["40"] = { -97.3,6455.48,31.46 },
	["41"] = { -132.93,6366.52,31.48 },
	["42"] = { -386.74,6046.08,31.49 },
	["43"] = { 24.47,-945.96,29.35 },
	["44"] = { 5.24,-919.83,29.55 },
	["45"] = { 295.77,-896.1,29.22 },
	["46"] = { 296.47,-894.21,29.23 },
	["47"] = { 1138.22,-468.93,66.73 },
	["48"] = { 1166.97,-456.06,66.79 },
	["49"] = { 1077.75,-776.54,58.23 },
	["50"] = { 289.1,-1256.8,29.44 },
	["51"] = { 288.81,-1282.37,29.64 },
	["52"] = { -1571.05,-547.38,34.95 },
	["53"] = { -1570.12,-546.72,34.95 },
	["54"] = { -1305.4,-706.41,25.33 },
	["55"] = { -2072.36,-317.28,13.31 },
	["56"] = { -2295.48,358.13,174.6 },
	["57"] = { -2294.7,356.46,174.6 },
	["58"] = { -2293.92,354.8,174.6 },
	["59"] = { 2558.75,351.01,108.61 },
	["60"] = { 89.69,2.47,68.29 },
	["61"] = { -866.69,-187.75,37.84 },
	["62"] = { -867.62,-186.09,37.84 },
	["63"] = { -618.22,-708.89,30.04 },
	["64"] = { -618.23,-706.89,30.04 },
	["65"] = { -614.58,-704.83,31.24 },
	["66"] = { -611.93,-704.83,31.24 },
	["67"] = { -537.82,-854.49,29.28 },
	["68"] = { -526.62,-1222.98,18.45 },
	["69"] = { -165.15,232.7,94.91 },
	["70"] = { -165.17,234.78,94.91 },
	["71"] = { -303.25,-829.74,32.42 },
	["72"] = { -301.7,-830.01,32.42 },
	["73"] = { -203.81,-861.37,30.26 },
	["74"] = { 119.06,-883.72,31.12 },
	["75"] = { 112.58,-819.4,31.34 },
	["76"] = { 111.26,-775.25,31.44 },
	["77"] = { 114.43,-776.38,31.41 },
	["78"] = { -256.23,-715.99,33.53 },
	["79"] = { -258.87,-723.38,33.48 },
	["80"] = { -254.42,-692.49,33.6 },
	["81"] = { -28.0,-724.52,44.23 },
	["82"] = { -30.23,-723.69,44.23 },
	["83"] = { -1315.75,-834.69,16.95 },
	["84"] = { -1314.81,-835.96,16.95 },
	["85"] = { -2956.86,487.64,15.47 },
	["86"] = { -2958.98,487.73,15.47 },
	["87"] = { -3043.97,592.42,7.9 },
	["88"] = { -3241.17,997.6,12.55 },
	["89"] = { -1205.78,-324.79,37.86 },
	["90"] = { -1205.02,-326.3,37.84 },
	["91"] = { 147.58,-1035.77,29.34 },
	["92"] = { 146.0,-1035.17,29.34 },
	["93"] = { 33.55,-1345.0,29.49 },
	["94"] = { 2555.28,389.99,108.61 },
	["95"] = { 1153.65,-326.78,69.2 },
	["96"] = { -717.71,-915.66,19.21 },
	["97"] = { -56.98,-1752.09,29.42 },
	["98"] = { 381.93,326.43,103.56 },
	["99"] = { -3243.78,1009.24,12.82 },
	["100"] = { 1737.02,6413.25,35.03 },
	["101"] = { 540.4,2667.86,42.16 },
	["102"] = { 1966.81,3746.52,32.33 },
	["103"] = { 2680.45,3288.48,55.23 },
	["104"] = { 1703.0,4933.6,42.06 },
	["105"] = { -1827.3,784.88,138.3 },
	["106"] = { -3043.91,592.48,7.9 },
	["107"] = { 238.61,212.44,106.27 },
	["108"] = { 239.06,213.67,106.27 },
	["109"] = { 239.5,214.88,106.27 },
	["110"] = { 239.94,216.15,106.27 },
	["111"] = { 241.01,219.02,106.27 },
	["112"] = { 241.43,220.24,106.27 },
	["113"] = { 241.89,221.49,106.27 },
	["114"] = { 242.35,222.7,106.27 },
	["115"] = { 264.02,203.62,106.27 },
	["116"] = { 264.48,204.89,106.27 },
	["117"] = { 264.94,206.14,106.27 },
	["118"] = { 265.38,207.34,106.27 },
	["120"] = { 130.11,-1292.7,29.27 },
	["121"] = { 130.11,-1292.7,29.27 },
	["122"] = { 315.09,-593.68,43.29 },
	["123"] = { -677.36,5834.58,17.32 },
	["124"] = { 472.3,-1001.57,30.68 },
	["125"] = { 468.52,-990.55,26.27 },
	["126"] = { 349.86,-594.51,28.8 },
	["127"] = { -352.87,-144.98,38.91 },	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATM
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.checkAtm(Coords)
	local BombZone = false
	local AtmSelected = false

	for Number,v in pairs(ATMList) do
		local Distance = #(vec3(Coords["x"],Coords["y"],Coords["z"]) - vec3(v[1],v[2],v[3]))
		if Distance <= 1.0 then
			BombZone = vec3(v[1],v[2],v[3] - 1)
			AtmSelected = Number
			break
		end
	end

	return BombZone,AtmSelected
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsPeds = {}
local StealPeds = {}
local DrugsTimer = GetGameTimer()
local StealTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTEALNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) and IsPedArmed(Ped,7) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not StealPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 5 then
						TimeDistance = 100

						local Pid = PlayerId()
						if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) and GetEntityModel(Selected) ~= -359228352 then
							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							StealPeds[Selected] = true

							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true

							if LoadAnim("random@mugging3") then
								TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,0,0,0,0)
							end

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
									SelectedRobbery = SelectedRobbery - 1

									if not IsEntityPlayingAnim(Selected,"random@mugging3","handsup_standing_base",3) then
										TaskPlayAnim(Selected,"random@mugging3","handsup_standing_base",8.0,8.0,-1,16,0,0,0,0)
									end

									if SelectedRobbery <= 0 then
										if LoadModel("prop_paper_bag_small") then
											local Object = CreateObject("prop_paper_bag_small",Coords["x"],Coords["y"],Coords["z"],false,false,false)
											AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,-0.05,0.05,180.0,0.0,0.0,false,false,false,false,2,true)
											
											if LoadAnim("mp_safehouselost@") then
												TaskPlayAnim(Selected,"mp_safehouselost@","package_dropoff",8.0,8.0,-1,16,0,0,0,0)
											end

											Wait(3000)

											if DoesEntityExist(Object) then
												DeleteEntity(Object)
											end

											vSERVER.StealPeds()
											ClearPedSecondaryTask(Selected)
											TaskWanderStandard(Selected,10.0,10)

											LocalPlayer["state"]["Buttons"] = false
											LocalPlayer["state"]["Commands"] = false

											break
										end
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) then
			local Handler,Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not DrugsPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 1 then
						TimeDistance = 1

						if IsControlJustPressed(1,38) and GetGameTimer() >= DrugsTimer and vSERVER.AmountDrugs() then
							DrugsTimer = GetGameTimer() + 5000

							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true

							TaskSetBlockingOfNonTemporaryEvents(Selected,true)
							SetBlockingOfNonTemporaryEvents(Selected,true)
							SetEntityAsMissionEntity(Selected,true,true)
							SetPedDropsWeaponsWhenDead(Selected,false)
							TaskTurnPedToFaceEntity(Selected,Ped,3.0)
							SetPedSuffersCriticalHits(Selected,false)
							DrugsPeds[Selected] = true

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 then
									SelectedRobbery = SelectedRobbery - 1

									if SelectedRobbery <= 0 then
										if LoadModel("prop_anim_cash_note") then
											local Object = CreateObject("prop_anim_cash_note",Coords["x"],Coords["y"],Coords["z"],false,false,false)
											AttachEntityToEntity(Object,Selected,GetPedBoneIndex(Selected,28422),0.0,0.0,0.0,90.0,0.0,0.0,false,false,false,false,2,true)
											vRP.createObjects("mp_safehouselost@","package_dropoff","prop_paper_bag_small",16,28422,0.0,-0.05,0.05,180.0,0.0,0.0)
											SetModelAsNoLongerNeeded("prop_anim_cash_note")

											if LoadAnim("mp_safehouselost@") then
												TaskPlayAnim(Selected,"mp_safehouselost@","package_dropoff",8.0,8.0,-1,16,0,0,0,0)
											end

											Wait(3000)

											if DoesEntityExist(Object) then
												DeleteEntity(Object)
											end

											vRP.removeObjects()
											ClearPedSecondaryTask(Selected)
											TaskWanderStandard(Selected,10.0,10)
											vSERVER.DrugPeds()

											LocalPlayer["state"]["Buttons"] = false
											LocalPlayer["state"]["Commands"] = false

											break
										end
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected,10.0,10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success,Selected = FindNextPed(Handler)
			until not Success EndFindPed(Handler)
		end

		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKARMS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckArms()
	return exports["paramedic"]:Arms()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local disSelect = 1
local disPlate = nil
local disModel = nil
local disActive = false
local disVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disCoords = {
	{ 1222.5,-704.47,60.46,280.63 },
	{ 1130.51,-485.59,65.38,73.71 },
	{ 1145.64,-275.44,68.73,87.88 },
	{ 870.49,-36.63,78.54,56.7 },
	{ 686.17,270.39,93.18,240.95 },
	{ 424.75,248.87,102.97,252.29 },
	{ 320.31,344.97,104.97,164.41 },
	{ -305.23,379.3,110.1,14.18 },
	{ -585.54,526.74,107.3,215.44 },
	{ -141.85,-1415.44,30.26,119.06 },
	{ 78.27,-1442.22,29.08,323.15 },
	{ 37.9,-1627.08,29.05,320.32 },
	{ 8.93,-1758.65,29.07,48.19 },
	{ -57.56,-1845.21,26.25,320.32 },
	{ 165.33,-1862.16,23.88,155.91 },
	{ 281.15,-2081.27,16.58,110.56 },
	{ 273.47,-2569.7,5.48,204.1 },
	{ 879.22,-2174.3,30.28,172.92 },
	{ 1116.02,-1502.53,34.46,272.13 },
	{ 1318.13,-534.38,71.83,158.75 },
	{ 1272.4,-353.88,68.85,110.56 },
	{ 653.32,176.89,94.78,68.04 },
	{ 638.88,285.34,102.97,150.24 },
	{ 320.97,495.35,152.24,286.3 },
	{ -74.63,495.95,144.22,8.51 },
	{ 176.89,483.66,141.99,351.5 },
	{ 181.24,380.51,108.55,0.0 },
	{ -398.45,337.43,108.48,0.0 },
	{ -472.76,353.61,103.64,337.33 },
	{ -947.26,574.26,100.76,343.0 },
	{ -1093.13,597.22,102.83,212.6 },
	{ -1271.82,452.79,94.8,19.85 },
	{ -1452.14,533.73,118.98,243.78 },
	{ -1507.85,429.28,110.84,45.36 },
	{ -1945.59,461.12,101.76,96.38 },
	{ -2001.96,368.42,94.24,184.26 },
	{ -1325.69,275.44,63.19,221.11 },
	{ -1281.53,251.9,63.1,0.0 },
	{ -905.31,-161.16,41.65,25.52 },
	{ -1023.98,-889.95,5.43,28.35 },
	{ -1318.87,-1141.38,4.26,90.71 },
	{ -1311.98,-1262.24,4.33,17.01 },
	{ -1297.72,-1316.22,4.5,0.0 },
	{ -1245.66,-1408.65,4.08,306.15 },
	{ -1092.76,-1595.64,4.31,306.15 },
	{ -963.01,-1592.08,4.79,19.85 },
	{ -915.94,-1541.24,4.79,17.01 },
	{ -1612.04,172.37,59.56,206.93 },
	{ -1242.87,381.54,75.12,14.18 },
	{ -1486.76,40.22,54.19,345.83 },
	{ -1576.99,-81.09,53.9,272.13 },
	{ -1391.2,75.67,53.46,130.4 },
	{ -1371.61,-26.18,53.01,0.0 },
	{ -1643.74,-232.78,54.63,252.29 },
	{ -1656.27,-379.46,45.09,232.45 },
	{ -1591.38,-643.5,29.93,232.45 },
	{ -1486.49,-735.27,25.29,181.42 },
	{ -1423.37,-963.41,7.03,56.7 },
	{ -1277.8,-1149.11,6.08,113.39 },
	{ -1070.8,-1424.54,5.12,257.96 },
	{ -1069.67,-1250.98,5.49,119.06 },
	{ -1610.2,-812.21,9.81,138.9 },
	{ -2061.94,-455.86,11.44,320.32 },
	{ -2981.69,83.31,11.29,147.41 },
	{ -3045.4,111.55,11.32,320.32 },
	{ -2960.51,368.42,14.54,31.19 },
	{ -3052.28,599.99,7.11,289.14 },
	{ -3253.1,987.45,12.23,0.0 },
	{ -3236.9,1038.27,11.42,266.46 },
	{ -3156.21,1153.75,20.83,246.62 },
	{ -1819.34,785.21,137.68,223.94 },
	{ -1749.7,366.06,89.47,116.23 },
	{ -1194.9,322.62,70.48,17.01 },
	{ -1207.54,272.21,69.3,286.3 },
	{ -722.21,-76.25,37.31,243.78 },
	{ -475.64,-218.96,36.16,212.6 },
	{ -532.25,-270.6,34.98,110.56 },
	{ -465.2,-451.88,33.97,82.21 },
	{ -391.09,-456.15,30.72,127.56 },
	{ -357.4,-767.63,38.55,272.13 },
	{ -330.9,-935.02,30.85,68.04 },
	{ -27.99,-2547.6,5.78,53.86 },
	{ -140.18,-2506.08,5.76,53.86 },
	{ -168.21,-2583.56,5.76,0.0 },
	{ -219.34,-2488.65,5.76,87.88 },
	{ -340.93,-2430.9,5.76,138.9 },
	{ -434.24,-2441.94,5.76,232.45 },
	{ 124.19,-2898.73,5.76,0.0 },
	{ 237.55,-3315.73,5.56,201.26 },
	{ 150.76,-3184.91,5.63,178.59 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLECATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local DismantleCategory = {
	["B"] = {
		"panto","prairie","rhapsody","blista","emperor2","emperor","bfinjection","ingot","regina"
	},
	["B+"] = {
		"asbo","brioso","club","weevil","felon","felon2","jackal","oracle","zion","zion2","buccaneer","virgo",
		"voodoo","bifta","rancherxl","bjxl","cavalcade","gresley","habanero","rocoto","primo","stratum","pigalle",
		"peyote","manana","streiter"
	},
	["A"] = {
		"exemplar","windsor","windsor2","blade","clique","dominator","faction2","gauntlet","moonbeam","nightshade",
		"sabregt2","tampa","rebel","baller","cavalcade2","fq2","huntley","landstalker","patriot","radi","xls","blista2",
		"retinue","stingergt","surano","specter","sultan","schwarzer","schafter2","ruston","rapidgt","raiden","ninef",
		"ninef2","omnis","massacro","jester","feltzer2","futo","carbonizzare"
	},
	["A+"] = {
		"tempesta","turismo2","retinue","mamba","infernus2","feltzer3","coquette2","futo2","zr350","tampa2",
		"sugoi","sultan2","schlagen","penumbra","pariah","paragon","jester3","gb200","elegy","furoregt"
	},
	["S"] = {
		"adder","autarch","banshee2","bullet","cheetah","cyclone","entity2","entity3","entityxf","emerus","fmj","furia","gp1",
		"infernus","italigtb","italigtb2","krieger","le7b","nero","nero2","osiris","penetrator","pfister811","prototipo","reaper"
	},
	["S+"] = {
		"s80","sc1","scramjet","sheava","sultanrs","t20","taipan","tempesta","tezeract","thrax","tigon","turismor","tyrant",
		"tyrus","vacca","vagner","vigilante","virtue","visione","voltic","voltic2","xa21","zentorno","zorrusso"
	}
}












-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismantle(Experience)
	if not disActive then
		disActive = true
		disSelect = math.random(#disCoords)
		disPlate = "DISM"..(1000 + LocalPlayer["state"]["Passport"])

		local Category = ClassCategory(Experience)
		local ModelRandom = math.random(#DismantleCategory[Category])
		disModel = DismantleCategory[Category][ModelRandom]

		local RandomX = math.random(25,100)
		local RandomY = math.random(25,100)

		if math.random(2) >= 2 then
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Veículo", x = disCoords[disSelect][1] + RandomX + 0.0, y = disCoords[disSelect][2] - RandomY + 0.0, z = disCoords[disSelect][3], vehicle = VehicleName(disModel).." - "..disPlate, blipColor = 60 })
		else
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Veículo", x = disCoords[disSelect][1] - RandomX + 0.0, y = disCoords[disSelect][2] + RandomY + 0.0, z = disCoords[disSelect][3], vehicle = VehicleName(disModel).." - "..disPlate, blipColor = 60 })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.DismantleStatus()
	return disActive
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Disreset")
AddEventHandler("inventory:Disreset",function()
	disSelect = 1
	disPlate = nil
	disModel = nil
	disActive = false
	disVehicle = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if disActive and not disVehicle then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3]))

			if Distance <= 125 then
				disVehicle = vGARAGE.ServerVehicle(disModel,disCoords[disSelect][1],disCoords[disSelect][2],disCoords[disSelect][3],disCoords[disSelect][4],disPlate,1000,nil,1000)

				if NetworkDoesNetworkIdExist(disVehicle) then
					local Network = NetToEnt(disVehicle)
					if NetworkDoesNetworkIdExist(Network) then
						SetVehicleOnGroundProperly(Network)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disPeds = {
	"ig_abigail","a_m_m_afriamer_01","ig_mp_agent14","csb_agent","ig_amandatownley","s_m_y_ammucity_01","u_m_y_antonb","g_m_m_armboss_01",
	"g_m_m_armgoon_01","g_m_m_armlieut_01","ig_ashley","s_m_m_autoshop_01","ig_money","g_m_y_ballaeast_01","g_f_y_ballas_01","g_m_y_ballasout_01",
	"s_m_y_barman_01","u_m_y_baygor","a_m_o_beach_01","ig_bestmen","a_f_y_bevhills_01","a_m_m_bevhills_02","u_m_m_bikehire_01","u_f_y_bikerchic",
	"mp_f_boatstaff_01","s_m_m_bouncer_01","ig_brad","ig_bride","u_m_y_burgerdrug_01","a_m_m_business_01","a_m_y_business_02","s_m_o_busker_01",
	"ig_car3guy2","cs_carbuyer","g_m_m_chiboss_01","g_m_m_chigoon_01","g_m_m_chigoon_02","u_f_y_comjane","ig_dale","ig_davenorton","s_m_y_dealer_01",
	"ig_denise","ig_devin","a_m_y_dhill_01","ig_dom","a_m_y_downtown_01","ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local disWeapons = { "WEAPON_BAT", "WEAPON_BAT", "WEAPON_BAT", "WEAPON_BAT", "WEAPON_BAT", "WEAPON_SNSPISTOL" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DisPed")
AddEventHandler("inventory:DisPed",function()
local Ped = PlayerPedId()
	local Rand = math.random(#disPeds)
	local Coords = GetEntityCoords(Ped)
	local Weapon = math.random(#disWeapons)
	local cX = Coords["x"] + math.random(-25.0,25.0)
	local cY = Coords["y"] + math.random(-25.0,25.0)
	local Hit,EntCoords = GetSafeCoordForPed(cX,cY,Coords["z"],false,16)
	local Entity,EntityNet = vRPS.CreatePed(disPeds[Rand],EntCoords["x"],EntCoords["y"],EntCoords["z"],3374176,4)
	if Entity then
		Wait(1000)

		local NetEntity = LoadNetwork(EntityNet)

		SetPedArmour(NetEntity,99)
		SetPedAccuracy(NetEntity,100)
		SetPedRelationshipGroupHash(NetEntity,GetHashKey("HATES_PLAYER"))
		SetPedKeepTask(NetEntity,true)
		SetCanAttackFriendly(NetEntity,false,true)
		TaskCombatPed(NetEntity,Ped,0,16)
		SetPedCombatAttributes(NetEntity,46,true)
		SetPedCombatAbility(NetEntity,0)
		SetPedCombatAttributes(NetEntity,0,true)
		GiveWeaponToPed(NetEntity,disWeapons[Weapon],-1,false,true)
		SetPedDropsWeaponsWhenDead(NetEntity,false)
		SetPedCombatRange(NetEntity,2)
		SetPedFleeAttributes(NetEntity,0,0)
		SetPedConfigFlag(NetEntity,58,true)
		SetPedConfigFlag(NetEntity,75,true)
		SetPedFiringPattern(NetEntity,-957453492)
		SetBlockingOfNonTemporaryEvents(NetEntity,true)

		SetModelAsNoLongerNeeded(disPeds[Rand])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local WeaObjects = {}
local WeaConfig = {
	["WEAPON_KATANA"] = {
		["Bone"] = 24818,
		["x"] = 0.32,
		["y"] = -0.15,
		["z"] = 0.20,
		["RotX"] = -30.0,
		["RotY"] = -225.0,
		["RotZ"] = 205.0,
		["Model"] = "w_me_katana"
	},
	["WEAPON_BAT"] = {
		["Bone"] = 24818,
		["x"] = 0.32,
		["y"] = -0.15,
		["z"] = 0.20,
		["RotX"] = -30.0,
		["RotY"] = -225.0,
		["RotZ"] = 205.0,
		["Model"] = "w_me_bat"
	},
	["WEAPON_POOLCUE"] = {
		["Bone"] = 24818,
		["x"] = 0.32,
		["y"] = -0.15,
		["z"] = 0.20,
		["RotX"] = -30.0,
		["RotY"] = -225.0,
		["RotZ"] = 205.0,
		["Model"] = "w_me_poolcue"
	},
	["WEAPON_MACHETE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.15,
		["z"] = 0.20,
		["RotX"] = -15.0,
		["RotY"] = -215.0,
		["RotZ"] = 205.0,
		["Model"] = "w_me_machette_lr"
	},
	["WEAPON_HATCHET"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.15,
		["z"] = 0.10,
		["RotX"] = -25.0,
		["RotY"] = -225.0,
		["RotZ"] = 205.0,
		["Model"] = "prop_w_me_hatchet"
	},
	["WEAPON_BATTLEAXE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.15,
		["z"] = 0.10,
		["RotX"] = -25.0,
		["RotY"] = -225.0,
		["RotZ"] = 205.0,
		["Model"] = "w_me_battleaxe"
	},

	["WEAPON_COLTXM177"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_coltxm177"
	},
	["WEAPON_SNSPISTOL"] = {
		["Bone"] = 11816,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.20,
		["RotX"] = -90.0,
		["RotY"] = 0.0,
		["RotZ"] = 0.0,
		["Model"] = "w_pi_sns_pistol"
	},

	["WEAPON_CARBINERIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_carbinerifle"
	},
	["WEAPON_CARBINERIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_carbineriflemk2"
	},
	["WEAPON_ADVANCEDRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_advancedrifle"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_bullpuprifle"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.02,
		["y"] = -0.14,
		["z"] = -0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_bullpupriflemk2"
	},
	["WEAPON_SPECIALCARBINE"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_specialcarbine"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_specialcarbinemk2"
	},
	["WEAPON_PARAFAL"] = {
		["Bone"] = 24818,
		["x"] = 0.0,
		["y"] = -0.14,
		["z"] = -0.12,
		["RotX"] = 0.0,
		["RotY"] = 360.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_parafal"
	},
	["WEAPON_FNFAL"] = {
		["Bone"] = 24818,
		["x"] = 0.0,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 180.0,
		["RotY"] = 360.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_fnfal"
	},
	["WEAPON_MUSKET"] = {
		["Bone"] = 24818,
		["x"] = -0.1,
		["y"] = -0.14,
		["z"] = 0.0,
		["RotX"] = 0.0,
		["RotY"] = 0.8,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_musket"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sg_pumpshotgun"
	},
	["WEAPON_PUMPSHOTGUN_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sg_pumpshotgunmk2"
	},
	["WEAPON_SMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sb_smg"
	},
	["WEAPON_SMG_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sb_smgmk2"
	},
	["WEAPON_COMPACTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.22,
		["y"] = -0.14,
		["z"] = 0.12,
		["RotX"] = 0.0,
		["RotY"] = 180.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_assaultrifle_smg"
	},
	["WEAPON_ASSAULTSMG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = -0.07,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sb_assaultsmg"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		["Bone"] = 24818,
		["x"] = 0.08,
		["y"] = -0.14,
		["z"] = 0.08,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_ar_assaultrifle"
	},
	["WEAPON_GUSENBERG"] = {
		["Bone"] = 24818,
		["x"] = 0.12,
		["y"] = -0.14,
		["z"] = 0.04,
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_sb_gusenberg"
	},
	["WEAPON_RPG"] = {
		["Bone"] = 24818,
		["x"] = -0.15, --CIMA >
		["y"] = -0.20, -- < TRAS
		["z"] = -0.15, -- ESQUERDA >
		["RotX"] = 0.0,
		["RotY"] = 135.0,
		["RotZ"] = 5.0,
		["Model"] = "w_lr_rpg"
	},
	["WEAPON_PISTOL"] = {
		["Bone"] = 11816,
		["x"] = 0.0,
		["y"] = 0.0,
		["z"] = 0.20,
		["RotX"] = -90.0,
		["RotY"] = 0.0,
		["RotZ"] = 0.0,
		["Model"] = "w_pi_pistol"
	}

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:RemoveWeapon")
AddEventHandler("inventory:RemoveWeapon",function(Item)
	local Split = splitString(Item,"-")
	local Name = Split[1]

	if WeaObjects[Name] then
		TriggerServerEvent("DeleteObject",0,Name)
		WeaObjects[Name] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CREATEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:CreateWeapon")
AddEventHandler("inventory:CreateWeapon",function(Item)
	local Split = splitString(Item,"-")
	local Name = Split[1]

	if not WeaObjects[Name] and WeaConfig[Name] then
		local Ped = PlayerPedId()
		local Config = WeaConfig[Name]
		local Coords = GetEntityCoords(Ped)
		local Bone = GetPedBoneIndex(Ped,Config["Bone"])

		local Progression,Network = vRPS.CreateObject(Config["Model"],Coords["x"],Coords["y"],Coords["z"],Name)
		if Progression then
			WeaObjects[Name] = LoadNetwork(Network)
			AttachEntityToEntity(WeaObjects[Name],Ped,Bone,Config["x"],Config["y"],Config["z"],Config["RotX"],Config["RotY"],Config["RotZ"],false,false,false,false,2,true)
			SetEntityCompletelyDisableCollision(WeaObjects[Name],false,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckMods(Vehicle,Mod)
	return GetNumVehicleMods(Vehicle,Mod) - 1
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCAR
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckCar(Vehicle)
	local Model = GetEntityModel(Vehicle)
	return IsThisModelACar(Model)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.ActiveMods(Vehicle,Plate,Mod,Number)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == Plate then
				SetVehicleMod(Vehicle,Mod,Number)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BURGERSHOT
-----------------------------------------------------------------------------------------------------------------------------------------
local BurgerShot = PolyZone:Create({
	vector2(-1174.21,-898.17),
	vector2(-1188.63,-908.10),
	vector2(-1198.07,-906.52),
	vector2(-1208.42,-891.13),
	vector2(-1188.37,-877.37)
},{ name = "BurgerShot" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- PIZZATHIS
-----------------------------------------------------------------------------------------------------------------------------------------
local PizzaThis = PolyZone:Create({
	vector2(793.94,-747.72),
	vector2(794.00,-768.85),
	vector2(814.90,-768.82),
	vector2(814.93,-747.62),
	vector2(812.48,-739.99),
	vector2(794.07,-740.05)
},{ name = "PizzaThis" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEANMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
local BeanMachine = PolyZone:Create({
	vector2(129.73,-1029.63),
	vector2(118.45,-1025.35),
	vector2(110.82,-1046.34),
	vector2(122.31,-1050.47)
},{ name = "BeanMachine" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- UWUCOFFEE
-----------------------------------------------------------------------------------------------------------------------------------------
local UwUCoffee = PolyZone:Create({
	vector2(-565.30,-1071.24),
	vector2(-575.38,-1070.52),
	vector2(-601.44,-1069.51),
	vector2(-601.53,-1046.78),
	vector2(-565.33,-1047.50)
},{ name = "UwUCoffee" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTAURANT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Restaurant(Name)
	local Return = false
	local Ped = PlayerPedId()
	local Coords = GetEntityCoords(Ped)

	if Name == "BurgerShot" then
		if BurgerShot:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "PizzaThis" then
		if PizzaThis:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "BeanMachine" then
		if BeanMachine:isPointInside(Coords) then
			Return = true
		end
	elseif Name == "Uwucoffee" then
		if UwUCoffee:isPointInside(Coords) then
			Return = true
		end
	end

	return Return
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
-- CreateThread(function()
-- 	local amountCoords = 0
-- 	repeat
-- 		amountCoords = amountCoords + 1
-- 		local rand = math.random(#scanCoords)
-- 		scanTable[amountCoords] = scanCoords[rand]
-- 		Wait(1)
-- 	until amountCoords == 25

-- 	for Number,v in pairs(ATMList) do
-- 		exports["target"]:AddCircleZone("Atm:"..Number,vec3(v[1],v[2],v[3]),0.5,{
-- 			name = "Atm:"..Number,
-- 			heading = 3374176
-- 		},{
-- 			Distance = 1.0,
-- 			options = {
-- 				{
-- 					event = "Bank",
-- 					label = "Abrir",
-- 					tunnel = "client"
-- 				}
-- 			}
-- 		})
-- 	end
-- end)

function Creative.isWithClothes()
	local clothesTrasher = exports['shops']:trasherClothes()
	local ped = PlayerPedId()
	local custom = vNATION.getCloths() 
	for k,v in pairs(clothesTrasher) do
		for clothe, table in pairs(custom) do
			if translateComponents[clothe] and (translateComponents[clothe] == translateComponents[k]) then
				if not (v.item == table.item) then
					return false
				end
			end
		end
	end

	return true
end