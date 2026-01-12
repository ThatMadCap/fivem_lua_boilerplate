-- Imports --------------------------------------------------------
local commands = lib.require('modules.server.commands')

-- Localised Functions --------------------------------------------
local GetCurrentResourceName = GetCurrentResourceName
local GetPlayerServerId = GetPlayerServerId
local RegisterNetEvent = RegisterNetEvent
local assert = assert
local GetResourceState = GetResourceState
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
    assert(GetResourceState('ox_lib') == 'started', 'ox_lib is not started. Please ensure ox_lib is installed and started before ' .. resourceName)
    serverFunctionExample()
    commands.initCommands()
end

-- Cleanup ---------------------------------------------------------
local function cleanup()
    lib.print.debug('Cleaning up')
end

-- Event Handlers --------------------------------------------------
AddEventHandler('onResourceStart', function(resName)
    if resourceName ~= resName then
        return
    end

    init()
end)

AddEventHandler('onResourceStop', function(resName)
    if resourceName ~= resName then
        return
    end

    cleanup()
end)

AddEventHandler('playerDropped', function()
    lib.print.debug('Player dropped | source: ', source)
end)
