fx_version 'adamant'
game 'gta5'

name 'LosSantosRP Motel Rooms'
description 'An motel script built for Monster ESX Framework '
author 'LSRP'
version '1.0.0'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'server/server.lua',
    'config.lua',
    'locales/en.lua'
}

client_scripts {
	'@es_extended/locale.lua',
    'client/client.lua',
    'config.lua',
    'locales/en.lua'
}

dependencies {
	'es_extended',
	'instance',
	'cron',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore'
}