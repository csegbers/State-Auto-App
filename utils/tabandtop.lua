------------------------------------------------------
print ("tabandtop: IN")
------------------------------------------------------

local myApp = require( "myapp" ) 
local widget = require( "widget" )
local common = require( "common" )

----------------------------------------------------------
--    background 
----------------------------------------------------------
myApp.backGroup = display.newGroup( )


local background = common.SceneBackground()

local backlogo = display.newImageRect("salogo.jpg",305,170)
backlogo.x = myApp.cCx
backlogo.y = myApp.cCy
backlogo.alpha = .1

myApp.backGroup:insert(background)
myApp.backGroup:insert(backlogo)

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
myApp.TitleGroup:insert(titleBar)

----------------------------------------------------------
--   text in the Titlebar
----------------------------------------------------------
local titleText = display.newText(myApp.tabs.btns[myApp.tabs.launchkey].title, 0, 0, myApp.fontBold, 20 )
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





