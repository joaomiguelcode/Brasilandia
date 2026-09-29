

fx_version "bodacious"
game "gta5"
lua54 "yes"
ui_page "web-side/dist/index.html"


shared_scripts {
	"@vrp/lib/Utils.lua"
}

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/config/Item.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/dist/**"
}