-------------------------------------------------------
-- Loaded once in main, used to override variables and create some common functions
-------------------------------------------------------
local myApp = require( "myapp" ) 

-------------------------------
-- if user just created then not every field is there like email
-------------------------------
function myApp.fncUserLoggedIn (userObject)

     myApp.authentication.email = userObject.email
     myApp.authentication.emailVerified = userObject.emailVerified
     myApp.authentication.username = userObject.username                -- for now this is email
     myApp.authentication.objectId = userObject.objectId
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
end