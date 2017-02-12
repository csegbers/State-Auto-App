--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" )  
require( myApp.utilsfld .. "startup" ) 
require( myApp.utilsfld .. "common" ) 
local aws_auth = require( myApp.utilsfld .. "aws_auth" )  

local config = {
  aws_host       = "cognito-idp.us-east-1.amazonaws.com",
  aws_key        = "seeexcel",  
  aws_secret     = "seeexcel",
  aws_region     = "us-east-1",
  aws_service    = "cognito-idp",
  aws_request    = 'aws4_request',
  content_type   = "application/x-amz-json-1.1",
  request_method = "POST",
  request_querystr = "" ,  -- always in asc order !!! empty string if nothing
  request_path   = "/",    -- "/" if nothing
  iso_date       = os.time({year=2017, month=02, day=11, hour=07, min=11,  sec=00}),   -- comment out in run. Only used for debug
  request_body   =  '{"AuthFlow": "ADMIN_NO_SRP_AUTH", "AuthParameters":{"USERNAME":"junk@segbers.com","PASSWORD":"xxxx"},"UserPoolId":"us-east-1_I55vFoOtI","ClientId":"1br0l7moqel6h915ceimtohsju"}'  --{ hello="world" }' -- table of all request params
}


local aws = aws_auth:new(config)
-- get the generated authorization header
-- eg: AWS4-HMAC-SHA256 Credential=AKIDEXAMPLE/20150830/us-east-1/iam/aws4_request,
---    SignedHeaders=content-type;host;x-amz-date, Signature=xxx
local auth = aws:get_authorization_header()
print (auth)
-- get the x-amz-date header
local amz_date = aws:get_amz_date_header()
print (amz_date)


local composer = require( "composer" )
composer.isDebug = myApp.debugMode
composer.recycleOnSceneChange = myApp.composer.recycleOnSceneChange

local widget = require( "widget" )
widget.setTheme(myApp.theme)

require( myApp.utilsfld .. "backgroup" )   -- set the backgroup
require( myApp.utilsfld .. "tabandtop" )   -- set the top and bottom sections

-----------------------------------------
-- launched from somehwre else ?
-----------------------------------------
local launchArgs = ...
local launchURL
if launchArgs and launchArgs.url then
   launchURL = launchArgs.url
   debugpopup("Launched in from another app - " .. launchURL)
end

---------------------------------------------------
--  Sort everything in the correct z-index order
----------------------------------------------------
local stage = display.getCurrentStage()
stage:insert( myApp.moreGroup )               -- if they hit the more button
stage:insert( myApp.backGroup )               -- background if secnes etc... are transparent
stage:insert( composer.stage )                -- composer
stage:insert( myApp.TitleGroup )              -- the top title area
stage:insert( myApp.tabBar )                  -- tabbar at bottom
stage:insert( myApp.transContainer )          -- a container we turn on and off if they select more.select
                                              -- this makes the slid out main area still somewhat appear but receive taps


                                              
---------------------------------------------------
--  Splash and launch first page
----------------------------------------------------
require( myApp.utilsfld .. "splash" )      -- transtion from the initial image and launch the first page










