---------------------------------------------------------------------------------------
-- HOME scene
---------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 
local common = require( myApp.utilsfld .. "common" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
print ("In " .. currScene .. " Scene")

local params

function scene:create(event)
  print ("Create  " .. currScene)
    local group = self.view
    params = event.params or {}
    local container = common.SceneContainer()
    group:insert(container)



    local scrollView = widget.newScrollView
        {
            x = 0,
            y = 0,
            width = myApp.sceneWidth, 
            height =  myApp.sceneHeight,
            horizontalScrollDisabled = true,
            hideBackground = true,
        }
    container:insert(scrollView)



    local starty = 0
    
    local backlogo = display.newImageRect("salogo.jpg",305,170)
    backlogo:scale( .5,.5  )
    backlogo.x = myApp.cCx
    starty = backlogo.height * .5 * .5  + 10
    backlogo.y = starty
    starty = starty + backlogo.height
    scrollView:insert(backlogo)

    local function renderInfo(whatText)
        starty = starty + 10
        local disNt = display.newText( whatText, 100, starty, native.systemFont, 16 )
        disNt:setFillColor( 1, 0, 0 )
        scrollView:insert(disNt)
        starty = starty + disNt.height
    end
    renderInfo("latitude " .. string.format( '%.4f', myApp.gps.event.latitude ))
    renderInfo("longitude " .. string.format( '%.4f', myApp.gps.event.longitude ))
    renderInfo("altitude " .. string.format( '%.4f', myApp.gps.event.altitude ))
    renderInfo("accuracy " .. string.format( '%.4f', myApp.gps.event.accuracy ))
    renderInfo("speed " .. string.format( '%.4f', myApp.gps.event.speed ))
    renderInfo("direction " .. string.format( '%.4f', myApp.gps.event.direction ))
    renderInfo("time " .. string.format( '%.4f', myApp.gps.event.time ))

    renderInfo("  " )
 
    renderInfo("memory " .. system.getInfo( "textureMemoryUsed" ) / 1000000)

end

function scene:show( event )


    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
            local group = self.view

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
	

end

function scene:hide( event )
    local group = self.view
    local phase = event.phase
    print ("Hide:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end

function scene:destroy( event )
	local group = self.view
    print ("Destroy "   .. currScene)
end

function scene:myparams( event )
       return params
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene