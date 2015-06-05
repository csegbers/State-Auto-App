
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local homepage = { 

            --------------------------------------------------------
            -- note: physical order of items does not matter. 
            -- Order is based on alphabetical based on key 
            --------------------------------------------------------
         
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
                                                          mapping = {name = "agencyName", miles = "milesTo", geo="agencyGeo"},
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
                                                          limit=100,
                                                          miles=10,
                                                          mapping = {name = "CompanyName", miles = "milesTo", geo="ShopGeo"},
                                                        },
                                                  navigation = { composer = {
                                                       id = "alocateqsg",
                                                       lua="locatepre",
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
            }
      
return homepage