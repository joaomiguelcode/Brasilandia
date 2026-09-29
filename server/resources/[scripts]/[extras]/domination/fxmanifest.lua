

fx_version "cerulean"
game "gta5"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"custom/cc.lua"
}

client_scripts {
	'**/zero.lua'
}

server_scripts {
	"@vrp/config/Item.lua",
	'**/geass.lua'
}
