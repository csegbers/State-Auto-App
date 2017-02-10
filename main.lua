--====================================================================--
-- Insured App
--====================================================================--
local myApp = require( "myapp" )  
require( myApp.utilsfld .. "startup" ) 

require( myApp.utilsfld .. "common" ) 

local aws_auth = require( myApp.utilsfld .. "aws_auth_segbers" )  
  
local config = {
  aws_host       = "example.amazonaws.com",
  aws_key        = "AKIDEXAMPLE",
  aws_secret     = "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY",
  aws_region     = "us-east-1",
  aws_service    = "service",
  aws_request    = 'aws4_request',
  content_type   = "application/x-www-form-urlencoded",
  request_method = "GET",
  request_querystr = "Param1=value1&Param2=value2" ,  -- always in asc order !!! empty string if nothing
  request_path   = "/",    -- "/" if nothing
  request_body   =  ""--{ hello="world" } -- table of all request params
}

local aws = aws_auth:new(config)

-- get the generated authorization header
-- eg: AWS4-HMAC-SHA256 Credential=AKIDEXAMPLE/20150830/us-east-1/iam/aws4_request,
---    SignedHeaders=content-type;host;x-amz-date, Signature=xxx
local auth = aws:get_authorization_header()
print ("*************AUTH*************")
print ("*************AUTH*************")
print ("*************AUTH*************")
print ("*************AUTH*************")
print (auth)
print ("*************AUTH*************")
print ("*************AUTH*************")
print ("*************AUTH*************")

-- get the x-amz-date header
local amz_date = aws:get_amz_date_header()
print ("*************amzdate*************")
print ("*************amzdate*************")
print ("*************amzdate*************")
print ("*************amzdate*************")

print (amz_date)
print ("*************amzdate*************")
print ("*************amzdate*************")
print ("*************amzdate*************")
print ("*************amzdate*************")



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










