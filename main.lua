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

parse:init({ appId = myApp.parse.appId , apiKey = myApp.parse.restApikey,})
parse.showStatus = myApp.debugMode-- outputs response info in the console
parse.showAlert = myApp.debugMode -- show a native pop-up with error and result codes
parse.showJSON = myApp.debugMode -- output the raw JSON response in the console 
--parse.dispatcher:addEventListener( "parseRequest", onParseResponse )
parse:appOpened(onAppOpened)


myApp.parseConfigListener  = function (event)
print "IN parseConfigListener"
-- print (event)
   if not event.error then
     print( "IN parseConfigListener no error " .. event.name .. " " ..  event.requestType)
     if event.response then
     print( "IN parseConfigListener no error table" .. event.response.agencyName)
     end
   end
   -- --if event.phase == "ended" then
   --    local response = event.response
   --    print ("Return From Network Request " .. response)
   --    local t = json.decode(response)
   --    if t.error ~= nil then
   --        print ("ERROR - Listener " .. t.error)
   --    else
   --        local r = t.params
   --        local x2 = r.TestParmObject
   --        myApp.appName = r.appName
   --     end
   -- -- end
end
parse:getObject("Agency","9ez6Z2tcaC",myApp.parseConfigListener )
--parse:logEvent( "MyCustomEvent", { ["x"] = "modparse" ,["y"] = "ccc"} )

------------------------------------------------------
--// testing below come events
------------------------------------------------------
--parse.parseLogEvent("MyCustomEvent",{x=3,y="ccc"})
--parse.parseLogEvent("Error",{code=124,desc="ccedc"})
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









