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

print ("Inxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " .. currScene .. " Scene")

parse:logEvent( "MyCustomEvent", { ["x"] = "home" ,["y"] = "ccc"}, function (e) print ("return from  home logevent") print (e.requestType)   end )


------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
--
-- self.view -> Container -> SCrollvew
------------------------------------------------------
function scene:create(event)

    print ("Create  " .. currScene)
    params = event.params or {}
    local group = self.view
    params.container = common.SceneContainer()
    group:insert(params.container)



    local function scrollListener( event )
            
            -- local phase = event.phase
            -- if ( phase == "began" ) then print( "Scroll view was touched" )
            -- elseif ( phase == "moved" ) then print( "Scroll view was moved" )
            -- elseif ( phase == "ended" ) then print( "Scroll view was released" )
            -- end

            -- -- In the event a scroll limit is reached...
            -- if ( event.limitReached ) then
            --     if ( event.direction == "up" ) then print( "Reached top limit" )
            --     elseif ( event.direction == "down" ) then print( "Reached bottom limit" )
            --     elseif ( event.direction == "left" ) then print( "Reached left limit" )
            --     elseif ( event.direction == "right" ) then print( "Reached right limit" )
            --     end
            -- end

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
    params.container:insert(scrollView)



 
    -- local aline = display.newLine( 0, 0,myApp.sceneWidth, 0)
    --  aline:setStrokeColor( 1, 0, 0, 1 )
    --  aline.strokeWidth = 1
    --  scrollView:insert(aline)


    -- local aline2 = display.newLine( 0, myApp.sceneHeight ,myApp.sceneWidth, myApp.sceneHeight)
    --  aline2:setStrokeColor( 7, 0, 9, 10 )
    --  aline2.strokeWidth = 2
    --  scrollView:insert(aline2)



     -- local container2 = display.newContainer( 100, 100)
     -- local bkgd = display.newImage( "salogo.jpg" )
     -- container2:insert( bkgd, true )
     -- scrollView:insert(container2)
     -- container2:translate( scrollView.width*0.5, scrollView.height*.5 )
     -- transition.to( container2, { rotation=360, transition=easing.inOutExpo} )

--container:insert(scrollView)
-- Create the widget


     local primGroup = display.newGroup(  )
     -- local aline = display.newLine( 0, 0,myApp.sceneWidth, 0)
     -- aline:setStrokeColor( 1, 0, 0, 1 )
     -- aline.strokeWidth = 1
     -- primGroup:insert(aline)

     local groupwidth = myApp.homepage.groupwidth                                -- starting width of the selection box
     local workingScreenWidth = myApp.sceneWidth - myApp.homepage.groupbetween   -- screen widh - the left edge (since each box would have 1 right edge)
     local workingGroupWidth = groupwidth + myApp.homepage.groupbetween          -- group width plus the right edge
     local groupsPerRow = math.floor(workingScreenWidth / workingGroupWidth )    --how many across can we fit
     local leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )      -- width of the left edige
     local leftY = (leftWidth) / 2 + (myApp.homepage.groupbetween / 2 )          -- starting point of left box

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

     local function onObjectTouch( event )
        local homepageitem = myApp.homepage.items[event.target.id]

        -------------------------------------------
        -- launch another scene ?
        -------------------------------------------
        if homepageitem.composer then
           homepageitem.callBack = function() myApp.showScreen({instructions=params,effectback=homepageitem.composer.effectback}) end
           myApp.showSubScreen ({instructions=homepageitem})  --- cant just launch if we recycle composer for some reason
        end
        
     end

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
             local startY = (myApp.homepage.groupheight/2 +myApp.homepage.groupbetween*row) + (row-1)*myApp.homepage.groupheight
             
             -------------------------------------------------
             -- Background
             -------------------------------------------------
             local myRoundedRect = display.newRoundedRect(startX, startY ,groupwidth, myApp.homepage.groupheight, 1 )
             myRoundedRect:setFillColor(myApp.homepage.groupbackground.r,myApp.homepage.groupbackground.g,myApp.homepage.groupbackground.b,myApp.homepage.groupbackground.a )
             itemGrp:insert(myRoundedRect)

             -------------------------------------------------
             -- Header Background
             -------------------------------------------------
             local startYother = startY-myApp.homepage.groupheight/2 + myApp.homepage.groupbetween
             local myRoundedTop = display.newRoundedRect(startX, startYother ,groupwidth, myApp.homepage.groupheaderheight, 1 )
             myRoundedTop:setFillColor(v.groupheader.r,v.groupheader.g,v.groupheader.b,v.groupheader.a )
             itemGrp:insert(myRoundedTop)
             
             -------------------------------------------------
             -- Header text
             -------------------------------------------------
             local myText = display.newText( v.title, startX, startYother,  myApp.fontBold, 12 )
             myText:setFillColor( myApp.homepage.headercolor.r,myApp.homepage.headercolor.g,myApp.homepage.headercolor.b,myApp.homepage.headercolor.a )
             itemGrp:insert(myText)

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