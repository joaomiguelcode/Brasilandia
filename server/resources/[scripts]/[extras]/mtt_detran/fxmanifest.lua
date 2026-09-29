fx_version "cerulean"
game "gta5"
lua54 "yes"

author "MTT Scripts"
description "Sistema DETRAN - prova teórica integração vRP com interface React"
version "1.0.0"

ui_page "web/dist/index.html"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"shared/shared.lua"
}

client_scripts {
	"client/client.lua"
}

server_scripts {
	"server/server.lua"
}

files {
	"web/dist/**"
}
