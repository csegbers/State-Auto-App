---------------------------------------------------------------------------------------
-- locateagent scene
---------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 

local parse = require( myApp.utilsfld .. "mod_parse" ) 
local common = require( myApp.utilsfld .. "common" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
print ("Inxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " .. currScene .. " Scene")

local params

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    local group = self.view
    params = event.params           -- params contains the item table  
    print (params.title)
    params.container  = common.SceneContainer()
    group:insert(params.container )

         -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(0,0,50,100, 1 )
     myRoundedRect:setFillColor(myApp.homepage.groupbackground.r,myApp.homepage.groupbackground.g,myApp.homepage.groupbackground.b,myApp.homepage.groupbackground.a )
     params.container :insert(myRoundedRect)



end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )

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


---------------------------------------------------
-- use if someone wants us to transition away
-- for navigational appearnaces
---------------------------------------------------
function scene:moveContainer( event )
    if params.container then
         local containerX = params.container.x
         local containerY = params.container.Y
         local x = containerX
         local y = containerY
         if event.direction == "left" then
            x = params.container.x*-1
         end
         if event.direction == "right" then
            x = params.container.x*3
         end
         transition.to(  params.container, { time=event.time,  x= x,y=y, onComplete=function() transition.to(  params.container, {  alpha=1,  x= containerX, y =containerY } )end} )
     end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene