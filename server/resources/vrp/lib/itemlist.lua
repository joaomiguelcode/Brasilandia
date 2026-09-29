-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPATIBILIDADE: ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local content = LoadResourceFile("vrp", "config/Item.lua")
if content then
	local fn, err = load(content)
	if fn then
		fn()
	else
		print("^1[vRP] Erro ao carregar config/Item.lua: " .. tostring(err) .. "^7")
	end
end
