
-------------------------------------------------------
-- OLoaded once in main, used to override variables and create some common functions
-------------------------------------------------------

local myApp = require( "myapp" ) 

myApp.login.loggedin = false
myApp.justLaunched = true

-------------------------------------------------------
-- Override print function make global
-------------------------------------------------------
reallyPrint = print
function print(...)
    if myApp.debugMode then
        reallyPrint("<-==============================================->") 
        reallyPrint(myApp.appName .. "-> " .. unpack(arg))
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






