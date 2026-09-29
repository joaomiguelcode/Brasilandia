shared_script ""

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"shared-side/*",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"shared-side/*",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}