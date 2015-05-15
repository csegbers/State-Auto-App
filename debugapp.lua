---------------------------------------------------------------------------------------
-- HOME scene
---------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" )
local common = require( "common" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
print ("In " .. currScene .. " Scene")

function scene:create(event)
    print ("Create  " .. currScene)
	local group = self.view
	local background = common.SceneBackground()
    group:insert(background)

    local scrollView = widget.newScrollView
    {
        top = myApp.sceneStartTop, 
        left = 1,
        width = myApp.sceneWidth, 
        height = myApp.sceneHeight ,
        -- scrollWidth = 600,
        -- scrollHeight = 800,
        --listener = scrollListener,
    }
    group:insert(scrollView)

    local starty = 0
    
    local backlogo = display.newImageRect("salogo.jpg",305,170)
    backlogo:scale( .5,.5  )
    backlogo.x = myApp.cCx
    starty = backlogo.height * .5 * .5  + 10
    backlogo.y = starty
    starty = starty + backlogo.height
    scrollView:insert(backlogo)




end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene