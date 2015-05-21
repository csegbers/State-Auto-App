------------------------------------------------------
print ("tabandtop: IN")
------------------------------------------------------

local myApp = require( "myapp" ) 
local widget = require( "widget" )
local common = require( "common" )
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
local titleBar = display.newImageRect(myApp.topBarBg, myApp.cW, myApp.titleBarHeight)
titleBar.x = myApp.cCx
titleBar.y = (myApp.titleBarHeight * 0.5 )+ myApp.tSbch
titleBar:setFillColor( myApp.titleGradient )
myApp.TitleGroup:insert(titleBar)

----------------------------------------------------------
--   text in the Titlebar
----------------------------------------------------------
--local titleText = display.newText(myApp.tabs.btns[myApp.tabs.launchkey].title, 0, 0, myApp.fontBold, 20 )
local titleText = display.newText("", 0, 0, myApp.fontBold, 20 )
if myApp.isGraphics2 then
    titleText:setFillColor(1, 1, 1)
else
    titleText:setTextColor( 255, 255, 255 )
end
titleText.x = myApp.cCx
titleText.y = titleBar.height * 0.5 + myApp.tSbch 
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
    local btnrntry = myApp.tabs.btns[tkey]
    btnrntry.sel=tabCnt
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
            onPress = function () myApp.showScreen({key=tkey}) end,
        }
    table.insert(tabButtons, tabitem)
end

---- following wors just puts them in random order
-- for k,v in pairs(myApp.tabs.btns) do 
--     addtabBtn(k)
-- end

addtabBtn("home")
addtabBtn("video")
addtabBtn("menu")
addtabBtn("blogs")
addtabBtn("pics")
addtabBtn("maps")
addtabBtn("debug")

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
--   Common info fot the screens
----------------------------------------------------------
myApp.sceneStartTop = titleBar.height + myApp.tSbch
myApp.sceneHeight = myApp.cH - myApp.sceneStartTop - myApp.tabBar.height
myApp.sceneWidth = myApp.cW

myApp.scenemaskFile = myApp.imgfld .. "mask-320x380.png"
if myApp.is_iPad then
    myApp.scenemaskFile = myApp.imgfld .. "mask-360x380.png"
end
if myApp.isTall then
    myApp.scenemaskFile = myApp.imgfld .. "mask-320x448.png"
end


--------------------------------------------------
-- Show screen
--------------------------------------------------
function myApp.showScreen(parms)
    local function showScreenIcon()
        ----------------------------------------------------------
        --   This is the title bar icon
        ----------------------------------------------------------
        display.remove(myApp.TitleGroup.titleIcon)    -- may not exist first time, this wont hurt
        local titleIcon = display.newImageRect(myApp.tabs.btns[parms.key].over,myApp.tabs.tabbtnh,myApp.tabs.tabbtnw)
        common.fitImage( titleIcon, myApp.titleBarHeight - myApp.titleBarEdge, false )
        titleIcon.x = myApp.titleBarEdge + (titleIcon.width * 0.5 )
        titleIcon.y = (myApp.titleBarHeight * 0.5 )+ myApp.tSbch
        print ("icon scale " .. titleIcon.xScale)
        titleIcon.alpha = 0
        myApp.TitleGroup.titleIcon = titleIcon
        myApp.TitleGroup:insert(myApp.TitleGroup.titleIcon)
        transition.to( myApp.TitleGroup.titleIcon, { time=100, alpha=1 })
    end
    print ("goto " .. parms.key)
    local tnt = myApp.tabs.btns[parms.key]
    myApp.tabBar:setSelected(tnt.sel)
    --myApp.TitleGroup.titleText.text = tnt.label
    if parms.firsttime  then
        myApp.TitleGroup.titleText.text = tnt.title
        showScreenIcon()
    else
        transition.to( myApp.TitleGroup.titleText, { time=200, alpha=.2,onComplete= function () myApp.TitleGroup.titleText.text = tnt.title;  transition.to( myApp.TitleGroup.titleText, {alpha=1, time=200}) end } )
        transition.to( myApp.TitleGroup.titleIcon, { time=200, alpha=0 ,onComplete=showScreenIcon})
    end
    composer.gotoScene(myApp.scenesfld .. tnt.lua, {time=tnt.time, effect=tnt.effect, params = tnt.options})
    return true
end

------------------------------------------------------
print ("tabandtop: OUT")
------------------------------------------------------


