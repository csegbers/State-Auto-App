--====================================================================--
-- Christmas Corner
--====================================================================--
local myApp = require( "myapp" ) 
------------------------------------------------------
print("main: Program Start") 
------------------------------------------------------
local parse = require( "parse" )

local composer = require( "composer" )
composer.isDebug = myApp.debugMode
composer.recycleOnSceneChange = true

local widget = require( "widget" )
widget.setTheme(myApp.theme)
------------------------------------------------------
print ("main: After Main Requires")
------------------------------------------------------

parse.parseGetConfig()

--------------------------------------------------
-- Home screen
--------------------------------------------------
function myApp.showScreen(parms)
    print ("goto " .. parms.key)
    local tnt = myApp.tabs.btns[parms.key]
    myApp.tabBar:setSelected(tnt.sel)
    --myApp.TitleGroup.titleText.text = tnt.label
    if parms.notitlefade  then
        myApp.TitleGroup.titleText.text = tnt.title
    else
        transition.to( myApp.TitleGroup.titleText, { time=200, alpha=.2,onComplete= function () myApp.TitleGroup.titleText.text = tnt.title;  transition.to( myApp.TitleGroup.titleText, {alpha=1, time=200}) end } )
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









