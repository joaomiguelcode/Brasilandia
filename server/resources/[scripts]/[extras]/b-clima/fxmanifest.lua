
fx_version 'cerulean'
game 'gta5'
-- Arquivos da NUI
ui_page 'web-side/index.html'
files {
    'web-side/index.html',
    'web-side/style.css',
    'web-side/script.js',
    'web-side/nui/*',
    'web-side/fonts/*.ttf'
}
-- Scripts client-side
client_scripts {
	"client-side/client.lua"
}
server_scripts {
    "@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
    "server-side/server.lua"
}