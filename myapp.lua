
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local M = { 
            debugMode = true,
            appName = "Insured App Initial" ,
            cW = display.contentWidth,
            cH = display.contentHeight,
            cCx = display.contentCenterX,
            cCy = display.contentCenterY,
            tSbch = display.topStatusBarContentHeight,
            statusBarType = display.TranslucentStatusBar,       "display.DefaultStatusBar",    "display.DarkStatusBar",    "display.TranslucentStatusBar",
            splashDelay = 150,    -- milliseconds
            saColor = { },
            saColorTrans = { },
            colorGray = { },
            isTall = false,
            colorDivisor = 255,
            isGraphics2 = true,
            is_iPad = false,
            titleBarHeight = 50,
            titleBarEdge = 10,
            imgfld = "images/",
            scenesfld = "scenes.",
            utilsfld = "utils.",
            classfld = "classes.",
            theme = "widget_theme_ios7",
            font = "HelveticaNeue-Light",
            fontBold = "HelveticaNeue",
            fontItalic = "HelveticaNeue-LightItalic",
            fontBoldItalic = "Helvetica-BoldItalic",
            sceneStartTop = 0,     -- set elsewhere
            sceneHeight = 0,     -- set elsewhere
            sceneWidth = 0,     -- set elsewhere
            sceneBackground = { r=241/255, g=242/255, b=243/255, a=1 },
            login = {
                        loggedin = false,
                        lua="login",
                        options = {
                                      isModal = true,
                                      effect = "fromTop",
                                      time = 2000,
                                      params = { }
                                   },
                    },
            scenemaskFile = "",
            composerrecycleOnSceneChange = false,
            titleGradient = {
                    type = 'gradient',
                    color1 = { 189/255, 203/255, 220/255, 1 }, 
                    color2 = { 89/255, 116/255, 152/255, 1 },
                    direction = "down"
             },
            parse = {
                        appId = 'nShcc7IgtlMjqroizNXtlVwjtwjfJgLsiRVgvUfA',
                        restApikey = 'DeOzYBpk6bBSha0SJ9cRUc36EbWUmuseajSyBrlF',
                        url = "https://api.parse.com/1",
                        endpoints = {
                                        config  = {
                                                     endpoint = "/config",
                                                     verb = "GET",
                                                  },
                                 
                                        appopened  = {
                                                     endpoint = "/events/AppOpened",
                                                     verb = "POST",
                                                  },
                                        customevent  = {
                                                     endpoint = "/events",    -- pass in actual eventname
                                                     verb = "POST",
                                                  },


                                  },
                    },
            homepage = {
                          items = {
                                      findgas = {title = "Find Gas", pic="images/gas.png",text="Find Gas Prices Near You"},
                                      roasast = {title = "RoadSide Assistance", pic="images/truck.png",text="Flat tire, out of gas ? We can help"},
                                   },
                       },
            tabs = {
                        tabbtnw = 32,tabbtnh = 32, tabBarHeight = 50,frameWidth = 20,launchkey = "home", transitiontime = 200,
                        btns = {
                            home = {
                                        label="Home",lua="home",title="State Auto",time=250, effect="crossFade",def="images/saicon.png",over="images/saicon-down.png"
                                    },
                            video = {
                                        label="My Agent",lua="video",title="My Agent",time=250, effect="slideRight",def="images/agent.png",over="images/agent-down.png",
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