fx_version('cerulean')
lua54('yes')
use_experimental_fxv2_oal('yes')
game('gta5')

name('RESOURCE_NAME')
version('0.0.0')
description('')
author('GITHUB_USERNAME')

ui_page('web/index.html')

dependencies({
    'ox_lib',
})

shared_scripts({
    '@ox_lib/init.lua',
    'modules/shared/*.lua',
    'shared/*.lua',
})

client_scripts({
    'bridge/notify/client.lua',
    'modules/client/*.lua',
    'client/*.lua',
})

server_scripts({
    'bridge/notify/server.lua',
    'server/*.lua',
})

files({
    'locales/*.json',
    'config/*.lua',
    'bridge/**/*',
    'data/*.json',
    'web/**/*',
})
