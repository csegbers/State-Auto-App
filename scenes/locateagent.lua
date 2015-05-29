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
    local container  = common.SceneContainer()
    group:insert(container )

    if common.testNetworkConnection() then
       native.setActivityIndicator( true )
       parse:run("getagenciesnearby",{["lat"] = myApp.gps.event.latitude, ["lng"] = myApp.gps.event.longitude,["limit"] = myApp.locateanagent.gps.limit, ["miles"] = myApp.locateanagent.gps.miles}, function(e) native.setActivityIndicator( false ) if not e.error then debugpopup ("BACK from agentsnearby " ) end end )
    end
     -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(0,0,50,100, 1 )
     myRoundedRect:setFillColor(myApp.homepage.groupbackground.r,myApp.homepage.groupbackground.g,myApp.homepage.groupbackground.b,myApp.homepage.groupbackground.a )
     container:insert(myRoundedRect)


        --local agentpagelink = common.DeepCopy(myApp.locatepage.agentinfo)
       -- local parentinfo = common.DeepCopy(params)
        local agentpagelink =  myApp.locateanagent.agentinfo 
        local parentinfo =  params 
        agentpagelink.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback=agentpagelink.composer.effectback}) end
        local agentbackButton = widget.newButton {
            label = agentpagelink.title ,
            labelColor = { default={ 0, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 30,
            font = myApp.fontBold,
            onRelease = function () myApp.showSubScreen ({instructions=agentpagelink}) end,
         }
       agentbackButton.y = 150

container:insert(agentbackButton)

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
function scene:specialFunction( event )
 
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene