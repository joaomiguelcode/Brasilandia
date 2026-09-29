


fx_version 'bodacious'
game 'gta5'

version '1.0.0'

ui_page "web-side/index.html"

shared_scripts {
    "@vrp/lib/utils.lua"
}

client_script "client-side/*.lua"

server_script "server-side/*.lua"

files {
    "web-side/**/*",
    "web-side/assets/audio/*"
}