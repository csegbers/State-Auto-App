------------------------------------------------------
print ("tabandtop: IN")
------------------------------------------------------

local myApp = require( "myapp" )  
local common = require( myApp.utilsfld .. "common" )

local widget = require( "widget" )
local composer = require( "composer" )

----------------------------------------------------------
--    background 
----------------------------------------------------------
myApp.backGroup = display.newGroup( )

local background = common.SceneBackground()

--local backlogo = display.newImageRect("salogo.jpg",305,170)
--backlogo.x = myApp.cCx
--backlogo.y = myApp.cCy
--backlogo.alpha = .1 

myApp.backGroup:insert(background)
--myApp.backGroup:insert(backlogo)

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

--myApp.statusBarType = display.TranslucentStatusBar
-- local titleBar = display.newImageRect(myApp.topBarBg, myApp.cW, myApp.titleBarHeight + sbAdjust)
-- titleBar.x = myApp.cCx
-- titleBar.y = (myApp.titleBarHeight * 0.5 )+ myApp.tSbch - sbAdjust
-- titleBar:setFillColor( myApp.titleGradient )
-- myApp.TitleGroup:insert(titleBar)

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
--local titleText = display.newText(myApp.tabs.btns[myApp.tabs.launchkey].title, 0, 0, myApp.fontBold, 20 )
local titleText = display.newText("", 0, 0, myApp.fontBold, 20 )
if myApp.isGraphics2 then
    titleText:setFillColor(1, 1, 1)
else
    titleText:setTextColor( 255, 255, 255 )
end
titleText.x = myApp.cCx
titleText.y = myApp.titleBarHeight * 0.5 + myApp.tSbch  
myApp.TitleGroup.titleText = titleText
myApp.TitleGroup:insert(myApp.TitleGroup.titleText) 


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

    --debugpopup ("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK " .. btnrntry.key .. " " .. myApp.tabs.btns[tkey].key  )
    local tabitem = 
        {
            label = btnrntry.label,
            defaultFile = btnrntry.def,
            overFile = btnrntry.over,
            labelColor = { 
                default = myApp.colorGray,   
                over = myApp.saColor,  
            },
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
---- following wors just puts them in random order
-- for k,v in pairs(myApp.tabs.btns) do 
--     addtabBtn(k)
-- end

-- addtabBtn("home")
-- addtabBtn("video")
-- addtabBtn("menu")
-- addtabBtn("blogs")
-- addtabBtn("pics")
-- addtabBtn("maps")
-- addtabBtn("debug")

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
--   Common info for the screens
----------------------------------------------------------
myApp.sceneStartTop = myApp.titleBarHeight + myApp.tSbch  
myApp.sceneHeight = myApp.cH - myApp.sceneStartTop - myApp.tabBar.height
myApp.sceneWidth = myApp.cW


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
    -- is there a widget ? get rid of
    --------------------------------------------
    if myApp.TitleGroup.backButton then
        transition.to( myApp.TitleGroup.backButton, { time=myApp.tabs.transitiontime*2, transition=easing.outQuint, alpha=0 ,x = myApp.TitleGroup.backButton.x*xendpoint,onComplete= function () end})
        display.remove(myApp.TitleGroup.backButton)    -- may not exist first time, this wont hurt
        myApp.TitleGroup.backButton = nil
    end
end

--------------------------------------------------
-- showScreenIcon
--
-- parms - {instructions (table)}
--------------------------------------------------
function myApp.showScreenIcon(image)
 

        -- --------------------------------------------
        -- -- is there a widget ? get rid of
        -- --------------------------------------------
        -- display.remove(myApp.TitleGroup.backButton)    -- may not exist first time, this wont hurt
        -- myApp.TitleGroup.backButton = nil
        -- ----------------------------------------------------------
        -- --   This is the title bar icon
        -- ----------------------------------------------------------
        -- display.remove(myApp.TitleGroup.titleIcon)    -- may not exist first time, this wont hurt
        -- myApp.TitleGroup.titleIcon = nil

        myApp.clearScreenIconWidget()

        myApp.TitleGroup.titleIcon = display.newImageRect(image,myApp.tabs.tabbtnh,myApp.tabs.tabbtnw)
        common.fitImage( myApp.TitleGroup.titleIcon, myApp.titleBarHeight - myApp.titleBarEdge, false )
        myApp.TitleGroup.titleIcon.x = myApp.titleBarEdge + (myApp.TitleGroup.titleIcon.width * 0.5 )
        myApp.TitleGroup.titleIcon.y = (myApp.titleBarHeight * 0.5 )+ myApp.tSbch

        print ("icon scale " .. myApp.TitleGroup.titleIcon.xScale)
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

    local tnt = parms.instructions
    ----------------------------------------------------------
    --   Make sure the Tab is selected in case we came from a different direction instead of user tapping tabbar
    ----------------------------------------------------------
    myApp.tabBar:setSelected(tnt.sel)
    ----------------------------------------------------------
    --   Change the title in the status bar and launch new screen
    ----------------------------------------------------------
    if parms.firsttime  then
        myApp.TitleGroup.titleText.text = tnt.title
        myApp.showScreenIcon(parms.instructions.over)
    else
        ---------------------------------------------------
        -- on a subscreen coming back ? slide it on in
        ---------------------------------------------------
        if parms.effectback then  
            transition.to( myApp.TitleGroup.titleText, { 
            time=myApp.tabs.transitiontime/2, alpha=.2,x = myApp.TitleGroup.titleText.x*3,
            onComplete= function () myApp.TitleGroup.titleText.text = tnt.title; myApp.TitleGroup.titleText.x = myApp.cCx*-1;  transition.to( myApp.TitleGroup.titleText, {alpha=1,x = myApp.cCx,   transition=easing.outQuint, time=myApp.tabs.transitiontime  }) myApp.showScreenIcon(parms.instructions.over) end } )
              
        else
            transition.to( myApp.TitleGroup.titleText, { time=myApp.tabs.transitiontime , alpha=.2,onComplete= function () myApp.TitleGroup.titleText.text = tnt.title;  transition.to( myApp.TitleGroup.titleText, {alpha=1, time=myApp.tabs.transitiontime }) end } )
            transition.to( myApp.TitleGroup.titleIcon, { time=myApp.tabs.transitiontime, alpha=0 ,onComplete=myApp.showScreenIcon(parms.instructions.over)})
        end
    end

    local effect = tnt.composer.effect
    -----------------------------------------------
    -- override effect ? Maybe a "back" etc..
    -----------------------------------------------
    if parms.effectback then effect = parms.effectback end

    composer.gotoScene(myApp.scenesfld .. tnt.composer.lua, {time=tnt.composer.time, effect=effect, params = tnt})
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
        local effect = tnt.composer.effect
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
        --debugpopup (tnt.backtext .. " " .. type(parms) .. " " ..type(tnt) .. " " ..type(tnt.callBack))


        --------------------------------------------
        -- Create a widget (text only or icon) for the navigation ?
        --------------------------------------------   
        if tnt.backtext then    
               myApp.TitleGroup.backButton = widget.newButton {
                    label = tnt.backtext ,
                    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                    fontSize = 30,
                    font = myApp.fontBold,
                    onRelease = tnt.callBack,
               }
        else
            if tnt.defaultFile then
               myApp.TitleGroup.backButton = widget.newButton {
                    defaultFile = tnt.defaultFile ,
                    overFile = tnt.overFile ,
                    onRelease = tnt.callBack,
                }
            end
        end

        myApp.TitleGroup.backButton.x = xbackbutton
        myApp.TitleGroup.backButton.y = (myApp.titleBarHeight * 0.5 )  + myApp.tSbch  
        myApp.TitleGroup:insert(myApp.TitleGroup.backButton)

        transition.to( myApp.TitleGroup.backButton, { time=myApp.tabs.transitiontime*2, x = myApp.titleBarEdge *2 , transition=easing.outQuint})
        --------------------------------------------
        -- goto the new scene
        --------------------------------------------
        composer.gotoScene(myApp.scenesfld .. tnt.composer.lua, {time=tnt.composer.time, effect=effect, params = tnt})
 
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


