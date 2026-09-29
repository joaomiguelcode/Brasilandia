fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/client.lua"
}

server_scripts {
	"@vrp/config/Vehicle.lua",
	"@vrp/lib/utils.lua",
	"server/server.lua"
}