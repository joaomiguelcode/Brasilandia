client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

this_is_a_map 'yes'

client_scripts {
    'client.lua'
}

files {
    'data/**/*.meta'
}

data_file 'mapzoomdata_FILE' 'data/**/mapzoomdata.meta'              