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



function myApp.MoreInfo( )
  
        print ("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
    local transtime = myApp.moreinfo.transitiontime
    local deltax = myApp.cW/myApp.moreinfo.movefactor*-1
    if myApp.moreinfodirection  == "right" then
       deltax = myApp.cW/myApp.moreinfo.movefactor
       myApp.moreinfodirection = "left"
    else
       myApp.moreinfodirection = "right"
    end
    print ("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL")
    transition.to(  composer.stage, {  time=transtime,delta=true, x = deltax , transition=easing.outQuint})
    print ("MMMMMMmmmMMMMMMMmMMMMMMMMMMMMMMMMM")
    transition.to(  myApp.backGroup, { time=transtime ,delta=true, x = deltax , transition=easing.outQuint})
    print ("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN")
    transition.to(  myApp.TitleGroup, { time=transtime,delta=true, x = deltax, transition=easing.outQuint})
    transition.to(  myApp.tabBar, { time=transtime,delta=true, x = deltax , transition=easing.outQuint})



end

local function onRowRender( event )

   --Set up the localized variables to be passed via the event table

   local row = event.row
   local id = row.index
   local params = event.row.params

   -- row.bg = display.newRect( 0, 0, display.contentWidth, 60 )
   -- row.bg.anchorX = 0
   -- row.bg.anchorY = 0
   -- row.bg:setFillColor( 1, 1, 1 )
   -- row:insert( row.bg )

   if ( event.row.params ) then    
      row.nameText = display.newText( params.title, 10, 0, native.systemFontBold, 14 )
      row.nameText.anchorX = 0
      row.nameText.anchorY = 0.5
      row.nameText:setFillColor( 1 )
      row.nameText.y = 25
      row.nameText.x = 25

      row:insert( row.nameText )
      
   end
   return true
end

local onRowTouch = function( event )
    if event.phase == "release" then
        
       local v = myApp.moreinfo.items[event.row.params.key]
 
 timer.performWithDelay(10, myApp.MoreInfo) 
  
        --     print ("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
        -- local transtime = myApp.moreinfo.transitiontime
        -- local deltax = myApp.cW/myApp.moreinfo.movefactor*-1
        -- if myApp.moreinfodirection  == "right" then
        --    deltax = myApp.cW/myApp.moreinfo.movefactor
        --    myApp.moreinfodirection = "left"
        -- else
        --    myApp.moreinfodirection = "right"
        -- end
        -- print ("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL")
        -- transition.to(  composer.stage, {  time=transtime,delta=true, x = deltax , transition=easing.outQuint})
        -- print ("MMMMMMmmmMMMMMMMmMMMMMMMMMMMMMMMMM")
        -- transition.to(  myApp.backGroup, { time=transtime ,delta=true, x = deltax , transition=easing.outQuint})
        -- print ("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN")
        -- transition.to(  myApp.TitleGroup, { time=transtime,delta=true, x = deltax, transition=easing.outQuint})
        -- transition.to(  myApp.tabBar, { time=transtime,delta=true, x = deltax , transition=easing.outQuint})



 
    end
 
end


local myList = widget.newTableView {
   x = myApp.cW/2 + (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor)/2 ,
   y = myApp.cH/2 + myApp.tSbch/2 , 
   hideBackground=true,
   width = myApp.sceneWidth- (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor)-10, 
   height = myApp.cH - myApp.tSbch,
   onRowRender = onRowRender,
   onRowTouch = onRowTouch,
}
 local a = {}
 for n in pairs(myApp.moreinfo.items) do table.insert(a, n) end
 table.sort(a)

 for i,k in ipairs(a) do 
       local v = myApp.moreinfo.items[k]

	   myList:insertRow({
	      rowHeight = 50,
	      isCategory = false,
	       
	      rowColor =  { default={myApp.sceneBackgroundmorecolor.r,myApp.sceneBackgroundmorecolor.g,myApp.sceneBackgroundmorecolor.b}, over={ 1, 0.5, 0, 0.2 } },
	      lineColor = { 200/255 },
	      params = {
	                 title = v.title,
	                 key = k,
	               }
	   })


 end
myApp.moreGroup :insert(myList )


