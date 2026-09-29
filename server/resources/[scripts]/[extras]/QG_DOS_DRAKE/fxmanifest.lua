fx_version 'cerulean'
game 'gta5'

author 'QG DOS DRAKE'
description 'Sistema de Prova - QG DOS DRAKE'
version '2.0.0'

ui_page 'html/index.html'

files {
    'html/**'
}

server_scripts {
    '@vrp/lib/utils.lua',
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}