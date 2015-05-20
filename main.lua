--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" ) 
local common = require( "common" )
------------------------------------------------------
print("main: Program Start") 
------------------------------------------------------
local parse = require( "parse" )
parse.parseGetConfig()
parse.parseAppOpened()

--// testing below come events
parse.parseLogEvent("MyCustomEvent",{x=3,y="ccc"})
parse.parseLogEvent("Error",{code=124,desc="ccedc"})
--// testing above come events

local composer = require( "composer" )
composer.isDebug = myApp.debugMode
composer.recycleOnSceneChange = true

local widget = require( "widget" )
widget.setTheme(myApp.theme)
------------------------------------------------------
print ("main: After Main Requires")
------------------------------------------------------

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
        myApp.TitleGroup.titleIcon = titleIcon
        myApp.TitleGroup.titleIcon.alpha = 0
        myApp.TitleGroup:insert(titleIcon)
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

require( myApp.utilsfld .. "tabandtop" )   -- set the top and bottom sections

---------------------------------------------------
--  Sort everything in the correct z-index order
----------------------------------------------------
local stage = display.getCurrentStage()
stage:insert( myApp.backGroup )
stage:insert( composer.stage )
stage:insert( myApp.TitleGroup )
stage:insert( myApp.tabBar )

require( myApp.utilsfld .. "splash" )      -- transtion from the initial image and launch the first page









