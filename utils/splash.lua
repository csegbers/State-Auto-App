
------------------------------------------------------
print ("splash: IN")
------------------------------------------------------

local myApp = require( "myapp" ) 
local common = require( myApp.utilsfld .. "common" )

local background = display.newRect(0,0, myApp.cW,myApp.cH)
background:setFillColor(255/myApp.colorDivisor,255/myApp.colorDivisor,255/myApp.colorDivisor)
background.x = myApp.cCx
background.y = myApp.cCy


local logo = display.newImageRect("salogo.jpg",305,170)
logo.x = myApp.cCx
logo.y = myApp.cCy

local function closeSplash()
   local function closeSplashFinal()
            -- display.remove(title)
                -- title = nil
                display.remove(logo)
                logo = nil
                local function removeBack()
                    display.remove(background)
                    background = nil
                    print ("splash: OUT")
                end
                transition.to( background, {time=800, alpha=0 , onComplete=removeBack } )
                ----------------------------------------------------------
                -- Launch the first screen
                ----------------------------------------------------------
                myApp.showScreen({key=myApp.tabs.launchkey,firsttime=true})

    end
    local function closeSplash1()
            transition.to( logo, {time=1500, alpha=0, x=(myApp.cW+50), y=(myApp.cH-500), onComplete=closeSplashFinal } )
    end
    --https://coronalabs.com/blog/2013/10/31/tutorial-2-5d-perspective-in-graphics-2-0/     .path property for 2.5 D
    transition.to( logo.path, { time=1500, x2=20, y2=-20, x4=-40, y4=40 , onComplete=closeSplash1 } )
end

timer.performWithDelay(myApp.splashDelay, closeSplash)