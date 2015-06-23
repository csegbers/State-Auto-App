
-------------------------------------------------------
-- Store variables used across the entire app 
-------------------------------------------------------
local otherscenes = {  
            login = {
                        loggedin = false,
                        sceneinfo = { 
                                     htmlinfo = {},
                                     scrollblockinfo = { },

                                     edge = 15,
                                     height = 220,
                                     cornerradius = 2,
                                     groupbackground = { r=235/255, g=235/255, b=235/255, a=1 },
                                     strokecolor = { r=150/255, g=150/255, b=150/255, a=1 },
                                     strokewidth = 1,

                                     userlabel = "Email Address",
                                     pwdlabel = "Password",

                                     textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                                     textfontsize=18  ,
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
                                     btnloginmessage = {
                                          errortitle = "Invalid Entries", 
                                          errormessage = "Must have a valid email address and password entered.",
                                          --successtitle= "Logged In !!",
                                          --successmessage= "An email verification has been re-sent. Please follow the link in the email, return back and Login again to continue.",
                                          failuretitle= "Error With Your Request",
                                          verifytitle= "Correct Login But No Email Verification",
                                          verifymessage= "An email verification has been re-sent. Please check your email in a few minutes, follow the link in the email, return back and Login again to continue.",

                                      },                                     

                                     btnfontsize = 16,
                                     btnheight = 30,
                                     btnwidth = 90,

                                     userfieldfontsize=14  , 
                                     userfieldheight = 25,
                                     userfieldcornerradius = 6,
                                     userfieldplaceholder = "",
                                     userfieldmessage = {
                                          errortitle = "xxxx", 
                                          errormessage = "yyyy",
                                      },

                                     pwdfieldfontsize=14  , 
                                     pwdfieldheight = 25,
                                     pwdfieldcornerradius = 6,
                                     pwdfieldplaceholder = "",
                                     pwdfieldmessage = {
                                          errortitle = "xxxx", 
                                          errormessage = "yyyy",
                                      },

                                      showpwdswitchstyle = "onOff",

                                      btnforgotlabel = "Forgot Password" ,
                                      btnforgotllabelcolor = { default={ 0, 100/255, 200/255 }, over={ 0, 0, 0, 0.5 } },
                                      btnforgotfontsize=13  , 
                                      btnforgotmessage = {
                                          errortitle = "Invalid Entries", 
                                          errormessage = "Must have a valid email address to reset password",
                                          successtitle= "Email Sent",
                                          successmessage= "An email has been sent. Please follow the link in the email to reset your password, return back and Login again to continue.",
                                          failuretitle= "Error With Your Request",

                                      },


                                      btncreatelabel = "Create An Account" ,
                                      btncreatellabelcolor = { default={ 0, 100/255, 200/255 }, over={ 0, 0, 0, 0.5 } },
                                      btncreatefontsize=13  , 
                                      btncreatemessage = {
                                          errortitle = "Invalid Entries", 
                                          errormessage = "Must have a valid email address and password entered.",
                                          successtitle= "Congratulations !!",
                                          successmessage= "An email verification has been sent. Please follow the link in the email, return back and Login again to continue.",
                                          failuretitle= "Error With Your Request",

                                      },



                                   },
                        navigation = { composer = {
                                   id = "login",
                                   isModal = true,
                                   lua="login",
                                   overlay=true,
                                   time=700, 
                                   effect= "slideDown",
                                   effectback="slideUp",
                                },},
                    },

          emergency = {  
                           sceneinfo = {   
                                       groupheader = { r=255/255, g=0/255, b=0/255, a=1 },
                                       groupheight = 140,
                                       edge=10,
                                       textfontsize=12   ,  
                                       groupwidth = 120,
                                       groupmaxwidth = 170,     -- we will allow to grow to fit better if there is extra edging. This would be max however
                                       groupstrokewidth = 1,
                                       groupbackground = { r=255/255, g=255/255, b=255/255, a=1 },
                                       groupheaderheight = 35,
                                       headerfontsize = 17, 
                                       headercolor = { r=255/255, g=255/255, b=255/255, a=1 },

                                      dialbutton = {
                                                      defaultFile="dial911.png",
                                                      overFile="dial911-down.png",
                                                      width = 75,    
                                                       height = 75,  
                                                       dial = { navigation = { systemurl = { url="tel:911"},},},
                                                      },
                                  
                                      text = "Approximate Address:" ,         
                                      textcolor = { r=1/255, g=1/255, b=1/255, a=1 },   
                                      textfontsize=16   , 
                                      textbottomedge =12   ,  


                                  },

                           navigation = { composer = {
                                         id = "alocateqsg",
                                         lua="emergency911",
                                         time=250, 
                                         effect="slideLeft",
                                         effectback="slideRight",
                                      },},
                        }


          }
return otherscenes