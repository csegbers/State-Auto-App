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
local container
local myList
local runit  
local justcreated  
local myMap
local myName
local myAddress
local itemGrp
local myObject     -- response object from the services call or nil if no hit
local objectgroup -- pointer to the mappings stuff
local curitemGrpy  
local curmyListy 

------------------------------------------------------
-- Row is rendered
------------------------------------------------------
local  onRowRender = function ( event )

         --Set up the localized variables to be passed via the event table

         local row = event.row
         local id = row.index
         local params = event.row.params

         if ( event.row.params ) then    
 
            row.titleText = display.newText( myApp.objecttypes[params.fieldtype].title, 0, 0, myApp.fontBold, myApp.locatedetails.row.titletextfontsize )
            row.titleText.anchorX = 0
            row.titleText.anchorY = 0.5
            row.titleText:setFillColor( myApp.locatedetails.row.titletextcolor )
            row.titleText.y = myApp.locatedetails.row.titletexty
            row.titleText.x = myApp.locatedetails.row.titletextx

            row.descText = display.newText( params.value, 0, 0, myApp.fontBold, myApp.locatedetails.row.desctextfontsize )
            row.descText.anchorX = 0
            row.descText.anchorY = 0.5
            row.descText:setFillColor( myApp.locatedetails.row.desctextColor )
            row.descText.y = myApp.locatedetails.row.desctexty
            row.descText.x = myApp.locatedetails.row.desctextx


            row:insert( row.titleText )
            row:insert( row.descText )

             -------------------------------------------------
             -- Icon ?
             -------------------------------------------------

            local iconimage = myApp.objecttypes[params.fieldtype].pic
            if iconimage then
                 row.myIcon = display.newImageRect(myApp.imgfld .. iconimage,  myApp.locatedetails.row.iconwidth , myApp.locatedetails.row.iconheight )
                 common.fitImage( row.myIcon,  myApp.locatedetails.row.iconwidth   )
                 row.myIcon.y = myApp.locatedetails.row.height / 2
                 row.myIcon.x = myApp.locatedetails.row.iconwidth/2 + myApp.locatedetails.edge
                 row:insert( row.myIcon )
            end


         end
         return true
end
 
------------------------------------------------------
-- what launch object ?
------------------------------------------------------
local onRowTouch = function( event )
        local row = event.row
        local params = row.params
        local obgroup = myApp.objecttypes[row.params.fieldtype]
        local navgroup = obgroup.navigation

        -----------------------
        -- center the map if we got off wack
        ------------------------
        if navgroup.directions  then
            if myMap and myObject then myMap:setCenter( myObject[objectgroup.mapping.geo].latitude, myObject[objectgroup.mapping.geo].longitude ,true ) end
        end
        
        if event.phase == "press"  then     

        elseif event.phase == "tap" then
              
        elseif event.phase == "swipeLeft" then

        elseif event.phase == "swipeRight" then
 
        elseif event.phase == "release" then


           if navgroup then
               -----------------------------
               -- launching "external ? ""
               ---------------------------- 
               if navgroup.directions then  
                   myApp.navigationCommon ({launch = obgroup.launch, navigation = { directions = { address=string.format( (navgroup.directions.address or ""),  row.params.fulladdress )},},} )
               else 
                   if navgroup.popup then 
                     myApp.navigationCommon ({launch = obgroup.launch, navigation = { popup = { type = navgroup.popup.type, options ={to=string.format( (navgroup.popup.options.to or ""),  row.params.value )},},} ,})
                   else
                       if navgroup.systemurl then 
                          myApp.navigationCommon( {launch = obgroup.launch, navigation = { systemurl = { url=string.format( (navgroup.systemurl.url or ""),  row.params.value )},},} )
                       else
                            if navgroup.composer then
                                local locatelaunch =                          
                                     {
                                        title = obgroup.title, 
                                        text=myName.text,
                                        backtext = obgroup.backtext ,
                                        forwardtext = obgroup.forwardtext ,
                                        pic=obgroup.pic,
                                        -- htmlinfo = { 
                                        --               url=row.params.value ,
                                        --            },
                                        sceneinfo = obgroup.sceneinfo,
                                        navigation = 
                                         { 
                                            composer = 
                                                { 
                                                   id = row.params.value ,
                                                   lua=navgroup.composer.lua,
                                                   time=navgroup.composer.time, 
                                                   effect=navgroup.composer.effect,
                                                   effectback=navgroup.composer.effectback,              
                                                }
                                        ,}
                                    ,}
                                 locatelaunch.sceneinfo.htmlinfo.url =  row.params.value   
                                 local parentinfo =  sceneparams 
                                 locatelaunch.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
                                 myApp.showSubScreen ({instructions=locatelaunch})
                            end   -- if composer
                       end  -- if systemurl
                   end   -- popup
               end -- directions
           end   -- if navigation

            
        end
    return true
end


------------------------------------------------------
-- The map. centered and marked for the 1 item
------------------------------------------------------
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
    sceneparams = event.params            
     
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
     local myRoundedRect = display.newRoundedRect(startX, startY , groupwidth-myApp.locatedetails.groupstrokewidth*2,myApp.locatedetails.groupheight, myApp.locatedetails.cornerradius )
     myRoundedRect:setFillColor(myApp.locatedetails.groupbackground.r,myApp.locatedetails.groupbackground.g,myApp.locatedetails.groupbackground.b,myApp.locatedetails.groupbackground.a )
     itemGrp:insert(myRoundedRect)

     local startYother = startY- myApp.locatedetails.groupheight/2  

     -------------------------------------------------
     -- Name text - will be set in show
     -------------------------------------------------
     myName = display.newText( {text="", x=startX , y=0, height=0,width=groupwidth-myApp.locatedetails.edge*2 ,font= myApp.fontBold, fontSize=myApp.locatedetails.textfontsize,align="left" })
     --myName.y=myRoundedRect.y --startYother+myApp.locatedetails.groupheight - (myName.height) -  myApp.locatedetails.textbottomedge
     myName.anchorY = 0
     myName.y = myRoundedRect.y - myRoundedRect.height/2 + myApp.locatedetails.edge/2
     myName:setFillColor( myApp.locatedetails.textcolor.r,myApp.locatedetails.textcolor.g,myApp.locatedetails.textcolor.b,myApp.locatedetails.textcolor.a )
     itemGrp:insert(myName)

     -------------------------------------------------
     -- address text - will be set in show
     -------------------------------------------------
     myAddress = display.newText( {text="", x=startX , y=0, height=0,width=groupwidth-myApp.locatedetails.edge*2 ,font= myApp.fontBold, fontSize=myApp.locatedetails.textfontsizeaddress,align="left" })
     myAddress.anchorY = 0
     myAddress.y = 0 -- myRoundedRect.y - myRoundedRect.height/2 + myApp.locatedetails.edge/2
     myAddress:setFillColor( myApp.locatedetails.textcoloraddress.r,myApp.locatedetails.textcoloraddress.g,myApp.locatedetails.textcoloraddress.b,myApp.locatedetails.textcoloraddress.a )
     itemGrp:insert(myAddress)

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
        -- sceneparams at this point contains prior
        -- KEEP IT THAT WAY !!!!!
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        -- Called when the scene is still off screen (but is about to come on screen).
        runit = true
        if sceneparams and justcreated == false then
          if  sceneparams.navigation.composer then
             if sceneparams.navigation.composer.id == event.params.navigation.composer.id then
               runit = false
             end
          end
        end
        ------------------------------------------------
        -- clear thing out for this luanhc
        ------------------------------------------------
        if (runit or justcreated) then 
            myObject = nil
            myName.text = ""  
            myAddress.text = ""  
            myList:deleteAllRows()
            if myApp.locatedetails.animation then
               curitemGrpy = itemGrp.y
               curmyListy = myList.y
               itemGrp.y = itemGrp.y - itemGrp.height
               myList.y = myList.y + myList.height
            end
        end
        ----------------------------
        -- now go ahead
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        sceneparams = event.params            

    ----------------------------------
    -- Did Show
    ----------------------------------
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
        objectgroup = myApp.mappings.objects[sceneparams.objecttype]     
        print(sceneparams.objecttype .." " .. sceneparams.objectqueryvalue    ) 

        if common.testNetworkConnection()  then
           -----------------------------------
           -- always do the map even if criteria is same since it gets destrpyed every scene change
           ------------------------------------
           native.setActivityIndicator( true )

           if (runit or justcreated) then
               --debugpopup ("looking for " .. sceneparams.objecttype .." " .. sceneparams.objectqueryvalue)
               parse:run(objectgroup.functionname.details,
                   {
                      [objectgroup.mapping.id] =  sceneparams.objectqueryvalue,  
                   },
                   ------------------------------------------------------------
                   -- Callback inline function
                   ------------------------------------------------------------
                   function(e) 
                      if not e.error then  
                          local haveitems = false
                          if #e.response.result > 0 then
                              myObject = e.response.result[1]
                              print("NAME" .. myObject[objectgroup.mapping.name])
                              myName.text = myObject[objectgroup.mapping.name]
                              myAddress.text = (myObject[objectgroup.mapping.street] or "") .. "\n" .. (myObject[objectgroup.mapping.city] or "") .. ", " .. (myObject[objectgroup.mapping.state] or "") .. " " .. (myObject[objectgroup.mapping.zip] or "") 
                              myAddress.y = myName.y+ myName.height  
                              if myApp.locatedetails.animation then
                                  transition.to(  itemGrp, { time=myApp.locatedetails.animationtime, y = curitemGrpy , transition=easing.outQuint})
                                  transition.to(  myList, { time=myApp.locatedetails.animationtime, y = curmyListy , transition=easing.outQuint})
                              end
                              ---------------------------------------------
                              -- Sort (key is critical !!)
                              -- what laucnh objects are availble ? See if those fields came down via the service.
                              -- they may not always exist
                              --------------------------------------------- 
                              local a = {}
                              for n in pairs(objectgroup.launchobjects) do table.insert(a, n) end
                              table.sort(a)


                              local insertObject = function ( rowparms )
                                    haveitems = true
                                    myList:insertRow{
                                      rowHeight = myApp.locatedetails.row.height,
                                      isCategory = false,
                                      rowColor = myApp.locatedetails.row.rowColor,
                                      lineColor = myApp.locatedetails.row.lineColor,

                                      params = rowparms, --{
                                                  -- fieldtype = rowparms.fieldtype,  -- will point to object table
                                                 --  desc = rowparms.desc,      -- actual field vale
                                               -- }  -- params
                                      }   --myList:insertRow
                              end

                              ---------------------------------------------
                              -- Generate a get directions row ?
                              --------------------------------------------- 
                              if myApp.locatedetails.row.includedirections then
                                 local address = (myObject[objectgroup.mapping.street] or "") .. " " .. (myObject[objectgroup.mapping.city] or "") .. ", " .. (myObject[objectgroup.mapping.state] or "")   --.. " " .. (myObject[objectgroup.mapping.zip] or ""
                                 local addresswithzip = address .. " " .. (myObject[objectgroup.mapping.zip] or "")
                                 insertObject({
                                        fieldtype = "directions",
                                        value = address, 
                                        fulladdress = addresswithzip,
                                        })
                              end

                              ---------------------------------------------
                              -- Generate the rows for potential object launches like phne email
                              --------------------------------------------- 
                              for i,k in ipairs(a) do 
                                  ---------------------------
                                  -- is the field there  in the response?
                                  ---------------------------
                                  if myObject[objectgroup.launchobjects[k].field] then  
                                     insertObject({fieldtype = objectgroup.launchobjects[k].type,value = myObject[objectgroup.launchobjects[k].field], })
                                  end   -- does field exist
                              end   --loop



                          end  -- end of results >0

                          if haveitems then 
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
       return sceneparams
end

---------------------------------------------------
-- if an overlay is happening to us
-- type (hide show)
-- phase (will did)
---------------------------------------------------
function scene:overlay( parms )
     print ("overlay happening on top of " .. currScene .. " " .. parms.type .. " " .. parms.phase)
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