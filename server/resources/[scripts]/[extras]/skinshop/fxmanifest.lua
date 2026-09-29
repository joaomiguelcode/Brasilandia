shared_script ""


fx_version "bodacious"
game 'gta5'
lua54 'yes'
author 'Faly_'
description '[SKINSHOP] Sistema de Rotas'
version '2.0.10'
ui_page 'web/index.html'
client_scripts {
	'@vrp/config/Native.lua',
	'@vrp/lib/Utils.lua',
	'client/*'
}
server_scripts {
	'@vrp/lib/Utils.lua',
	"@vrp/config/Item.lua",
	'server/connection.lua',
	'server/modules/*',
	'server/vrp/*'
}
files {
	'web/*',
	'web/**/*',
}              
shared_scripts {
	'config/*'
}
escrow_ignore {
	'config/*',
}