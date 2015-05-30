---------------------------------------------------------------------------------------
-- HOME scene
---------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 
local parse = require( myApp.utilsfld .. "mod_parse" )  
local common = require( myApp.utilsfld .. "common" )
local login = require( myApp.classfld .. "classlogin" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
local params

------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
--
-- self.view -> Container -> SCrollvew -> primgroup -> individual item groups
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    params = event.params or {}
    local group = self.view
    local container = common.SceneContainer()
    group:insert(container)
 
    local function scrollListener( event )
          return true
    end

    local scrollView = widget.newScrollView
        {
            x = 0,
            y = 0,
            width = myApp.sceneWidth, 
            height =  myApp.sceneHeight,
            listener = scrollListener,
            horizontalScrollDisabled = true,
            hideBackground = true,
        }
     container:insert(scrollView)

     ----------------------------------------------
     -- Tcouhed an object - go do something
     ----------------------------------------------
     local function onObjectTouch( event )
        local homepageitem = myApp.homepage.items[event.target.id] 
        -------------------------------------------
        -- launch another scene ?
        -- Pass in our scene info for the new scene callback
        -------------------------------------------
        local function onObjectTouchAction(  )
            if homepageitem.composer then
               local parentinfo = params 
               homepageitem.callBack = function() myApp.showScreen({instructions=parentinfo,effectback=homepageitem.composer.effectback}) end
               myApp.showSubScreen ({instructions=homepageitem})   
            end
        end       

        ---------------------------------------------
        -- simulate a pressing of a button
        ---------------------------------------------
        transition.to( event.target, { time=100, x=5,y=5,  delta=true , transition=easing.continuousLoop, onComplete=onObjectTouchAction } )

        
     end

     local groupheight = myApp.homepage.groupheight
     local groupwidth = myApp.homepage.groupwidth                                -- starting width of the selection box
     local workingScreenWidth = myApp.sceneWidth - myApp.homepage.groupbetween   -- screen widh - the left edge (since each box would have 1 right edge)
     local workingGroupWidth = groupwidth + myApp.homepage.groupbetween          -- group width plus the right edge
     local groupsPerRow = math.floor(workingScreenWidth / workingGroupWidth )    -- how many across can we fit
     local leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )      -- width of the left edige
     local leftY = (leftWidth) / 2 + (myApp.homepage.groupbetween / 2 )          -- starting point of left box
     local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=myApp.homepage.textfontsize})
     local textHeightSingleLine = dumText.height
     display.remove( dumText )
     dumText=nil

     -------------------------------------------
     -- lots of extra edging ? edging > space in between ?
     -- expand the boxes but not beyond their max size
     -------------------------------------------
     if leftWidth > myApp.homepage.groupbetween then
        local origgroupwidth = groupwidth
        groupwidth = groupwidth + ((leftWidth - myApp.homepage.groupbetween) / groupsPerRow)   -- calcualte new group width
        if groupwidth > myApp.homepage.groupmaxwidth then                                      -- gone too far ? push back
            groupwidth = myApp.homepage.groupmaxwidth 
            if groupwidth < origgroupwidth then groupwidth = origgroupwidth end                -- just incase someone puts the max > than original
        end
        workingGroupWidth = groupwidth +  myApp.homepage.groupbetween                          -- calcualt enew total group width _ spacing
        leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )                       -- recalce leftwdith and left starting point
        leftY = (leftWidth) / 2 + (myApp.homepage.groupbetween / 2 )
     end

     -----------------------------------------------
     -- where we stuff all the little selection groups
     -----------------------------------------------
     local primGroup = display.newGroup(  )

     --------------------------------------------
     -- must sort otherwise order is not honered
     -- so the KEYS must be in alphabetical order you want !!
     --------------------------------------------
     local a = {}
     for n in pairs(myApp.homepage.items) do table.insert(a, n) end
     table.sort(a)
     local row = 1
     local col = 1
     for i,k in ipairs(a) do 
         local v = myApp.homepage.items[k]
         print ("home page item " .. k)
             --------------------------------------
             -- need to start a new row ?
             --------------------------------------
             if col > groupsPerRow then
                  row = row + 1
                  col = 1
             end

             ---------------------------------------------
             -- lets create the group
             ---------------------------------------------
             local itemGrp = display.newGroup(  )
             itemGrp.id = k
             local startX = workingGroupWidth*(col-1) + leftY + groupwidth/2
             local startY = (groupheight/2 +myApp.homepage.groupbetween*row) + (row-1)* groupheight
             
             -------------------------------------------------
             -- Background
             -------------------------------------------------
             local myRoundedRect = display.newRoundedRect(startX, startY ,groupwidth,  groupheight, 1 )
             myRoundedRect:setFillColor(myApp.homepage.groupbackground.r,myApp.homepage.groupbackground.g,myApp.homepage.groupbackground.b,myApp.homepage.groupbackground.a )
             itemGrp:insert(myRoundedRect)

             -------------------------------------------------
             -- Header Background
             -------------------------------------------------
             local startYother = startY- groupheight/2 + myApp.homepage.groupbetween
             local myRoundedTop = display.newRoundedRect(startX, startYother ,groupwidth, myApp.homepage.groupheaderheight, 1 )
             local headcolor = v.groupheader or myApp.homepage.groupheader
             myRoundedTop:setFillColor(headcolor.r,headcolor.g,headcolor.b,headcolor.a )
             itemGrp:insert(myRoundedTop)
             
             -------------------------------------------------
             -- Header text
             -------------------------------------------------
             local myText = display.newText( v.title, startX, startYother,  myApp.fontBold, myApp.homepage.headerfontsize )
             myText:setFillColor( myApp.homepage.headercolor.r,myApp.homepage.headercolor.g,myApp.homepage.headercolor.b,myApp.homepage.headercolor.a )
             itemGrp:insert(myText)

             -------------------------------------------------
             -- Icon ?
             -------------------------------------------------
             if v.pic then
                 local myIcon = display.newImageRect(myApp.imgfld .. v.pic, v.originaliconwidth or myApp.homepage.iconwidth ,v.originaliconheight or myApp.homepage.iconheight )
                 common.fitImage( myIcon, v.iconwidth or myApp.homepage.iconwidth   )
                 myIcon.x = startX
                 myIcon.y = startYother + itemGrp.height/2 - 10
                 itemGrp:insert(myIcon)
             end

             -------------------------------------------------
             -- Desc text
             -------------------------------------------------
             

             local myDesc = display.newText( {text=v.text, x=startX, y=0, height=0,width=groupwidth-5 ,font= myApp.fontBold, fontSize=myApp.homepage.textfontsize,align="center" })
             myDesc.y=startYother+groupheight  -(myDesc.height/2) - textHeightSingleLine + 2
             myDesc:setFillColor( myApp.homepage.textcolor.r,myApp.homepage.textcolor.g,myApp.homepage.textcolor.b,myApp.homepage.textcolor.a )
             itemGrp:insert(myDesc)


             -------------------------------------------------
             -- Add touch event
             -------------------------------------------------
             itemGrp:addEventListener( "tap", onObjectTouch )

             -------------------------------------------------
             -- insert each individual group into the master group
             -------------------------------------------------

             primGroup:insert(itemGrp)

             
             col = col+1
   end

   scrollView:insert(primGroup)

   ---------------------------------------------
   -- stick in a buffer for the scroll
   ----------------------------------------------
   scrollView:insert(display.newRoundedRect(1, (myApp.homepage.groupbetween*(row+1)) + row*myApp.homepage.groupheight ,1, myApp.homepage.groupbetween, 1 ))

end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
       
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )

            -- Called when the scene is now on screen.
            -- Insert code here to make the scene come alive.
            -- Example: start timers, begin animation, play audio, etc.

         -- if myApp.login.loggedin == false and myApp.justLaunched == true then
         --    myApp.justLaunched = false
         --    timer.performWithDelay(10, myApp.Login)  --- cant just launch if we recycle composer for some reason

         -- end
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

-- ---------------------------------------------------
-- -- use if someone wants us to transition away
-- -- for navigational appearnaces
-- -- ****** just use the slide transitions from composer
-- ---------------------------------------------------
-- function scene:moveContainer( event )
--     if params.container then
--          local containerX = params.container.x
--          local containerY = params.container.Y
--          local x = containerX
--          local y = containerY
--          if event.direction == "left" then
--             x = params.container.x*-1
--          end
--          if event.direction == "right" then
--             x = params.container.x*3
--          end
--          transition.to(  params.container, { time=event.time,  x= x,y=y, onComplete=function() transition.to(  params.container, {  alpha=1,  x= containerX, y =containerY } )end} )
--      end
-- end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene