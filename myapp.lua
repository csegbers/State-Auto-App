
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local M = { 
            debugMode = true,
            appName = "State Auto Insured App" ,
            appNameSmall = "Insured App" ,
            urlScheme = "rockhillapp",
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
            promptforphonecalls = true,
            composer = {
                          recycleOnSceneChange = false,
                       },
            webview = {
                         pageloadwaittime = 10000,
                         timeoutmessage = "Page taking too long to load.",
                     },

            objecttypes = {
                        phone = {
                              launch="phone",
                              pic="phone.png",
                              title="Phone",
                              navigation = { systemurl = { url="tel:%s" },},
                            },
                        email = {
                              launch="email",
                              pic="email.png",
                              title="Email",
                              navigation = { popup = { type="mail" ,options={to="%s" },},},
                            },
                        sms = {
                              launch="sms",
                              pic="sms.png",
                              title="SMS Text",
                              navigation = { popup = { type="sms" ,options={to="%s" },},},
                            },
                        web = {
                              launch="web",
                              pic="web.png",
                              title="Web Site",
                              --navigation = { systemurl = { url="%s" },},


                              text="Sample web page",
                              backtext = "<",
                              forwardtext = ">",
                              -- htmlinfo = {
                              --               url="",    --- dyanamically changed
                              --             },
                             sceneinfo = { 
                                               htmlinfo = { url="", } ,  --- dyanamically changed  
                                               scrollblockinfo = { },
                                         },
                              navigation = { composer = {
                                         id = "", --- dyanamically changed
                                         lua="webview",
                                         time=250, 
                                         effect="slideLeft",
                                         effectback="slideRight",
                                      },},

                            },
                        facebook = {
                              launch="facebook",
                              pic="facebook.png",
                              title="Facebook",
                              navigation = { systemurl = { url="%s" },},
                            },
                        twitter = {
                              launch="twitter",
                              pic="twitter.png",
                              title="Twitter",
                              navigation = { systemurl = { url="%s" },},
                            },
                        directions = {
                              launch="directions",
                              pic="map.png",
                              title="Get Directions",
                              navigation = { directions = { address="%s" },},
                            },

                         -- xxdirections = {
                         --                  title = "Contact State Auto", 
                         --                  launch="directions",
                         --                  pic="truck.png",
                         --                  backtext = "<",
                         --                  sceneinfo = { 
                         --                       htmlinfo = {},
                         --                       scrollblockinfo = { object="contactus" , navigate = "subscene"},
                         --                               },
                         --                  navigation = { composer = { id = "contactus",lua="scrollblocks" ,time=250, effect="slideLeft" ,effectback="slideRight", },},
                         --              },


                           },    --objecttypes

            maps = {
                      --googlemapapp = "comgooglemaps-x-callback://",
                      google = 
                             { 
                                 app = "comgooglemaps-x-callback://",
                                 directions = {
                                                 additions = "&directionsmode=driving",
                                              },
                                 search = {
                                                 additions = "&zoom=14",
                                              },
                            },
                      apple = 
                             {
                                 app = "http://maps.apple.com/",
                                 directions = {
                                                 additions = "",
                                              },
                                 search = {
                                                 additions = "",   --&spn=.50
                                              },
                             },
                   },
 
            gps = {
                     --timer = 30000,                           --30 seconds
                     --timebetweenattempts = 100,              --1 seconds
                     --attempts = 0,                             -- cointer
                     --maxattempts = 10,                     
                     --event= "",                               -- set elsewhere
                     haveaccuratelocation = false ,               -- set elsewhere
                     currentlocation = {},                     -- set elsewhere
                     debug = {                                -- will be used if in debugmode
                                latitude=39.896311,
                                longitude=-82.7674464,
                              },
                     addresslocate = {
                                errortitle = "Not Valid Location",
                                errormessage = "Cannot Determine Location: ",
                                loadwaittime = 12000,
                                timeoutmessage = "Taking too long to determine location.",
                                    },
                     currentlocate = {
                                errortitle = "No GPS Signal",
                                errormessage = "Can't sync with GPS. Error: ",
                                    },
                                  
                  },
            authentication = {
                                  loggedin = false
                              },
            otherscenes = { 
                      login = {
                                  loggedin = false,
                                  sceneinfo = { 
                                               htmlinfo = {},
                                               scrollblockinfo = { },

                                               edge = 15,
                                               height = 200,
                                               cornerradius = 2,
                                               groupbackground = { r=235/255, g=235/255, b=235/255, a=1 },
                                               strokecolor = { r=150/255, g=150/255, b=150/255, a=1 },
                                               strokewidth = 1,
 
                                               textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                                               textfontsize=12  ,
                                               btnshape= "rect", --roundedRect",

                                               btncanceldefcolor = { r=160/255, g=160/255, b=160/255, a=1 },  
                                               btncancelovcolor = { r=130/255, g=130/255, b=130/255, a=1 }, 
                                               btncanceldeflabelcolor = { r=255/255, g=255/255, b=255/255, a=1 }, 
                                               btncancelovlabelcolor = { r=100/255, g=100/255, b=100/255, a=1 },  
                                               btncanceltext = "Cancel",

                                               btnlogindefcolor = { r=0/255, g=100/255, b=0/255, a=1 },  
                                               btnloginovcolor = { r=0/255, g=150/255, b=0/255, a=1 }, 
                                               btnlogindeflabelcolor = { r=255/255, g=255/255, b=255/255, a=1 }, 
                                               btnloginovlabelcolor = { r=230/255, g=230/255, b=230/255, a=1 },  
                                               btnlogintext = "Login",                                             

                                               btnfontsize = 14,
                                               btnheight = 25,
                                               btnwidth = 90,

                                               

                                             },
                                  navigation = { composer = {
                                             id = "login",
                                             isModal = true,
                                             lua="login",
                                             overlay=true,
                                             time=700, 
                                             effect="slideDown",
                                             effectback="slideUp",
                                          },},
                              },
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
M.contactus = require( M.myappadds .. "myappcontactus" )  
M.mappings = require( M.myappadds .. "myappmappings" )  
M.locate = require( M.myappadds .. "myapplocate" ).locate 
M.locatepre = require( M.myappadds .. "myapplocate" ).locatepre
M.locatedetails = require( M.myappadds .. "myapplocate" ).locatedetails
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