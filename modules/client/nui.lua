-- Localised Functions ------------------------------------------
local SetNuiFocus = SetNuiFocus
local SendNUIMessage = SendNUIMessage
local RegisterNUICallback = RegisterNUICallback

-- Local Variables ----------------------------------------------
local nui = {}
local isNuiOpen = false ---@type boolean Whether the NUI is currently open

-- Functions -----------------------------------------------------
---Shows the NUI
function nui.show()
    if not isNuiOpen then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'show'
        })
        isNuiOpen = true
    end
end

---Hides the NUI
function nui.hide()
    if isNuiOpen then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'hide'
        })
        isNuiOpen = false
    end
end

-- NUI Callbacks --------------------------------------------------
RegisterNUICallback('close', function(data, cb)
    nui.hide()
    cb('ok')
end)

-- Module Exports ------------------------------------------------
return nui
