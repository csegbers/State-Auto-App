---------------------------------------------------------------------------------------
-- emergecny scene
---------------------------------------------------------------------------------------
local myApp = require( "myapp" ) 
local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local widgetExtras = require( myApp.utilsfld .. "widget-extras" )
local myApp = require( "myapp" ) 

local parse = require( myApp.utilsfld .. "mod_parse" ) 
local common = require( myApp.utilsfld .. "common" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
print ("Inxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " .. currScene .. " Scene")

local sceneparams
local container
local itemGrp
local curlocButton
local addressButton

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    -- local group = self.view
    -- sceneparams = event.params or {}

end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
             --------------------------
             -- Setting params needed on the "Will" phase !!!!
             --------------------------
             sceneparams = event.params or {}          -- params contains the item table 
             -- Called when the scene is still off screen (but is about to come on screen).
             display.remove( container )           -- wont exist initially no biggie
             container = nil

             container  = common.SceneContainer()
             group:insert(container )

             ---------------------------------------------
             -- lets create the group
             ---------------------------------------------

             itemGrp = display.newGroup(  )
             local headcolor = sceneparams.groupheader or myApp.locatepre.groupheader
             local startX = 0
             local startY = 0 -myApp.cH/2 + myApp.locatepre.groupheight/2 + myApp.locatepre.edge*2 + myApp.sceneStartTop
             local groupwidth = myApp.sceneWidth-myApp.locatepre.edge*2
             local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize})
             local textHeightSingleLine = dumText.height

             local startYother = startY  
             -------------------------------------------------
             -- Icon ?
             -------------------------------------------------
             if sceneparams.pic then
                 local myIcon = display.newImageRect(myApp.imgfld .. "dial911.png",  myApp.locatepre.iconwidth *2,  myApp.locatepre.iconheight * 2 )
                 --common.fitImage( myIcon, sceneparams.iconwidth or myApp.locatepre.iconwidth   )
                 myIcon.x = startX
                 myIcon.y = startYother + itemGrp.height/2 - 20
                 itemGrp:insert(myIcon)
             end

             -- -------------------------------------------------
             -- -- Desc text
             -- -------------------------------------------------
             -- local myDesc = display.newText( {text=sceneparams.text, x=startX , y=0, height=0,width=groupwidth-myApp.locatepre.edge*2 ,font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize,align="center" })
             -- myDesc.y=startYother+myApp.locatepre.groupheight - (myDesc.height/2) -  myApp.locatepre.textbottomedge
             -- myDesc:setFillColor( myApp.locatepre.textcolor.r,myApp.locatepre.textcolor.g,myApp.locatepre.textcolor.b,myApp.locatepre.textcolor.a )
             -- itemGrp:insert(myDesc)

             container:insert(itemGrp)



             -------------------------------------------------
             -- Current loc button pressed return
             -------------------------------------------------

             local function launchLocateScene(inputparms) 
                      local locatelaunch = {  
                                         title = myApp.mappings.objects[sceneparams.sceneinfo.locateinfo.object].desc.plural , --sceneparams.title, 
                                         pic=sceneparams.pic,
                                         originaliconwidth = sceneparams.originaliconwidth,
                                         originaliconheight = sceneparams.originaliconheight,
                                         iconwidth = sceneparams.iconwidth,      -- height will be scaled appropriately
                                         text=sceneparams.text,
                                         backtext = sceneparams.backtext,
 
                                         locateinfo = {
                                                        desc = inputparms.desc,
                                                        functionname=myApp.mappings.objects[sceneparams.sceneinfo.locateinfo.object].functionname.locate,
                                                        limit=sceneparams.sceneinfo.locateinfo.limit,
                                                        miles=sceneparams.sceneinfo.locateinfo.miles,
                                                        object=sceneparams.sceneinfo.locateinfo.object,
                                                        lat = inputparms.lat,
                                                        lng = inputparms.lng,
                                                        mapping= myApp.mappings.objects[sceneparams.sceneinfo.locateinfo.object].mapping,
                                                      },
                                         navigation = { 
                                               composer = {
                                                              -- this id setting this way we will rerun if different than prior request either miles or lat.lng etc...
                                                             id = sceneparams.sceneinfo.locateinfo.object.."-" ..sceneparams.sceneinfo.locateinfo.miles.."-" .. sceneparams.sceneinfo.locateinfo.limit .."-".. inputparms.lat .."-".. inputparms.lng,   
                                                             lua=myApp.locatepre.lua ,
                                                             time=sceneparams.navigation.composer.time, 
                                                             effect=myApp.locatepre.effect,
                                                             effectback=myApp.locatepre.effectback,
                                                          },
                                                     },
                                 }      

                         local parentinfo =  sceneparams 
                         locatelaunch.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
                         myApp.showSubScreen ({instructions=locatelaunch})

             end


             local function curlocReleaseback() 
                  ------------------------------------------------------
                  -- have accurate location ?
                  ------------------------------------------------------
                  if myApp.gps.haveaccuratelocation == true then
                       launchLocateScene{desc=string.format (myApp.mappings.objects[sceneparams.sceneinfo.locateinfo.object].desc.plural ..  " within %i miles of your current location.",sceneparams.sceneinfo.locateinfo.miles), lat=myApp.gps.currentlocation.latitude,lng=myApp.gps.currentlocation.longitude}
                  end

             end




             ---------------------------------------------
             -- Use Current Location button
             ---------------------------------------------
              curlocButton = widget.newButton {
                    shape=myApp.locatepre.shape,
                    fillColor = { default={ headcolor.r, headcolor.g, headcolor.b, myApp.locatepre.btndefaultcoloralpha}, over={ headcolor.r, headcolor.g, headcolor.b, myApp.locatepre.btnovercoloralpha } },
                    label = myApp.locatepre.curlocbtntext,
                    labelColor = { default={ myApp.locatepre.headercolor.r,myApp.locatepre.headercolor.g,myApp.locatepre.headercolor.b }, over={ myApp.locatepre.headercolor.r,myApp.locatepre.headercolor.g,myApp.locatepre.headercolor.b, .75 } },
                    fontSize = myApp.locatepre.headerfontsize,
                    font = myApp.fontBold,
                    width = itemGrp.width,
                    height = myApp.locatepre.btnheight,
                    x = itemGrp.x,
                    y = startY +  itemGrp.height /2 + myApp.locatepre.btnheight /2 + 50,
                    onRelease = function() 
                                    myApp.getCurrentLocation({callback=curlocReleaseback}) 
                                end,
                  }
               container:insert(curlocButton)




    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
        --sceneparams = event.params           -- params contains the item table 


    end
  

end

function scene:hide( event )
    local group = self.view
    local phase = event.phase
    print ("Hide:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
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
     
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene