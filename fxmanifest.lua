fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_script 'client/*.lua'
server_script 'server/*.lua'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua',
}

server_script '@oxmysql/lib/MySQL.lua'