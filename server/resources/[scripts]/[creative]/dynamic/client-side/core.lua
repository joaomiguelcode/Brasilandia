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
vSERVER = Tunnel.getInterface("dynamic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local menuOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("AddButton",function(title,description,trigger,par,id,server)
	SendNUIMessage({ addbutton = true, title = title, description = description, trigger = trigger, par = par, id = id, server = server })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUBMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("SubMenu",function(title,description,id)
	SendNUIMessage({ addmenu = true, title = title, description = description, menuid = id })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENMENU
-----------------------------------------------------------------------------------------------------------------------------------------
exports("openMenu",function()
	SendNUIMessage({ show = true })
	SetNuiFocus(true,true)
	menuOpen = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLICKED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("clicked",function(Data,Callback)
	if Data["trigger"] and Data["trigger"] ~= "" then
		if Data["server"] == "true" then
			TriggerServerEvent(Data["trigger"],Data["param"])
		else
			TriggerEvent(Data["trigger"],Data["param"])
		end
		
		-- Fechar a NUI automaticamente para eventos específicos
		if Data["trigger"] == "sirene:toggleModule" or Data["trigger"] == "mtt_identity:open" or Data["trigger"] == "mtt_wardrobe:open" or Data["trigger"] == "skinshop:Open" or Data["trigger"] == "skinshop:openShop" then
			SendNUIMessage({ close = true })
			SetNuiFocus(false,false)
			menuOpen = false
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close",function(Data,Callback)
	SetNuiFocus(false,false)
	menuOpen = false

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dynamic:closeSystem")
AddEventHandler("dynamic:closeSystem",function()
	if menuOpen then
		SendNUIMessage({ close = true })
		SetNuiFocus(false,false)
		menuOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLOBALFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("globalFunctions",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		if GetEntityHealth(Ped) > 100 then
			exports["dynamic"]:AddButton("Chapéu","Colocar/Retirar o chapéu.","player:Outfit","Hat","clothes",true)
			exports["dynamic"]:AddButton("Máscara","Colocar/Retirar a máscara.","player:Outfit","Mask","clothes",true)
			exports["dynamic"]:AddButton("Óculos","Colocar/Retirar o óculos.","player:Outfit","Glasses","clothes",true)
			exports["dynamic"]:AddButton("Jaqueta","Colocar/Retirar o jaqueta.","player:Outfit","Jacket","clothes",true)
			exports["dynamic"]:AddButton("Camisa","Colocar/Retirar o camisa.","player:Outfit","Shirt","clothes",true)
			exports["dynamic"]:AddButton("Luvas","Colocar/Retirar o luvas.","player:Outfit","Arms","clothes",true)
			exports["dynamic"]:AddButton("Calça","Colocar/Retirar o calça.","player:Outfit","Pants","clothes",true)
			exports["dynamic"]:AddButton("Sapatos","Colocar/Retirar o sapatos.","player:Outfit","Shoes","clothes",true)

				
			local arrested = LocalPlayer.state.arrested

			exports["dynamic"]:AddButton("Animações","Abrir menu de animações","rg_emotes:openMenu","","others",false)

			-- Documentos (RG / CNH)
			local hasCNH = vSERVER.hasCNH()
			exports["dynamic"]:SubMenu("Documentos","Acesse seus documentos pessoais.","docs")
			exports["dynamic"]:AddButton("RG Nacional","Visualizar seu RG.","mtt_identity:open","rg","docs",false)
			if hasCNH then
				exports["dynamic"]:AddButton("CNH Digital","Visualizar sua CNH.","mtt_identity:open","cnh","docs",false)
			end

			-- Armário de roupas deve ficar na tela inicial 
			if not arrested then
				exports["dynamic"]:AddButton("Armário de Roupas","Salvar, aplicar e excluir presets.","propertys:ClothesReset","",false,false)
			end

			if GetResourceState("heyy_houses") == "started" then
				local house = exports["heyy_houses"]:getNearestProperty(15.0)
				if house then
					exports["dynamic"]:SubMenu("Propriedade","Funções da propriedade.","house")

					local pData = exports.heyy_houses:getPropertyData(house)
					local garageIdentifier = pData.garageIdentifier or house

					exports["dynamic"]:AddButton("Garagem", "Adicionar/Reajustar a garagem.", "heyy_houses:setGarage", garageIdentifier, "house", true)
				end
			end
			-- exports["dynamic"]:AddButton("Localizar Propriedades","Localizar propriedades no mapa.","heyy_houses:showBlips","","propertys",false)
			-- exports["dynamic"]:AddButton("Propriedades","Marcar/Desmarcar propriedades no mapa.","propertys:Blips","","others",false)
			
			exports["dynamic"]:AddButton("Ferimentos","Verificar ferimentos no corpo.","paramedic:Injuries","","others",false)
			exports["dynamic"]:AddButton("Desbugar","Recarregar o personagem.","player:Debug","","others",true)

			local Vehicle = vRP.ClosestVehicle(7)
			if IsEntityAVehicle(Vehicle) then
				if not IsPedInAnyVehicle(Ped) then
					exports["dynamic"]:AddButton("Rebocar","Colocar veículo na prancha do reboque.","towdriver:invokeTow","","vehicle",false)

					if vRP.ClosestPed(3) then
						exports["dynamic"]:AddButton("Colocar no Veículo","Colocar no veículo mais próximo.","player:cvFunctions","cv","closestpeds",true)
						exports["dynamic"]:AddButton("Remover do Veículo","Remover do veículo mais próximo.","player:cvFunctions","rv","closestpeds",true)

						exports["dynamic"]:SubMenu("Jogador","Pessoa mais próxima de você.","closestpeds")
					end
				else
					exports["dynamic"]:AddButton("Sentar no Motorista","Sentar no banco do motorista.","player:seatPlayer","0","vehicle",false)
					exports["dynamic"]:AddButton("Sentar no Passageiro","Sentar no banco do passageiro.","player:seatPlayer","1","vehicle",false)
					exports["dynamic"]:AddButton("Sentar em Outros","Sentar no banco traseiro.","player:seatPlayer","2","vehicle",false)
					exports["dynamic"]:AddButton("Levantar Vidros","Levantar os vidros.","player:winsFunctions","1","vehicle",true)
					exports["dynamic"]:AddButton("Abaixar Vidros","Abaixar os vidros.","player:winsFunctions","0","vehicle",true)
				end

				exports["dynamic"]:AddButton("Porta do Motorista","Abrir porta do motorista.","player:Doors","1","doors",true)
				exports["dynamic"]:AddButton("Porta do Passageiro","Abrir porta do passageiro.","player:Doors","2","doors",true)
				exports["dynamic"]:AddButton("Porta Traseira Esquerda","Abrir porta traseira esquerda.","player:Doors","3","doors",true)
				exports["dynamic"]:AddButton("Porta Traseira Direita","Abrir porta traseira direita.","player:Doors","4","doors",true)
				exports["dynamic"]:AddButton("Porta-Malas","Abrir porta-malas.","player:Doors","5","doors",true)
				exports["dynamic"]:AddButton("Capô","Abrir capô.","player:Doors","6","doors",true)

				exports["dynamic"]:SubMenu("Veículo","Funções do veículo.","vehicle")
				exports["dynamic"]:SubMenu("Portas","Portas do veículo.","doors")
			end

			-- local Exclusivas = vSERVER.Exclusivas()
			-- if parseInt(#Exclusivas) > 0 then
			-- 	for _,v in pairs(Exclusivas) do
			-- 		if v["type"] == "backpack" then
			-- 			exports["dynamic"]:AddButton(v["name"],"Clique para colocar/remover.","skinshop:toggleBackpack",v["id"].."-"..v["texture"],"Exclusivas",false)
			-- 		end
			-- 	end

			-- 	exports["dynamic"]:SubMenu("Exclusivas","Todas as roupas exclusivas.","Exclusivas")
			-- end

			-- local Experience = vSERVER.Experience()
			-- for Name,Exp in pairs(Experience) do
			-- 	exports["dynamic"]:AddButton(Name,"Você possuí <yellow>"..Exp.." pontos</yellow> na classe <yellow>"..ClassCategory(Exp).."</yellow>.","","","Experience",false)
			-- end

			if not arrested then
				exports["dynamic"]:SubMenu("Roupas","Colocar/Retirar roupas.","clothes")
			end
				
			-- exports["dynamic"]:SubMenu("Experiência","Todas as suas habilidades.","Experience")
			exports["dynamic"]:SubMenu("Outros","Todas as funções do personagem.","others")

			exports["dynamic"]:openMenu()
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTITY OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("mtt_identity:open")
AddEventHandler("mtt_identity:open",function(docType)
	local data = vSERVER.getIdentityData()
	if not data then return end
	local title = "RG Nacional"
	if tostring(docType) == "cnh" then
		title = "CNH Digital"
	end
	SendNUIMessage({
		showIdentity = true,
		title = title,
		name = data.name or "",
		id = data.id or "",
		registration = data.registration or "",
		phone = data.phone or "",
		duration = 7000
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMERGENCYFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("emergencyFunctions", function()
    if not IsPauseMenuActive() then
        local Options = {}

        if LocalPlayer["state"]["Staff"] or LocalPlayer["state"]["waitStaff"] then
            Options[#Options + 1] = function()
                exports["dynamic"]:AddButton("Entrar/Sair de serviço", "Entrar e sair de serviço.", "service:Toggle", "Staff-1", "staff", true)
                exports["dynamic"]:SubMenu("Opções staff", "Opções staff.", "staff")
            end
        end

        local isPlayerPolice, groupName = exports.vrp:isStatePolice()
        if isPlayerPolice or LocalPlayer["state"]["Hospital"] then
            if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not menuOpen and LocalPlayer["state"]["Route"] < 900000 then
                local Ped = PlayerPedId()
                if GetEntityHealth(Ped) > 100 then
                    if not IsPedInAnyVehicle(Ped) then
						Options[#Options + 1] = function()
							-- exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "player:carryPlayer", "", "player", true)
							exports["dynamic"]:AddButton("Carregar", "Carregar a pessoa mais próxima.", "mTT:carryPlayer", "", "player", false)
							exports["dynamic"]:AddButton("Colocar no Veículo", "Colocar no veículo mais próximo.", "player:cvFunctions", "cv", "player", true)
							exports["dynamic"]:AddButton("Remover do Veículo", "Remover do veículo mais próximo.", "player:cvFunctions", "rv", "player", true)
							exports["dynamic"]:SubMenu("Jogador", "Pessoa mais próxima de você.", "player")
						end
                    end

                    if isPlayerPolice then
						Options[#Options + 1] = function()
							exports["dynamic"]:AddButton("Remover Chapéu", "Remover da pessoa mais próxima.", "skinshop:Remove", "Hat", "player", true)
							exports["dynamic"]:AddButton("Remover Máscara", "Remover da pessoa mais próxima.", "skinshop:Remove", "Mask", "player", true)
							exports["dynamic"]:AddButton("Remover Óculos", "Remover da pessoa mais próxima.", "skinshop:Remove", "Glasses", "player", true)
						end
                    end

                    if LocalPlayer["state"]["Hospital"] then
						Options[#Options + 1] = function()
                        	exports["dynamic"]:AddButton("Tablet", "Acessar tablet do Hospital.", "heyy_hospital:openUI", "", false, false)
							exports["dynamic"]:AddButton("Ponto Eletrônico", "Sair de serviço.", "service:ToggleDynamic", "Hospital", false, false)
						end
                    end

                    if isPlayerPolice then
                        if IsPedInAnyVehicle(Ped) then
                            exports["dynamic"]:AddButton("Patrulhar 5 km/h", "Ativar modo patrulhamento.", "mTT:cruizeControl", "5", "ptrPolice", false)
                            exports["dynamic"]:AddButton("Patrulhar 10 km/h", "Ativar modo patrulhamento.", "mTT:cruizeControl", "10", "ptrPolice", false)
                            exports["dynamic"]:AddButton("Patrulhar 20 km/h", "Ativar modo patrulhamento.", "mTT:cruizeControl", "20", "ptrPolice", false)
                            exports["dynamic"]:SubMenu("Modo Patrulhamento", "Acesse o modo patrulhamento.", "ptrPolice")

                            exports["dynamic"]:AddButton("Controladora Giroflex", "Acessar a controladora do giroflex.", "sirene:toggleModule", "", false, false)

                            exports["dynamic"]:AddButton("Lado Esquerdo", "Braço para fora lado esquerdo.", "mTT:militaryAnims", "bracop1", "animPolice", false)
                            exports["dynamic"]:AddButton("Lado Esquerdo 2", "Braço para fora lado esquerdo.", "mTT:militaryAnims", "bracop2", "animPolice", false)
                            exports["dynamic"]:AddButton("Lado Direito", "Braço para fora lado direito.", "mTT:militaryAnims", "bracop3", "animPolice", false)
                            exports["dynamic"]:AddButton("Lado Direito 2", "Braço para fora lado direito.", "mTT:militaryAnims", "bracop4", "animPolice", false)
                        else
                            exports["dynamic"]:AddButton("Sentido", "Animação de sentido.", "mTT:militaryAnims", "sentido", "animPolice", false)
                            exports["dynamic"]:AddButton("Descansar", "Animação de descansar.", "mTT:militaryAnims", "descansar", "animPolice", false)
                            exports["dynamic"]:AddButton("Continência", "Animação de continência.", "mTT:militaryAnims", "continencia", "animPolice", false)
                        end

                        exports["dynamic"]:SubMenu("Animações Policiais", "Todas animações policiais.", "animPolice")
                        exports["dynamic"]:AddButton("Tablet", "Acessar tablet SSP.", "heyy_mdt:openUI", "", false, false)
                        exports["dynamic"]:AddButton("Ponto Eletrônico", "Sair de serviço.", "service:ToggleDynamic", groupName, false, false)
                    end
                end
            end
        end

		if LocalPlayer["state"]["RadCustoms"] then
			Options[#Options + 1] = function()
				exports["dynamic"]:AddButton("Ponto Eletrônico", "Sair de serviço.", "service:ToggleDynamic", "RadCustoms", false, false)
			end
		end

		if LocalPlayer["state"]["Judiciario"] then
			Options[#Options + 1] = function()
				exports["dynamic"]:AddButton("Ponto Eletrônico", "Sair de serviço.", "service:ToggleDynamic", "Judiciario", false, false)
				exports["dynamic"]:AddButton("Tablet", "Acessar tablet SSP.", "heyy_mdt:openUI", "", false, false)
			end
		end

		if LocalPlayer["state"]["ReceitaFederal"] then
			Options[#Options + 1] = function()
				exports["dynamic"]:AddButton("Ponto Eletrônico", "Sair de serviço.", "service:ToggleDynamic", "ReceitaFederal", false, false)
				exports["dynamic"]:AddButton("Tablet", "Acessar tablet SSP.", "heyy_mdt:openUI", "", false, false)
			end
		end

        if #Options >= 1 then
            for Number, Option in ipairs(Options) do
                Option()
            end
            exports["dynamic"]:openMenu()
        end
    end
end)

RegisterNetEvent('mTT:militaryAnims')
AddEventHandler('mTT:militaryAnims', function(anim)
	if anim == "sentido" then
		vRP.playAnim(false,{"airforce@attention","base"},true)
	elseif anim == "descansar" then
		vRP.playAnim(false,{"airforce@parade_rest","base"},true)
	elseif anim == "continencia" then
		vRP.playAnim(false,{"airforce@salute","base"},true)
	elseif anim == "bracop1" then
		vRP.playAnim(true,{"anim@veh@lowrider@std@ds@arm@base","sit_low_lowdoor"},true)
	elseif anim == "bracop2" then
		vRP.playAnim(true,{"anim@veh@lowrider@std@ds@arm@base","steer_lean_left_low_lowdoor"},true)
	elseif anim == "bracop3" then
		vRP.playAnim(true,{"missarmenian2","car_react_gang_ps"},true)
	elseif anim == "bracop4" then
		vRP.playAnim(true,{"anim@veh@lowrider@low@front_ps@arm@base","sit"},true)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("globalFunctions","Abrir menu principal.","keyboard","F9")
RegisterKeyMapping("emergencyFunctions","Abrir menu de emergencial.","keyboard","F10")
