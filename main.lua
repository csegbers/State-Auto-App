--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" )  
local parse = require( myApp.utilsfld .. "mod_parse" )  
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

parse:init({ appId = myApp.parse.appId , apiKey = myApp.parse.restApikey,})
parse.showStatus = myApp.debugMode-- outputs response info in the console
--parse.showAlert = myApp.debugMode -- show a native pop-up with error and result codes
parse.showJSON = myApp.debugMode -- output the raw JSON response in the console 
--parse.dispatcher:addEventListener( "parseRequest", onParseResponse )
parse:appOpened(function (e) print ("return from appOpened") print (e.requestType)   end )
parse:getObject("Agency","9ez6Z2tcaC", function(e) if not e.error then print ("BBBBAAACCCK " .. e.response.agencyName) end end )
parse:getConfig( function(e) if not e.error then myApp.appName = e.response.params.appName print ("ZZZZZZBBBBAAACCCK " .. e.response.params.appName) end end )
parse:logEvent( "MyCustomEvent", { ["x"] = "modparse" ,["y"] = "ccc"}, function (e) print ("return from logevent") print (e.requestType)   end )

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









