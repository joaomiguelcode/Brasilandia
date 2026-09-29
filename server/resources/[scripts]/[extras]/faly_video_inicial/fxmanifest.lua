

fx_version "bodacious"
game "gta5"

client_scripts {
	"client/*"
}
server_scripts {
	"@vrp/lib/Utils.lua",
	"server/*"
}

ui_page "web/index.html"

files {
	"web/*",
	"web/**/*"
}