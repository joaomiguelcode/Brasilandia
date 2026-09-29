fx_version "cerulean"
game "gta5"
author "Jhon Durateston"
lua54 "yes"

files {
	"web-side/*",
	"web-side/**/*"
}

ui_page "web-side/index.html"

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua",
} 

shared_scripts{
    "config.lua"
}

client_scripts {
    "@vrp/lib/utils.lua",
    "client.lua"
} 

