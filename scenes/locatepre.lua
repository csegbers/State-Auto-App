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
    params = event.params or {}

    local container  = common.SceneContainer()
    group:insert(container )

     ---------------------------------------------
     -- lets create the group
     ---------------------------------------------
     local itemGrp = display.newGroup(  )
     local startX = 0
     local startY = 0 -myApp.cH/2 + myApp.locatepre.groupheight/2 + myApp.locatepre.edge*2 + myApp.sceneStartTop
     local groupwidth = myApp.sceneWidth-myApp.locatepre.edge*2
     local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.locatepre.textfontsize})
     local textHeightSingleLine = dumText.height
     
     -------------------------------------------------
     -- Background
     -------------------------------------------------
     local myRoundedRect = display.newRoundedRect(startX, startY , groupwidth,myApp.locatepre.groupheight, 1 )
     myRoundedRect:setFillColor(myApp.locatepre.groupbackground.r,myApp.locatepre.groupbackground.g,myApp.locatepre.groupbackground.b,myApp.locatepre.groupbackground.a )
     itemGrp:insert(myRoundedRect)

     -------------------------------------------------
     -- Header Background
     -------------------------------------------------
     local startYother = startY- myApp.locatepre.groupheight/2  
     local myRoundedTop = display.newRoundedRect(startX, startYother ,groupwidth, myApp.locatepre.groupheaderheight, 1 )
     local headcolor = params.groupheader or myApp.locatepre.groupheader
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
     --myDesc.y=startYother+myApp.locatepre.groupheight  -(myDesc.height/2) - textHeightSingleLine /2 -2
     myDesc.y=startYother+myApp.locatepre.groupheight - (myDesc.height/2) --- textHeightSingleLine
     myDesc.y=startYother+myApp.locatepre.groupheight - (myDesc.height/2) -  myApp.locatepre.textbottomedge
     myDesc:setFillColor( myApp.locatepre.textcolor.r,myApp.locatepre.textcolor.g,myApp.locatepre.textcolor.b,myApp.locatepre.textcolor.a )
     itemGrp:insert(myDesc)

     container:insert(itemGrp)


         local curlocButton = widget.newButton {
            shape="rect",
            fillColor = { default={ 0, 0.2, 0.5, 0.7 }, over={ 1, 0.2, 0.5, 1 } },
            strokeColor = { default={ 0, 0, 0 }, over={ 0.4, 0.1, 0.2 } },
            label = "Use Current Location" ,
            labelColor = { default={ 0, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            fontSize = 14,
            font = myApp.fontBold,
            --onRelease = function () myApp.showSubScreen ({instructions=debuglink}) end,
         }
       curlocButton.y = 50
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