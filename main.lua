--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" )  
require( myApp.utilsfld .. "startup" ) 
require( myApp.utilsfld .. "common" ) 
local aws_auth = require( myApp.utilsfld .. "aws_auth" )  

 local config = {
  aws_host       = "cognito-idp.us-east-1.amazonaws.com",
  aws_key        = "--",  
  aws_secret     = "--",
  aws_region     = "us-east-1",
  aws_service    = "cognito-idp",
  aws_request    = 'aws4_request',
  content_type   = "application/x-amz-json-1.1",
  request_method = "POST",
  request_querystr = "" ,  -- always in asc order !!! empty string if nothing
  request_path   = "/",    -- "/" if nothing
  --iso_date       = os.time({year=2017, month=04, day=06, hour=12, min=50,  sec=00}),   -- comment out in run. Only used for debug
  request_body   =  "{\"AuthFlow\": \"ADMIN_NO_SRP_AUTH\", \"AuthParameters\":{\"USERNAME\":\"craig@segbers.com\",\"PASSWORD\":\"gh%%3322SSsD\"},\"UserPoolId\":\"us-east-1_6p997uKVk\",\"ClientId\":\"7m7p7tk8ta4qlb4ai15nqmh8a1\"}"  --{ hello="world" }' -- table of all request params
} 

--[[
local config = {
  aws_host       = "example.amazonaws.com",
  aws_key        = "AKIDEXAMPLE",
  aws_secret     = "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY",
  aws_region     = "us-east-1",
  aws_service    = "service",
  aws_request    = 'aws4_request',
  content_type   = "application/x-amz-json-1.1",
  request_method = "GET",
  request_querystr = "Param1=value1&Param2=value2" ,  -- always in asc order !!! empty string if nothing
  request_path   = "/",    -- "/" if nothing 20150830T123600Z
  iso_date       = os.time({year=2015, month=08, day=30, hour=08, min=36,  sec=00}),   -- comment out in run. Only used for debug remeber iso time so set hour 4 hours early
  request_body   =  ""
}]]

local aws = aws_auth:new(config)
-- get the generated authorization header
-- eg: AWS4-HMAC-SHA256 Credential=AKIDEXAMPLE/20150830/us-east-1/iam/aws4_request,
---    SignedHeaders=content-type;host;x-amz-date, Signature=xxx
print ("---------------- auth ------------------------")
local auth = aws:get_authorization_header()
print (auth)
-- get the x-amz-date header
print ("---------------- amz_date ------------------------")
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










