--module(..., package.seeall)
local M = {}

local json = require("json")
local mime = require("mime")
local myApp = require( "myapp" ) 
local headers = {}
headers["X-Parse-Application-Id"] = myApp.parse.appId
headers["X-Parse-REST-API-Key"] = myApp.parse.restApikey
headers["Content-Type"] = "application/json"

M.parseRest  = function (endpointkey,listener,reqbody,eventType)

        local params = {}
        params.headers = headers
        reqbody = reqbody or {}
        params.body = json.encode(reqbody)
        local url =  myApp.parse.url .. endpointkey.endpoint
        if  eventType == nil or eventType == "" then
        else
            url = url .. "/" .. eventType
        end
        print ("Launch Network Request " .. url)
        network.request( url ,endpointkey.verb, listener,  params)
end

M.parseConfigListener  = function (event)
   if event.phase == "ended" then
      local response = event.response
      print ("Return From Network Request " .. response)
      local t = json.decode(response)
      if t.error ~= nil then
          print ("ERROR - Listener " .. t.error)
      else
          local r = t.params
          local x2 = r.TestParmObject
          myApp.appName = r.appName
       end
    end
end
M.parseGetConfig  = function ()
  M.parseRest (myApp.parse.endpoints.config, M.parseConfigListener)
end
M.parseEventsListener  = function (event)
   if event.phase == "ended" then
      local response = event.response
      print ("Return From Events Request " .. response)
   end
end
M.parseAppOpened  = function ()
  M.parseRest (myApp.parse.endpoints.appopened, M.parseEventsListener)
end
M.parseLogEvent = function ( eventType, dimensionsTable)
  dimensionsTable = dimensionsTable or {}
  local requestParams = { ["dimensions"] = dimensionsTable }
  M.parseRest (myApp.parse.endpoints.customevent, M.parseEventsListener,requestParams,eventType)
end

return M