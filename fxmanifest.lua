fx_version 'cerulean'
game 'gta5'

lua54 'yes'

name 'poojai'
author 'Codex'
description 'ESX food box pickup with an ox_inventory container'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
}

server_scripts {
    'server/main.lua',
}

dependencies {
    'es_extended',
    'esx_status',
    'ox_lib',
    'ox_target',
    'ox_inventory',
}
