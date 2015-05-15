
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local M = { 
            debugMode = true,
            appName = "Christmas Corner Initial" ,
            cW = display.contentWidth,
            cH = display.contentHeight,
            cCx = display.contentCenterX,
            cCy = display.contentCenterY,
            tSbch = display.topStatusBarContentHeight,
            splashDelay = 150,    -- milliseconds
            saColor = { },
            saColorTrans = { },
            colorGray = { },
            isTall = false,
            colorDivisor = 255,
            isGraphics2 = true,
            is_iPad = false,
            titleBarHeight = 50,
            imgfld = "images/",
            scenesfld = "",
            utilsfld = "utils.",
            theme = "widget_theme_ios7",
            font = "HelveticaNeue-Light",
            fontBold = "HelveticaNeue",
            fontItalic = "HelveticaNeue-LightItalic",
            fontBoldItalic = "Helvetica-BoldItalic",
            sceneStartTop = 0,     -- set elsewhere
            sceneHeight = 0,     -- set elsewhere
            sceneWidth = 0,     -- set elsewhere
            scenemaskFile = "",
            parse = {
                        appId = '7VPJbmZC067N3H79JZIrFXDzkFWCNFEsaBezDtsW',
                        restApikey = 'utglxB3RVEswoGl0AYuXa3UAKkgITiKvfio72pXB',

                        getConfig = "https://api.parse.com/1/functions/getconfig",

                    },
            tabs = {
                        tabbtnw = 32,tabbtnh = 32, tabBarHeight = 50,frameWidth = 20,launchkey = "home",
                        btns = {
                            home = {
                                        label="Home",lua="home",title="Christmas Corner",time=250, effect="crossFade",def="images/tabbaricon.png",over="images/tabbaricon-down.png"
                                    },
                            video = {
                                        label="Video",lua="video",title="Video",time=250, effect="slideRight",def="images/tabbaricon.png",over="images/tabbaricon-down.png",
                                        options = {
                                                feedName = "video.rss",
                                                --feedURL = "http://gdata.youtube.com/feeds/mobile/users/CoronaLabs/uploads?max-results=20&alt=rss&orderby=published&format=1",
                                                feedURL = "http://gdata.youtube.com/feeds/mobile/users/StateAutoChristmas/uploads?max-results=20&alt=rss&orderby=published&format=1",
                                                icons = "embedded",
                                                displayMode = "videoviewer",
                                                pageTitle = "Corona Videos"
                                                   }                                
                                    },
                            menu = {
                                        label="Menu",lua="menu",title="Menu",time=250, effect="slideDown",def="images/tabbaricon.png",over="images/tabbaricon-down.png"
                                    },
                            blogs = {
                                      label="Blogs",lua="feed",title="Blog",time=250, effect="crossFade",def="images/tabbaricon.png",over="images/tabbaricon-down.png",
                                      options = {
                                            feedName = "corona.rss",
                                            feedURL = "http://www.coronalabs.com/feed/",
                                            icons = "fixed",
                                            displayMode = "webpage",
                                            pageTitle = "Corona Labs"
                                                 }
                                      },
                           pics = {label="Pics",lua="photogallery",title="Pics",stime=250, effect="crossFade",def="images/tabbaricon.png",over="images/tabbaricon-down.png"},
                           maps = {
                                        label="Maps",lua="mapscene",title="Maps",time=250, effect="crossFade",def="images/tabbaricon.png",over="images/tabbaricon-down.png",
                                        options = {
                                                pageTitle = "Corona Headquarters"
                                                 }                              
                                    },
                          debug = {label="Debug",lua="debugapp",title="debug",stime=250, effect="crossFade",def="images/tabbaricon.png",over="images/tabbaricon-down.png"},

                                }
                   },

        }

-------------------------------------------------------
-- Override print function make global
-------------------------------------------------------
reallyPrint = print
function print(...)
    if M.debugMode then
        reallyPrint("<-==============================================->") 
        reallyPrint(M.appName .. "-> " .. unpack(arg))
    end
end
print "In myapp.lua"

-------------------------------------------------------
-- Seed random generator in case we use
-------------------------------------------------------
math.randomseed( os.time() )

-------------------------------------------------------
-- Set app variables
-------------------------------------------------------
if (display.pixelHeight/display.pixelWidth) > 1.5 then
    M.isTall = true
end

if display.contentWidth > 320 then M.is_iPad = true end

--
-- Handle Graphics 2.0 changes
if tonumber( system.getInfo("build") ) < 2013.2000 then
    -- we are a Graphics 1.0 build
    M.colorDivisor = 1
    M.isGraphics2 = false
end

M.saColor = { 0/M.colorDivisor, 104/M.colorDivisor, 167/M.colorDivisor } 
M.saColorTrans = { 0/M.colorDivisor, 104/M.colorDivisor, 167/M.colorDivisor, .75 }
M.colorGray = { 83/M.colorDivisor, 83/M.colorDivisor, 83/M.colorDivisor }

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

local iconInfo = {
    width = 40,
    height = 40,
    numFrames = 20,
    sheetContentWidth = 200,
    sheetContentHeight = 160
}

M.icons = graphics.newImageSheet(M.imgfld.. "ios7icons.png", iconInfo)

return M



-- The following string values are supported for the effect key of the options table:

-- "fade"
-- "crossFade"
-- "zoomOutIn"
-- "zoomOutInFade"
-- "zoomInOut"
-- "zoomInOutFade"
-- "flip"
-- "flipFadeOutIn"
-- "zoomOutInRotate"
-- "zoomOutInFadeRotate"
-- "zoomInOutRotate"
-- "zoomInOutFadeRotate"
-- "fromRight" — over current scene
-- "fromLeft" — over current scene
-- "fromTop" — over current scene
-- "fromBottom" — over current scene
-- "slideLeft" — pushes current scene off
-- "slideRight" — pushes current scene off
-- "slideDown" — pushes current scene off
-- "slideUp" — pushes current scene off