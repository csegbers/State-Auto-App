--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" ) 
local startup = require( myApp.utilsfld .. "startup" ) 
local common = require( "common" )

------------------------------------------------------
print("main: Program Start") 
------------------------------------------------------
local parse = require( "parse" )
parse.parseGetConfig()
parse.parseAppOpened()

------------------------------------------------------
--// testing below come events
------------------------------------------------------
parse.parseLogEvent("MyCustomEvent",{x=3,y="ccc"})
parse.parseLogEvent("Error",{code=124,desc="ccedc"})
--// testing above come events

local composer = require( "composer" )
composer.isDebug = myApp.debugMode
composer.recycleOnSceneChange = myApp.composerrecycleOnSceneChange

local widget = require( "widget" )
widget.setTheme(myApp.theme)


------------------------------------------------------
print ("main: After Main Requires")
------------------------------------------------------
require( myApp.utilsfld .. "tabandtop" )   -- set the top and bottom sections

---------------------------------------------------
--  Sort everything in the correct z-index order
----------------------------------------------------
local stage = display.getCurrentStage()
stage:insert( myApp.backGroup )
stage:insert( composer.stage )
stage:insert( myApp.TitleGroup )
stage:insert( myApp.tabBar )

---------------------------------------------------
--  Splash and launch first page
----------------------------------------------------
require( myApp.utilsfld .. "splash" )      -- transtion from the initial image and launch the first page









