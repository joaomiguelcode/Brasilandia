local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local MTT = {}
Tunnel.bindInterface("mtt_influencers",MTT)
local function readSData(k)
  local s = vRP.getSData(k)
  if s and s ~= "" then
    local ok, t = pcall(json.decode, s)
    if ok and type(t) == "table" then return t end
  end
  return {}
end
local function writeSData(k, t)
  vRP.setSData(k, json.encode(t or {}))
end
local function readUData(uid)
  local s = vRP.getUData(uid,"mtt_influencers:user")
  if s and s ~= "" then
    local ok, t = pcall(json.decode, s)
    if ok and type(t) == "table" then return t end
  end
  return {}
end
local function writeUData(uid, t)
  vRP.setUData(uid,"mtt_influencers:user", json.encode(t or {}))
end
local function codesMap()
  return readSData("mtt_influencers:codes")
end
local function saveCodesMap(t)
  writeSData("mtt_influencers:codes", t)
end
local function redeemsMap()
  return readSData("mtt_influencers:redeems")
end
local function saveRedeemsMap(t)
  writeSData("mtt_influencers:redeems", t)
end
local function computePointsFor(uid)
  local r = redeemsMap()
  local total = 0
  local valid = 0
  for _, v in pairs(r) do
    if v and v.influencer_id == uid then
      total = total + 1
      if v.valid then valid = valid + 1 end
    end
  end
  return total, valid
end
local function computeSaldo(validPoints, userData)
  local vp = (Config and Config.VALUE_PER_POINT) or 1
  local paid = tonumber(userData.totalResgatado or 0) or 0
  local saldo = (validPoints * vp) - paid
  if saldo < 0 then saldo = 0 end
  return saldo
end
function MTT.getDashboardData()
  local src = source
  local uid = vRP.getUserId(src)
  if not uid then return nil end
  local u = readUData(uid)
  local total, valid = computePointsFor(uid)
  local saldo = computeSaldo(valid, u)
  return {
    pontosTotais = total,
    pontosValidados = valid,
    codigoCriador = u.codigoCriador or "",
    saldo = saldo,
    ultimoSaque = u.ultimoSaque,
    metaPontos = Config and Config.META_POINTS or 0,
    valorPorPonto = Config and Config.VALUE_PER_POINT or 1,
    resgateGemas = Config and Config.RESGATE_GEMAS or 50
  }
end
function MTT.saveCodigoCriador(codigo)
  local src = source
  local uid = vRP.getUserId(src)
  if not uid then return false end
  if type(codigo) ~= "string" then return false end
  if not codigo:match("^[%w]+$") then return false end
  codigo = codigo:sub(1,10)
  local codeKey = string.upper(codigo)
  local codes = codesMap()
  local u = readUData(uid)
  if u.codigoCriador then
    local prev = string.upper(u.codigoCriador)
    if codes[prev] and codes[prev] == uid then codes[prev] = nil end
  end
  local owner = codes[codeKey]
  if owner and owner ~= uid then return false end
  codes[codeKey] = uid
  saveCodesMap(codes)
  u.codigoCriador = codigo
  writeUData(uid, u)
  return true
end
function MTT.resgatarCodigo(codigo)
  local src = source
  local uid = vRP.getUserId(src)
  if not uid then return false end
  if not Config or not Config.RESGATE_MIN_ACCOUNT_ID then return false end
  if uid <= Config.RESGATE_MIN_ACCOUNT_ID then return false end
  if type(codigo) ~= "string" then return false end
  local codeKey = string.upper(codigo:sub(1,10))
  local codes = codesMap()
  local influencer = codes[codeKey]
  if not influencer then return false end
  if influencer == uid then return false end
  local r = redeemsMap()
  if r[tostring(uid)] then return false end
  r[tostring(uid)] = { code = codeKey, influencer_id = influencer, ts = os.time(), valid = false, rewarded = true }
  saveRedeemsMap(r)
  local amount = tonumber(Config and Config.RESGATE_GEMAS) or 0
  if amount > 0 then
    local item = (Config and Config.RESGATE_ITEM_NAME) or "gemas"
    local ok = false
    if vRP and vRP.giveInventoryItem then
      local ok1 = pcall(function() vRP.giveInventoryItem(uid, item, amount, true) end)
      ok = ok1 and true or false
    end
    if not ok and vRP and vRP.giveBank then pcall(function() vRP.giveBank(uid, amount) end) end
    if not ok and vRP and vRP.giveMoney then pcall(function() vRP.giveMoney(uid, amount) end) end
  end
  return true
end
function MTT.requestWithdraw(amount, pixType, pixValue)
  local src = source
  local uid = vRP.getUserId(src)
  if not uid then return false end
  local a = tonumber(amount or 0) or 0
  if a <= 0 then return false end
  local u = readUData(uid)
  local total, valid = computePointsFor(uid)
  local saldo = computeSaldo(valid, u)
  if valid < (Config and Config.META_POINTS or 0) then return false end
  if a > saldo then return false end
  u.totalResgatado = (u.totalResgatado or 0) + a
  u.ultimoSaque = os.date("%d/%m/%Y %H:%M:%S")
  u.withdraws = u.withdraws or {}
  table.insert(u.withdraws, { amount = a, at = os.time(), pix = { type = pixType, value = pixValue } })
  writeUData(uid, u)
  local wb = Config and Config.WEBHOOK_SAQUE
  if wb and type(wb) == "string" and wb ~= "" then
    local identity = vRP.getUserIdentity and vRP.getUserIdentity(uid) or {}
    local name = (identity.name and identity.firstname) and (identity.name.." "..identity.firstname) or ("ID "..uid)
    local payload = {
      embeds = {{
        title = "Solicitação de Saque",
        description = "ID: "..uid.."\nNome: "..name.."\nValor: R$ "..string.format("%.2f", a).."\nPIX: "..tostring(pixType or "").." - "..tostring(pixValue or ""),
        color = 65280,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    PerformHttpRequest(wb, function() end, "POST", json.encode(payload), {["Content-Type"]="application/json"})
  end
  return true
end
function MTT.canResgate()
  local src = source
  local uid = vRP.getUserId(src)
  if not uid then return false end
  if not Config or not Config.RESGATE_MIN_ACCOUNT_ID then return false end
  if uid <= Config.RESGATE_MIN_ACCOUNT_ID then return false end
  local r = redeemsMap()
  if r[tostring(uid)] then return false end
  return true
end
RegisterCommand("influencers", function(source, args, raw)
  local src = source
  if src <= 0 then return end
  local uid = vRP.getUserId(src)
  if not uid then return end
  local allow = true
  if Config and type(Config.INFLUENCERS_COMMAND_GROUP) == "table" and #Config.INFLUENCERS_COMMAND_GROUP > 0 then
    allow = false
    for _, g in ipairs(Config.INFLUENCERS_COMMAND_GROUP) do
      if vRP.hasGroup and vRP.hasGroup(uid, g) then allow = true break end
    end
  end
  if allow then
    TriggerClientEvent("mtt_influencers:openCarteira", src)
  end
end)
CreateThread(function()
  while true do
    Wait(60000)
    local mins = (Config and Config.PLAYTIME_VALID_MINUTES) or 0
    if mins > 0 then
      local r = redeemsMap()
      local changed = false
      local now = os.time()
      for k, v in pairs(r) do
        if v and not v.valid and v.ts and (now - v.ts) >= (mins * 60) then
          v.valid = true
          changed = true
        end
      end
      if changed then saveRedeemsMap(r) end
    end
  end
end)
