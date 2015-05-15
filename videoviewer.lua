-- Project: Business Sample app
--
-- File name: podcast.lua
--
-- Author: Corona Labs
--
-- Abstract: Play a video.
--
--
-- Target devices: simulator, device
--
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2013 Corona Labs Inc. All Rights Reserved.
---------------------------------------------------------------------------------------
--[[

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all copies
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

]]--
---------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


local widget = require( "widget" )
local myApp = require( "myapp" )
local common = require( "common" )

widget.setTheme(myApp.theme)

local backButton 
local playButton
local titleText
local webView

local function goBack(event)
    storyboard.hideOverlay()
    return true
end

function scene:create( event )
    local group = self.view
        
    local params = event.params
    local story = event.params.story

    local background = common.SceneBackground()
    group:insert(background)
    --
    -- setup a page background, really not that important 
    --

    print("create scene")
    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)

    backButton = widget.newButton({
        width =  59,
        height = 32,
        defaultFile = myApp.imgfld .. "backbutton7_white.png",
        overFile = myApp.imgfld .. "backbutton7_white.png",
        onRelease = goBack
    })
    backButton.y =    25   -- titleBar.y
    backButton.x = 32
    group:insert(backButton)

end

function scene:show( event )
    local group = self.view
    local phase = event.phase
    local params = event.params

    local story = params.story
    local enclosures = story.enclosuers

    local title = story.title

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).




            if title and title:len() > 16 then
                title = title:sub(1,16) .. "..."
            end

            --titleText.text = title
            
            -- do nothing when the podcast finishes playing.
            local function onComplete(event)
                return true
            end
            
            -- function to play the podcast.  We get the URL to stream from the story.enclosures
            -- table.
            local function playPodcast()
                print("playPodcast", story.link)
                media.playVideo( story.link, media.RemoteSource, true, onComplete )
                return true
            end
            
            local function viewWebPage(event)
                system.openURL( story.link )
            end

            -- now we write out the story body, which likely has HTML code in it to a
            -- temporary file that we will load back in to our web view.
            
            local path = system.pathForFile( "story.html", system.TemporaryDirectory )
         
            -- io.open opens a file at path. returns nil if no file found
            local fh, errStr = io.open( path, "w" )
         
            -- 
            -- Write out the required headers to make sure the content fits into our
            -- window and then dump the body.
            --
            if fh then
                print( "Created file" )
                fh:write("<!doctype html>\n<html>\n<head>\n<meta charset=\"utf-8\">")
                fh:write("<meta name=\"viewport\" content=\"width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\"/>\n")
                fh:write("<style type=\"text/css\">\n html { -webkit-text-size-adjust: none; font-family: HelveticaNeue-Light, Helvetica, Droid-Sans, Arial, san-serif; font-size: 1.1em; } h1 {font-size:1.25em;} p {font-size:0.9em; } </style>")
                fh:write("</head>\n<body>\n")
                if story.title then
                    fh:write("<h1>" .. story.title .. "</h1>\n")
                end
                if story.link then 
                    local videoID = story.link:sub(32, 42)
                    print(videoID)
                    fh:write([[<iframe width="300" height="225" src="http://www.youtube.com/embed/]] .. videoID .. [[?html5=1" frameborder="0" allowfullscreen></iframe>]])
                end
                if story.content_encoded then
                    fh:write( story.content_encoded)
                elseif story.description then
                    fh:write(story.description)
                end

                fh:write( "\n</body>\n</html>\n" )
                io.close( fh )
            else
                print( "Create file failed!" )
            end

            --
            -- handler to deal with clicking on any anchor tags in the above HTML.
            --
            local function webListener(event)
                print("showWebPopup callback")
                
                local url = event.url

                if string.find(url, "http://www.youtube.com") then
                    return true
                end

                if( string.find( url, "http:" ) ~= nil or string.find( url, "mailto:" ) ~= nil ) then
                    print("url: ".. url)
                    system.openURL(url)
                end

                return true
            end
           
            local isTall = 0
            if myApp.isTall then
                isTall = 88
            end

            -- turn off the activity indicator and show the webview
            --native.setActivityIndicator( false )
        --    local options = { hasBackground=false, baseUrl=system.TemporaryDirectory, urlRequest=listener }
            --local options = { hasBackground=true,  urlRequest=listener }
        --    native.showWebPopup(0, 51 + 60 + 20 + 60, display.contentWidth, 220 + isTall, "story.html", options )
            
            webView = native.newWebView(0, 71, display.contentWidth, 300 + isTall)
            webView.x = display.contentCenterX
            webView.y = 150 + isTall / 2 + 71
            webView:request("story.html", system.TemporaryDirectory)
            webView:addEventListener( "urlRequest", webListener )
            -- add a button to see the full article in the web browser
            local play_button = display.newImageRect("images/view_button.png", 300, 32)
            play_button.x = display.contentCenterX
            play_button.y = display.contentHeight - 80
            group:insert(play_button)
            play_button:addEventListener("tap", viewWebPage)
     elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end             
end

function scene:hide( event )
    local group = self.view
    local phase = event.phase
    
    --
    -- Clean up any native objects and Runtime listeners, timers, etc.
    --    
    if ( phase == "will" ) then
        if webView and webView.removeSelf then
            webView:removeSelf()
            webView = nil
        end
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end

function scene:destroy( event )
    local group = self.view
    
    print("destroy scene")
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
