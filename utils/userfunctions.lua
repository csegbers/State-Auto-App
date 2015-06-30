-------------------------------------------------------
-- Loaded once in main, used to override variables and create some common functions
-------------------------------------------------------
local myApp = require( "myapp" ) 
local parse = require( myApp.utilsfld .. "mod_parse" ) 

 
function myApp.fncUserUpdatePolicies ()
   myApp.authentication.policies =  {}
   myApp.authentication.agencies =  {}
   myApp.authentication.agencycode = ""

   if myApp.authentication.loggedin   then
 
               parse:run(myApp.otherscenes.account.functionname.getpolicies,
                  {
                   ["userId"] = myApp.authentication.objectId 
                   },
                   ------------------------------------------------------------
                   -- Callback inline function
                   ------------------------------------------------------------
                   function(e) 
                      --debugpopup ("here from get policies")
                      if not e.error then  
                           
                          for i = 1, #e.response.result do
                              local resgroup = e.response.result[i][1]
                              myApp.authentication.policies[resgroup["policyNumber"]] = resgroup
                              print("policy Number" .. resgroup["policyNumber"])
                              if #resgroup.policyTerms[1] > 0 then
                                  myApp.authentication.agencycode = resgroup.policyTerms[1][1].agencyCode or ""
                             end
                          end

                          ------------------------------
                          -- go grab agent
                          ------------------------------
                          if myApp.authentication.agencycode ~= "" then
                             --print("function name" .. myApp.mappings.objects.Agency.functionname.details)
                             --print("agency code" .. myApp.authentication.agencycode)
                             parse:run(
                                         myApp.mappings.objects.Agency.functionname.details,
                                         {
                                            ["agencyCode"] = myApp.authentication.agencycode
                                         },
                                         function(e) 
                                            if not e.error then 
                                                if #e.response.result > 0 then
                                                   myApp.authentication.agencies = e.response.result[1]
                                                   --print("agency name" .. myApp.authentication.agencies.agencyName)
                                                end
                                            end
                                         end
                                      )
                          end
                          native.setActivityIndicator( false ) 
 
                      else
                        native.setActivityIndicator( false ) 
                       --buildMap()     no need to do. Nothing to mark
                      end  -- end of error check
                  end )  -- end of parse call

   end
end

-------------------------------
-- if user just created then not every field is there like email
-------------------------------
function myApp.fncUserLogInfo (userObject)
     print "fncUserLoggedIn  "
     myApp.authentication.email = userObject.email
     myApp.authentication.emailVerified = userObject.emailVerified
     myApp.authentication.username = userObject.username                -- for now this is email
     myApp.authentication.objectId = userObject.objectId                -- internal userid
     myApp.authentication.sessionToken = userObject.sessionToken

     local curLoggedin = myApp.authentication.loggedin or false
     myApp.authentication.loggedin =  myApp.authentication.emailVerified or false

     -----------------------------
     -- dispatch event if login status changed
     -----------------------------
     if myApp.authentication.loggedin ~= curLoggedin then
         Runtime:dispatchEvent{ name="loginchanged", value=myApp.authentication.loggedin }
     end

     ----------------------------
     -- first time logging in ?
     -- event it in case we want to do something
     ----------------------------
     if myApp.authentication.loggedin   then
          myApp.fncPutUD ("everloggedin",1)     --- if still a 0 will update and trigger event
     end

     ----------------------------
     -- always update policies and agents
     -- becuase most likely they are logging in or out
     -----------------------------
     myApp.fncUserUpdatePolicies()
end

-------------------------------
-- Log em out
-------------------------------
function myApp.fncUserLoggedOut (event)
     print "fncUserLoggedOut  "
     myApp.fncUserLogInfo({
           email = "",
           emailVerified = false,
           username = "",
           objectId = "",
           sessionToken = "",
          })
   
end