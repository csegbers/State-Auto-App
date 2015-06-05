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

    if ( phase == "will" ) then
             --------------------------
             -- Setting params needed on the "Will" phase !!!!
             --------------------------
             params = event.params or {}          -- params contains the item table 
             -- Called when the scene is still off screen (but is about to come on screen).
             display.remove( container )           -- wont exist initially no biggie
             container = nil

             container  = common.SceneContainer()
             group:insert(container )

             ---------------------------------------------
             -- lets create the group
             ---------------------------------------------

             local itemGrp = display.newGroup(  )
             local headcolor = params.groupheader or myApp.locatepre.groupheader
             local startX = 0
             local startY = 0 -myApp.cH/2 + myApp.locatepre.groupheight/2 + myApp.locatepre.edge*2 + myApp.sceneStartTop
             local groupwidth = myApp.sceneWidth-myApp.locatepre.edge*2
             local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize})
             local textHeightSingleLine = dumText.height
             
             -------------------------------------------------
             -- Background
             -------------------------------------------------
             local myRoundedRect = display.newRoundedRect(startX, startY , groupwidth-myApp.locatepre.groupstrokewidth*2,myApp.locatepre.groupheight, 1 )
             myRoundedRect:setFillColor(myApp.locatepre.groupbackground.r,myApp.locatepre.groupbackground.g,myApp.locatepre.groupbackground.b,myApp.locatepre.groupbackground.a )
             myRoundedRect.strokeWidth = myApp.locatepre.groupstrokewidth
             myRoundedRect:setStrokeColor( headcolor.r,headcolor.g,headcolor.b ) 
             itemGrp:insert(myRoundedRect)

             -------------------------------------------------
             -- Header Background
             -------------------------------------------------
             local startYother = startY- myApp.locatepre.groupheight/2  
             local myRoundedTop = display.newRoundedRect(startX, startYother ,groupwidth, myApp.locatepre.groupheaderheight, 1 )
             myRoundedTop:setFillColor(headcolor.r,headcolor.g,headcolor.b,headcolor.a )
             itemGrp:insert(myRoundedTop)
             
             -------------------------------------------------
             -- Header text
             -------------------------------------------------
             local myText = display.newText( params.title, startX, startYother,  myApp.fontBold, myApp.locatepre.headerfontsize )
             myText:setFillColor( myApp.locatepre.headercolor.r,myApp.locatepre.headercolor.g,myApp.locatepre.headercolor.b,myApp.locatepre.headercolor.a )
             itemGrp:insert(myText)

             -------------------------------------------------
             -- Icon ?
             -------------------------------------------------
             if params.pic then
                 local myIcon = display.newImageRect(myApp.imgfld .. params.pic, params.originaliconwidth or myApp.locatepre.iconwidth ,params.originaliconheight or myApp.locatepre.iconheight )
                 common.fitImage( myIcon, params.iconwidth or myApp.locatepre.iconwidth   )
                 myIcon.x = startX
                 myIcon.y = startYother + itemGrp.height/2 - 10
                 itemGrp:insert(myIcon)
             end

             -------------------------------------------------
             -- Desc text
             -------------------------------------------------
             local myDesc = display.newText( {text=params.text, x=startX , y=0, height=0,width=groupwidth-myApp.locatepre.edge*2 ,font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize,align="center" })
             myDesc.y=startYother+myApp.locatepre.groupheight - (myDesc.height/2) -  myApp.locatepre.textbottomedge
             myDesc:setFillColor( myApp.locatepre.textcolor.r,myApp.locatepre.textcolor.g,myApp.locatepre.textcolor.b,myApp.locatepre.textcolor.a )
             itemGrp:insert(myDesc)

             container:insert(itemGrp)

             -------------------------------------------------
             -- Range text
             -------------------------------------------------
             local myRangetext = display.newText( {text="Range",font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize,align="left" })
             myRangetext.x = myApp.cW/2*-1 + myRangetext.width/2 + myApp.locatepre.edge  + 2
             myRangetext.y=startYother+myApp.locatepre.groupheight  + myApp.locatepre.edge* 2
             myRangetext:setFillColor( myApp.locatepre.textcolor.r,myApp.locatepre.textcolor.g,myApp.locatepre.textcolor.b,myApp.locatepre.textcolor.a )
             container:insert(myRangetext)

             -------------------------------------------------
             -- Miles text
             -------------------------------------------------
             local myMilestext = display.newText( {text="xxx Miles",font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize,align="right" })
             myMilestext.x = myApp.cW/2 - myMilestext.width/2 - myApp.locatepre.edge  - 2
             myMilestext.y=startYother+myApp.locatepre.groupheight  + myApp.locatepre.edge* 2
             myMilestext:setFillColor( myApp.locatepre.textcolor.r,myApp.locatepre.textcolor.g,myApp.locatepre.textcolor.b,myApp.locatepre.textcolor.a )
             container:insert(myMilestext)

            local function milesCheck()
                if params.locateinfo.miles > myApp.locatepre.milerange.high then
                    params.locateinfo.miles = myApp.locatepre.milerange.high
                else
                    if params.locateinfo.miles < myApp.locatepre.milerange.low then
                        params.locateinfo.miles = myApp.locatepre.milerange.low
                    end
                end
            end
            milesCheck()

            --------------------------------------------
            -- Create a horizontal slider
            -- slider value is 0-100 so we have to caluclate based on min and max range
            ---------------------------------------------
            local horizontalSlider = widget.newSlider {
                x = itemGrp.x - myApp.locatepre.edge,
                y = myRangetext.y + 3,
                width = itemGrp.width - myRangetext.width - myMilestext.width - myApp.locatepre.edge*5,
                id = "miles",
                orientation = "horizontal",
                value = (params.locateinfo.miles-myApp.locatepre.milerange.low)  / myApp.locatepre.milerange.high * 100,
                listener = function(event) 
                             params.locateinfo.miles = ((event.value/100) * myApp.locatepre.milerange.high) +  myApp.locatepre.milerange.low 
                             milesCheck()
                             myMilestext.text = params.locateinfo.miles .. " Miles"
                          end,
            }
            myMilestext.text = params.locateinfo.miles .. " Miles"
            container:insert( horizontalSlider )

             -------------------------------------------------
             -- Current loc button pressed return
             -------------------------------------------------

             local function curlocReleaseback() 
                  ------------------------------------------------------
                  -- have accurate location ?
                  ------------------------------------------------------
                  if myApp.gps.haveaccuratelocation == true then
                      local locatelaunch = {  
                                         title = params.title, 
                                         pic=params.pic,
                                         originaliconwidth = params.originaliconwidth,
                                         originaliconheight = params.originaliconheight,
                                         iconwidth = params.iconwidth,      -- height will be scaled appropriately
                                         text=params.text,
                                         backtext = "<",
                                         groupheader = params.groupheader,   -- can override

                                         locateinfo = {
                                                        functionname=params.locateinfo.functionname,
                                                        limit=params.locateinfo.limit,
                                                        miles=params.locateinfo.miles,
                                                        mapping = {name = params.locateinfo.mapping.name, miles = params.locateinfo.mapping.miles},
                                                      },
                                         navigation = { composer = {
                                                      -- this id setting this way we will rerun if different than prior request either miles or lat.lng etc...
                                                     id = params.locateinfo.functionname.."-" ..params.locateinfo.miles.."-" .. params.locateinfo.limit .."-".. myApp.gps.currentlocation.latitude .."-".. myApp.gps.currentlocation.longitude,   
                                                     lua=myApp.locatepre.lua ,
                                                     time=params.navigation.composer.time, 
                                                     effect=myApp.locatepre.effect,
                                                     effectback=myApp.locatepre.effectback,
                                                  },},
                                 }      

                         local parentinfo =  params 
                         locatelaunch.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
                         myApp.showSubScreen ({instructions=locatelaunch})
                    end
             end

              
             ---------------------------------------------
             -- Use Current Location button
             ---------------------------------------------
             local curlocButton = widget.newButton {
                    shape=myApp.locatepre.shape,
                    fillColor = { default={ headcolor.r, headcolor.g, headcolor.b, 0.8 }, over={ headcolor.r, headcolor.g, headcolor.b, 0.6 } },
                    label = myApp.locatepre.curlocbtntext,
                    labelColor = { default={ myApp.locatepre.headercolor.r,myApp.locatepre.headercolor.g,myApp.locatepre.headercolor.b }, over={ myApp.locatepre.headercolor.r,myApp.locatepre.headercolor.g,myApp.locatepre.headercolor.b, .75 } },
                    fontSize = myApp.locatepre.headerfontsize,
                    font = myApp.fontBold,
                    width = itemGrp.width,
                    height = myApp.locatepre.btnheight,
                    x = itemGrp.x,
                    y = startY +  itemGrp.height /2 + myApp.locatepre.btnheight /2 + horizontalSlider.height,
                    onRelease = function() myApp.getCurrentLocation({callback=curlocReleaseback}) end,
                  }
               container:insert(curlocButton)



        --myApp.sceneWidth / 2 ,myApp.sceneHeight  /2 + myApp.sceneStartTop


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


               --          local debuglink = {
               --                       title = "Dbug Info", 
               --                       backtext = "<",
               --                       groupheader = { r=53/255, g=48/255, b=102/255, a=1 },
               --                       navigation = { composer = {
               --                                   lua="debugapp",
               --                                   time=250, 
               --                                   effect="slideLeft",
               --                                   effectback="slideRight",
               --                                },
               --                              },
               --                           } 

               --  local parentinfo =  params 
               --  debuglink.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
               --  local debugbackButton = widget.newButton {
               --      label = "Debug Link" ,
               --      labelColor = { default={ 0, 1, 1 }, over={ 0, 0, 0, 0.5 } },
               --      fontSize = 30,
               --      font = myApp.fontBold,
               --      onRelease = function () myApp.showSubScreen ({instructions=debuglink}) end,
               --   }
               -- debugbackButton.y = 150
               -- container:insert(debugbackButton)


    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
        --params = event.params           -- params contains the item table 

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
       return params
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene