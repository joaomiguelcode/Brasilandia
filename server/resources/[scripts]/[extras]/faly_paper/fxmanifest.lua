

fx_version "bodacious"
game "gta5"

ui_page "web/index.html"

shared_scripts {
    "cfg.lua",
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/*"
}

files {
	"web/**/**/*",
	"web/**/*",
	"web/*"
}              