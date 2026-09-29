local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_tattoos")
func = {}
Tunnel.bindInterface("nation_tattoos", func)

function func.checkPermission(permission, src)
    local source = src or source
    local Passport = vRP.Passport(source)
    if type(permission) == "table" then
        for i, perm in pairs(permission) do
            if vRP.HasPermission(Passport, perm) then
                return true
            end
        end
        return false
    end
    return not permission or vRP.HasPermission(Passport, permission)
end

function func.saveChar(t)
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local char = getUserChar(Passport)
        char.tattoos, char.overlay = t.tattoos, t.overlay
        vRP.execute("playerdata/SetData",{ Passport = parseInt(Passport), dkey = "Tatuagens", dvalue = json.encode(char,{indent=false}) })
    end
end

function func.tryPay(value)
    local source = source
    local Passport = vRP.Passport(source)
    if value >= 0 then
        if vRP.PaymentFull(Passport, value) or value == 0 then
            return true
        end
    end
    return false
end

function func.getTattoos()
    local source = source
    local Passport = vRP.Passport(source)
    if Passport then
        local char = getUserChar(Passport)
        return (char.tattoos or {}), (char.overlay or 0)
    end
    return false
end

function getUserChar(Passport)
    local data = vRP.UserData(Passport, "Tatuagens")
    if next(data) ~= nil then
        local char = data
        if char then
            return char
        end
    end
    return {}
end