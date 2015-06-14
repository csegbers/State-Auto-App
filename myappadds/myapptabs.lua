
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local tabs = { 

        tabbtnw = 32,tabbtnh = 32, tabBarHeight = 50,frameWidth = 20,launchkey = "ahome", transitiontime = 200,
        btns = {
            ahome = {
                        label="Home", title="State Auto" ,def="saicon.png",over="saicon-down.png",
                        scrollblockinfo = { object="homepage" , navigate = "mainscene"},
                        navigation = { composer = { id = "home",lua="scrollblocks" ,time=250, effect="crossFade" },},
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
                     label="Debug" ,title="Debug" ,def="tabbaricon.png",over="tabbaricon-down.png" ,showonlyindebugMode=true,
                    navigation = { composer = { id = "debug",lua="debugapp" ,time=250, effect="crossFade" },},
                  }
                }
        } 

         

return tabs
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