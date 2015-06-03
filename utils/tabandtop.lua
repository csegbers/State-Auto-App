------------------------------------------------------
print ("tabandtop: IN")
------------------------------------------------------

local myApp = require( "myapp" )  
local common = require( myApp.utilsfld .. "common" )

local widget = require( "widget" )
local composer = require( "composer" )

----------------------------------------------------------
--    Top Title Bar stuff
----------------------------------------------------------
myApp.topBarBg = myApp.imgfld .. "topBarBg7.png"
myApp.TitleGroup = display.newGroup( )

----------------------------------------------------------
--   This goes behind the status bar
----------------------------------------------------------
local statusBarBackground = display.newImageRect(myApp.topBarBg, myApp.cW, myApp.tSbch)
statusBarBackground.x = myApp.cCx
statusBarBackground.y = myApp.tSbch * .5  
statusBarBackground.alpha = .5
myApp.TitleGroup:insert(statusBarBackground)

----------------------------------------------------------
--   This is the title bar
----------------------------------------------------------

local tbry = myApp.titleBarHeight / 2
local tbrheight = myApp.titleBarHeight

-------------------------------------------------
-- translucent status bar - adjust our background rect size and position.
-- bascially we want the whole rect to be gradient and status on top
-------------------------------------------------
if myApp.statusBarType == display.TranslucentStatusBar then 
   tbrheight = tbrheight + myApp.tSbch
   tbry = tbry + (myApp.tSbch /2)
else
   tbry = tbry + myApp.tSbch 
end

local titleBarRect = display.newRect(myApp.cW/2,tbry, myApp.cW, tbrheight )
titleBarRect.strokeWidth = 0
titleBarRect:setFillColor(  myApp.titleGradient )
myApp.TitleGroup:insert(titleBarRect)

----------------------------------------------------------
--   text in the Titlebar Set to blank initially
----------------------------------------------------------
local titleText = display.newText("", 0, 0, myApp.fontBold, 20 )
titleText:setFillColor (myApp.titleBarTextColor.r,myApp.titleBarTextColor.g,myApp.titleBarTextColor.b,myApp.titleBarTextColor.a)
titleText.x = myApp.cCx
titleText.y = myApp.titleBarHeight * 0.5 + myApp.tSbch  
myApp.TitleGroup.titleText = titleText
myApp.TitleGroup:insert(myApp.TitleGroup.titleText) 

----------------------------------------------------------
--   right side more button
----------------------------------------------------------
myApp.TitleGroup.moreIcon = widget.newButton {
                    defaultFile = myApp.imgfld .. myApp.moreinfo.morebutton.defaultFile,
                    overFile = myApp.imgfld .. myApp.moreinfo.morebutton.overFile ,
                    height = myApp.tabs.tabbtnh,
                    width = myApp.tabs.tabbtnw,
                    x = myApp.sceneWidth - myApp.tabs.tabbtnw/2 - myApp.titleBarEdge  ,
                    y = (myApp.titleBarHeight * 0.5 )  + myApp.tSbch  ,
                    onRelease = function() if myApp.moreinfo.imsliding == false then myApp.MoreInfoMove() end end,
               }

myApp.TitleGroup:insert(myApp.TitleGroup.moreIcon) 
 
----------------------------------------------------------
--   the icon is added in the showscreen
----------------------------------------------------------


----------------------------------------------------------
--    Bottom Tab sections
----------------------------------------------------------

myApp.tabBar = {}

local tabButtons = {}
local tabCnt = 0
local function addtabBtn(tkey)
    tabCnt = tabCnt + 1
    local btnrntry = myApp.tabs.btns[tkey]      -- will refernece same copy no biggie for now
    ---------------------------------
    -- dynamically add a couple items
    ---------------------------------
    btnrntry.sel=tabCnt                         -- add a sequence
    btnrntry.key=tkey                           -- add the key to the table
    local tabitem = 
        {
            label = btnrntry.label,
            defaultFile = myApp.imgfld .. btnrntry.def,
            overFile = myApp.imgfld .. btnrntry.over,
            labelColor = { default = myApp.colorGray,   over = myApp.saColor,  },
            width = myApp.tabs.tabbtnw,
            height = myApp.tabs.tabbtnh,
            onPress = function () myApp.showScreen({instructions=btnrntry}) end,
        }
    table.insert(tabButtons, tabitem)
end
------------------------------------------------
-- have to sort first
------------------------------------------------
 local a = {}
 for n in pairs(myApp.tabs.btns) do table.insert(a, n) end
 table.sort(a)
 for i,k in ipairs(a) do addtabBtn(k) end

 myApp.tabBar = widget.newTabBar{
    top =  myApp.cH - myApp.tabs.tabBarHeight ,
    left = 0,
    width = myApp.cW,
    backgroundFile = myApp.imgfld .. "tabBarBg7.png",
    tabSelectedLeftFile = myApp.imgfld .. "tabBar_tabSelectedLeft7.png",       
    tabSelectedRightFile = myApp.imgfld .. "tabBar_tabSelectedRight7.png",     
    tabSelectedMiddleFile = myApp.imgfld .. "tabBar_tabSelectedMiddle7.png",       
    tabSelectedFrameWidth = myApp.tabs.frameWidth,                                         
    tabSelectedFrameHeight = myApp.tabs.tabBarHeight,                                          
    buttons = tabButtons,
    height = myApp.tabs.tabBarHeight,
    --background="images/tabBarBg7.png"
}

----------------------------------------------------------
--   following may not be needed
----------------------------------------------------------
myApp.scenemaskFile = myApp.imgfld .. "mask-320x380.png"
if myApp.is_iPad then
    myApp.scenemaskFile = myApp.imgfld .. "mask-360x380.png"
end
if myApp.isTall then
    myApp.scenemaskFile = myApp.imgfld .. "mask-320x448.png"
end


--------------------------------------------------
-- clear Title bar icons nav elements
--
-- parms - {instructions (table)}
--------------------------------------------------
function myApp.showScreenCallback(parms)
    
    local returncode = false
    ----------------------------------------------
    -- does the current screen want to do something with navigation ?
    -- if so do it otherwise default to the normal navigation
    --------------------------------------------------
    pcall(function() returncode = composer.getScene( composer.getSceneName( "current" ) ):navigationhit({phase=parms.phase} ) end)
    if returncode == false then
        parms.callBack()
    end
end


--------------------------------------------------
-- clear Title bar icons nav elements
--
-- parms - {instructions (table)}
--------------------------------------------------
function myApp.clearScreenIconWidget(parms)

    local xendpoint = -1
    if parms and parms.effectback then  
        xendpoint = 3
    end

    --------------------------------------------
    -- is there an icon ? get rid of
    --------------------------------------------
    if myApp.TitleGroup.titleIcon then
        transition.to( myApp.TitleGroup.titleIcon, { time=myApp.tabs.transitiontime*2, transition=easing.outQuint, alpha=0 ,x = myApp.TitleGroup.titleIcon.x*xendpoint,onComplete= function () end})
        display.remove(myApp.TitleGroup.titleIcon)    -- may not exist first time, this wont hurt
        myApp.TitleGroup.titleIcon = nil
    end

    --------------------------------------------
    -- is there a back widget ? get rid of
    --------------------------------------------
    if myApp.TitleGroup.backButton then
        transition.to( myApp.TitleGroup.backButton, { time=myApp.tabs.transitiontime*2, transition=easing.outQuint, alpha=0 ,x = myApp.TitleGroup.backButton.x*xendpoint,onComplete= function () end})
        display.remove(myApp.TitleGroup.backButton)    -- may not exist first time, this wont hurt
        myApp.TitleGroup.backButton = nil
    end

    --------------------------------------------
    -- is there a forward widget ? get rid of
    --------------------------------------------
    if myApp.TitleGroup.forwardButton then
        transition.to( myApp.TitleGroup.forwardButton, { time=myApp.tabs.transitiontime*2, transition=easing.outQuint, alpha=0 ,x = myApp.TitleGroup.forwardButton.x*xendpoint,onComplete= function () end})
        display.remove(myApp.TitleGroup.forwardButton)    -- may not exist first time, this wont hurt
        myApp.TitleGroup.forwardButton = nil
    end
end

--------------------------------------------------
-- showScreenIcon
--
-- parms - {instructions (table)}
--------------------------------------------------
function myApp.showScreenIcon(image)

        myApp.clearScreenIconWidget()

        myApp.TitleGroup.titleIcon = display.newImageRect(image,myApp.tabs.tabbtnh,myApp.tabs.tabbtnw)
        common.fitImage( myApp.TitleGroup.titleIcon, myApp.titleBarHeight - myApp.titleBarEdge, false )
        myApp.TitleGroup.titleIcon.x = myApp.titleBarEdge + (myApp.TitleGroup.titleIcon.width * 0.5 )
        myApp.TitleGroup.titleIcon.y = (myApp.titleBarHeight * 0.5 )+ myApp.tSbch

        myApp.TitleGroup.titleIcon.alpha = 0
        myApp.TitleGroup:insert(myApp.TitleGroup.titleIcon)
        transition.to( myApp.TitleGroup.titleIcon, { time=myApp.tabs.transitiontime, alpha=1 })
end
--------------------------------------------------
-- Show screen. Add function
--
-- Used for the Major scenes from the Tabbar **************************
--
-- parms - instructions(table), [firsttime], [effectback]
--         instructions table must have a composer table
--------------------------------------------------
function myApp.showScreen(parms)

    if myApp.moreinfo.direction  == "left" then 
        local tnt = parms.instructions
        myApp.tabCurrentKey = tnt.key
        ----------------------------------------------------------
        --   Make sure the Tab is selected in case we came from a different direction instead of user tapping tabbar
        ----------------------------------------------------------
        myApp.tabBar:setSelected(tnt.sel)
        ----------------------------------------------------------
        --   Change the title in the status bar and launch new screen
        ----------------------------------------------------------
        if parms.firsttime  then
            myApp.TitleGroup.titleText.text = tnt.title
            myApp.showScreenIcon(myApp.imgfld .. parms.instructions.over)
        else
            ---------------------------------------------------
            -- on a subscreen coming back ? slide it on in
            ---------------------------------------------------
            if parms.effectback then  
                transition.to( myApp.TitleGroup.titleText, { 
                time=myApp.tabs.transitiontime/2, alpha=.2,x = myApp.TitleGroup.titleText.x*3,
                onComplete= function () myApp.TitleGroup.titleText.text = tnt.title; myApp.TitleGroup.titleText.x = myApp.cCx*-1;  transition.to( myApp.TitleGroup.titleText, {alpha=1,x = myApp.cCx,   transition=easing.outQuint, time=myApp.tabs.transitiontime  }) myApp.showScreenIcon(myApp.imgfld .. parms.instructions.over) end } )
                  
            else
                transition.to( myApp.TitleGroup.titleText, { time=myApp.tabs.transitiontime , alpha=.2,onComplete= function () myApp.TitleGroup.titleText.text = tnt.title;  transition.to( myApp.TitleGroup.titleText, {alpha=1, time=myApp.tabs.transitiontime }) end } )
                transition.to( myApp.TitleGroup.titleIcon, { time=myApp.tabs.transitiontime, alpha=0 ,onComplete=myApp.showScreenIcon(myApp.imgfld .. parms.instructions.over)})
            end
        end

        local effect = tnt.navigation.composer.effect
        -----------------------------------------------
        -- override effect ? Maybe a "back" etc..
        -----------------------------------------------
        if parms.effectback then effect = parms.effectback end

        composer.gotoScene(myApp.scenesfld .. tnt.navigation.composer.lua, {time=tnt.navigation.composer.time, effect=effect, params = tnt})
    end
    return true
end

--------------------------------------------------
-- Show sub screen. Add function
-- parms - instructions(table) 
--         instructions table must have a composer table
--------------------------------------------------
function myApp.showSubScreen(parms)
        local tnt = parms.instructions

        ----------------------------------------------
        -- As screen calls screen calls screen... the parms
        -- builds all by itself the trail of these calls because the callback
        -- actrually has the prior parent parms infos so...so--
        ----------------------------------------------
 
        myApp.clearScreenIconWidget(parms )
 
        --------------------------------------------
        -- Slide the current Text out
        -- and set to the new text
        -- SLide it on in
        --------------------------------------------
        ---------------------------------------------------
        -- on a subscreen coming back ? slide it on in
        ---------------------------------------------------
        local xendpoint = -1
        local xstartpoint = 3
        local xbackbutton = myApp.cW
        local effect = tnt.navigation.composer.effect
        if parms.effectback then  
           xendpoint = 3
           xstartpoint = -1
           xbackbutton = -20
           effect = parms.effectback
        end

        transition.to( myApp.TitleGroup.titleText, 
            { 
               time=myApp.tabs.transitiontime, alpha=.2,x = myApp.TitleGroup.titleText.x*xendpoint,
               onComplete= function () myApp.TitleGroup.titleText.text = tnt.title; myApp.TitleGroup.titleText.x = myApp.cCx*xstartpoint;  transition.to( myApp.TitleGroup.titleText, {alpha=1,x = myApp.cCx,   transition=easing.outQuint, time=myApp.tabs.transitiontime }) end
             } )

        --------------------------------------------
        -- Create a widget (text only or icon) for the navigation ?
        --
        -- Back button
        --------------------------------------------   
        if tnt.backtext then    
               myApp.TitleGroup.backButton = widget.newButton {
                    label = tnt.backtext ,
                    width =  myApp.tabs.tabbtnw,
                    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                    fontSize = 30,
                    font = myApp.fontBold,
                    onRelease = function() myApp.showScreenCallback ({callBack=tnt.callBack,phase="back"}) end,
               }

        else
            if tnt.defaultFile then
               myApp.TitleGroup.backButton = widget.newButton {
                    defaultFile = tnt.defaultFile ,
                    overFile = tnt.overFile ,
                    onRelease = function() myApp.showScreenCallback ({callBack=tnt.callBack,phase="back"}) end,
                }
            end
        end
        --------------------------------------------
        -- Create a widget (text only or icon) for the navigation ?
        --
        -- Forward button
        --------------------------------------------   
        if tnt.forwardtext then 
           myApp.TitleGroup.forwardButton = widget.newButton {
                label = tnt.forwardtext ,
                width =  myApp.tabs.tabbtnw,
                labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                fontSize = 30,
                font = myApp.fontBold,
                onRelease = function() myApp.showScreenCallback ({callBack=tnt.callBack,phase="forward"}) end,
           }
        else
             if tnt.defaultForwardFile then
               myApp.TitleGroup.forwardButton = widget.newButton {
                    defaultFile = tnt.defaultForwardFile ,
                    overFile = tnt.overForwardFile ,
                    onRelease = function() myApp.showScreenCallback ({callBack=tnt.callBack,phase="forward"}) end,
                }
            end
        end

        myApp.TitleGroup.backButton.x = xbackbutton
        myApp.TitleGroup.backButton.y = (myApp.titleBarHeight * 0.5 )  + myApp.tSbch  
        myApp.TitleGroup:insert(myApp.TitleGroup.backButton)

        transition.to( myApp.TitleGroup.backButton, { time=myApp.tabs.transitiontime*2, x = myApp.titleBarEdge *2 , transition=easing.outQuint})

        if myApp.TitleGroup.forwardButton then
            myApp.TitleGroup.forwardButton.x = xbackbutton 
            myApp.TitleGroup.forwardButton.y = (myApp.titleBarHeight * 0.5 )  + myApp.tSbch  
            myApp.TitleGroup:insert(myApp.TitleGroup.forwardButton)

            transition.to( myApp.TitleGroup.forwardButton, { time=myApp.tabs.transitiontime*2, x = myApp.titleBarEdge *2 + myApp.tabs.tabbtnw, transition=easing.outQuint})
        end

        --------------------------------------------
        -- goto the new scene
        --------------------------------------------
        composer.gotoScene(myApp.scenesfld .. tnt.navigation.composer.lua, {time=tnt.navigation.composer.time, effect=effect, params = tnt})
 
    return true
end

function myApp.Login(parms)
    print "IN overlay"
    composer.showOverlay(myApp.scenesfld .. myApp.login.lua, myApp.login.options)
    return true
end

------------------------------------------------------
print ("tabandtop: OUT")
------------------------------------------------------


