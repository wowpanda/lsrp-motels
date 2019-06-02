resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'LosSantosRP Motel Rooms'

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