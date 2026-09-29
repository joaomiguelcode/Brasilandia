fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

dependency "vrp"

client_scripts {
	"@vrp/config/Native.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/core.lua"
}

files {
	"web-side/*",
	"web-side/**/*"
}

shared_scripts {
	"@vrp/config/Item.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua"
}
