-- Imports --------------------------------------------------------
local sharedConfig = lib.require('config.shared')

-- Types --------------------------------------------------------
---@alias Data string

-- Localised Functions --------------------------------------------
local assert = assert
local type = type

-- Global Variables ------------------------------------------------
SharedGlobalVar = false ---@type boolean

---Example shared data table
---@type table<Data, boolean>
SharedData = {
    ['example_1'] = true,
    ['example_2'] = true,
}

-- Local Variables ------------------------------------------------
local baz = sharedConfig.baz

-- Functions ------------------------------------------------------
local function sharedFunctionExample(count)
    assert(type(count) == 'number', 'count must be a number')
    for i = 1, count do
        lib.print.info('config.baz = ' .. baz .. '_' .. i)
    end
end

sharedFunctionExample(3)
