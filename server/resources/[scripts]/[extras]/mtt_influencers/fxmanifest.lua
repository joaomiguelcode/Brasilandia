fx_version "cerulean"
game "gta5"
lua54 "yes"

author "MTT Scripts"
description "Sistema de Influenciadores"
version "1.0.0"

ui_page "web-side/dist/index.html"

shared_scripts {
	"shared/shared.lua"
}

client_scripts {
	"@vrp/lib/Utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server/*"
}

files {
	"web-side/dist/**/*"
}
