-- Local Variables -------------------------------------
local dispatch = exports.dispatch_resource_one

-- Global Functions --------------------------------------
---Sends a dispatch notification
---@param data table dispatch data
function ClientDispatch.Dispatch(data)
    dispatch:sendDispatch(data)
end
