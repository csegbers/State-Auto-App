local myApp = require( "myapp" ) 
local common = require( myApp.utilsfld .. "common" )
local composer = require( "composer" )
local widget = require( "widget" )


----------------------------------------------------------
--    background that shows thru 
----------------------------------------------------------
myApp.backGroup = display.newGroup( )
myApp.backGroup:insert(common.SceneBackground(myApp.sceneBackgroundcolor))


----------------------------------------------------------
--    background that shows when top right button is hit
----------------------------------------------------------

myApp.moreGroup = display.newGroup( )
myApp.moreGroup:insert(common.SceneBackground(myApp.sceneBackgroundmorecolor))
local myList = widget.newTableView {
   x = myApp.cW/2 + (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor)/2,
   y = myApp.cH/2 + myApp.tSbch/2 , 
   --hideBackground=true,
   width = myApp.sceneWidth- (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor), 
   height = myApp.cH - myApp.tSbch,
   --onRowRender = onRowRender,
   --onRowTouch = onRowTouch,
 
 
}
myApp.moreGroup :insert(myList )



function myApp.MoreInfo(parms)
  
        
    local transtime = myApp.moreinfo.transitiontime
    local deltax = myApp.cW/myApp.moreinfo.movefactor*-1
    if myApp.moreinfodirection  == "right" then
       deltax = myApp.cW/myApp.moreinfo.movefactor
       myApp.moreinfodirection = "left"
    else
   	   myApp.moreinfodirection = "right"
    end
    transition.to(  composer.stage, {  time=transtime,delta=true, x = deltax , transition=easing.outQuint})
    transition.to(  myApp.backGroup, { time=transtime ,delta=true, x = deltax , transition=easing.outQuint})
    transition.to(  myApp.TitleGroup, { time=transtime,delta=true, x = deltax, transition=easing.outQuint})
    transition.to(  myApp.tabBar, { time=transtime,delta=true, x = deltax , transition=easing.outQuint})

 
    return true
end