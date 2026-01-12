-- Local Variables -------------------------------------
local dispatch = exports.dispatch_resource_two

-- Global Functions --------------------------------------
---Sends a dispatch notification
---@param data table dispatch data
function ServerDispatch.Dispatch(target, data)
    dispatch:sendDispatch(target, data)
end
