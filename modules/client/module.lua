-- Imports ------------------------------------------------------
local clientConfig = lib.require('config.client')

-- Localised Functions ------------------------------------------
local GetCurrentResourceName = GetCurrentResourceName

-- Local Variables ----------------------------------------------
local module = {}
local resourceName = GetCurrentResourceName()

-- Functions -----------------------------------------------------
---Example module function
function module.example()
    local foo = clientConfig.foo
    lib.print.info('This is an example function from ', resourceName)
    lib.print.info('foo = ', foo)
end

-- Module Exports ------------------------------------------------
return module
