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
local webView

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    local group = self.view
    params = event.params or {}

end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)
    params = event.params or {}

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
            parse:logEvent( "Scene", { ["name"] = currScene} )
            params = event.params           -- params contains the item table 

            local function webListener( event )
                if event.type == "loaded" then
                    webView.isVisible = true
                    webView:removeEventListener( "urlRequest", webListener)
                    native.setActivityIndicator( false )
                end
            end

            
            webView = native.newWebView( myApp.sceneWidth / 2, myApp.sceneHeight  /2 + myApp.sceneStartTop,myApp.sceneWidth,myApp.sceneHeight -200)
            webView.isVisible = false
            --webView:reload()
            webView:addEventListener( "urlRequest", webListener )
            if params.htmlinfo.url then
                native.setActivityIndicator( true )
                webView:request( params.htmlinfo.url )
            else
                webView:request( myApp.htmlfld .. params.htmlinfo.htmlfile , params.htmlinfo.dir )
            end



----------------------------------------------------------
--   right side more button
----------------------------------------------------------
       backbutton = widget.newButton {
                    defaultFile = myApp.imgfld .. myApp.moreinfo.morebutton.defaultFile,
                    overFile = myApp.imgfld .. myApp.moreinfo.morebutton.overFile ,
                    height = myApp.tabs.tabbtnh,
                    width = myApp.tabs.tabbtnw,
                    x = myApp.sceneWidth - myApp.tabs.tabbtnw/2 - myApp.titleBarEdge  ,
                    y = (myApp.titleBarHeight * 0.5 )  + myApp.tSbch + 100 ,
                    --onRelease = function() if myApp.moreinfo.imsliding == false then myApp.MoreInfoMove() end end,
               }

      group:insert(backbutton )


      --         row.rightArrow = display.newImageRect(myApp.icons, 15 , 40, 40)
      -- row.rightArrow.x = display.contentWidth - 20
      --  row.rightArrow.y = row.height / 2

    end
	

end

function scene:hide( event )
    local group = self.view
    local phase = event.phase
    print ("Hide:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        if webView and webView.removeSelf then
            native.setActivityIndicator( false )     -- just incase
            webView:removeSelf()
            webView = nil
        end
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
       return params
end

---------------------------------------------------
-- use if someone wants us to transition away
-- for navigational appearnaces
-- used from the more button
---------------------------------------------------
function scene:movebutton( parms )
 
     transition.to(  webView, {  time=parms.time,delta=true, x = parms.x , transition=parms.transition})

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene