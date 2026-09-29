-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("pdm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mount = nil
local Camera = nil
local LastModel = ""
local CamRoration = 294.81
local CamCoords = vec3(-49.14,-1099.56,26.92)
local TestDriveReturn = vec3(-770.63,-1039.22,13.5)
local VehicleCoords = vec4(-775.31,-1033.84,13.55,283.47)
local TestDriveCoords = vec4(-811.27,-1088.76,10.88,306.15)
local PDMCoords = vec3(-49.14,-1099.56,26.92)
local InPDMZone = false
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAMERAACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
function CameraActive()
	if not DoesCamExist(Camera) then
		Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
		SetCamCoord(Camera,CamCoords.x,CamCoords.y,CamCoords.z)
		SetCamRot(Camera,CamRoration,0.0,0.0)
		SetCamActive(Camera,true)
		RenderScriptCams(true,false,0,false,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1000
		local Ped = PlayerPedId()
		local PedCoords = GetEntityCoords(Ped)
		
		local Distance = #(PDMCoords - PedCoords)
		if Distance <= 15 then
			TimeDistance = 4
			DrawMarker(27,PDMCoords.x,PDMCoords.y,PDMCoords.z - 1.0,0,0,0,0,0,0,1.0,1.0,1.0,59,130,246,100,0,0,0,1)
			
			if Distance <= 2.5 and not menuOpen then
				if not InPDMZone then
					InPDMZone = true
				end
				
				DrawText3D(PDMCoords.x,PDMCoords.y,PDMCoords.z + 0.5,"[E] ABRIR CONCESSIONÁRIA")
				
				if IsControlJustPressed(0,38) then -- E key
					TriggerEvent("pdm:Open")
				end
			else
				if InPDMZone then
					InPDMZone = false
				end
			end
		else
			if InPDMZone then
				InPDMZone = false
			end
		end
		
		Wait(TimeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)
	if onScreen then
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255,255,255,215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y + 0.0125,0.01 + factor,0.03,38,42,56,68)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("pdm:Open")
AddEventHandler("pdm:Open",function()
	if menuOpen then return end
	menuOpen = true
	
	print("[PDM-DEBUG] Evento pdm:Open acionado!")
	
	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	local Ped = PlayerPedId()
	print("[PDM-DEBUG] Verificando condições...")
	
	if not LocalPlayer["state"]["Buttons"] and not LocalPlayer["state"]["Commands"] and GetEntityHealth(Ped) > 100 and not exports["hud"]:Wanted() then
		print("[PDM-DEBUG] Condições atendidas, abrindo painel...")
		CameraActive()
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("dynamic:Close")
		TriggerEvent("hud:Active",false)
		
		local vehicles = vSERVER.VehicleGlobal()
		local discount = vSERVER.Discount()
		print("[PDM-DEBUG] Enviando dados para NUI...")
		
		SendNUIMessage({ Action = "Open", Payload = { vehicles, discount } })
		print("[PDM-DEBUG] Mensagem NUI enviada!")
	else
		print("[PDM-DEBUG] Condições não atendidas para abrir painel")
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Close",function(Data,Callback)
	TriggerEvent("hud:Active",true)
	TriggerEvent("pdm:Close")

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Mount",function(Data,Callback)
	local Vehicle = Data["vehicle"]
	if LoadModel(Vehicle) and LastModel ~= Vehicle then
		if DoesEntityExist(Mount) then
			DeleteEntity(Mount)
		end

		Mount = CreateVehicle(Vehicle,VehicleCoords.x,VehicleCoords.y,VehicleCoords.z,VehicleCoords.w,false,false)
		SetVehicleCustomSecondaryColour(Mount,59,130,246)
		SetVehicleCustomPrimaryColour(Mount,59,130,246)
		SetVehicleNumberPlateText(Mount,"PDMSPORT")
		SetEntityCollision(Mount,false,false)
		FreezeEntityPosition(Mount,true)
		SetEntityInvincible(Mount,true)
		SetVehicleDirtLevel(Mount,0.0)
		SetModelAsNoLongerNeeded(Vehicle)
		LastModel = Vehicle
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Buy",function(Data,Callback)
	local success, message = vSERVER.Buy(Data["vehicle"])
	
	if success == nil then
		success = false
		message = "Erro interno no servidor."
	end

	Callback({ success = success, message = message })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMYVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMyVehicles",function(Data,Callback)
	local vehicles = vSERVER.requestMyVehicles()
	Callback({ list = vehicles })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Rotate",function(Data,Callback)
	if DoesEntityExist(Mount) then
		if Data["direction"] == "Left" then
			SetEntityHeading(Mount,GetEntityHeading(Mount) - 5)
		else
			SetEntityHeading(Mount,GetEntityHeading(Mount) + 5)
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Drive",function(Data,Callback)
	print("=========================================")
	print("[PDM-DEBUG] Callback 'Drive' iniciado pelo NUI!")
	print("[PDM-DEBUG] Nome do Veículo Recebido:", Data["vehicle"])

	if vSERVER.Check(Data["vehicle"]) then
		print("[PDM-DEBUG] vSERVER.Check passou. Mudando bucket e cobrando banco...")
		if IsScreenFadedIn() then
			DoScreenFadeOut(0)
			print("[PDM-DEBUG] Tela escura (DoScreenFadeOut ativado).")
		end

		TriggerEvent("pdm:Close")
		SendNUIMessage({ Action = "Close" })
		print("[PDM-DEBUG] Fechando NUI...")

		CreateThread(function()
			local Hash = type(Data["vehicle"]) == "string" and GetHashKey(Data["vehicle"]) or Data["vehicle"]
			print("[PDM-DEBUG] Hash do Veículo gerado:", Hash)
			
			local loadTimer = 0
			print("[PDM-DEBUG] Forçando carregamento do modelo ignorando validação nativa...")
			RequestModel(Hash)
			while not HasModelLoaded(Hash) and loadTimer < 100 do
				RequestModel(Hash)
				Wait(100)
				loadTimer = loadTimer + 1
			end

			print("[PDM-DEBUG] Fim do pre-load do carro. HasModelLoaded:", HasModelLoaded(Hash))

			if HasModelLoaded(Hash) then
				if DoesEntityExist(Mount) then
					DeleteEntity(Mount)
					print("[PDM-DEBUG] Apagado veículo Mount antigo.")
				end

				print("[PDM-DEBUG] SetEntityCoords para TestDriveCoords ("..TestDriveCoords.x..").")
				SetEntityCoords(PlayerPedId(),TestDriveCoords.x,TestDriveCoords.y,TestDriveCoords.z,false,false,false,false)
				RequestCollisionAtCoord(TestDriveCoords.x,TestDriveCoords.y,TestDriveCoords.z)
				Wait(500)

				print("[PDM-DEBUG] Tentando CreateVehicle...")
				Mount = CreateVehicle(Hash,TestDriveCoords.x,TestDriveCoords.y,TestDriveCoords.z,TestDriveCoords.w,false,false)
				print("[PDM-DEBUG] CreateVehicle retornou valor Mount:", Mount)

				local spawnTimer = 0
				while not DoesEntityExist(Mount) and spawnTimer < 20 do
					Wait(100)
					spawnTimer = spawnTimer + 1
				end
				print("[PDM-DEBUG] DoesEntityExist(Mount):", DoesEntityExist(Mount))

				if DoesEntityExist(Mount) then
					print("[PDM-DEBUG] Veiculo existe localmente! Colocando configs e sentando ped...")
					SetVehicleModKit(Mount,0)
					SetVehicleDirtLevel(Mount,0.0)
					ToggleVehicleMod(Mount,18,true)
					SetEntityInvincible(Mount,true)
					
					Wait(100)
					SetPedIntoVehicle(PlayerPedId(),Mount,-1)

					SetVehicleNumberPlateText(Mount,"PDMSPORT")
					SetVehicleCustomPrimaryColour(Mount,59,130,246)
					SetVehicleCustomSecondaryColour(Mount,59,130,246)
					SetVehicleMod(Mount,11,GetNumVehicleMods(Mount,11) - 1,false)
					SetVehicleMod(Mount,12,GetNumVehicleMods(Mount,12) - 1,false)
					SetVehicleMod(Mount,13,GetNumVehicleMods(Mount,13) - 1,false)
					SetVehicleMod(Mount,15,GetNumVehicleMods(Mount,15) - 1,false)
					
					print("[PDM-DEBUG] Ped inserido. IsPedInAnyVehicle:", IsPedInAnyVehicle(PlayerPedId()))
				else
					print("[PDM-DEBUG] ERRO: Carro nulo após tentativa de criação! Base apagou instantaneamente?")
				end

				SetModelAsNoLongerNeeded(Data["vehicle"])

				LocalPlayer["state"]:set("Commands",true,true)
				LocalPlayer["state"]:set("TestDrive",true,false)

				SetTimeout(2500,function()
					TriggerEvent("hud:Active",true)
					if IsScreenFadedOut() then
						DoScreenFadeIn(2500)
						print("[PDM-DEBUG] Tela voltando ao normal agora (fade In).")
					end
				end)

				Wait(500)
				local testDriveEnd = GetGameTimer() + 120000
				print("[PDM-DEBUG] Início do loop Principal do Test Drive de 2 mins.")

				while true do
					local Ped = PlayerPedId()
					if not IsPedInAnyVehicle(Ped) or GetGameTimer() >= testDriveEnd then
						print("=========================================")
						print("[PDM-DEBUG] Gatilho de Encerramento acionado no Loop!")
						print("[PDM-DEBUG] IsPedInAnyVehicle(Ped):", IsPedInAnyVehicle(Ped))
						print("[PDM-DEBUG] Timeout dos 2 min:", GetGameTimer() >= testDriveEnd)

						if IsScreenFadedIn() then
							DoScreenFadeOut(0)
						end

						vSERVER.Remove()
						SetEntityCoords(Ped,TestDriveReturn.x,TestDriveReturn.y,TestDriveReturn.z)
						LocalPlayer["state"]:set("Commands",false,true)
						LocalPlayer["state"]:set("TestDrive",false,false)

						if DoesEntityExist(Mount) then
							DeleteEntity(Mount)
							print("[PDM-DEBUG] Carro deletado na saída.")
						end

						SetTimeout(2500,function()
							if IsScreenFadedOut() then
								DoScreenFadeIn(2500)
								print("[PDM-DEBUG] Tela de finalização reaberta em segurança.")
							end
						end)

						break
					end

					Wait(100)
				end
			else
				print("[PDM-DEBUG] HasModelLoaded FALHOU! Ejetando pro lugar inicial...")
				vSERVER.Remove()
				SetTimeout(2500,function()
					TriggerEvent("hud:Active",true)
					if IsScreenFadedOut() then
						DoScreenFadeIn(2500)
					end
				end)
			end
		end)
	else
		print("[PDM-DEBUG] vSERVER.Check = FALSE. Usuário não estava apto ao bucket ou check falhou!")
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PDM:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("pdm:Close",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)

	if DoesEntityExist(Mount) then
		DeleteEntity(Mount)
	end

	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end
	LastModel = ""
	menuOpen = false
end)