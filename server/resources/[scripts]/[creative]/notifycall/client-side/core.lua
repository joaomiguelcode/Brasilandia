-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYCALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("NotifyCall",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPauseMenuActive() then
		SendNUIMessage({ name = "Open" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("NotifyCall","Consultar as notificações.","keyboard","F2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
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

RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(Data)
    local Blip = AddBlipForCoord(Data["x"],Data["y"],Data["z"])
    local _, Road = GetStreetNameAtCoord(Data["x"],Data["y"],Data["z"])

    local streetName = GetStreetNameFromHashKey(Road)

    if ruas[streetName] then
        Data["street"] = ruas[streetName]
    elseif streetName and streetName ~= "" then
        Data["street"] = streetName
    else
        Data["street"] = "Não informado"
    end

    if parseInt(Data["code"]) == 13 then
        TriggerEvent("sounds:Private","deathcop",0.5)
    end

    SendNUIMessage({ name = "New", payload = Data })

    if parseInt(Data["code"]) == 33 then -- TRAFICO DE DROGAS
        SetBlipSprite(Blip,161)
        SetBlipDisplay(Blip,4)
        SetBlipAsShortRange(Blip,true)
        SetBlipColour(Blip,1)
        SetBlipScale(Blip,1.8)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Data["title"])
        EndTextCommandSetBlipName(Blip)
    else
        SetBlipSprite(Blip,270)
        SetBlipDisplay(Blip,4)
        SetBlipAsShortRange(Blip,true)
        SetBlipColour(Blip,Data["color"])
        SetBlipScale(Blip,0.9)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Data["title"])
        EndTextCommandSetBlipName(Blip)
    end

    SetTimeout(60000,function()
        if DoesBlipExist(Blip) then
            RemoveBlip(Blip)
        end
    end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function(Data,Callback)
	SetNuiFocus(true,true)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function(Data,Callback)
	SetNuiFocus(false,false)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WAYPOINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Waypoint",function(Data,Callback)
	SetNewWaypoint(Data["x"] + 0.0001,Data["y"] + 0.0001)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PHONE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Phone",function(Data,Callback)
    -- exports["smartphone"]:callPlayer(Data["phone"])
	if not Data["phone"] or Data["phone"] == "" then
		TriggerEvent("Notify","vermelho","Número de telefone não disponível.",5000)
		Callback("Ok")
		return
	end
	
	if exports["lb-phone"] then
		exports["lb-phone"]:CreateCall({
			number = Data["phone"]
		})
	else
		TriggerEvent("Notify","vermelho","Sistema de telefone não disponível.",5000)
	end

	Callback("Ok")
end)