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

local sceneparams

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    local group = self.view
    sceneparams = event.params or {}

    local container  = common.SceneContainer()
    group:insert(container )

     -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(0,0,90,130, 1 )
     myRoundedRect:setFillColor(myApp.homepage.groupbackground.r,myApp.homepage.groupbackground.g,myApp.homepage.groupbackground.b,myApp.homepage.groupbackground.a )
     container:insert(myRoundedRect)



        -- local debuglink = common.DeepCopy({
        --                      title = "Dbug Info", 
        --                      backtext = "<",
        --                      groupheader = { r=53/255, g=48/255, b=102/255, a=1 },
        --                      composer = {
        --                                  lua="debugapp",
        --                                  time=250, 
        --                                  effect="slideLeft",
        --                                  effectback="slideRight",
        --                               },
        --                          })

        -- local parentinfo = common.DeepCopy(params)
                local debuglink = {
                             title = "Dbug Info", 
                             backtext = "<",
                             groupheader = { r=53/255, g=48/255, b=102/255, a=1 },
                             navigation = { composer = {
                                         lua="debugapp",
                                         time=250, 
                                         effect="slideLeft",
                                         effectback="slideRight",
                                      },
                                    },
                                 } 

        local parentinfo =  sceneparams 
        debuglink.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
        local debugbackButton = widget.newButton {
            label = "Debug Link" ,
            labelColor = { default={ 0, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 30,
            font = myApp.fontBold,
            onRelease = function () myApp.showSubScreen ({instructions=debuglink}) end,
         }
       debugbackButton.y = 150
       container:insert(debugbackButton)

end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        sceneparams = event.params           -- params contains the item table 
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
function scene:myparams( event )
       return sceneparams
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene