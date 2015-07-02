---------------------------------------------------------------------------------------
-- account scene
---------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 
local parse = require( myApp.utilsfld .. "mod_parse" )  
local common = require( myApp.utilsfld .. "common" )
local login = require( myApp.classfld .. "classlogin" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
local sceneparams
local sceneid
local sbi
local container
local scrollView
local justcreated  
local runit  
------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
--
-- self.view -> Container -> SCrollvew -> primgroup -> individual item groups
------------------------------------------------------
function scene:create(event)
     print ("Create  " .. currScene)
     justcreated = true
     sceneparams = event.params or {}
end

function scene:show( event )

    local group = self.view
    local phase = event.phase
    print ("Show:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).


        ----------------------------
        -- sceneparams at this point contains prior
        -- KEEP IT THAT WAY !!!!!
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        -- Called when the scene is still off screen (but is about to come on screen).
        runit = true
        if sceneparams and justcreated == false then
          print ("scene compare " .. sceneparams.navigation.composer.id .. " " .. event.params.navigation.composer.id )
          if  sceneparams.navigation.composer then
             if sceneid == event.params.navigation.composer.id then
               runit = false
             end
          end
        end

        --------------------
        -- update sceneparams now, not before as we check prior scene
        --------------------
        sceneparams = event.params or {}
        sceneid = sceneparams.navigation.composer.id       --- new field otherwise it is a refernce and some calls here send a reference so comparing id's is useless         

        sbi = myApp.otherscenes.myaccount 
       --debugpopup (sceneparams.sceneinfo.scrollblockinfo.navigate)

        if (runit or justcreated) then 

            display.remove( container )           -- wont exist initially no biggie
            container = nil

            display.remove( scrollView )           -- wont exist initially no biggie
            scrollView = nil

            container = common.SceneContainer()
            group:insert(container)
         
            local function scrollListener( event )
                  return true
            end

            scrollView = widget.newScrollView
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
             
                local rowitem = event.target.id
            --    local homepageitem = sbi.items[event.target.id] 
                -------------------------------------------
                -- launch another scene ?
                -- Pass in our scene info for the new scene callback
                -------------------------------------------
                local function onObjectTouchAction(  )

                end       
                ---------------------------------------------
                -- simulate a pressing of a button
                ---------------------------------------------
                transition.to( event.target, { time=100, x=5,y=5,  delta=true , transition=easing.continuousLoop, onComplete=onObjectTouchAction } )  
             end

             local groupheight = sbi.groupheight
             local groupwidth = sbi.groupwidth                                -- starting width of the selection box
             local workingScreenWidth = myApp.sceneWidth - sbi.groupbetween   -- screen widh - the left edge (since each box would have 1 right edge)
             local workingGroupWidth = groupwidth + sbi.groupbetween          -- group width plus the right edge
             local groupsPerRow = math.floor(workingScreenWidth / workingGroupWidth )    -- how many across can we fit
             local leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )      -- width of the left edige
             local leftY = (leftWidth) / 2 + (sbi.groupbetween / 2 )          -- starting point of left box
             local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=sbi.textfontsize})
             local textHeightSingleLine = dumText.height
             display.remove( dumText )
             dumText=nil

             -------------------------------------------
             -- lots of extra edging ? edging > space in between ?
             -- expand the boxes but not beyond their max size
             -------------------------------------------
             if leftWidth > sbi.groupbetween then
                local origgroupwidth = groupwidth
                groupwidth = groupwidth + ((leftWidth - sbi.groupbetween) / groupsPerRow)   -- calcualte new group width
                if groupwidth > sbi.groupmaxwidth then                                      -- gone too far ? push back
                    groupwidth = sbi.groupmaxwidth 
                    if groupwidth < origgroupwidth then groupwidth = origgroupwidth end                -- just incase someone puts the max > than original
                end
                workingGroupWidth = groupwidth +  sbi.groupbetween                          -- calcualt enew total group width _ spacing
                leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )                       -- recalce leftwdith and left starting point
                leftY = (leftWidth) / 2 + (sbi.groupbetween / 2 )
             end

             -----------------------------------------------
             -- where we stuff all the little selection groups
             -----------------------------------------------
             local primGroup = display.newGroup(  )
 
 
             local row = 1
             local col = 1

             for k,v in pairs(myApp.authentication.policies) do 
                    local polgroup = myApp.authentication.policies[k]
 
                    print ("account page item " .. k)
 
                     --------------------------------------
                     -- need to start a new row ?
                     --------------------------------------
                     if col > groupsPerRow then
                          row = row + 1
                          col = 1
                     end

                     local cellworkingGroupWidth = workingGroupWidth
                     local cellgroupwidth = groupwidth 
                     -- if v.doublewide then 
                     --    cellworkingGroupWidth = cellworkingGroupWidth * 2  
                     --    cellgroupwidth = cellgroupwidth * 2 + sbi.groupbetween
                     --    --col = col + 1
                     --    if col == groupsPerRow then
                     --      row = row + 1
                     --       col = 1
                     --     end
                     -- end

                     ---------------------------------------------
                     -- lets create the group
                     ---------------------------------------------
                     local itemGrp = display.newGroup(  )
                     itemGrp.id = k
                     local startX = cellworkingGroupWidth*(col-1) + leftY + cellgroupwidth/2
                     local startY = (groupheight/2 +sbi.groupbetween*row) + (row-1)* groupheight
                     
                     -------------------------------------------------
                     -- Background
                     -------------------------------------------------
                     local myRoundedRect = display.newRoundedRect(startX, startY ,cellgroupwidth,  groupheight, 1 )
                     myRoundedRect:setFillColor(sbi.groupbackground.r,sbi.groupbackground.g,sbi.groupbackground.b,sbi.groupbackground.a )
                     itemGrp:insert(myRoundedRect)

                     -------------------------------------------------
                     -- Header Background
                     -------------------------------------------------
                     local startYother = startY- groupheight/2 + sbi.groupbetween
                     local myRoundedTop = display.newRoundedRect(startX, startYother ,cellgroupwidth, sbi.groupheaderheight, 1 )
                     local headcolor = sbi.groupheader
                     myRoundedTop:setFillColor(headcolor.r,headcolor.g,headcolor.b,headcolor.a )
                     itemGrp:insert(myRoundedTop)
                     
                     -------------------------------------------------
                     -- Header text
                     -------------------------------------------------
                     local myText = display.newText( (k), startX, startYother,  myApp.fontBold, sbi.headerfontsize )
                     myText:setFillColor( sbi.headercolor.r,sbi.headercolor.g,sbi.headercolor.b,sbi.headercolor.a )
                     itemGrp:insert(myText)

                     -------------------------------------------------
                     -- Icon ?
                     -------------------------------------------------
                     -- if v.pic then
                     --     local myIcon = display.newImageRect(myApp.imgfld .. v.pic, v.originaliconwidth or sbi.iconwidth ,v.originaliconheight or sbi.iconheight )
                     --     common.fitImage( myIcon, v.iconwidth or sbi.iconwidth   )
                     --     myIcon.x = startX
                     --     myIcon.y = startYother + itemGrp.height/2 - 10 --- sbi.iconwidth
                     --     itemGrp:insert(myIcon)
                     -- end

                     -------------------------------------------------
                     -- Desc text
                     -------------------------------------------------
                     
                     local myDesc = display.newText( {text=("xxx"), x=startX, y=0, height=0,width=cellgroupwidth-5 ,font= myApp.fontBold, fontSize=sbi.textfontsize,align="center" })
                     myDesc.y=startYother+groupheight - (myDesc.height/2) - sbi.textbottomedge
                     myDesc:setFillColor( sbi.textcolor.r,sbi.textcolor.g,sbi.textcolor.b,sbi.textcolor.a )
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
                     -- if v.doublewide then 
                     --  col = col+1
                     -- end
                  
              end     -- end for

              scrollView:insert(primGroup)

              ---------------------------------------------
              -- stick in a buffer for the scroll
              ----------------------------------------------
               scrollView:insert(display.newRoundedRect(1, (sbi.groupbetween*(row+1)) + row*sbi.groupheight ,1, sbi.groupbetween, 1 ))
               print ("end of will show")
        end -- runit ?
       
    elseif ( phase == "did" ) then
         print ("end of did show")
         parse:logEvent( "Scene", { ["name"] = currScene} )
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