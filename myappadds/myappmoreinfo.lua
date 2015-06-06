
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local moreinfo = { 

           
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
                                           desc="Agents",
                                           backtext = "<",
                                          -- groupheader = { r=15/255, g=75/255, b=100/255, a=1 },   -- can override
                                           locateinfo = {
                                                          functionname="getagenciesnearby",
                                                          limit=100,
                                                          miles=25,
                                                          mapping = {name = "agencyName", miles = "milesTo", geo="agencyGeo"},
                                                        },
                                           navigation = { composer = {
                                                       id = "alocatemore",
                                                       lua="locatepre",
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

     }
                        
        
return moreinfo