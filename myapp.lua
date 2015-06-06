
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
            saColor = { },
            saColorTrans = { },
            colorGray = { },
            isTall = false,
            colorDivisor = 255,
            isGraphics2 = true,
            is_iPad = false,
            titleBarHeight = 50,
            titleBarEdge = 10,
            titleBarTextColor = { r=255/255, g=255/255, b=255/255, a=1 },
            imgfld = "images/",
            myappadds = "myappadds.",
            scenesfld = "scenes.",
            utilsfld = "utils.",
            classfld = "classes.",
            htmlfld = "html/",
            theme = "widget_theme_ios7",
            font = "HelveticaNeue-Light",
            fontBold = "HelveticaNeue",
            fontItalic = "HelveticaNeue-LightItalic",
            fontBoldItalic = "Helvetica-BoldItalic",
            sceneStartTop = 0,     -- set elsewhere
            sceneHeight = 0,     -- set elsewhere
            sceneWidth = 0,     -- set elsewhere
            sceneBackgroundcolor = { r=241/255, g=242/255, b=243/255, a=1 },
            sceneBackgroundmorecolor = { r=25/255, g=75/255, b=150/255, a=1 },
            scenemaskFile = "",
            splash = {image = "splash.jpg", delay = 150, },
 
            gps = {
                     --timer = 30000,                           --30 seconds
                     --timebetweenattempts = 100,              --1 seconds
                     --attempts = 0,                             -- cointer
                     --maxattempts = 10,                     
                     --event= "",                               -- set elsewhere
                     haveaccuratelocation = false ,  
                     currentlocation = {},                     -- set elsewhere
                     debug = {                                -- will be used if in debugmode
                                latitude=39.896311,
                                longitude=-82.7674464,
                              },
                     addresslocate = {
                                errortitle = "Not Valid Location",
                                errormessage = "Cannot Determine Location: ",
                                    },
                     currentlocate = {
                                errortitle = "No GPS Signal",
                                errormessage = "Can't sync with GPS. Error: ",
                                    },
                                  
                  },
            login = {
                        loggedin = false,
                        lua = "login",
                        options = {
                                      isModal = true,
                                      effect = "fromTop",
                                      time = 1000,
                                       params = { }
                                   },
                    },
            composer = {
                          recycleOnSceneChange = false,
                       },
            titleGradient = {
                    type = 'gradient',
                    color1 = { 189/255, 203/255, 220/255, 1 }, 
                    color2 = { 89/255, 116/255, 152/255, 1 },
                    direction = "down"
             },
            icons = "",
            iconinfo = 
               {
                       icondimensions = {
                              width = 40,
                              height = 40,
                              numFrames = 20,
                              sheetContentWidth = 200,
                              sheetContentHeight = 160
                              },
                        sheet = "ios7icons.png",
                },
            parse = {
                        appId = 'nShcc7IgtlMjqroizNXtlVwjtwjfJgLsiRVgvUfA',
                        restApikey = 'DeOzYBpk6bBSha0SJ9cRUc36EbWUmuseajSyBrlF',
                        url = "https://api.parse.com/1",
                        -- endpoints = {
                        --                 config  = {
                        --                              endpoint = "/config",
                        --                              verb = "GET",
                        --                           },
                                 
                        --                 appopened  = {
                        --                              endpoint = "/events/AppOpened",
                        --                              verb = "POST",
                        --                           },
                        --                 customevent  = {
                        --                              endpoint = "/events",    -- pass in actual eventname
                        --                              verb = "POST",
                        --                           },


                        --           },
                    },

            -- locateanagent = {    -- tem,poirary for now
            --             gps ={
            --                     limit=50,
            --                     miles=30
            --                   },
            --             agentinfo = {
            --                  title = "Agent Info", 
            --                  backtext = "<",
            --                  groupheader = { r=53/255, g=48/255, b=102/255, a=1 },
            --                  navigation = { composer = {
            --                              id = "agentinfo1",
            --                              lua="agent",
            --                              time=250, 
            --                              effect="slideLeft",
            --                              effectback="slideRight",
            --                           },},
            --                      },
                                 
            --            },
             locatepre = {    

                                edge=10,
                                groupheight = 130,
                                groupheaderheight = 40,
                                groupbackground = { r=255/255, g=255/255, b=255/255, a=1 },
                                groupstrokewidth = 1,
                                groupheader = { r=25/255, g=75/255, b=150/255, a=1 },
                                iconwidth = 60,    -- can be overidden in item
                                iconheight = 60,   -- can be overidden in item
                                headercolor = { r=255/255, g=255/255, b=255/255, a=1 },   
                                headerfontsize = 17,  
                                textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                                textfontsize=16  ,   
                                textbottomedge =2   ,  
                                shape="roundedRect",
                                curlocbtntext = "Use Current Location",

                                addressbtntext= "Use Location Entered Below",
                                addresstextfontsize=14  , 
                                btnheight = 35,
                                milerange = {low=5,high=100},
                                lua="locate",
                                effect="slideLeft",
                                effectback="slideRight",
                                addressfieldheight = 50,
                                addressfieldcornerradius = 6,
                                addressfieldplaceholder = "Enter zip, city/state or address",
                                addresslocate = {
                                       errortitle = "Location Not Entered", 
                                       errormessage = "Please Enter A Valid Location",
                                                },
                                 
                       },
             locate = {    

                                edge=10,
                                groupheight = 40,
                                groupbackground = { r=180/255, g=180/255, b=180/255, a=1 },
                                groupstrokewidth = 0,

                                textcolor = { r=255/255, g=255/255, b=255/255, a=1 },   
                                textfontsize=15  ,   
                                textbottomedge =2   ,

                                tableheight=180,  
                                row={
                                       height=60,
                                       rowColor = { 1, 1, 1 },
                                       lineColor = { 220/255 },
                                       nametextfontsize=16  , 
                                       nametexty = 15,
                                       nametextx = 10,
                                       nametextColor = 0,
                                       addresstextfontsize = 10,
                                       addresstexty= 40,
                                       addresstextx= 10,
                                       addressColor = 0.5,
                                       milestextfontsize = 13,
                                       milesColor = 0.5,
                                       milestexty = 45,
                                       milestextx = 210,
                                       arrowwidth = 40,
                                       arrowheight = 40,
                                    },
                                map = {
                                          latitudespan = .25,
                                          longitudespan = .25,
                                          type = "standard" ,
                                      },

                                 
                       },

            --========================
            --== Device
            --========================
            deviceinfo = {
                            infoname = {name="name",title="Name"},
                            infoenvironment = {name="environment",title="Environment"},
                            infoplatformName = {name="platformName",title="Plat Name"},
                            infoplatformVersion = {name="platformVersion",title="Plat Version"},
                            infoversion = {name="version",title="Version"},
                            infobuild = {name="build",title="Corona BLD"},
                            infotextureMemoryUsed = {name="textureMemoryUsed",title="Memory Used"},
                            infoarchitectureInfo = {name="architectureInfo",title="Architecture"},
                            pref1 = {cat="ui",name="language",title="UI Lang"},
                            pref2 = {cat="locale",name="country",title="Loc Country"},
                            pref3 = {cat="locale",name="identifier",title="Loc ID"},
                            pref4 = {cat="locale",name="language",title="Loc Lang"},
                        },
  

        }
M.tabs     = require( M.myappadds .. "myapptabs" )  
M.moreinfo = require( M.myappadds .. "myappmoreinfo" )  
M.homepage = require( M.myappadds .. "myapphomepage" )  
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