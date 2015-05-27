
-------------------------------------------------------
-- OLoaded once in main, used to override variables and create some common functions
-------------------------------------------------------

local myApp = require( "myapp" ) 
local parse = require( myApp.utilsfld .. "mod_parse" ) 

myApp.login.loggedin = false
myApp.justLaunched = true

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

-------------------------------------------------------
-- Override print function make global
-------------------------------------------------------
reallyPrint = print
function print(...)
    if myApp.debugMode then
        reallyPrint("<-==============================================->") 
        if type(arg[1]) == "table" then
            print_r(arg[1])
        else
            reallyPrint(myApp.appName .. "-> " .. unpack(arg))
        end
    end
end
print "In startup.lua"

-------------------------------------------------------
-- Seed random generator in case we use
-------------------------------------------------------
math.randomseed( os.time() )

-------------------------------------------------------
----Get User Defaults here
-----------------------------------------------------
display.setStatusBar( myApp.statusBarType )
myApp.tSbch = display.topStatusBarContentHeight 
-- print ("sttaus bar height " .. display.topStatusBarContentHeight )
-------------------------------------------------------
-- Set app variables
-------------------------------------------------------
if (display.pixelHeight/display.pixelWidth) > 1.5 then
    myApp.isTall = true
end

if display.contentWidth > 320 then myApp.is_iPad = true end

--
-- -- Handle Graphics 2.0 changes
-- if tonumber( system.getInfo("build") ) < 2013.2000 then
--     -- we are a Graphics 1.0 build
--     M.colorDivisor = 1
--     M.isGraphics2 = false
-- end

myApp.saColor = { 0/myApp.colorDivisor, 104/myApp.colorDivisor, 167/myApp.colorDivisor } 
myApp.saColorTrans = { 0/myApp.colorDivisor, 104/myApp.colorDivisor, 167/myApp.colorDivisor, .75 }
myApp.colorGray = { 83/myApp.colorDivisor, 83/myApp.colorDivisor, 83/myApp.colorDivisor }

if system.getInfo("platformName") == "Android" then
    myApp.theme = "widget_theme_android"
    myApp.font = "Droid Sans"
    myApp.fontBold = "Droid Sans Bold"
    myApp.fontItalic = "Droid Sans"
    myApp.fontBoldItalic = "Droid Sans Bold"
    myApp.topBarBg = M.imgfld .. "topBarBg7.png"
else
    local coronaBuild = system.getInfo("build")
    if tonumber(coronaBuild:sub(6,12)) < 1206 then myApp.theme = "widget_theme_ios" end
end

-------------------------------------------------------
-- Icon sheet
-------------------------------------------------------
myApp.icons = graphics.newImageSheet(myApp.imgfld.. myApp.iconinfo.sheet,myApp.iconinfo.icondimensions)

-------------------------------------------------------
--  Start Parse
-------------------------------------------------------
parse:init({ appId = myApp.parse.appId , apiKey = myApp.parse.restApikey,})
parse.showStatus = myApp.debugMode-- outputs response info in the console
--parse.showAlert = myApp.debugMode -- show a native pop-up with error and result codes
parse.showJSON = myApp.debugMode -- output the raw JSON response in the console 
--parse.dispatcher:addEventListener( "parseRequest", onParseResponse )
parse:appOpened(function (e) print ("return from appOpened") print (e.requestType)   end )
parse:getObject("Agency","9ez6Z2tcaC", function(e) if not e.error then print ("BBBBAAACCCK " .. e.response.agencyName) end end )
parse:getConfig( function(e) if not e.error then myApp.appName = e.response.params.appName print ("ZZZZZZBBBBAAACCCK " .. e.response.params.appName) end end )
parse:logEvent( "MyCustomEvent", { ["x"] = "modparse" ,["y"] = "ccc"}, function (e) print ("return from home logevent") print (e.requestType)   end )


-------------------------------------------------------
-- Runtime Events
-------------------------------------------------------
function myApp.locationHandler ( event )
    myApp.gps.event = event
    print("locationHandler")
end
function myApp.updateGPS()
    -- Reload GPS location
    Runtime:removeEventListener( "location", myApp.locationHandler )    
    Runtime:addEventListener( "location", myApp.locationHandler )    

    -- Update again
    timer.performWithDelay( myApp.gps.timer, myApp.updateGPS )
end
function myApp.onSystemEvent( event )
   if event.type == "applicationStart" then
        print("onSystemEvent start")
    elseif event.type == "applicationExit" then
        print("onSystemEvent exit")
    elseif event.type == "applicationSuspend" then
        print("onSystemEvent suspend")
    elseif event.type == "applicationResume" then
        print("onSystemEvent resume")
    end
end

myApp.updateGPS()
Runtime:addEventListener( "system", myApp.onSystemEvent )


