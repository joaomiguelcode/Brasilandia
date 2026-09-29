

fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/lib/Utils.lua",
	"clothes.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"clothes.lua",
	"server-side/*"
}