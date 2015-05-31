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

----------------------------------------------------------
--    move transparent group  
--    this will display over evenrything to capture touch events
--    and give the appearance you cant do something
----------------------------------------------------------
myApp.transContainer = common.SceneBackground(myApp.moreinfo.transparentcolor)
myApp.transContainer.y = myApp.transContainer.y + myApp.sceneStartTop/2
myApp.transContainer.height = myApp.transContainer.height - myApp.sceneStartTop
myApp.transContainer.alpha = 0

---------------------------------------------
-- dont allow touches to go thru
-- for some reason items in composer idnore this
-----------------------------------------------
myApp.transContainer:addEventListener( "touch", function(event)   return myApp.transContainer.alpha  > 0  end )

---------------------------------------------
-- used to slide out the major groups left and right
-- and tuern on / off the alpha of the last group
-----------------------------------------------
function myApp.MoreInfoMove( parms )
  
    myApp.moreinfo.imsliding = true
    local params = parms or {}
    local transtime = myApp.moreinfo.transitiontime
    local deltax = myApp.cW/myApp.moreinfo.movefactor*-1
    local talpha = myApp.moreinfo.transparentalpha

    if myApp.moreinfo.direction  == "right" then
       deltax = myApp.cW/myApp.moreinfo.movefactor
       myApp.moreinfo.direction = "left"
       talpha = 0
    else
       myApp.moreinfo.direction = "right"

    end

    transition.to(  composer.stage, {  time=transtime,delta=true, x = deltax , transition=easing.outQuint})
    transition.to(  myApp.backGroup, { time=transtime ,delta=true, x = deltax , transition=easing.outQuint})
    transition.to(  myApp.TitleGroup, { time=transtime,delta=true, x = deltax, transition=easing.outQuint})
    transition.to(  myApp.tabBar, { time=transtime,delta=true, x = deltax , transition=easing.outQuint})
    transition.to(  myApp.transContainer, { time=transtime, delta=true, x = deltax , transition=easing.outQuint, onComplete = function() myApp.moreinfo.imsliding = false end })  
    ---------------------------------------
    -- do alpha separate because of the delta
    ---------------------------------------
    transition.to(  myApp.transContainer, { time=myApp.moreinfo.transitiontimealpha,alpha = talpha, onComplete = params.onComplete })

end


---------------------------------------------
-- Action on selection
-----------------------------------------------
local onRowTouch = function( event )
    if event.phase == "release" and  myApp.moreinfo.imsliding == false then
        myApp.MoreInfoMove({onComplete = 
              function()  
                  local v = myApp.moreinfo.items[event.row.params.key]
                  ----------------------------------------------
                  -- always do a "back" to the MAIN Tabbar page !!!!
                  -- no nested backing for these items
                  ---------------------------------------------
                  ---------------------------------------------
                  -- Composer ?
                  -- Different scene name or id ?
                  ----------------------------------------------
                  if v.composer  then
                      if ((composer.getSceneName( "current" )  == (myApp.scenesfld .. v.composer.lua))
                          and (composer.getScene( composer.getSceneName( "current" ) ).myparams().composer.id == v.composer.id)) then
                       else
                         --local parentinfo = composer.getScene( composer.getSceneName( "current" ) ).myparams()
                         v.callBack = function() myApp.showScreen({instructions=myApp.tabs.btns[myApp.tabCurrentKey],effectback=v.composer.effectback}) end
                         myApp.showSubScreen ({instructions=v})   
                     end
                  else
                    if v.tabbar then
                       myApp.showScreen({instructions=myApp.tabs.btns[v.tabbar.key]})
                    end
                  end

              end })
    end
 
end

---------------------------------------------
-- create the list that will appear on the "more" button
-----------------------------------------------
local myList = widget.newTableView {
   x = myApp.cW/2 + (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor)/2 ,
   y = myApp.cH/2 + myApp.tSbch/2 , 
   hideBackground=true,
   width = myApp.sceneWidth- (myApp.sceneWidth - myApp.cW/myApp.moreinfo.movefactor)-10, 
   height = myApp.cH - myApp.tSbch,
   onRowTouch = onRowTouch,
   onRowRender = 
      function(event)
           local row = event.row
           row.nameText = display.newText( event.row.params.title, 0, 0, myApp.fontBold, myApp.moreinfo.row.textfontsize )
           row.nameText.anchorX = 0
           row.nameText.anchorY = 0.5
           row.nameText:setFillColor( myApp.moreinfo.row.textcolor )
           row.nameText.y = myApp.moreinfo.row.height / 2
           row.nameText.x = myApp.moreinfo.row.indent
           row:insert( row.nameText )
           return true
      end
   ,
}
---------------------------------------------
-- Sort (key is critical !!)
--------------------------------------------- 
local a = {}
for n in pairs(myApp.moreinfo.items) do table.insert(a, n) end
table.sort(a)

---------------------------------------------
-- Generate the rows
--------------------------------------------- 
for i,k in ipairs(a) do 
	   myList:insertRow({
	      rowHeight = myApp.moreinfo.row.height, 
	      rowColor =  { default={myApp.sceneBackgroundmorecolor.r,myApp.sceneBackgroundmorecolor.g,myApp.sceneBackgroundmorecolor.b}, over=myApp.moreinfo.row.over },
	      lineColor = myApp.moreinfo.row.linecolor,
	      params = { title = myApp.moreinfo.items[k].title,key = k,}
	   })
 end
---------------------------------------------
-- Insert the list
--------------------------------------------- 
myApp.moreGroup:insert(myList )


