shared_script ""

fx_version "bodacious"
game "gta5"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"config.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/config/Native.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"config.lua",
	"server-side/*"
}