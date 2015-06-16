---------------------------------------------------------------------------------------
-- Login Overlay scene
---------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 
local common = require( myApp.utilsfld .. "common" )

local login = require( myApp.classfld .. "classlogin" )

local currScene = "login"
print ("Inxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " .. currScene .. " Scene")

local sceneparams
local container
local cancelButton

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
--
-- self.view -> Container -> SCrollvew
------------------------------------------------------
function scene:create(event)
    print ("Create  " .. currScene)


end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)
    sceneparams = event.params   or {}         -- params contains the item table 

    -----------------------------
    -- call incase the parent needs to do any action
    ------------------------------
    pcall(function() event.parent:overlay({type="show",phase = phase,time=sceneparams.navigation.composer.time } ) end)
 

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).


            local sceneinfo = myApp.otherscenes.login.sceneinfo

            display.remove( container )           -- wont exist initially no biggie
            container = nil
            
            container = display.newContainer(myApp.sceneWidth-sceneinfo.edge*2,sceneinfo.height)
            container.y = myApp.sceneStartTop + container.height / 2 + sceneinfo.edge
            container.x = myApp.cW / 2


            local background = display.newRoundedRect(0, 0 ,container.width -sceneinfo.edge/2,container.height -sceneinfo.edge/2 , sceneinfo.cornerradius)
            background.strokeWidth = sceneinfo.strokewidth
            background:setStrokeColor( sceneinfo.strokecolor.r,sceneinfo.strokecolor.g,sceneinfo.strokecolor.b,sceneinfo.strokecolor.a )
            background:setFillColor(sceneinfo.groupbackground.r,sceneinfo.groupbackground.g,sceneinfo.groupbackground.b,sceneinfo.groupbackground.a)


            container:insert(background)

             -------------------------------------------------
             -- Header text
             -------------------------------------------------
             local myText = display.newText({text="Email Address", font= myApp.fontBold, fontSize=sceneinfo.textfontsize,align="left" })
             myText:setFillColor( sceneinfo.textcolor.r,sceneinfo.textcolor.g,sceneinfo.textcolor.b,sceneinfo.textcolor.a )
             myText.anchorX = 0
             myText.anchorY = 0
             myText.x = background.x - background.width/2 + sceneinfo.edge/2
             myText.y = background.y - background.height/2 + sceneinfo.edge/2
            -- myText.x = container.height / 2
             container:insert(myText)

             ---------------------------------------------
             -- Cancel button
             ---------------------------------------------
             cancelButton = widget.newButton {
                    shape=sceneinfo.btnshape,
                    fillColor = { default={ sceneinfo.btncanceldefcolor.r,  sceneinfo.btncanceldefcolor.g, sceneinfo.btncanceldefcolor.b, sceneinfo.btncanceldefcolor.a}, over={ sceneinfo.btncancelovcolor.r, sceneinfo.btncancelovcolor.g, sceneinfo.btncancelovcolor.b, sceneinfo.btncancelovcolor.a } },
                    label = sceneinfo.btncanceltext,
                    labelColor = { default={ sceneinfo.btncanceldeflabelcolor.r,  sceneinfo.btncanceldeflabelcolor.g, sceneinfo.btncanceldeflabelcolor.b, sceneinfo.btncanceldeflabelcolor.a}, over={ sceneinfo.btncancelovlabelcolor.r, sceneinfo.btncancelovlabelcolor.g, sceneinfo.btncancelovlabelcolor.b, sceneinfo.btncancelovlabelcolor.a } },
                    fontSize = sceneinfo.btnfontsize,
                    font = myApp.fontBold,
                    width = sceneinfo.btnwidth,
                    height = sceneinfo.btnheight,
                    ---------------------------------
                    -- stick inside a time to prevent the buton press from passing thru to the current scene
                    ---------------------------------
                    onRelease = function() timer.performWithDelay(10,function () myApp.hideOverlay({callback=nill}) end)  return true end,

                  }
               cancelButton.anchorX = 0
               cancelButton.anchorY = 0
               cancelButton.x = myText.x  
               cancelButton.y = background.y + background.height/2 - sceneinfo.btnheight - sceneinfo.edge/2   -- background uses .5 anchor
               --debugpopup (background.y .. " " .. background.height)
               container:insert(cancelButton)


             ---------------------------------------------
             -- Login button
             ---------------------------------------------
             loginButton = widget.newButton {
                    shape=sceneinfo.btnshape,
                    fillColor = { default={ sceneinfo.btnlogindefcolor.r,  sceneinfo.btnlogindefcolor.g, sceneinfo.btnlogindefcolor.b, sceneinfo.btnlogindefcolor.a}, over={ sceneinfo.btnloginovcolor.r, sceneinfo.btnloginovcolor.g, sceneinfo.btnloginovcolor.b, sceneinfo.btnloginovcolor.a } },
                    label = sceneinfo.btnlogintext,
                    labelColor = { default={ sceneinfo.btnlogindeflabelcolor.r,  sceneinfo.btnlogindeflabelcolor.g, sceneinfo.btnlogindeflabelcolor.b, sceneinfo.btnlogindeflabelcolor.a}, over={ sceneinfo.btnloginovlabelcolor.r, sceneinfo.btnloginovlabelcolor.g, sceneinfo.btnloginovlabelcolor.b, sceneinfo.btnloginovlabelcolor.a } },
                    fontSize = sceneinfo.btnfontsize,
                    font = myApp.fontBold,
                    width = sceneinfo.btnwidth,
                    height = sceneinfo.btnheight,
                    ---------------------------------
                    -- stick inside a time to prevent the buton press from passing thru to the current scene
                    ---------------------------------
                    onRelease = function() timer.performWithDelay(10,function () myApp.hideOverlay({callback=nill}) end)  return true end,

                  }
               loginButton.anchorX = 0
               loginButton.anchorY = 0
               loginButton.x = background.x + background.width/2  - sceneinfo.btnwidth - sceneinfo.edge/2 
               loginButton.y = background.y + background.height/2 - sceneinfo.btnheight - sceneinfo.edge/2   -- background uses .5 anchor
               --debugpopup (background.y .. " " .. background.height)
               container:insert(loginButton)

               group:insert(container)




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

    -----------------------------
    -- call incase the parent needs to do any action
    ------------------------------
    pcall(function() event.parent:overlay({type="hide",phase = phase,time=sceneparams.navigation.composer.time } ) end)
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
       return sceneparams
end
---------------------------------------------------
-- use if someone wants us to transition away
-- for navigational appearnaces
-- used from the more button
---------------------------------------------------
function scene:morebutton( parms )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene