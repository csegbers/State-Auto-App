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
local container
local myList
local runit  
local justcreated  
local myMap
local myDesc


  ------------------------------------------------------
  -- Row is rendered
  ------------------------------------------------------
local  onRowRender = function ( event )

         --Set up the localized variables to be passed via the event table

         local row = event.row
         local id = row.index
         local params = event.row.params
         print ("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" .. params.name)

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

------------------------------------------------------
-- Row is touched
------------------------------------------------------
local onRowTouch = function ( event )

--     local agentpagelink =  myApp.locateanagent.agentinfo 
--     local parentinfo =  params 
--     agentpagelink.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback=agentpagelink.navigation.composer.effectback}) end
--     local agentbackButton = widget.newButton {
--         label = agentpagelink.title ,
--         labelColor = { default={ 0, 1, 1 }, over={ 0, 0, 0, 0.5 } },
--         fontSize = 30,
--         font = myApp.fontBold,
--         onRelease = function () myApp.showSubScreen ({instructions=agentpagelink}) end,
--      }
--    agentbackButton.y = 150

-- container:insert(agentbackButton)



end


local function markerListener( event )
    print("type: ", event.type) -- event type
    print("markerId: ", event.markerId) -- id of the marker that was touched
    print("lat: ", event.latitude) -- latitude of the marker
    print("long: ", event.longitude) -- longitude of the marker
end

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)
 
    print ("Create  " .. currScene)
    justcreated = true
    local group = self.view
    params = event.params           -- params contains the item table  
     
    container  = common.SceneContainer()
    group:insert(container )

     ---------------------------------------------
     -- Header group
     ---------------------------------------------

     local itemGrp = display.newGroup(  )
     local startX = 0
     local startY = 0 -myApp.cH/2 + myApp.locate.groupheight/2  + myApp.sceneStartTop

     local groupwidth = myApp.sceneWidth-myApp.locate.edge
     local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.locate.textfontsize})
     local textHeightSingleLine = dumText.height
     
     -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(startX, startY , groupwidth-myApp.locate.groupstrokewidth*2,myApp.locate.groupheight, 1 )
     myRoundedRect:setFillColor(myApp.locate.groupbackground.r,myApp.locate.groupbackground.g,myApp.locate.groupbackground.b,myApp.locate.groupbackground.a )
     itemGrp:insert(myRoundedRect)

     local startYother = startY- myApp.locate.groupheight/2  

     -------------------------------------------------
     -- Desc text
     -------------------------------------------------
     myDesc = display.newText( {text="", x=startX , y=0, height=0,width=groupwidth-myApp.locate.edge*2 ,font= myApp.fontBold, fontSize=myApp.locate.textfontsize,align="center" })
     myDesc.y=myRoundedRect.y --startYother+myApp.locate.groupheight - (myDesc.height) -  myApp.locate.textbottomedge
     myDesc:setFillColor( myApp.locate.textcolor.r,myApp.locate.textcolor.g,myApp.locate.textcolor.b,myApp.locate.textcolor.a )
     itemGrp:insert(myDesc)

     container:insert(itemGrp)

    ------------------------------------------------------
    -- Table View
    ------------------------------------------------------
    myList = widget.newTableView {
           x=0,
           y= myApp.cH/2 -  myApp.locate.tableheight/2 - myApp.tabs.tabBarHeight-myApp.locate.edge, 
           width = myApp.sceneWidth-myApp.locate.edge, 
           height = myApp.locate.tableheight,
           onRowRender = onRowRender,
           onRowTouch = onRowTouch,
           listener = scrollListener,
        }
     container:insert(myList )

end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)
    ----------------------------------
    -- Will Show
    ----------------------------------
    if ( phase == "will" ) then

        ----------------------------
        -- params at this point contains prior
        -- KEEP IT THAT WAY !!!!!
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        -- Called when the scene is still off screen (but is about to come on screen).
        runit = true
        if params and justcreated == false then
          if  params.navigation.composer then
             if params.navigation.composer.id == event.params.navigation.composer.id then
               runit = false
             end
          end
        end
        if (runit or justcreated) then  myList:deleteAllRows() end
        ----------------------------
        -- now go ahead
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        params = event.params           -- params contains the item table 

        ---------------------------------------
        -- upodate the desc
        ---------------------------------------
        myDesc.text = params.locateinfo.desc

    ----------------------------------
    -- Did Show
    ----------------------------------
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
        
        print(params.locateinfo.lat .." " .. params.locateinfo.lng  .. " " .. params.locateinfo.limit .. " " .. params.locateinfo.miles ) 

        if common.testNetworkConnection() and (runit or justcreated) then
           native.setActivityIndicator( true )

           myMap = native.newMapView( 0, -50, myApp.sceneWidth-myApp.locate.edge , 250 ) 
           myMap.mapType = myApp.locate.type -- other mapType options are "satellite" or "hybrid"

          -- The MapView is just another Corona display object, and can be moved or rotated, etc.
           myMap.x = display.contentCenterX
           myMap.y = display.contentCenterY

           myMap:setCenter( params.locateinfo.lat, params.locateinfo.lng, false )
           myMap:setRegion( params.locateinfo.lat, params.locateinfo.lng, myApp.locate.map.latitudespan, myApp.locate.map.longitudespan, false)


           parse:run(params.locateinfo.functionname,{["lat"] = params.locateinfo.lat , ["lng"] = params.locateinfo.lng ,["limit"] = params.locateinfo.limit, ["miles"] = params.locateinfo.miles}, function(e) native.setActivityIndicator( false ) if not e.error then  

                  for i = 1, #e.response.result do
                      print("NAME" .. e.response.result[i][params.locateinfo.mapping.name])

                     myList:insertRow{
                        rowHeight = myApp.locate.row.height,
                        isCategory = false,
                        rowColor = { 1, 1, 1 },
                        lineColor = { 220/255 },

                         params = {
                           name = e.response.result[i][params.locateinfo.mapping.name],
                           miles = e.response.result[i][params.locateinfo.mapping.miles],
                                  }
                        }

                      local options = { 
                        title=e.response.result[i][params.locateinfo.mapping.name], 
                        subtitle="Subtitle", 
                        --imageFile = 
                       -- {
                        --    filename = "images/coronamarker.png",
                         --   baseDir = system.ResourcesDirectory
                        --},
                          listener=markerListener 
                      }
                      print ("JHIUHIHIUHUI" .. e.response.result[i][params.locateinfo.mapping.geo].latitude)
                      myMap:addMarker( e.response.result[i][params.locateinfo.mapping.geo].latitude, e.response.result[i][params.locateinfo.mapping.geo].longitude, options )

                     

                  end
                  if #e.response.result > 0 then myList:scrollToIndex( 1 ) end

            end end )
        end
        justcreated = false

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
        if myMap and myMap.removeSelf then
          myMap:removeSelf()
          myMap = nil
        end
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