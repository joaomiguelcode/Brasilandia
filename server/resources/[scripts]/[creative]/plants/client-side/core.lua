-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("plants",Creative)
vSERVER = Tunnel.getInterface("plants")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Plants = {}
local Objects = {}


local phases = {
	[1] = 'bkr_prop_weed_01_small_01c',
	[2] = 'bkr_prop_weed_01_small_01a',
	[3] = 'bkr_prop_weed_med_01a'
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)
		for k,v in pairs(Plants) do
			local Distance = #(Coords - vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]))
			if Distance <= 50 then
				if not Objects[k] and v["Route"] == LocalPlayer["state"]["Route"] then
					exports["target"]:AddBoxZone("Plants:"..k,vec3(v["Coords"][1],v["Coords"][2],v["Coords"][3]),0.4,0.4,{
						name = "Plants:"..k,
						heading = 3374176,
						minZ = v["Coords"][3] - 0.50,
						maxZ = v["Coords"][3] + 2.50,
					},{
						shop = k,
						Distance = 2.5,
						options = {
							{
								event = "plants:Informations",
								label = "Verificar",
								tunnel = "shop"
							}
						}
					})

					local Object = ""
					if v.Phase == 1 then
						Object = phases[1]
					elseif v.Phase == 2 then
						Object = phases[2]
					else
						Object = phases[3]
					end
					createModels(k,v["Coords"],Object)
					-- createModels(k,v["Coords"],v.Object)
				end
			else
				if Objects[k] then
					if DoesEntityExist(Objects[k]) then
						exports["target"]:RemCircleZone("Plants:"..k)
						DeleteEntity(Objects[k])
						Objects[k] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Informations")
AddEventHandler("plants:Informations",function(Number)
	local Informations = vSERVER.Informations(Number)
	--local isPolice = vSERVER.isPolice()
	if Informations then
		exports["dynamic"]:AddButton("Coletar",Informations[1],"plants:Collect",Number,false,true)
		exports["dynamic"]:AddButton("Clonagem",Informations[2],"plants:Cloning",Number,false,true)
		--if isPolice then
			exports["dynamic"]:AddButton("Destruir","Destruir plantação","plants:Removing",Number,false,true)
		--end
		exports["dynamic"]:openMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEMODELS
-----------------------------------------------------------------------------------------------------------------------------------------
function createModels(Number,Coords,object)
	if LoadModel(object) then
		Objects[Number] = CreateObjectNoOffset(object,Coords[1],Coords[2],Coords[3],false,false,false)
		SetModelAsNoLongerNeeded(object)
		PlaceObjectOnGroundProperly(Objects[Number])
		FreezeEntityPosition(Objects[Number],true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Table")
AddEventHandler("plants:Table",function(table)
	Plants = table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:NEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:New")
AddEventHandler("plants:New",function(Number,Table,obj)
	Plants[Number] = Table
	Plants[Number].Object = obj
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLANTS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("plants:Remover")
AddEventHandler("plants:Remover",function(Number)
	Plants[Number] = nil

	if DoesEntityExist(Objects[Number]) then
		exports["target"]:RemCircleZone("Plants:"..Number)
		DeleteEntity(Objects[Number])
		Objects[Number] = nil
	end
end)