-- Imports ---------------------------------------------------------
local serverConfig = lib.require('config.server')

-- Localised Functions ----------------------------------------------
local string = string
local format = string.format

-- Local Variables --------------------------------------------------
local commands = {}

-- Local Functions --------------------------------------------------
---Example
local function testCommand()
    lib.addCommand('test', {
        help = 'test command',
        params = {
            { name = 'argument', type = 'string', help = 'argument to send' },
        },
        restricted = false,
    }, function(source, args)

        lib.print.debug(format('Player %d used test command', source))
    end)
end

-- Module Functions -----------------------------------------------------
---Initialise commands
function commands.initCommands()
    if not serverConfig.enableCommands then return end

    testCommand()
end

-- Module Exports ------------------------------------------------
return commands

