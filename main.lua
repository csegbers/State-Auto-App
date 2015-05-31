--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" )  
local startup = require( myApp.utilsfld .. "startup" ) 
local common = require( myApp.utilsfld .. "common" )  

------------------------------------------------------
print("main: Program Start") 
------------------------------------------------------
--local parse = require( myApp.utilsfld .. "parse" )
--parse.parseGetConfig()
--parse.parseAppOpened() 
------------------------------------------------------
--// testing below come events
------------------------------------------------------
--parse.parseLogEvent("MyCustomEvent",{x=3,y="ccc"})
--parse.parseLogEvent("Error",{code=124,desc="ccedc"})
--// testing above come events

local composer = require( "composer" )
composer.isDebug = myApp.debugMode
composer.recycleOnSceneChange = myApp.composer.recycleOnSceneChange

local widget = require( "widget" )
widget.setTheme(myApp.theme)

require( myApp.utilsfld .. "backgroup" )   -- set the backgroup
require( myApp.utilsfld .. "tabandtop" )   -- set the top and bottom sections
------------------------------------------------------

---------------------------------------------------
--  Sort everything in the correct z-index order
----------------------------------------------------
local stage = display.getCurrentStage()
stage:insert( myApp.moreGroup )
stage:insert( myApp.backGroup )
stage:insert( composer.stage )
stage:insert( myApp.TitleGroup )
stage:insert( myApp.tabBar )
stage:insert( myApp.transContainer )

---------------------------------------------------
--  Splash and launch first page
----------------------------------------------------
require( myApp.utilsfld .. "splash" )      -- transtion from the initial image and launch the first page









