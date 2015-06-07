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
local itemGrp
local myObject     -- response object from the services call or nil if no hit
local objectgroup -- pointer to the mappings stuff


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
            row.nameText = display.newText( params.name, 0, 0, myApp.fontBold, myApp.locatedetails.row.nametextfontsize )
            row.nameText.anchorX = 0
            row.nameText.anchorY = 0.5
            row.nameText:setFillColor( myApp.locatedetails.row.nametextColor )
            row.nameText.y = myApp.locatedetails.row.nametexty
            row.nameText.x = myApp.locatedetails.row.nametextx

            --local addressline = (params.street or "") .. "\n" .. (params.city or "") .. ", " .. (params.state or "") .. " " .. (params.zip or "") 
            row.addressText = display.newText( params.address, 0, 0, row.width / 2,0,myApp.fontBold, myApp.locatedetails.row.addresstextfontsize  )
            row.addressText.anchorX = 0
            row.addressText.anchorY = 0.5
            row.addressText:setFillColor( myApp.locatedetails.row.addressColor )
            row.addressText.y = myApp.locatedetails.row.addresstexty
            row.addressText.x = myApp.locatedetails.row.addresstextx

            row.rightArrow = display.newImageRect(myApp.icons, 15 , myApp.locatedetails.row.arrowwidth, myApp.locatedetails.row.arrowheight)
            row.rightArrow.x = row.width - myApp.locatedetails.row.arrowwidth/2
            row.rightArrow.y = row.height / 2

            row:insert( row.nameText )
            row:insert( row.addressText )
            row:insert( row.rightArrow )
         end
         return true
end
 


local onRowTouch = function( event )
        local row = event.row
        if myMap then myMap:setCenter( row.params.lat, row.params.lng ,true ) end
        
        if event.phase == "press"  then     

                print ("press")
        elseif event.phase == "tap" then
               print ("tap")
        elseif event.phase == "swipeLeft" then

               print ("sl")
        elseif event.phase == "swipeRight" then
               print ("sr")
 
        elseif event.phase == "release" then
               print ("release")
  
            -- force row re-render on next TableView update
            
        end
    return true
end


local function buildMap( event )
      native.setActivityIndicator( true ) 

      local mapheight = myApp.sceneHeight-myList.height-itemGrp.height-myApp.locatedetails.edge*2
      myMap = native.newMapView( 0, 0, myApp.sceneWidth-myApp.locatedetails.edge , mapheight  )   -- cause
      if myMap and myObject then
         myMap.mapType = myApp.locatedetails.map.type -- other mapType options are "satellite" or "hybrid"

      -- The MapView is just another Corona display object, and can be moved or rotated, etc.
         myMap.x = myApp.cCx
         myMap.y = myApp.sceneStartTop + itemGrp.height  + myApp.locatedetails.edge+ mapheight/2 + myApp.locatedetails.edge/2

         myMap:setCenter( myObject[objectgroup.mapping.geo].latitude, myObject[objectgroup.mapping.geo].longitude, false )
         myMap:setRegion( myObject[objectgroup.mapping.geo].latitude, myObject[objectgroup.mapping.geo].longitude, myApp.locatedetails.map.latitudespan, myApp.locatedetails.map.longitudespan, false)
      
         local options = { 
                  title=myObject[objectgroup.mapping.name], 
                  subtitle=(myObject[objectgroup.mapping.street] or "") .. " " .. (myObject[objectgroup.mapping.city] or "") .. ", " .. (myObject[objectgroup.mapping.state] or "") .. " " .. (myObject[objectgroup.mapping.zip] or "") , 
                   }
         myMap:addMarker( myObject[objectgroup.mapping.geo].latitude, myObject[objectgroup.mapping.geo].longitude, options )
      end
      native.setActivityIndicator( false ) 
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
     -- text gets set in Show evvent
     ---------------------------------------------

     itemGrp = display.newGroup(  )
     local startX = 0
     local startY = 0 -myApp.cH/2 + myApp.locatedetails.groupheight/2  + myApp.sceneStartTop

     local groupwidth = myApp.sceneWidth-myApp.locatedetails.edge
     local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.locatedetails.textfontsize})
     local textHeightSingleLine = dumText.height
     
     -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(startX, startY , groupwidth-myApp.locatedetails.groupstrokewidth*2,myApp.locatedetails.groupheight, 1 )
     myRoundedRect:setFillColor(myApp.locatedetails.groupbackground.r,myApp.locatedetails.groupbackground.g,myApp.locatedetails.groupbackground.b,myApp.locatedetails.groupbackground.a )
     itemGrp:insert(myRoundedRect)

     local startYother = startY- myApp.locatedetails.groupheight/2  

     -------------------------------------------------
     -- Desc text
     -------------------------------------------------
     myDesc = display.newText( {text="", x=startX , y=0, height=0,width=groupwidth-myApp.locatedetails.edge*2 ,font= myApp.fontBold, fontSize=myApp.locatedetails.textfontsize,align="left" })
     myDesc.y=myRoundedRect.y --startYother+myApp.locatedetails.groupheight - (myDesc.height) -  myApp.locatedetails.textbottomedge
     myDesc:setFillColor( myApp.locatedetails.textcolor.r,myApp.locatedetails.textcolor.g,myApp.locatedetails.textcolor.b,myApp.locatedetails.textcolor.a )
     itemGrp:insert(myDesc)

     container:insert(itemGrp)

    ------------------------------------------------------
    -- Table View
    ------------------------------------------------------
    myList = widget.newTableView {
           x=0,
           y= myApp.cH/2 -  myApp.locatedetails.tableheight/2 - myApp.tabs.tabBarHeight-myApp.locatedetails.edge, 
           width = myApp.sceneWidth-myApp.locatedetails.edge, 
           height = myApp.locatedetails.tableheight,
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
        ------------------------------------------------
        -- clear thing out for this luanhc
        ------------------------------------------------
        if (runit or justcreated) then 
            myObject = nil
            myDesc.text = ""  
            myList:deleteAllRows()
        end
        ----------------------------
        -- now go ahead
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        params = event.params           -- params contains the item table 

    ----------------------------------
    -- Did Show
    ----------------------------------
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
        objectgroup = myApp.mappings.objects[params.objecttype]     
        print(params.objecttype .." " .. params.objectqueryvalue    ) 

        if common.testNetworkConnection()  then
           -----------------------------------
           -- always do the map even if criteria is same since it gets destrpyed every scene change
           ------------------------------------
           native.setActivityIndicator( true )


           if (runit or justcreated) then
               --debugpopup ("looking for " .. params.objecttype .." " .. params.objectqueryvalue)
               parse:run(objectgroup.functionname.details,
                   {
                      [objectgroup.mapping.id] =  params.objectqueryvalue,  
                   },
                   ------------------------------------------------------------
                   -- Callback inline function
                   ------------------------------------------------------------
                   function(e) 
                      if not e.error then  
                          if #e.response.result > 0 then
                              myObject = e.response.result[1]
                              print("NAME" .. myObject[objectgroup.mapping.name])
                              myDesc.text = myObject[objectgroup.mapping.name]

                             myList:insertRow{
                                rowHeight = myApp.locatedetails.row.height,
                                isCategory = false,
                                rowColor = myApp.locatedetails.row.rowColor,
                                lineColor = myApp.locatedetails.row.lineColor,

                                params = {
                                             objectId = myObject.objectId,
                                             id = myObject[objectgroup.mapping.id],
                                             name = myObject[objectgroup.mapping.name],
                                             miles = myObject[objectgroup.mapping.miles],
                                             lat = myObject[objectgroup.mapping.geo].latitude,
                                             lng = myObject[objectgroup.mapping.geo].longitude,
                                             street = myObject[objectgroup.mapping.street],                           
                                             city = myObject[objectgroup.mapping.city],
                                             state = myObject[objectgroup.mapping.state],
                                             zip = myObject[objectgroup.mapping.zip],
                                             address = (myObject[objectgroup.mapping.street] or "") .. "\n" .. (myObject[objectgroup.mapping.city] or "") .. ", " .. (myObject[objectgroup.mapping.state] or "") .. " " .. (myObject[objectgroup.mapping.zip] or "") 

                                          }  -- params
                                }   --myList:insertRow

                          end  -- end of results >0

                          if #e.response.result > 0 then 
                            myList:scrollToIndex( 1 ) 
                          end
                      end  -- end of error check
                      -----------------------------------------------
                      -- always do when returned fro srvice call
                      ----------------------------------------------
                      native.setActivityIndicator( false ) 
                      buildMap()
                  end )  -- end of parse call
            else   -- else of runit or justcreated
                -----------------------------------------------
                -- always do the map even if same criteria coming in
                -----------------------------------------------
                native.setActivityIndicator( false )
                buildMap()     -- always need to do   even on same object
            end  -- end of runit or justcreated
        end    -- end of network connection check
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

---------------------------------------------------
-- use if someone wants us to transition away
-- for navigational appearnaces
-- used from the more button
---------------------------------------------------
function scene:morebutton( parms )
     transition.to(  myMap, {  time=parms.time,delta=true, x = parms.x , transition=parms.transition})
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene