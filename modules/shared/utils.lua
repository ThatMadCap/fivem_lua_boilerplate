-- Localised Functions ----------------------------------------------
local string = string
local upper = string.upper
local sub = string.sub
local lower = string.lower

-- Local Variables --------------------------------------------------
local utils = {}

-- Module Exports ----------------------------------------------
---Capitalise first letter of a string and lowercases the rest
---@param text string
function utils.capital(text)
    return upper(sub(text, 1, 1)) .. lower(sub(text, 2))
end

return utils
