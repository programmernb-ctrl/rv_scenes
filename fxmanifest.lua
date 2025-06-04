fx_version 'cerulean'
game 'gta5'
lua54 'yes'

version '0.0.2'
author 'thirst'
description 'Utility Script for handling synchronised network scenes.'
repository 'https://github.com/programmernb-ctrl/rv_scenes'
name 'rv_scenes'

client_script 'cl_scenes.lua'
shared_script '@ox_lib/init.lua'
server_script 'server/main.lua'

files {
    "class/scenes.lua"
}

dependency 'ox_lib'

use_experimental_fxv2_oal 'yes'
