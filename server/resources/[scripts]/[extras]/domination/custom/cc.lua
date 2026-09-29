CC = {}

CC.sizeBlip = 80.0      -- Tamanho do BLIP | Alcance do território
CC.blipOverlapping = 10 -- Quantidade de metros que a área de um território pode sobrepor a outra

CC.claimDistance = 5.0  -- Distancia que o cara pode usar o Tinner

CC.minOnlineDefenders = 4 -- Quantidade mínima de membros da facção defensora online para iniciar uma disputa
CC.minAttackersOnArea = 4 -- Quantidade mínima de membros da facção atacante na área atacada para iniciar uma disputa

CC.maxMembers = 10 -- Quantidade máxima de membros contabilizados das facções na área disputada

CC.disputeDuration = 15 -- Quantidade de tempo que dura a disputa de território(em minutos)

CC.reclaimTime = 5 -- Quantidade de tempo que demora para os defensores cancelarem a disputa(em minutos)
CC.reclaimCoodown = 5 -- Quantidade de tempo que demora para os defensores tentarem cancelar a disputa novamente(em minutos)

CC.dominationCooldown = 720 -- Quantidade de tempo de intervalo entre dominações da mesma facção(em minutos)
CC.disputeCooldown = 720 -- Quantidade de tempo de intervalo entre disputadas da facção atacada(em minutos)

CC.factions = {
  ["Ballas"] = {
    ["color"] = 7,
    ["spray"] = "ballas",
  }, 
  ["Vagos"] = {
    ["color"] = 5,
    ["spray"] = "vagos",
  }, 
  ["Families"] = {
    ["color"] = 25,
    ["spray"] = "padrao",
  }, 
  ["Machado99"] = {
    ["color"] = 10,
    ["spray"] = "padrao",
  }, 
  ["Bloods"] = {
    ["color"] = 6,
    ["spray"] = "padrao",
  },
  ["Admin"] = {
    ["color"] = 6,
    ["spray"] = "padrao",
  },
  ["Cripz"] = {
    ["color"] = 3,
    ["spray"] = "Cripz",
  },
  ["Rogers"] = {
    ["color"] = 15,
    ["spray"] = "padrao",
  },
  ["TheLost"] = {
    ["color"] = 62,
    ["spray"] = "padrao",
  },
  ["Mafia"] = {
    ["color"] = 8,
    ["spray"] = "padrao",
  },
  ["Tequila"] = {
    ["color"] = 39,
    ["spray"] = "padrao",
  },
  ["Yellow"] = {
    ["color"] = 0,
    ["spray"] = "setealem",
  },
  ["Cosanostra"] = {
    ["color"] = 76,
    ["spray"] = "snake",
  },
  ["Renegados"] = {
    ["color"] = 85,
    ["spray"] = "renegados",
  },
  ["Redencao"] = {
    ["color"] = 67,
    ["spray"] = "padrao",
  },
  ["Cantagalo"] = {
    ["color"] = 75,
    ["spray"] = "kalli",
  },
  ["Trem"] = {
    ["color"] = 40,
    ["spray"] = "brazza",
  },
  ["Esquadrao"] = {
    ["color"] = 72,
    ["spray"] = "padrao",
  },
  ["Resistencia"] = {
    ["color"] = 38,
    ["spray"] = "b13",
  },

  
}