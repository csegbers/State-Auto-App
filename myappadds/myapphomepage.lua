
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
                                            limit=100,
                                            miles=25,
                                            object = "Agency", --- used for mapping and other web services
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
                                            limit=100,
                                            miles=10,
                                            object = "BodyShop", --- used for mapping and other web services
                                          },
                                    navigation = { composer = {
                                         id = "alocateqsg",
                                         lua="locatepre",
                                         time=250, 
                                         effect="slideLeft",
                                         effectback="slideRight",
                                      },},
                                   },
                          ccc = {title = "Roadside Assistance", pic="towing.png",text="Locate nearby towing services" ,
                               navigation = { search = { q="Towing" },},
                                      
                                  },
                          dss = {title = "State Auto Web", 
                              pic="web.png",
                              text="Sample web page",
                              backtext = "<",
                              forwardtext = ">",
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
                              pic="web.png",
                              text="Sample web page",
                              backtext = "<",
                              navigation = { systemurl = {
                                   url="http://www.cnn.com/"
                                },},
                                      
                                },
                          eb44 = {title = "Nearby gas stations", pic="gas.png",text="locate nearby gas stations" ,
                               navigation = { search = { q="Gas Station" },},
                                      
                                  },
                           ec3t = {title = "Directions to segbers", pic="map.png",text="Get directions to segber shouse" ,
                               navigation = { directions = { address="12293 Mallard Pond Ct Pickerington Ohio 43147" },},
                                      
                                  },
                           et3t = {title = "Phone Call", pic="phone.png",text="Flat tire, out of gas ? We can help" ,
                               navigation = { systemurl = { url="tel:614-915-9769"},},
                                      
                                  },
                           ey3t = {title = "Text", pic="sms.png",text="send a text" ,
                               navigation = { popup = { type="sms",options= {to="614-915-9769"},},},
                                      
                                  },
                         fttt = {title = "Mail", pic="email.png",text="Flat tire, out of gas ? We can help", 
                               navigation = { popup = { type="mail", options= {to="nobody@mycompany.com", subject="hi there"},},},
                                 },
                     },   --items
            }
      
return homepage