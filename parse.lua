--module(..., package.seeall)
local M = {}

local json = require("json")
local mime = require("mime")
local myApp = require( "myapp" ) 

M.parseRest  = function (endpoint,listener)
        headers = {}
        headers["X-Parse-Application-Id"] = myApp.parse.appId
        headers["X-Parse-REST-API-Key"] = myApp.parse.restApikey
        headers["Content-Type"] = "application/json"

        local params = {}
        params.headers = headers
        local x = {}
        x.y = "x" --need something to get valid json
        params.body = json.encode(x)
        local url =  myApp.parse.url .. endpoint.endpoint
        print ("Launch Network Request " .. url)
        network.request( url ,endpoint.verb, listener,  params)
end

M.parseConfigListener  = function (event)
        t = json.decode(event.response)
        r = t.params
        print ("Return From Network Request " .. r.appName)
        myApp.appName = r.appName
end
M.parseGetConfig  = function (event)
        M.parseRest (myApp.parse.endpoints.config, M.parseConfigListener)
end
    
return M