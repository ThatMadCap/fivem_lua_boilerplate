-- Imports --------------------------------------
local sharedConfig = lib.require('config.shared')

-- Localised Functions --------------------------
local string = string
local format = string.format
local ipairs = ipairs
local GetResourceState = GetResourceState

-- Global Variables -----------------------------
ClientNotify = {}

-- Local Variables ------------------------------
local notify = {
    { name = 'ox_lib', bridge = 'ox' },
}

local notifyFound = false
local selectedNotify = sharedConfig.notify.type or 'ox_lib'

-- Logic ----------------------------------------
for _, resource in ipairs(notify) do
    if resource.name == selectedNotify and GetResourceState(resource.name) == 'started' then
        lib.load(format('bridge.notify.%s.client', resource.bridge))
        lib.print.debug(format('Notify selected: %s', resource.name))
        notifyFound = true
        break
    end
end

if sharedConfig.notify.type == 'custom' then
    notifyFound = true
    lib.load('bridge.notify.custom.client')
    lib.print.debug('Custom notify selected')
end

if not notifyFound then
    lib.load('bridge.notify.custom.client')
    lib.print.warn('No notify resource found: falling back to custom')
end
