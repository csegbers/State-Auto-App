local myApp = require( "myapp" )
local socket = require( "socket" )
-------------------------------------------------------
-- Store variables used across the app
-------------------------------------------------------
local M = { }
 
function M.SceneBackground()
    local background = display.newRect(0,0,myApp.cW, myApp.cH)
    background:setFillColor(255/myApp.colorDivisor, 255/myApp.colorDivisor, 255/myApp.colorDivisor, 255/myApp.colorDivisor)
    background.x = myApp.cW / 2
    background.y = myApp.cH / 2
    return background
end

function M.testNetworkConnection()
    local netConn = socket.connect('www.google.com', 80)
    if netConn == nil then
         return false
    end
    netConn:close()
    return true
end

return M