
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
                              height = 40,
                              indent = 25,
                              textcolor = 1,
                              textfontsize=14 ,
                              catheight = 25,
                              catcolor = { default={ 180 /255, 200/255, 230/255, 0.7} },
                            },
                      items = {

                               AAlogin = {
                                   title = "Login", 
                                   isCategory = true,
                                      },
                              alocate = {
                                   includeline  = false,       -- needed if prior is header otherwise it looks bad 
                                   title = "Login", 
                                   pic="trustedchoice.png",
                                   originaliconwidth = 196,
                                   originaliconheight = 77,
                                   iconwidth = 120,      -- height will be scaled appropriately
                                   text="Locate agents nearby or from an address",
                                   backtext = "<",
                                  -- groupheader = { r=15/255, g=75/255, b=100/255, a=1 },   -- can override
                                   locateinfo = {
                                                  limit=100,
                                                  miles=25,
                                                  object = "Agency", --- used for mapping and other web services
                                                },
                                   navigation = { composer = {
                                               otherscenes = "login",
                                            },},
                                       },
                               bb0head = {
                                   title = "Support", 
                                   isCategory = true,
                                      },

                               bb3 = {
                                          title = "Contact State Auto", 
                                          pic="truck.png",
                                          backtext = "<",
                                          scrollblockinfo = { object="contactus" , navigate = "subscene"},
                                          navigation = { composer = { id = "contactus",lua="scrollblocks" ,time=250, effect="slideLeft" ,effectback="slideRight", },},
                                      },
                               bb4 = {title = "Help", 
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
                               bb5 = {title = "Terms", 
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

                                bb6 = {title = "Help", 
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
                                   dtt= {title = "Privacy", 
                                    includeline  = false,
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
                               xx0 = {
                                   title = "Settings", 
                                   isCategory = true,
                                      },
                               xx1 = {
                                   includeline  = false,       -- needed if prior is header otherwise it looks bad 
                                   title = "Test", 
                                   pic="trustedchoice.png",
                                   originaliconwidth = 196,
                                   originaliconheight = 77,
                                   iconwidth = 120,      -- height will be scaled appropriately
                                   text="Locate agents nearby or from an address",
                                   backtext = "<",
                                  -- groupheader = { r=15/255, g=75/255, b=100/255, a=1 },   -- can override
                                   locateinfo = {
                                                  limit=100,
                                                  miles=25,
                                                  object = "Agency", --- used for mapping and other web services
                                                },
                                   navigation = { composer = {
                                               id = "alocatemore",
                                               lua="locatepre",
                                               time=250, 
                                               effect="slideLeft",
                                               effectback="slideRight",
                                            },},
                                       },
                               zz0 = {
                                   title = "Extras", 
                                   isCategory = true,
                                      },
                               zz1= {title = "External Launch", 
                                    pic="truck.png",
                                    text="xxxxxx",
                                    backtext = "<",
                                          pic="truck.png",
                                          navigation = { systemurl = { url="tel:614-915-9769"},},
                                            
                                      },

                                 zz2 = {title = "Debug", 
                                          pic="truck.png",
                                          text="Flat tire, out of gas ? We can help really help",
                                           backtext = "<",
                                          navigation = { tabbar = {
                                               id = "xxxmore",
                                               key="gdebug",
                                            },},
                                      },
                              },  --items

     }
                        
        
return moreinfo