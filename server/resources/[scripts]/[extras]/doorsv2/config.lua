config = {}

config.colocatrancar = "addport"

config.deletaporta   = "debugport"

config.debugporthesh =    "debugport"    

config.reloaddoorss  =   "reloaddoors"

local _print = print
print = function(...)
	local args = { ... }
	if args[1] and type(args[1]) == "string" and string.find(args[1], "Portas carregadas") then
		Citizen.CreateThread(function()
			Citizen.Wait(4100)
			_print(table.unpack(args))
		end)
		return
	end
	_print(table.unpack(args))
end