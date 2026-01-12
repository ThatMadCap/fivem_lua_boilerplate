-- Imports ---------------------------------------------------------
lib.locale()
local clientConfig = lib.require('config.client')

-- Localised Functions ---------------------------------------------
local RegisterNetEvent = RegisterNetEvent
local GetCurrentResourceName = GetCurrentResourceName
local AddEventHandler = AddEventHandler

-- Global Variables ------------------------------------------------
GlobalClientVar = false ---@type boolean

-- Local Variables -------------------------------------------------
local resourceName = GetCurrentResourceName()

-- Functions -------------------------------------------------------
---Example function
local function clientFunctionExample()
    lib.print.info('config.foo = ', clientConfig.foo)
end

---Example lib callback to server
local function callbackServerExample()
    local callback = lib.callback.await(resourceName .. ':server:callback', false)
    if not callback then
        return
    end

    lib.print.info('Server callback response: ', callback)

    local data = {
        description = tostring(callback),
        type = 'info',
    }
    ClientNotify.Notify(data)
end

-- Event Registration -----------------------------------------------
---Example server-only event
RegisterNetEvent(resourceName .. ':client:event', function(data)
    if source ~= 65535 then
        return
    end
    lib.print.debug('client:event fired | source: ', source, ' | data: ', data)
end)

---Example event
RegisterNetEvent(resourceName .. ':client:anotherEvent', function()
    lib.print.debug('client:anotherEvent fired | source: ', source)
end)

-- Callback Registration -------------------------------------------
--- Example lib callback
lib.callback.register(resourceName .. ':client:callback', function()
    return 'Hello!'
end)

-- Initialisation --------------------------------------------------
local function init()
    lib.print.debug('Initialising')

    clientFunctionExample()
    callbackServerExample()
end

-- Cleanup ---------------------------------------------------------
local function cleanup()
    lib.print.debug('Cleaning up')
end

-- Event Handlers --------------------------------------------------
AddEventHandler('onClientResourceStart', function(resName)
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
