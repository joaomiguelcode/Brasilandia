Config = {}

Config.base = "creative_network" --Tipo da base, seja ela creative_v5 ou creative_network

Config.minPayment = 1000 --Valor mínimo de pagamento por roubo de ATM
Config.maxPayment = 2000 --Valor máximo de pagamento por roubo de ATM

Config.timeToRobbery = 21600 --Valor em segundos para roubar um ATM novamente
Config.percentPolice = 0 --Chance de chamar a polícia em um roubo

Config.itemUsed = "pendrive2" --Nome do item usado para realizar o roubo

--Animação de 4 segundos para iniciar o roubo (Plugar algum item no caixa)
Config.animationStartDict = "amb@prop_human_atm@male@exit" --Anim Dict
Config.animationStartName = "exit" --Anim Base

--Animação de 20 segundos para realizar o roubo com o telefone (Animação parado com o telefone na mão)
Config.animationBaseDict = "cellphone@" --Anim Dict
Config.animationBaseName = "cellphone_text_in" --Anim Base
Config.animationBaseObject = "prop_npc_phone_02" --Anim Object