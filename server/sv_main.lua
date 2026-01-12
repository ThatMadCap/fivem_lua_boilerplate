-- Imports --------------------------------------------------------
local commands = lib.require('modules.server.commands')

-- Localised Functions --------------------------------------------
local RegisterNetEvent = RegisterNetEvent
local GetPlayerServerId = GetPlayerServerId
local GetCurrentResourceName = GetCurrentResourceName
local AddEventHandler = AddEventHandler

-- Global Variables ------------------------------------------------
GlobalServerVar = false ---@type boolean

-- Local Variables ------------------------------------------------
local resourceName = GetCurrentResourceName()

-- Functions ------------------------------------------------------
---Example server function
---@return number playerServerId the player's server ID
local function serverFunctionExample()
    local playerServerId = GetPlayerServerId(source)
    return playerServerId
end

-- Callback Registration ------------------------------------------
---Example lib callback registration
lib.callback.register(resourceName .. ':server:callback', function(source)
    return 'Hey!'
end)

-- Event Registration ----------------------------------------------
---Example server event
RegisterNetEvent(resourceName .. ':server:event', function()
    lib.print.debug('server:event fired | source: ', source)

    local data = {}
    ServerDispatch.Dispatch(source, data)
end)

-- Initialisation --------------------------------------------------
lib.versionCheck('GITHUB_USERNAME/RESOURCE_NAME')

local function init()
    serverFunctionExample()
    commands.initCommands()
end

-- Cleanup ---------------------------------------------------------
local function cleanup()
    lib.print.debug('Cleaning up')
end

-- Event Handlers --------------------------------------------------
AddEventHandler('onResourceStart', function(resName)
    if GetCurrentResourceName() ~= resName then
        return
    end

    init()
end)

AddEventHandler('onResourceStop', function(resName)
    if GetCurrentResourceName() ~= resName then
        return
    end

    cleanup()
end)

AddEventHandler('playerDropped', function()
    lib.print.debug('Player dropped | source: ', source)
end)
