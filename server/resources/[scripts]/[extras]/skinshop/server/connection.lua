-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface(GetCurrentResourceName(), Creative)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOAD EXTENSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local extensions = {}
function create_extension(name, moduleFn)
    extensions[name] = moduleFn
end
function load_extension(name)
    local old = extensions[name]
    if type(old) == 'function' then
        extensions[name] = old() or {}
        return extensions[name]
    elseif old ~= nil then
        return old
    end
    error(_('extension.not_found', { name=name }))
end
function printf(...)
    local text = sprint(...)
    print(text)
    if is_server then
        append_log(text)
    end
end
sprint = string.format
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATIVE 
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    if CreativeV5 then
        if load_extension(GetCurrentResourceName()..'/creativeV5') then
			printf('\x1b[32m[ '..string.upper(GetCurrentResourceName())..' ] Creative v5 injected!\x1b[0m')
        end
    end
end)







