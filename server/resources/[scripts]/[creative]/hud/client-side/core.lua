-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("hud",Creative)
vSERVER = Tunnel.getInterface("hud")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
Display = false
Player = GetPlayerServerId(PlayerId())
inMap = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Road = "Alta-Street"
local Crossing = "Hawick Avenue"
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRINCIPAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Health = 999
local Armour = 999
local Stamine = 999
-----------------------------------------------------------------------------------------------------------------------------------------
-- THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local Thirst = 999
local ThirstTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
local Wanted = 0
local WantedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
local Stress = 999
local StressTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
local Reposed = 0
local ReposedTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- STRESS
-----------------------------------------------------------------------------------------------------------------------------------------
local Stress = 999
local StressTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local Hunger = 999
local HungerTimer = GetGameTimer()
local TableRoad,TableCross = {},{}
local RoadsTxt,CrossTxt = "",""
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Addiction = 0
local AddictionTimer = GetGameTimer()
local TCM = "glasses_red"
local Effect = "Dont_tazeme_bro"
-----------------------------------------------------------------------------------------------------------------------------------------
-- RUAS
-----------------------------------------------------------------------------------------------------------------------------------------
local ruas = {
    -----Santos-----
    ["Paleto Boulevard"] = "Av. Senador Feijó",
    ["Pyrite Avenue"] = "R. Taubaté",
    ["Cascabel Avenue"] = "R. Braz Cuba",
    ["Procopio Drive"] = "Av. Afonso Pena",
    ["Duluoz Avenue"] = "R. Maranhão",
    ["Great Ocean Highway"] = "Rod. Anchieta",
    ["Procopio Promenade"] = "Av. Nossa senhora de Fátima",
    ["Cassidy Trail"] = "Caminho dos Pilões",
    ["North Calafia Way"] = "Estrada Velha de Santos",
    ["Seaview Road"] = "Av. Prudente de Morais",
    ["Grapeseed Main Street"] = "Av. Arnaldo Salles de Oliveira",
    ["Joad Lane"] = "Av. Sete de Setembro",
    ["O'Neil Way"] = "R. Campos Salles",
    ["Union Road"] = "R. Ruí Barbosa",
    ["Grapeseed Avenue"] = "R. Sebastião Luiz",
    ["Senora Freeway"] = "Rod. Dos Bandeirantes",

    -----Guarulho-----
    ["East Joshua Road"] = "Av. Monteiro Lobato",
    ["Joshua Road"] = "Av. Monteiro Lobato",
    ["Chianski Passage"] = "Av. Jaguari",
    ["Alhambra Drive"] = "R. Cachoeira",
    ["Marina Drive"] = "R. Emilio Ribas",
    ["Algonquin Boulevard"] = "Av. Guarulhos",
    ["Zancudo Avenue"] = "Av. julío Prestes",
    ["Mountain View Drive"] = "Av. Salgado Filho",
    ["Cholla Springs Avenue"] = "R. Dom Pedro II",
    ["Armadillo Avenue"] = "R. Oscar Lima",
    ["Niland Avenue"] = "R. Criciuma",
    ["Panorama Drive"] = "Av. Dr. Assis Ribeiro",
    ["Cat-Claw Avenue"] = "R. Gonçalves Dias",
    ["Smoke Tree Road"] = "R. Esmeralda",
    ["Nowhere Road"] = "Viela União",
    ["Route 68"] = "Rod. Transbrasiliana",
    ["Calafia Road"] = "R. Orlando Segala",
    ["Route 68 Approach"] = "Monteiro Lobato / Transbrasiliana",
    ["Catfish View"] = "R. Sebastião Luiz",
    ["Lorita Avenue"] = "R. das Rosas",
    ["Lesbos Lane"] = "R. Quinze",
    ["Meringue Lane"] = "R. Oito",
    ["Cholla Road"] = "R. Xingu",

    ----Campinas----
    ["Zancudo Grande Valley"] = "Av. Francisco Glicério",
    ["Fort Zancudo Approach Road"] = "Terminal A / Aeroporto Viracopos",
    ["Zancudo Barranca"] = "R. Araçatuba",
    ["Barbareno Road"] = "R. Paranavai",                 ----Perto do Fleeca----
    ["Ineseno Road"] = "R. Assembléia",                  ----Perto do Fleeca----
    ["Banham Canyon Drive"] = "R. Luigi Batistini",      ----Sentido Vinhedo----
    ["Buen Vino Road"] = "R. Serra do Pilar",            ----Sentido Vinhedo----
    ["Galileo Road"] = "R. Fazendinha",
    ["Mount Vinewood Drive"] = "Av. Francisco Glicério",
    ["Edwood Way"] = "R. Manuel Borba",
    ["Strangeways Drive"] = "R. Cordeiro Galvão",
    ["Zancudo Road"] = "Av. Conselheiro Carrão",

    ----Cidade----
    ["Senora Road"] = "Av. Senador Teotônio Vilela",
    ["Vinewood Boulevard"] = "Av. Paulista",
    ["Eclipse Boulevard"] = "Av. Paulista",
    ["Alta Street"] = "Av. dos Estados",
    ["Vespucci Boulevard"] = "Av. 23 de Maio",
    ["El Rancho Boulevard"] = "Av. Jacú Pêssego",
    ["Carson Avenue"] = "Av. Sapopemba",
    ["Innocence Boulevard"] = "Av. Aricanduva",
    ["Baytree Canyon Road"] = "Av. Marechal Tito",
    ["Marlowe Drive"] = " Alameda Campinas",
    ["Tongva Drive"] = "Rod. Anhaguera",             ----Sentido Norte-----
    ["North Rockford Drive"] = "Av. Brig Faria Lima",
    ["South Rockford Drive"] = "Av. Brig Faria Lima",
    ["Milton Road"] = "Av. Canadá",
    ["North Sheldon Avenue"] = "Av. Europa",
    ["West Galileo Avenue"] = "Av. Ucrânia",
    ["East Galileo Avenue"] = "R. Tanzânia",
    ["Mount Haan Road"] = "R. Raul Tabajara",
    ["Vinewood Park Drive"] = "R. Roger Chaffee",
    ["Fenwell Place"] = "R. João Adolfo",
    ["Meteor Street"] = "R. da Consolação",
    ["Elgin Avenue"] = "Av. 13 de Maio",
    ["Mirror Park Boulevard"] = "Av. Jacú-Pessêgo",
    ["York Street"] = "R. São Fortunato",
    ["San Andreas Avenue"] = "Av. 9 de Julho",
    ["Hawick Avenue"] = "Av. Atlântica",
    ["Buccaneer Way"] = "Av. Salim Farah Maluf / Porto",
    ["Popular Street"] = "Av. Salim Farah Maluf",
    ["Palomino Freeway"] = "Rod. Ayrton Senna",
    ["Olympic Freeway"] = "Rod. Ayrton Senna",
    ["Los Santos Freeway"] = "Rod. Dos Bandeirantes",
    ["Strawberry Avenue"] = "Av. Interlagos",
    ["Integrity Way"] = "R. Brig. Galvão",
    ["Sinner Street"] = "R. Barra Funda",
    ["Adam's Apple Boulevard"] = "Alameda Eduardo Prado",
    ["Little Bighorn Avenue"] = "Av. Juscelino Kubitschek",
    ["Sinners Passage"] = "R. Boa Vista",
    ["Power Street"] = "Alameda Rocha Azevedo",
    ["Low Power Street"] = "Av. Francisco Matarazzo",
    ["Peaceful Street"] = "R. São Paulo",
    ["Davis Avenue"] = "Av. Santo Amaro",
    ["Macdonald Street"] = "R. Amador Bueno",
    ["Brouge Avenue"] = "R. Borba Gato",
    ["Covenant Avenue"] = "R. Min. Guimarães",
    ["Roy Lowenstein Boulevard"] = "Av. Giovanni Gronchi",
    ["Jamestown Street"] = "R. João Alfredo",
    ["Dutch London Street"] = "Av. Pedro Bueno",
    ["New Empire Way"] = "Aeroporto de Congonhas - CGH",
    ["La Puerta Freeway"] = "Marginal Pinheiros",
    ["Elysian Fields Freeway"] = "Marginal Pinheiros",
    ["Del Perro Freeway"] = "Marginal Tiête",
    ["Occupation Avenue"] = "Av. Angelica",
    ["Boulevard Del Perro"] = "Av. Atlântica",
    ["Las Lagunas Boulevard"] = "Av. Pacaembu",
    ["West Eclipse Boulevard"] = "Av. Autodromo",
    ["Palomino Avenue"] = "Av. Washington Luís",
    ["Dorset Drive"] = "Av. Rio Branco",
    ["Bay City Avenue"] = "Av. Guarapiranga",
    ["Prosperity Street"] = "R. dos Pinheiros",
    ["Red Desert Avenue"] = "Av. Berrini",
    ["Marathon Avenue"] = "R. Cantareira",
    ["Heritage Way"] = "R. São Vicente",
    ["Movie Star Way"] = "Av. Sumaré",
    ["South Boulevard Del Perro"] = "Av. Costa Rica",
    ["Portola Drive"] = "Av. São João",
    ["Carcer Way"] = "Av. Ipiranga",
    ["Abe Milton Parkway"] = "Av. Costa Rica",
    ["San Vitus Boulevard"] = "Av. Casper Libero",
    ["Morningwood Boulevard"] = "Av. Cap. Gustavo Sagat",
    ["Greenwich Place"] = "R. São Judas",
    ["Liberty Street"] = "R. Paris",
    ["Perth Street"] = "R. 15",
    ["Alta Place"] = "R. Mauá",
    ["Laguna Place"] = "R. Barão",
    ["Hardy Way"] = "R. Amazonas",

    ----Refinaria----
    ["Senora Way"] = "Rod. Transbrasiliana",

    ---- Vila Aphina---
    ["Glory Way"] = "R. Amparo",
    ["Bridge Street"] = "Av. Anhaia Mello",
    ["Tangerine Street"] = "R. Alcidez Munhoz",
    ["West Mirror Drive"] = "R. Francisco Polito",
    ["Nikola Avenue"] = "R. Américo Cioffi",
    ["Mirror Place"] = "R. Costa Barros",
    ["East Mirror Drive"] = "R. Olimpia",
    ["Utopia Gardens"] = "R. Campo Limpo",
    ["Nikola Place"] = "R. Lombroso",
    ["Capital Boulevard"] = "Av. Higienópolis",
    ["North Archer Avenue"] = "R. Frei Caneca",
    ["Spanish Avenue"] = "Alameda Tiête",
    ["Mad Wayne Thunder Drive"] = "Av. Europa",
    ["Picture Perfect Drive"] = "R. Francisco Ferrari",
    ["Sam Austin Drive"] = "R. Cel. Bonfim",
    ["Americano Way"] = "R. Cel. Soares",
    ["Richman Street"] = "R. do Matão",
    ["Ace Jones Drive"] = "Alameda Porto",
    ["Hangman Avenue"] = "R. Conde de Linhares",
    ["Hillcrest Ridge Access Road"] = "R. Portugal",
    ["Hillcrest Avenue"] = "R. Alemanha",
    ["Normandy Drive"] = "R. França",
    ["Kimble Hill Drive"] = "R. Argentina",
    ["Lake Vinewood Drive"] = "R. Estados Unidos / Represa",
    ["Lake Vinewood Estate"] = "R. Nino Crespi / Represa",
    ["Whispymound Drive"] = "R. Alasca",
    ["Wild Oats Drive"] = "R. Holanda",
    ["North Conker Avenue"] = "R. André Bonotti",
    ["Clinton Avenue"] = "R. Rosália Grisi Sandoval",
    ["Didion Drive"] = "R. Sueçia",
    ["Cox Way"] = "R. Suiça",
    ["South Mo Milton Drive"] = "R. Italia",
    ["Cockingend Drive"] = "R. México",
    ["Dunstable Drive"] = "R. Durval de Morais",
    ["Greenwich Way"] = "R. Itaim Bibi",
    ["Dunstable Lane"] = "R. Santos Doumont",
    ["Caesars Place"] = "R. Cubatão",
    ["Rockford Drive"] = "R. Colombia",
    ["Eastbourne Way"] = "R. Cuba",
    ["Cougar Avenue"] = "Travessa Doze",
    ["Bay City Incline"] = "Av. Jaguaré",
    ["Playa Vista"] = "R. Camargo",
    ["Decker Street"] = "R. Alvarenga",
    ["Ginger Street"] = "R. Vergueiro",
    ["Calais Avenue"] = "Av. Roberto Marinho",
    ["Shank Street"] = "Jardim Sao Bento / CAvPM",
    ["Tackle Street"] = "Marina Interlagos",
    ["Lindsay Circus"] = "R. Luiz schwelm",
    ["Equality Way"] = "R. Bartolomeu Zunega",
    ["Conquistador Street"] = "Travessa Alberto Campos",
    ["Magellan Avenue"] = "Av. do Emissário ",
    ["Cortes Street"] = "Travessa Domingos Assunção",
    ["Vitus Street"] = "R. Marcos Azevedo",
    ["Aguja Street"] = "R. Teodoro Sampaio",
    ["Goma Street"] = "R. William Navarro",
    ["Atlee Street"] = "R. Daniel Soares",
    ["Melanoma Street"] = "R. Bento Frias",
    ["Rub Street"] = "Marina Interlagos / Praia",
    ["Tug Street"] = "Marina Interlagos / Praia",
    ["Invention Court"] = "R. Pacatuba",
    ["Imagination Court"] = "R. Matias Gomes",
    ["South Arsenal Street"] = "R. João Schmidt",
    ["Mutiny Road"] = "R. Tapanan",
    ["Autopia Parkway"] = "R. Iguatinga",
    ["Exceptionalists Way"] = "R. Tamoios",
    ["Greenwich Parkway"] = "R. Toré",
    ["Grove Street"] = "R. da Paz",
    ["Crusade Road"] = "R. Joaquim Nabuca",
    ["Steele Way"] = "R. João Pimenta",
    ["Forum Drive"] = "R. Rodrigo Bonfim",
    ["Abattoir Avenue"] = "EcoPatio / Porto",
    ["Voodoo Place"] = "Libra Terminal",
    ["Kortz Drive"] = "Av. Adriano Bertozzi",
    ["Sandcastle Way"] = "Travesa Alberto Santos",
    ["Gentry Lane"] = "R. Russia",
    ["Swiss Street"] = "R. Paraguai",

    ------Itaquera----
    ["Sustancia Road"] = "Rod. Mario Covas",
    ["Amarillo Vista"] = "R. Botuporã",
    ["Labor Place"] = "R. Colombo",
    ["Amarillo Way"] = "R. Santa Cruz",
    ["Tower Way"] = "R. Laudelino Freire",
    ["Fudge Lane"] = "R. Silvio Romero",

    ----Industrial ----
    ["South Shambles Street"] = "R. Parapuã",
    ["Hanger Way"] = "R. Panambí",
    ["Orchardville Avenue"] = "R. São Luis",
    ["Dry Dock Street"] = "R. da Sorte",
    ["El Burro Boulevard"] = "Alameda Barros",
    ["Supply Street"] = "Av. Carlos Hank",

    ----Docas-----
    ["Signal Street"] = "R. Paschoal Leonardi",
    ["Chum Street"] = "Av. José Carlos Pace",
    ["Plaice Place"] = "R. Celso Lara Barberis",
    ["Mount Hann Drive"] = "Av. Cel. Alan Henrique",
    ["Chupacabra Street"] = "Marimex / Docas",
    ["Pista de pouso1"] = "Aeroporto de Congonhas - CGH",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local Ped = PlayerPedId()

			if Display then
				local Coords = GetEntityCoords(Ped)
				local Armouring = GetPedArmour(Ped)
				local Healing = GetEntityHealth(Ped) - 100
				local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"]))
                local CurrentStamine = GetPlayerStamina(PlayerId())

				if Health ~= Healing then
					if Healing < 0 then
						Healing = 0
					end

					SendNUIMessage({ typeId = "Health", Number = Healing / 1 })
					Health = Healing
				end

				if Armour ~= Armouring then
                    if Armouring > 98 then
                        Armouring = 100
                    end
					SendNUIMessage({ typeId = "Armour", Number = Armouring })
					Armour = Armouring
				end

				SendNUIMessage({ typeId = "Addiction", Number = Addiction })

				if Stamine ~= CurrentStamine then
					SendNUIMessage({ typeId = "Stamine", Number = parseInt(CurrentStamine) })
					Stamine = CurrentStamine
				end

                if Road ~= ruas[streetName] then
                    local antigaRua = Road
                    SendNUIMessage({ typeId = "Road", Name = ruas[streetName], OldName = antigaRua })
                    Road = ruas[streetName]
                end

				if Reposed > 0 and ReposedTimer <= GetGameTimer() then
					Reposed = Reposed - 1
					ReposedTimer = GetGameTimer() + 1000
					SendNUIMessage({ name = "Reposed", payload = Reposed })
				end

				SendNUIMessage({ typeId = "Crossing", Name = Crossing })
				SendNUIMessage({ typeId = "Clock", Hours = string.format("%02d", GlobalState["Hours"]), Minutes = string.format("%02d", GlobalState["Minutes"]) })

			end

			if HungerTimer <= GetGameTimer() then
				HungerTimer = GetGameTimer() + 50000

				if Hunger < 5 and GetEntityHealth(Ped) > 100 then
					DoScreenFadeOut(0)

					if not IsPedInAnyVehicle(Ped) then
						SetPedToRagdoll(Ped,2500,2500,0,0,0,0)
					end

					SetTimeout(500,function() -- tempo que a tela acende
						DoScreenFadeIn(0)
					end)

					ApplyDamageToPed(Ped,math.random(2),false)
					TriggerEvent("Notify","amarelo","Sofrendo com a fome.",2500)
				end
			end

			if AddictionTimer <= GetGameTimer() then
				AddictionTimer = GetGameTimer() + 30000

				if Addiction >= 80 and GetEntityHealth(Ped) > 100 then
					SetTimecycleModifier(TCM)
					SetTimecycleModifierStrength(3.9)
					AnimpostfxPlay(Effect,0,true)
					ExecuteCommand("andar 19")
					SetTimeout(3000,function()
						AnimpostfxStop(Effect)
        				SetTimecycleModifierStrength(0.0)
						if Addiction >= 90 and GetEntityHealth(Ped) > 100 then
							SetPedToRagdoll(Ped,3000,3000,0,0,0,0)
						end
					end)

					TriggerEvent("Notify","amarelo","Sofrendo com a abstinência.",2500)
				end
			end

			if ThirstTimer <= GetGameTimer() then
				ThirstTimer = GetGameTimer() + 10000

				if Thirst < 5 and GetEntityHealth(Ped) > 100 then
					ApplyDamageToPed(Ped,math.random(1),false)
					TriggerEvent("Notify","amarelo","Sofrendo com a sede.",2500)
				end
			end

			if Wanted > 0 and WantedTimer <= GetGameTimer() then
				Wanted = Wanted - 1
				WantedTimer = GetGameTimer() + 1000
			end

			if Reposed > 0 and ReposedTimer <= GetGameTimer() then
				Reposed = Reposed - 1
				ReposedTimer = GetGameTimer() + 1000
			end

		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if Addiction >= 90 and GetEntityHealth(Ped) > 100 then
			ShakeGameplayCam("SMALL_EXPLOSION_SHAKE",0.03)
		end
		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FX
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)
	AnimpostfxStop(Effect)
	SetTimecycleModifierStrength(0.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ADDGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:AddGems")
AddEventHandler("hud:AddGems",function(Gems)
	SendNUIMessage({ typeId = "Gems", Gems = Gems })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:PASSPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Passport")
AddEventHandler("hud:Passport",function(Number)
	SendNUIMessage({ typeId = "Passport", Number = Number })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voice")
AddEventHandler("hud:Voice",function(Status)
    SendNUIMessage({ typeId = "IsTalking", Status = Status })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(Number)
	SendNUIMessage({ typeId = "Voip", Voip = Number })
end)

CreateThread(function()
	Wait(1000)
	if LocalPlayer.state.Active then
		TriggerEvent("hud:Active", true)
		TriggerEvent("hud:Passport", LocalPlayer.state.Passport)
	end
	TriggerEvent("hud:Voip", LocalPlayer.state?.proximity?.index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:VOIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:inMap")
AddEventHandler("hud:inMap",function()
	inMap = true
    Display = true
    SendNUIMessage({ typeId = "Body", Status = false })
    Wait(250)
    while inMap do
        if not IsPauseMenuActive()then
            inMap = false
            SendNUIMessage({ typeId = "Body", Status = true })
        end
        Wait(50)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Active")
AddEventHandler("hud:Active",function(Status)
	SendNUIMessage({ typeId = "Body", Status = Status })
	Display = Status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function()
	Display = not Display
	TriggerEvent("hud:Active", Display)

	if not Display then
		if IsMinimapRendering() then
			DisplayRadar(false)
		end
    else
        SendNUIMessage({ typeId = "Safe", Status = (LocalPlayer.state["inSafeZone"] or LocalPlayer.state["inSafeMode"] or LocalPlayer.state["Newbie"]) or false })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("roads",function()
    TriggerServerEvent("hud:roads",RoadsTxt,CrossTxt)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress",function(Message,Timer)
    SendNUIMessage({ typeId = "RemoveProgress" })
	SendNUIMessage({ typeId = "Progress", Message = Message, Timer = Timer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(Number)
	if Thirst ~= Number then
		SendNUIMessage({ typeId = "Thirst", Number = Number })
		Thirst = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:HUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(Number)
	if Hunger ~= Number then
		SendNUIMessage({ typeId = "Hunger", Number = Number })
		Hunger = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:ADDICTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Addiction")
AddEventHandler("hud:Addiction",function(Number)
	if Addiction ~= Number then
		SendNUIMessage({ typeId = "Addiction", Number = Number })
		Addiction = Number
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:RADIO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(Frequency)
	SendNUIMessage({ typeId = "Frequency", Frequency = Frequency })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SAFE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Safe")
AddEventHandler("hud:Safe",function(Status)
	SendNUIMessage({ typeId = "Safe", Status = Status })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATES
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler('InSafeZone',('player:%s'):format(Player) , function(_, _, value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    SendNUIMessage({ typeId = "Safe", Status = (LocalPlayer.state["inSafeZone"] or LocalPlayer.state["inSafeMode"] or LocalPlayer.state["Newbie"]) or false })
end)

AddStateBagChangeHandler('inSafeMode',('player:%s'):format(Player) , function(_, _, value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    SendNUIMessage({ typeId = "Safe", Status = (LocalPlayer.state["inSafeZone"] or LocalPlayer.state["inSafeMode"] or LocalPlayer.state["Newbie"]) or false })
end)

AddStateBagChangeHandler('Newbie',('player:%s'):format(Player) , function(_, _, value)
    if value then
        TriggerEvent("inventory:CleanWeapons")
    end
    SendNUIMessage({ typeId = "Safe", Status = (LocalPlayer.state["inSafeZone"] or LocalPlayer.state["inSafeMode"] or LocalPlayer.state["Newbie"]) or false })
end)

-- CreateThread(function()
--     while true do
--         local Ped = PlayerPedId()
--         local Coords = GetEntityCoords(Ped)
--         local Armouring = GetPedArmour(Ped)
--         local Healing = GetEntityHealth(Ped) - 100
--         local ground,z = GetGroundZFor_3dCoord(Coords["x"],Coords["y"],Coords["z"])
--         if ground then
--             Coords["z"] = z
--         end
--         local MinRoad,MinCross = GetStreetNameAtCoord(Coords["x"],Coords["y"],Coords["z"])
--         local FullRoad = GetStreetNameFromHashKey(MinRoad)
--         local FullCross = GetStreetNameFromHashKey(MinCross)
--         local NotMapped = false

--         for i=1,#Streets do
--             if Streets[i].hash == MinRoad then
--                 NotMapped = true
--             end

--             if Streets[i].hash == MinCross then
--                 NotMapped = true
--             end
--         end

--         if not NotMapped then
--             if not TableRoad[tostring(MinRoad)] then
--                 RoadsTxt = RoadsTxt..'{ hash = '..tostring(MinRoad)..', name = "'..GetStreetNameFromHashKey(MinRoad)..'" },\n'
--                 TableRoad[tostring(MinRoad)] = GetStreetNameFromHashKey(MinRoad)
--             end

--             if not TableRoad[tostring(MinCross)] then
--                 RoadsTxt = RoadsTxt..'{ hash = '..tostring(MinCross)..', name = "'..GetStreetNameFromHashKey(MinCross)..'" },\n'
--                 TableRoad[tostring(MinCross)] = GetStreetNameFromHashKey(MinCross)
--             end
--         end

--         DisplayRadar(true)
--         SetBigmapActive(true,false)
--         Wait(0)
--     end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Wanted")
AddEventHandler("hud:Wanted",function(Seconds)
	Wanted = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WANTED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Wanted",function()
	return Wanted > 0 and true or false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Reposed")
AddEventHandler("hud:Reposed",function(Seconds)
	Reposed = Seconds
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSED
-----------------------------------------------------------------------------------------------------------------------------------------
exports("Reposed",function()
	return Reposed > 0 and true or false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
local Hood = false
RegisterNetEvent("hud:Hood")
AddEventHandler("hud:Hood",function()
    if Hood then
        DoScreenFadeIn(0)
        SetPedComponentVariation(PlayerPedId(),1,0,0,1)
        Hood = false
    else
        DoScreenFadeOut(0)
        SetPedComponentVariation(PlayerPedId(),1,69,2,1)
        Hood = true
    end
end)
