shared_script ""

fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "ui/index.html"
shared_script "shared.lua"

client_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/config/Native.lua",
	"client/init/proximity.lua",
	"client/init/init.lua",
	"client/init/main.lua",
	"client/init/submix.lua",
	"client/module/*.lua",
	"client/*.lua"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server/**/*.lua"
}

files {
	"ui/*.ogg",
	"ui/css/*.css",
	"ui/js/*.js",
	"ui/index.html"
}