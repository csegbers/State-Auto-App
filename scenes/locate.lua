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


local function onRowRender( event )

   --Set up the localized variables to be passed via the event table

   local row = event.row
   local id = row.index
   local params = event.row.params

   -- row.bg = display.newRect( 0, 0, display.contentWidth, 60 )
   -- row.bg.anchorX = 0
   -- row.bg.anchorY = 0
   -- row.bg:setFillColor( 1, 1, 1 )
   -- row:insert( row.bg )

   if ( event.row.params ) then    
      row.nameText = display.newText( params.name, 10, 0, native.systemFontBold, 14 )
      row.nameText.anchorX = 0
      row.nameText.anchorY = 0.5
      row.nameText:setFillColor( 0 )
      row.nameText.y = 20
      row.nameText.x = 42

      row.milesText = display.newText( "Miles: " .. string.format( '%.2f', params.miles ), 10, 0, native.systemFont, 14 )
      row.milesText.anchorX = 0
      row.milesText.anchorY = 0.5
      row.milesText:setFillColor( 0.5 )
      row.milesText.y = 40
      row.milesText.x = 42

    row.rightArrow = display.newImageRect(myApp.icons, 15 , 40, 40)
    row.rightArrow.x = display.contentWidth - 20
    row.rightArrow.y = row.height / 2
      -- row.rightArrow = display.newImageRect( "rightarrow.png", 15 , 40, 40 )
      -- row.rightArrow.x = display.contentWidth - 20
      -- row.rightArrow.y = row.height / 2

      row:insert( row.nameText )
      row:insert( row.milesText )
      row:insert( row.rightArrow )
   end
   return true
end



    if common.testNetworkConnection() then
       native.setActivityIndicator( true )
       parse:run(params.locateinfo.functionname,{["lat"] = myApp.gps.event.latitude, ["lng"] = myApp.gps.event.longitude,["limit"] = params.locateinfo.limit, ["miles"] = params.locateinfo.miles}, function(e) native.setActivityIndicator( false ) if not e.error then  


local myList = widget.newTableView {
   x = 0 ,
   y = 0, 

   width = myApp.sceneWidth, 
   height = myApp.sceneHeight/3 ,
   onRowRender = onRowRender,
   onRowTouch = onRowTouch,
   listener = scrollListener,
 
}
container:insert(myList )
 

for i = 1, #e.response.result do
    print("AGCNY NAME" .. e.response.result[i].agencyName)
   myList:insertRow{
      rowHeight = 50,
      isCategory = false,
      rowColor = { 1, 1, 1 },
      lineColor = { 220/255 },

            params = {
         name = e.response.result[i].agencyName,
         miles = e.response.result[i].milesTo,
      }
   }

end


        end end )
    end




 



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
        params = event.params           -- params contains the item table 

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