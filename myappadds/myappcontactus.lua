
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local contactus = { 

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

                          -- ccc = {title = "Roadside Assistance", pic="towing.png",text="Locate nearby towing services" ,
                          --      navigation = { search = { q="Towing" },},
                                      
                          --         },


                               -- bb5 = {title = "video", 
                               --             pic="video.png",
                               --             text="Flat tire, out of gas ? We can help",
                               --             backtext = "<",

                               --            sceneinfo = { 
                               --                  htmlinfo = {
                               --                      youtubeid="6EKIB8vhki8" ,
                               --                  },
                               --                 scrollblockinfo = { },
                               --               },
                               --            navigation = { composer = {
                               --                 id = "term",
                               --                 lua="webview",
                               --                 time=250, 
                               --                 effect="slideLeft",
                               --                 effectback="slideRight",
                               --              },},
                               --           },

                          dss = {title = "State Auto Web", 
                              pic="web.png",
                              text="State Auto main website",
                              backtext = "<",
                              forwardtext = ">",

                             sceneinfo = { 
                                  htmlinfo = {     url="http://www.stateauto.com/" , },
                                 scrollblockinfo = { },
                                             },
                              navigation = { composer = {
                                   id = "stateautoweb",
                                   lua="webview",
                                   time=250, 
                                   effect="slideLeft",
                                   effectback="slideRight",
                                },},
                                
                                },
                            dsu = {title = "Live Chat", 
                              pic="livechat.png",
                              text="Chat live with a State Auto representative",
                              backtext = "<",
                             -- forwardtext = ">",

                             sceneinfo = { 
                                  htmlinfo = {     url="https://stateauto.webex.com/stateauto/supportcenter/webacd.wbx?WQID=e29ea21658790f784c1ca0a97c85bbf8" , },
                                 scrollblockinfo = { },
                                             },
                              navigation = { composer = {
                                   id = "stateautochat",
                                   lua="webview",
                                   time=250, 
                                   effect="slideLeft",
                                   effectback="slideRight",
                                },},
                                
                                },
                            -- dtt= {title = "CNN Launch separate", 
                            --   pic="web.png",
                            --   text="Sample web page",
                            --   backtext = "<",
                            --   navigation = { systemurl = {
                            --        url="http://www.cnn.com/"
                            --     },},
                                      
                            --     },
                              ea3t = {title = "Billing Questions", pic="billing.png",text="Call The 24 Hour Claim Contact Center" ,
                               navigation = { systemurl = { url="tel:800-444-9950"},},
                                      
                                  },
                          et3t = {title = "Report A Claim", pic="claim.png",text="Call The 24 Hour Claim Contact Center" ,
                               navigation = { systemurl = { url="tel:800-766-1853"},},
                                      
                                  },
                          ft3t = {title = "Report A Glass Claim", pic="claimglass.png",text="For Auto Glass Only Claims" ,
                               navigation = { systemurl = { url="tel:888-504-4527"},},
                                      
                                  },
                         gt3t = {title = "Report Fraud", pic="fraud.png",text="Anonomously call to report fraud" ,
                               navigation = { systemurl = { url="tel:888-999-8037"},},
                                      
                                  },
                          -- eb44 = {title = "Nearby gas stations", pic="gas.png",text="Locate nearby gas stations" ,
                          --      navigation = { search = { q="Gas Station" },},
                                      
                          --         },
                           h3t = {title = "Directions - State Auto", pic="map.png",text="Get Directions To The State Auto Home Office" ,
                               navigation = { directions = { address="518 E Broad St Columbus Ohio 43215" },},
                                      
                                  },
                           it3t = {title = "Call State Auto", pic="phone.png",text="State Auto Main Phone Number" ,
                               navigation = { systemurl = { url="tel:614-464-5000"},},
                                      
                                  },
                           jy3t = {title = "Text", pic="sms.png",text="Text State Auto your question" ,
                               navigation = { popup = { type="sms",options= {to="614-464-5000"},},},
                                      
                                  },
                         kttt = {title = "Email State Auto", pic="email.png",text="Email State Auto your question", 
                               navigation = { popup = { type="mail", options= {to="webmaster@stateauto.com", subject="General Question"},},},
                                 },
                     },   --items
            }
      
return contactus