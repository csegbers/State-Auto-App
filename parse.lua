--module(..., package.seeall)
local M = {}

local json = require("json")
local mime = require("mime")
local myApp = require( "myapp" ) 

M.parseNetworkListener	= function (event)

        t = json.decode(event.response)
        r = t.result
        print ("Return From Network Request " .. r.appName)
        myApp.appName = r.appName
               
end

M.parseGetConfig  = function (event)
        headers = {}
        headers["X-Parse-Application-Id"] = myApp.parse.appId
        headers["X-Parse-REST-API-Key"] = myApp.parse.restApikey
        headers["Content-Type"] = "application/json"

        local params = {}
        params.headers = headers
        local x = {}
        x.y = "x" --need something to get valid json
        params.body = json.encode(x)
        print ("Launch Network Request " .. myApp.parse.getConfig)
        network.request( myApp.parse.getConfig ,"POST", M.parseNetworkListener,  params)

end
    
return M