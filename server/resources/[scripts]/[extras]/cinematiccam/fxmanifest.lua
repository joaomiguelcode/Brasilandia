


fx_version 'bodacious'
games { 'gta5' }
author 'Kiminaze'
client_scripts {
	--'@NativeUILua-Reloaded/src/NativeUIReloaded.lua',
	'@NativeUI/NativeUI.lua',
	'client.lua'
}
server_script 'server.lua'
shared_scripts {
	"@vrp/lib/Utils.lua",
	'config.lua',
}
dependency "NativeUI"