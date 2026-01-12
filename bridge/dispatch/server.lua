-- Localised Functions --------------------------
local string = string
local format = string.format
local ipairs = ipairs
local GetResourceState = GetResourceState

-- Global Variables -----------------------------
ServerDispatch = {}

-- Local Variables ------------------------------
local dispatches = {
    { name = 'dispatch_one', bridge = 'dp1' },
    { name = 'dispatch_two', bridge = 'dp2' },
}

local dispatchFound = false

-- Logic ----------------------------------------
for _, resource in ipairs(dispatches) do
    if GetResourceState(resource.name) == 'started' then
        lib.load(format('bridge.dispatch.%s.server', resource.bridge))
        lib.print.debug(format('Dispatch selected: %s', resource.name))
        dispatchFound = true
        break
    end
end

if not dispatchFound then
    lib.load('bridge.dispatch.custom.server')
    lib.print.warn('No dispatch resource found: falling back to custom')
end

