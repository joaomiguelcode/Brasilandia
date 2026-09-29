local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local vRP = Proxy.getInterface("vRP")
local dynamic = {}
Tunnel.bindInterface("dynamic",dynamic)
local function getPassport(source)
	if vRP and vRP.Passport then
		return vRP.Passport(source)
	end
	if vRP and vRP.getUserId then
		return vRP.getUserId(source)
	end
	return nil
end
local function hasItem(passport,item)
	if not passport or not item then return false end
	if vRP and vRP.getInventoryItemAmount then
		local amount = vRP.getInventoryItemAmount(passport,item)
		local qtd = amount
		if type(qtd) == "table" then
			if qtd.amount ~= nil then
				qtd = qtd.amount
			elseif qtd.count ~= nil then
				qtd = qtd.count
			elseif qtd[1] ~= nil then
				qtd = qtd[1]
			else
				qtd = 0
			end
		end
		qtd = tonumber(qtd) or 0
		if qtd > 0 then
			return true
		end
	end
	if vRP and vRP.Inventory then
		local ok,inv = pcall(vRP.Inventory,passport)
		if ok and inv and inv.getItemAmount then
			local amount = inv.getItemAmount(item)
			local qtd = amount
			if type(qtd) == "table" then
				if qtd.amount ~= nil then
					qtd = qtd.amount
				elseif qtd.count ~= nil then
					qtd = qtd.count
				elseif qtd[1] ~= nil then
					qtd = qtd[1]
				else
					qtd = 0
				end
			end
			qtd = tonumber(qtd) or 0
			if qtd > 0 then
				return true
			end
		end
	end
	return false
end
local function hasGroup(passport,group)
	if not passport or not group then return false end
	if vRP and vRP.HasGroup then
		return vRP.HasGroup(passport,group)
	end
	if vRP and vRP.hasGroup then
		return vRP.hasGroup(passport,group)
	end
	return false
end
function dynamic.hasCNH()
	local source = source
	local passport = getPassport(source)
	if not passport then return false end
	if hasItem(passport,"cnh") or hasItem(passport,"cnhdigital") or hasItem(passport,"driverlicense") then
		return true
	end
	if hasGroup(passport,"CNH") or hasGroup(passport,"Habilitado") or hasGroup(passport,"Motorista") or hasGroup(passport,"Driver") then
		return true
	end
	return false
end

local function getIdentity(passport)
	if not passport then return nil end
	if vRP and vRP.Identity then
		local ok,ident = pcall(vRP.Identity,passport)
		if ok and ident then return ident end
	end
	if vRP and vRP.getUserIdentity then
		local ok,ident = pcall(vRP.getUserIdentity,passport)
		if ok and ident then return ident end
	end
	if vRP and vRP.GetUserIdentity then
		local ok,ident = pcall(vRP.GetUserIdentity,passport)
		if ok and ident then return ident end
	end
	return nil
end

local function pick(tbl,keys)
	if type(tbl) ~= "table" then return nil end
	for _,k in ipairs(keys) do
		if tbl[k] ~= nil and tbl[k] ~= "" then
			return tbl[k]
		end
	end
	return nil
end

function dynamic.getIdentityData()
	local source = source
	local passport = getPassport(source)
	if not passport then return nil end
	local ident = getIdentity(passport) or {}
	local first = pick(ident,{ "firstname","name","nome","first_name" })
	local last = pick(ident,{ "lastname","name2","sobrenome","last_name" })
	local full = pick(ident,{ "fullname","fullName" })
	if not full then
		if first and last then
			full = tostring(first).." "..tostring(last)
		else
			full = tostring(first or last or "Indefinido")
		end
	end
	local phone = pick(ident,{ "phone","phone_number","telefone","cellphone" })
	if not phone and vRP and vRP.getPhone then
		local ok,ph = pcall(vRP.getPhone,passport)
		if ok then phone = ph end
	end
	if not phone and vRP and vRP.GetPhone then
		local ok,ph = pcall(vRP.GetPhone,passport)
		if ok then phone = ph end
	end
	local registration = pick(ident,{ "registration","rg","cpf","identidade" })
	return {
		id = passport,
		name = full or "",
		firstname = first or "",
		lastname = last or "",
		phone = phone or "",
		registration = registration or ""
	}
end
