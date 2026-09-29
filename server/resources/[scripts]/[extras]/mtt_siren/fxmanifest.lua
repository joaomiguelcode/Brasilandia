fx_version "bodacious"
game "gta5"
lua54 "yes"

author "Brasilândia"
description "Sistema de sirene para veículos"

ui_page "web/dist/index.html"

files {
	"web/dist/**/*"
}

shared_scripts {
	"@vrp/lib/Utils.lua"
}

client_scripts {
	"@vrp/lib/Utils.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server.lua"
}
