
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
            moreinfo = {
                      imsliding = false,
                      transitiontime = 700,
                      transitiontimealpha = 200,
                      direction = "left",     -- initial direction
                      movefactor = 1.2,      -- how much left or right. Less means less showing of the main screen
                      morebutton = {
                                      defaultFile="morebutton.png",
                                      overFile="morebutton-down.png",
                                      },
                      transparentcolor = { r=255/255, g=255/255, b=255/255, a=1 },
                      transparentalpha = .7,
                      row = {
                              over={ 1, 0.5, 0, 0.2 },
                              linecolor={ 200/255 },
                              height = 50,
                              indent = 25,
                              textcolor = 1,
                              textfontsize=14 
                            },
                      items = {
                                      alocate = {
                                           title = "Locate an Agent more", 
                                           pic="trustedchoice.png",
                                           originaliconwidth = 196,
                                           originaliconheight = 77,
                                           iconwidth = 120,      -- height will be scaled appropriately
                                           text="Locate agents nearby or from an address",
                                           backtext = "<",
                                          -- groupheader = { r=15/255, g=75/255, b=100/255, a=1 },   -- can override
                                           locateinfo = {
                                                          functionname="getagenciesnearby",
                                                          limit=20,
                                                          miles=25,
                                                          mapping = {name = "agencyName", miles = "milesTo"},
                                                        },
                                           navigation = { composer = {
                                                       id = "alocate1",    -- same id as home page item. This way if selected on we are on that screen dont do anything
                                                       lua="locate",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                               },
                                       broasast = {title = "Terms", 
                                                   pic="truck.png",
                                                   text="Flat tire, out of gas ? We can help",
                                                   backtext = "<",
                                                  htmlinfo = {
                                                          htmlfile="terms.html" ,
                                                          dir = system.ResourceDirectory ,
                                                        },
                                                  navigation = { composer = {
                                                       id = "term",
                                                       lua="webview",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                 },
                                        bzoasast = {title = "Help", 
                                                   pic="truck.png",
                                                   text="Flat tire, out of gas ? We can help",
                                                   backtext = "<",
                                                  htmlinfo = {
                                                          htmlfile="help.html" ,
                                                          dir = system.ResourceDirectory ,
                                                        },
                                                  navigation = { composer = {
                                                       id = "help",
                                                       lua="webview",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                 },
                                       css = {title = "Debug", 
                                                  pic="truck.png",
                                                  text="Flat tire, out of gas ? We can help really help",
                                                   backtext = "<",
                                                  locateinfo = {
                                                          functionname="getagenciesnearby",
                                                          limit=2,
                                                          miles=50,
                                                        },
                                                  navigation = { tabbar = {
                                                       id = "xxxmore",
                                                       key="gdebug",
                                                    },},
                                              },
                                          dtt= {title = "Yahoo Web", 
                                            pic="truck.png",
                                            text="Sample web page",
                                            backtext = "<",
                                                  pic="truck.png",
                                                  htmlinfo = {
                                                          url="http://www.yahoo.com/" ,
                                                        },
                                                  navigation = { composer = {
                                                       id = "yahooweb6",
                                                       lua="webview",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                    
                                              },
                                           dtt= {title = "Privacy", 
                                            pic="truck.png",
                                            text="Sample web page",
                                            backtext = "<",
                                                  pic="truck.png",
                                                  htmlinfo = {
                                                          htmlfile="privacy.html" ,
                                                          dir = system.ResourceDirectory ,
                                                        },
                                                  navigation = { composer = {
                                                       id = "yahooweb6",
                                                       lua="webview",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                    
                                              },

                                          edd= {title = "External Launch", 
                                            pic="truck.png",
                                            text="xxxxxx",
                                            backtext = "<",
                                                  pic="truck.png",
                                                  navigation = { systemurl = { url="tel:614-915-9769"},},
                                                    
                                              },
                                      },


                        },
            gps = {
                     timer = 30000,                           --30 seconds
                     event= "",                               -- set elsewhere
                     debug = {                                -- will be used if in debugmode
                                latitude=39.896311,
                                longitude=-82.7674464,
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
            --------------------------------------------------------
            -- note: physical order of items does not matter. 
            -- Order is based on alphabetical based on key 
            --------------------------------------------------------
            homepage = {
                          groupwidth = 120,
                          groupmaxwidth = 170,     -- we will allow to grow to fit better if there is extra edging. This would be max however
                          groupheight = 140,
                          groupheaderheight = 20,
                          groupbetween = 10,
                          groupbackground = { r=255/255, g=255/255, b=255/255, a=1 },
                          groupheader = { r=25/255, g=75/255, b=150/255, a=1 },
                          iconwidth = 60,    -- can be overidden in item
                          iconheight = 60,   -- can be overidden in item
                          headercolor = { r=255/255, g=255/255, b=255/255, a=1 },   
                          headerfontsize = 13,  
                          textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                          textfontsize=12   ,       
                          textbottomedge =12   ,           
                          items = {
                                      alocate = {
                                           title = "Locate an Agent", 
                                           pic="trustedchoice.png",
                                           originaliconwidth = 196,
                                           originaliconheight = 77,
                                           iconwidth = 120,      -- height will be scaled appropriately
                                           text="Locate agents nearby or from an address",
                                           backtext = "<",
                                           --groupheader = { r=15/255, g=75/255, b=100/255, a=1 },   -- can override
                                           locateinfo = {
                                                          functionname="getagenciesnearby",
                                                          limit=100,
                                                          miles=25,
                                                          mapping = {name = "agencyName", miles = "milesTo"},
                                                        },
                                           navigation = { composer = {
                                                       id = "alocate1",
                                                       lua="locatepre",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                               },
                                       broasast = {title = "Certified Repair Shops", 
                                                   pic="qsg.png",
                                                   text="Locate certified repair shops nearby or from an address",
                                                   backtext = "<",
                                                  locateinfo = {
                                                          functionname="getbodyshopsnearby",
                                                          limit=5,
                                                          miles=50,
                                                          mapping = {name = "CompanyName", miles = "milesTo"},
                                                        },
                                                  navigation = { composer = {
                                                       id = "alocateqsg",
                                                       lua="locate",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                 },
                                        css = {title = "debug", 
                                            pic="truck.png",
                                            text="Flat tire, out of gas ? We can help really help",
                                            backtext = "<",
                                                  pic="truck.png",

                                             navigation = { tabbar = {
                                                       id = "xxxxx",
                                                       key="gdebug",
                                                    },},
                                              },
                                        dss = {title = "State Auto Web", 
                                            pic="truck.png",
                                            text="Sample web page",
                                            backtext = "<",
                                            forwardtext = ">",
                                                  pic="truck.png",
                                                  htmlinfo = {
                                                          url="http://www.stateauto.com/" ,
                                                        },
                                                  navigation = { composer = {
                                                       id = "stateautoweb",
                                                       lua="webview",
                                                       time=250, 
                                                       effect="slideLeft",
                                                       effectback="slideRight",
                                                    },},
                                                    
                                              },
                                          dtt= {title = "CNN Launch separate", 
                                            pic="truck.png",
                                            text="Sample web page",
                                            backtext = "<",
                                                  pic="truck.png",
                                                  navigation = { systemurl = {
                                                       url="http://www.cnn.com/"
                                                    },},
                                                    
                                              },
                                         et3t = {title = "Phone Call", pic="truck.png",text="Flat tire, out of gas ? We can help" ,
                                             navigation = { systemurl = { url="tel:614-915-9769"},},
                                                    
                                                },
                                       fttt = {title = "Mail", pic="truck.png",text="Flat tire, out of gas ? We can help", 
                                             navigation = { systemurl = { url="mailto:nobody@mycompany.com?subject=hi%20there"},},
                                               },
                                   },
                       },
            locateanagent = {    -- tem,poirary for now
                        gps ={
                                limit=50,
                                miles=30
                              },
                        agentinfo = {
                             title = "Agent Info", 
                             backtext = "<",
                             groupheader = { r=53/255, g=48/255, b=102/255, a=1 },
                             navigation = { composer = {
                                         id = "agentinfo1",
                                         lua="agent",
                                         time=250, 
                                         effect="slideLeft",
                                         effectback="slideRight",
                                      },},
                                 },
                                 
                       },
             locatepre = {    

                                edge=10,
                                groupheight = 130,
                                groupheaderheight = 40,
                                groupbackground = { r=255/255, g=255/255, b=255/255, a=1 },
                                groupheader = { r=25/255, g=75/255, b=150/255, a=1 },
                                iconwidth = 60,    -- can be overidden in item
                                iconheight = 60,   -- can be overidden in item
                                headercolor = { r=255/255, g=255/255, b=255/255, a=1 },   
                                headerfontsize = 17,  
                                textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                                textfontsize=16  ,   
                                textbottomedge =2   ,  
 
                                 
                       },
               tabs = {

                        tabbtnw = 32,tabbtnh = 32, tabBarHeight = 50,frameWidth = 20,launchkey = "ahome", transitiontime = 200,
                        btns = {
                            ahome = {
                                        label="Home", title="State Auto" ,def="saicon.png",over="saicon-down.png",
                                        navigation = { composer = { id = "home",lua="home" ,time=250, effect="crossFade" },},
                                    },
                            bvideo = {
                                        label="My Agent" ,title="My Agent" ,def="myagent.png",over="myagent-down.png",
                                        navigation = { composer = {id = "video", lua="video" ,time=250, effect="slideRight" },},
                                        options = {
                                                feedName = "video.rss",
                                                --feedURL = "http://gdata.youtube.com/feeds/mobile/users/CoronaLabs/uploads?max-results=20&alt=rss&orderby=published&format=1",
                                                feedURL = "http://gdata.youtube.com/feeds/mobile/users/StateAutoChristmas/uploads?max-results=20&alt=rss&orderby=published&format=1",
                                                icons = "embedded",
                                                displayMode = "videoviewer",
                                                pageTitle = "Corona Videos"
                                                   }                                
                                    },
                            cmenu = {
                                        label="Account",  title="Menu" ,def="account.png",over="account-down.png",
                                        navigation = { composer = { id = "account",lua="menu" ,time=250, effect="slideDown" },},
                                    },
                            dblogs = {
                                      label="Blogs" ,title="Blog" ,def="tabbaricon.png",over="tabbaricon-down.png",
                                      navigation = { composer = {id = "blog", lua="feed" ,time=250, effect="crossFade" },},
                                      options = {
                                            feedName = "corona.rss",
                                            feedURL = "http://www.coronalabs.com/feed/",
                                            icons = "fixed",
                                            displayMode = "webpage",
                                            pageTitle = "Corona Labs"
                                                 }
                                      },
                           epics = {
                                    label="Pics" ,title="Pics",def="tabbaricon.png",over="tabbaricon-down.png",
                                    navigation = { composer = { id = "epic",lua="photogallery" ,time=250, effect="crossFade" },},
                                   },
                           
                           fmaps = {
                                        label="Maps", title="Maps",def="tabbaricon.png",over="tabbaricon-down.png",
                                        navigation = { composer = {id = "maps", lua="mapscene" ,time=250, effect="crossFade" },},
                                        options = {
                                                pageTitle = "Corona Headquarters"
                                                 }                              
                                    },
                          gdebug = {
                                     label="Debug" ,title="Debug" ,def="tabbaricon.png",over="tabbaricon-down.png" ,
                                    navigation = { composer = { id = "debug",lua="debugapp" ,time=250, effect="crossFade" },},
                                  }
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