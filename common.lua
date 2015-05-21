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


function M.SceneContainer()
    local container = display.newContainer(myApp.sceneWidth,myApp.sceneHeight)
    container:insert(M.SceneBackground())
    --local background = display.newRect(0,0,myApp.sceneWidth,myApp.sceneHeight)
   -- background:setFillColor(155/myApp.colorDivisor, 255/myApp.colorDivisor, 255/myApp.colorDivisor, 255/myApp.colorDivisor)
    --container:insert(background) 
    container.y = myApp.sceneHeight  /2 + myApp.sceneStartTop
    container.x = myApp.sceneWidth / 2  
    return container
end

function M.testNetworkConnection()
    local netConn = socket.connect('www.google.com', 80)
    if netConn == nil then
         return false
    end
    netConn:close()
    return true
end

function M.fitImage( displayObject, fitWidth, enlarge )
    --
    -- first determine which edge is out of bounds
    --
    local scaleFactor = fitWidth / displayObject.width 
    displayObject:scale( scaleFactor, scaleFactor )
end

return M