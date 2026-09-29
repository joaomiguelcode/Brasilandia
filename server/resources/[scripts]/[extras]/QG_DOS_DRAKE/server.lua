-----------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local config = {
    group_name = "Bandido", -- Nome do cargo que o jogador vai ganhar ao passar
    min_acertos = 10,       -- Quantidade mínima de acertos para passar na prova
    logs_name = "PROVA QG DOS DRAKE",
    cds = { x = -598.08, y = 209.68, z = 74.17 } -- Coordenada para iniciar a prova (Exemplo: Praça)
}                    

-- Fornecer coordenadas para o client
RegisterServerEvent("prova:getCds")
AddEventHandler("prova:getCds", function()
    local source = source
    TriggerClientEvent("prova:setCds", source, config.cds)
end)

local perguntas = {
    {
        pergunta = "O que é 'Amor à Vida' no RP?",
        opcoes = {"Valorizar a vida acima de tudo", "Atirar em todo mundo", "Fugir a 300km/h", "Ignorar armas apontadas"},
        resposta = 0
    },
    {
        pergunta = "O que significa VDM?",
        opcoes = {"Veículo de Médico", "Atropelar jogadores sem motivo", "Velocidade de Moto", "Vender Drogas de Manhã"},
        resposta = 1
    },
    {
        pergunta = "Pode assaltar alguém em frente ao Hospital ou Praça?",
        opcoes = {"Sim, em qualquer lugar", "Somente se tiver arma", "Não, são zonas seguras", "Depende do horário"},
        resposta = 2
    },
    {
        pergunta = "O que é Power Gaming (PG)?",
        opcoes = {"Ganhar muito dinheiro", "Fazer algo impossível na vida real", "Ser o mais forte do servidor", "Usar rádio da polícia"},
        resposta = 1
    },
    {
        pergunta = "Você pode reconhecer alguém mascarado pela voz?",
        opcoes = {"Sim, sempre", "Não, é Meta Gaming", "Só se for meu amigo", "Se a voz for única"},
        resposta = 1
    },
    {
        pergunta = "O que é Meta Gaming (MG)?",
        opcoes = {"Usar informações de fora no jogo", "Atirar de dentro do carro", "Fazer amizade com a polícia", "Roubar bancos"},
        resposta = 0
    },
    {
        pergunta = "O que fazer ao ser rendido por 3 pessoas armadas?",
        opcoes = {"Tentar puxar arma e atirar", "Sair do jogo rapidamente", "Levantar as mãos e colaborar", "Sair correndo e pular no mar"},
        resposta = 2
    },
    {
        pergunta = "Pode usar o chat local para passar tática em tiroteio?",
        opcoes = {"Sim, é mais rápido", "Não, deve-se usar o rádio/voz", "Só se o rádio quebrar", "Ninguém usa chat"},
        resposta = 1
    },
    {
        pergunta = "O que é Combat Log?",
        opcoes = {"Logar para entrar em combate", "Sair do jogo para evitar o RP", "Anotar as mortes do dia", "Usar hack de combate"},
        resposta = 1
    },
    {
        pergunta = "Bateu o carro a 200km/h. O que deve fazer?",
        opcoes = {"Continuar dirigindo normal", "Descer e atirar no poste", "Simular o dano e ferimentos", "Dar /fix e seguir viagem"},
        resposta = 2
    },
    {
        pergunta = "Pode roubar viatura da polícia sem motivo forte?",
        opcoes = {"Sim, é legal", "Não, é proibido sem motivo RP", "Só se a viatura estiver aberta", "Só de madrugada"},
        resposta = 1
    },
    {
        pergunta = "Qual o objetivo de um bandido no RP?",
        opcoes = {"Ficar rico rápido", "Matar o máximo de policiais", "Criar histórias e interações", "Ser o dono da praça"},
        resposta = 2
    },
    {
        pergunta = "Pode sequestrar médicos em serviço?",
        opcoes = {"Sim, para curar amigos", "Não, médicos são neutros", "Só se ele for folgado", "Depende se tem polícia on"},
        resposta = 1
    },
    {
        pergunta = "O que fazer se encontrar um bug de dinheiro?",
        opcoes = {"Usar até ficar rico", "Contar para os amigos", "Reportar imediatamente à staff", "Ignorar e não falar nada"},
        resposta = 2
    },
    {
        pergunta = "Pode usar celular enquanto está algemado?",
        opcoes = {"Sim, para avisar a fac", "Não, é Power Gaming", "Só se a polícia não ver", "Se o celular for touch"},
        resposta = 1
    },
    {
        pergunta = "O que é RDM?",
        opcoes = {"Roubar Dinheiro de Mortos", "Matar sem motivo de RP", "Rádio de Médicos", "Regra de Manutenção"},
        resposta = 1
    },
    {
        pergunta = "Pode assaltar o mesmo jogador várias vezes seguidas?",
        opcoes = {"Sim, até ele ficar sem nada", "Não, deve-se aguardar o cooldown", "Só se ele for rico", "Se ele reclamar, mato"},
        resposta = 1
    },
    {
        pergunta = "Como deve ser a postura em um sequestro?",
        opcoes = {"Ficar gritando e xingando", "Valorizar a vida e colaborar", "Ficar mudo o tempo todo", "Tentar fugir a todo custo"},
        resposta = 1
    },
    {
        pergunta = "Pode usar o rádio da polícia se roubar um rádio?",
        opcoes = {"Sim, para monitorar", "Não, é proibido", "Só se tiver um hacker", "Se eu souber a frequência"},
        resposta = 1
    },
    {
        pergunta = "O que é 'Zonar' no RP?",
        opcoes = {"Ir para a zona norte", "Ficar brincando e quebrando o RP", "Dominar uma zona de drogas", "Limpar a zona de combate"},
        resposta = 1
    }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- Sistema de banco de dados para salvar grupos permanentemente
local db = {}

-- Inicializar tabela no banco de dados
MySQL.Async.execute("CREATE TABLE IF NOT EXISTS vrp_user_groups (user_id INT, group_name VARCHAR(50), date_added DATETIME DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(user_id))", {}, function(rows)
    if rows > 0 then
        print("["..config.logs_name.."] Tabela de grupos criada/atualizada")
    end
end)

-- Salvar grupo no banco de dados
function db.saveGroup(user_id, group_name)
    MySQL.Async.execute("REPLACE INTO vrp_user_groups (user_id, group_name) VALUES (@user_id, @group_name)", {
        ['@user_id'] = user_id,
        ['@group_name'] = group_name
    }, function(affectedRows)
        if affectedRows > 0 then
            print("["..config.logs_name.."] Grupo " .. group_name .. " salvo no banco para o usuário " .. user_id)
        end
    end)
end

-- Carregar grupo do banco de dados
function db.loadGroup(user_id, callback)
    MySQL.Async.fetchAll("SELECT group_name FROM vrp_user_groups WHERE user_id = @user_id", {
        ['@user_id'] = user_id
    }, function(result)
        if result[1] then
            callback(result[1].group_name)
        else
            callback(nil)
        end
    end)
end

-- Evento quando jogador conecta - carregar grupo salvo
AddEventHandler("Connect", function(user_id, source)
    db.loadGroup(user_id, function(group_name)
        if group_name then
            print("["..config.logs_name.."] Carregando grupo salvo " .. group_name .. " para o usuário " .. user_id)
            vRP.SetPermission(user_id, group_name, 1)
        end
    end)
end)

-- Evento para iniciar a prova (chamado pelo client no local das CDS)
RegisterServerEvent("prova:iniciar")
AddEventHandler("prova:iniciar", function()
    local source = source
    TriggerClientEvent("prova:abrir", source, perguntas, config.min_acertos)
end)

RegisterServerEvent("prova:finalizar")
AddEventHandler("prova:finalizar", function(acertos)
    local source = source
    
    if not vRP then
        print("["..config.logs_name.."] ERRO: vRP não está carregado!")
        TriggerClientEvent("Notify", source, "negado", "Sistema indisponível no momento.")
        return
    end
    
    local user_id = vRP.Passport(source)
    
    if not user_id then
        TriggerClientEvent("Notify", source, "negado", "Usuário não identificado.")
        return
    end

    if acertos >= config.min_acertos then
        print("["..config.logs_name.."] Jogador " .. user_id .. " acertou " .. acertos .. " perguntas - APROVADO")
        
        -- Atribuir o cargo configurado diretamente
        vRP.SetPermission(user_id, config.group_name, 1)
        
        print("["..config.logs_name.."] Grupo "..config.group_name.." atribuído com sucesso!")
        TriggerClientEvent("Notify", source, "sucesso", "Você passou e ganhou o cargo de "..config.group_name.."!")
        
        -- Salvar grupo no banco de dados para persistência
        db.saveGroup(user_id, config.group_name)
        
    else
        print("["..config.logs_name.."] Jogador " .. user_id .. " acertou " .. acertos .. " perguntas - REPROVADO")
        TriggerClientEvent("Notify", source, "negado", "Você reprovou.")
    end
end)