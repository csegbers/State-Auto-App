---------------------------------------------------------------------------------------
-- policy details scene
---------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local myApp = require( "myapp" ) 

local parse = require( myApp.utilsfld .. "mod_parse" ) 
local common = require( myApp.utilsfld .. "common" )

local currScene = (composer.getSceneName( "current" ) or "unknown")
print ("Inxxxxxxxxxxxxxxxxxxxxxxxxxxxxx " .. currScene .. " Scene")

local sceneparams
local sceneid
local sceneinfo
local polgroup

local runit  
local justcreated  

local container
local myList

local myName
local myAddress
local itemGrp
local objectgroup -- pointer to the mappings stuff
local curitemGrpy  
local curmyListy 


------------------------------------------------------
-- Row is rendered
------------------------------------------------------
local  onRowRender = function ( event )

         --Set up the localized variables to be passed via the event table

         local row = event.row
         local id = row.index
         local params = event.row.params

         if ( event.row.params ) then    
 
            row.titleText = display.newText( myApp.objecttypes[params.fieldtype].title, 0, 0, myApp.fontBold, sceneinfo.row.titletextfontsize )
            row.titleText.anchorX = 0
            row.titleText.anchorY = 0.5
            row.titleText:setFillColor( sceneinfo.row.titletextcolor )
            row.titleText.y = sceneinfo.row.titletexty
            row.titleText.x = sceneinfo.row.titletextx

            row.descText = display.newText( params.value, 0, 0, myApp.fontBold, sceneinfo.row.desctextfontsize )
            row.descText.anchorX = 0
            row.descText.anchorY = 0.5
            row.descText:setFillColor( sceneinfo.row.desctextColor )
            row.descText.y = sceneinfo.row.desctexty
            row.descText.x = sceneinfo.row.desctextx


            row:insert( row.titleText )
            row:insert( row.descText )

             -------------------------------------------------
             -- Icon ?
             -------------------------------------------------

            local iconimage = myApp.objecttypes[params.fieldtype].pic
            if iconimage then
                 row.myIcon = display.newImageRect(myApp.imgfld .. iconimage,  sceneinfo.row.iconwidth , sceneinfo.row.iconheight )
                 common.fitImage( row.myIcon,  sceneinfo.row.iconwidth   )
                 row.myIcon.y = sceneinfo.row.height / 2
                 row.myIcon.x = sceneinfo.row.iconwidth/2 + sceneinfo.edge
                 row:insert( row.myIcon )
            end


         end
         return true
end
 
------------------------------------------------------
-- what launch object ?
------------------------------------------------------
local onRowTouch = function( event )
        local row = event.row
        local params = row.params
        local obgroup = myApp.objecttypes[row.params.fieldtype]
        local navgroup = obgroup.navigation

        -----------------------
        -- center the map if we got off wack
        ------------------------
        if navgroup.directions  then
            -- if myMap and myObject then 
            --   if myObject[objectgroup.mapping.geo] then myMap:setCenter( myObject[objectgroup.mapping.geo].latitude, myObject[objectgroup.mapping.geo].longitude ,true ) end
            -- end
        end
        
        if event.phase == "press"  then     

        elseif event.phase == "tap" then
              
        elseif event.phase == "swipeLeft" then

        elseif event.phase == "swipeRight" then
 
        elseif event.phase == "release" then


           if navgroup then
               if navgroup.tabbar then
                  myApp.showScreen({instructions=myApp.tabs.btns[navgroup.tabbar.key]})
               else
                   -----------------------------
                   -- launching "external ? ""
                   ---------------------------- 
                   if navgroup.directions then  
                       myApp.navigationCommon ({launch = obgroup.launch, navigation = { directions = { address=string.format( (navgroup.directions.address or ""),  row.params.fulladdress )},},} )
                   else 
                       if navgroup.popup then 
                         myApp.navigationCommon ({launch = obgroup.launch, navigation = { popup = { type = navgroup.popup.type, options ={to=string.format( (navgroup.popup.options.to or ""),  row.params.value )},},} ,})
                       else
                           if navgroup.systemurl then 
                              myApp.navigationCommon( {launch = obgroup.launch, navigation = { systemurl = { url=string.format( (navgroup.systemurl.url or ""),  row.params.value )},},} )
                           else
                                if navgroup.composer then
                                    local locatelaunch =                          
                                         {
                                            title = obgroup.title, 
                                            text=myName.text,
                                            backtext = obgroup.backtext ,
                                            forwardtext = obgroup.forwardtext ,
                                            pic=obgroup.pic,
                                            -- htmlinfo = { 
                                            --               url=row.params.value ,
                                            --            },
                                            sceneinfo = obgroup.sceneinfo,
                                            navigation = 
                                             { 
                                                composer = 
                                                    { 
                                                       id = row.params.value ,
                                                       lua=navgroup.composer.lua,
                                                       time=navgroup.composer.time, 
                                                       effect=navgroup.composer.effect,
                                                       effectback=navgroup.composer.effectback,              
                                                    }
                                            ,}
                                        ,}
                                     locatelaunch.sceneinfo.htmlinfo.url =  row.params.value   
                                     local parentinfo =  sceneparams 
                                     -----------------------------------------
                                     -- are being used as a main tabbar scene ?
                                     -----------------------------------------
                                     if myApp.MainSceneNavidate(parentinfo) then
                                       myApp.navigationCommon(locatelaunch)
                                     else
                                        locatelaunch.callBack = function() myApp.showSubScreen({instructions=parentinfo,effectback="slideRight"}) end
                                        myApp.showSubScreen ({instructions=locatelaunch})
                                     end
                                     
                                end   -- if composer
                           end  -- if systemurl
                       end   -- popup
                   end -- directions
               end -- tabbar
           end   -- if navigation

            
        end
    return true
end





------------------------------------------------------
-- Called first time. May not be called again if we dont recyle
------------------------------------------------------
function scene:create(event)
 
    print ("Create  " .. currScene)
    justcreated = true
    sceneparams = event.params            
     
end

function scene:show( event )

    local group = self.view
    local phase = event.phase

    print ("Show:" .. phase.. " " .. currScene)

    ----------------------------------
    -- Will Show
    ----------------------------------
    if ( phase == "will" ) then   
        ----------------------------
        -- sceneparams at this point contains prior
        -- KEEP IT THAT WAY !!!!!
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        -- Called when the scene is still off screen (but is about to come on screen).
        runit = true
        if sceneparams and justcreated == false then
          if  sceneparams.navigation.composer then
             --if sceneparams.navigation.composer.id == event.params.navigation.composer.id then
             if sceneid == event.params.navigation.composer.id then
               runit = false
             end
          end
        end

        ----------------------------
        -- now go ahead
        --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ------------------------------
        sceneparams = event.params  
        sceneid = sceneparams.navigation.composer.id       --- new field otherwise it is a refernce and some calls here send a reference so comparing id's is useless         
        sceneinfo = myApp.otherscenes.policydetails 

        ------------------------------------------------
        -- clear thing out for this luanhc
        ------------------------------------------------
        if (runit or justcreated) then 


             display.remove( container )           -- wont exist initially no biggie
             container = nil

             display.remove( myList )           -- wont exist initially no biggie
             myList = nil

             container  = common.SceneContainer()
             group:insert(container )

             ---------------------------------------------
             -- Header group
             -- text gets set in Show evvent
             ---------------------------------------------

             itemGrp = display.newGroup(  )
             local startX = 0

             polgroup = myApp.authentication.policies[sceneid]
       
             -----------------------------
             -- is there a relationship to a policy that no longer the polciy exists ? policyTerms count would be 0
             -----------------------------
             if #polgroup.policyTerms > 0 then
                 local col = 1
                 local row = 1
                 local polcurrentterm = polgroup.policyTerms[1]    -- should be the current term as the rest service sorrted and we instered in order
                
                 print ("policy" .. sceneid .. polcurrentterm.policyInsuredName)


                --groupsPerRow   -- not really used on this screen


                 local groupheight = sceneinfo.groupheight
                 local groupwidth = sceneinfo.groupwidth                                -- starting width of the selection box
                 local workingScreenWidth = myApp.sceneWidth - sceneinfo.groupbetween   -- screen widh - the left edge (since each box would have 1 right edge)
                 local workingGroupWidth = groupwidth + sceneinfo.groupbetween          -- group width plus the right edge
                 local groupsPerRow = math.floor(workingScreenWidth / workingGroupWidth )    -- how many across can we fit
                 local leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )      -- width of the left edige
                 local leftY = (leftWidth) / 2 + (sceneinfo.groupbetween / 2 )          -- starting point of left box
                 local dumText = display.newText( {text="X",font= myApp.fontBold, fontSize=sceneinfo.textfontsize})
                 local textHeightSingleLine = dumText.height
                 display.remove( dumText )
                 dumText=nil

                 -------------------------------------------
                 -- lots of extra edging ? edging > space in between ?
                 -- expand the boxes but not beyond their max size
                 -------------------------------------------
                 if leftWidth > sceneinfo.groupbetween then
                    local origgroupwidth = groupwidth
                    groupwidth = groupwidth + ((leftWidth - sceneinfo.groupbetween) / groupsPerRow)   -- calcualte new group width
                    if groupwidth > sceneinfo.groupmaxwidth then                                      -- gone too far ? push back
                        groupwidth = sceneinfo.groupmaxwidth 
                        if groupwidth < origgroupwidth then groupwidth = origgroupwidth end                -- just incase someone puts the max > than original
                    end
                    workingGroupWidth = groupwidth +  sceneinfo.groupbetween                          -- calcualt enew total group width _ spacing
                    leftWidth = myApp.sceneWidth - (workingGroupWidth*groupsPerRow )                       -- recalce leftwdith and left starting point
                    leftY = (leftWidth) / 2 + (sceneinfo.groupbetween / 2 )
                 end


                 local  cellworkingGroupWidth = workingGroupWidth
                 local  cellgroupwidth = groupwidth 

                 ---------------------------------------------
                 -- lets create the group
                 ---------------------------------------------
                 local itemGrp = display.newGroup(  )
                 itemGrp.id = k
                 local startX =  0 
                 local startY =  0  - myApp.sceneHeight / 2  + groupheight / 2 + sceneinfo.groupbetween 


                 local textwidth = cellgroupwidth  - sceneinfo.textalignx  + 5
                 local textalignx = sceneinfo.textalignx * -1 - sceneinfo.groupbetween * 2
                 
                 -------------------------------------------------
                 -- Background
                 -------------------------------------------------
                 local myRoundedRect = display.newRoundedRect(startX, startY ,cellgroupwidth,  groupheight, 1 )
                 myRoundedRect:setFillColor(sceneinfo.groupbackground.r,sceneinfo.groupbackground.g,sceneinfo.groupbackground.b,sceneinfo.groupbackground.a )
                 itemGrp:insert(myRoundedRect)

                 -------------------------------------------------
                 -- Header Background
                 -------------------------------------------------
                 local startYother = startY- groupheight/2 + sceneinfo.groupbetween
                 local myRoundedTop = display.newRoundedRect(startX, startYother ,cellgroupwidth, sceneinfo.groupheaderheight, 1 )
                 --local headcolor = sceneinfo.groupheader
                 --myRoundedTop:setFillColor(headcolor.r,headcolor.g,headcolor.b,headcolor.a )
                 myRoundedTop:setFillColor(sceneinfo.groupheader)
                 itemGrp:insert(myRoundedTop)
                 
                 -------------------------------------------------
                 -- Header text
                 -------------------------------------------------
                 local myText = display.newText( sceneinfo.policytextlabel .. (polcurrentterm.policyNumber or ""), 0, startYother,  myApp.fontBold, sceneinfo.headerfontsize )
                 myText:setFillColor( sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b,sceneinfo.headercolor.a )
                 myText.anchorX = 0
                 myText.x= textalignx
                 itemGrp:insert(myText)

                 -------------------------------------------------
                 -- Lob image ?
                 -------------------------------------------------
                 local lob = string.lower( (polcurrentterm.policyLOB or "") )
                 local lobimage  =  myApp.lobimages[lob]
                 if lobimage == nil then
                    lobimage  =  myApp.lobimages.default
                 end
                 if lobimage then
                     local myIcon = display.newImageRect(myApp.imgfld .. lobimage,  sceneinfo.iconwidth , sceneinfo.iconheight )
                     common.fitImage( myIcon,   sceneinfo.iconwidth   )
                     myIcon.x = startX - cellgroupwidth/2 + myIcon.width/2  
                     myIcon.y = startYother  + myIcon.height/2  - sceneinfo.groupheaderheight / 2
                     itemGrp:insert(myIcon)
                 end

                 -------------------------------------------------
                 -- Insured Name
                 -------------------------------------------------
                 
                 local myName = display.newText( {text=(polcurrentterm.policyInsuredName or ""), x=0, y=0, height=0,width=textwidth,font= myApp.fontBold, fontSize=sceneinfo.nametextfontsize,align="left" })
                 myName:setFillColor( sceneinfo.nametextcolor.r,sceneinfo.nametextcolor.g,sceneinfo.nametextcolor.b,sceneinfo.nametextcolor.a )
                 myName.anchorX = 0
                 myName.anchorY = 0
                 myName.x= textalignx
                 myName.y=startYother + sceneinfo.groupheaderheight 
                 itemGrp:insert(myName)


                 -------------------------------------------------
                 -- Balance label
                 -------------------------------------------------
                 
                 local myBalanceLabel = display.newText( {text=sceneinfo.balancelabellabel  , x=0, y=0, height=0,font= myApp.fontBold, fontSize=sceneinfo.balancelabelfontsize })
                 myBalanceLabel:setFillColor( sceneinfo.balancelabelcolor.r,sceneinfo.balancelabelcolor.g,sceneinfo.balancelabelcolor.b,sceneinfo.balancelabelcolor.a )
                 myBalanceLabel.x=startX - cellgroupwidth/2 + sceneinfo.iconwidth /2  
                 myBalanceLabel.y=myName.y + 20
                 itemGrp:insert(myBalanceLabel)

                 -------------------------------------------------
                 -- Balance
                 -------------------------------------------------
                  
                 local myBalanceText = display.newText( {text=string.format("%6.2f",(polcurrentterm.policyDue or "") ) , x=0, y=0, height=0,font= myApp.fontBold, fontSize=sceneinfo.balancetextfontsize })
                 myBalanceText:setFillColor( sceneinfo.balancetextcolor.r,sceneinfo.balancetextcolor.g,sceneinfo.balancetextcolor.b,sceneinfo.balancetextcolor.a )
                 myBalanceText.x=myBalanceLabel.x
                 myBalanceText.y=myBalanceLabel.y + myBalanceLabel.height  
                 itemGrp:insert(myBalanceText)

                 -- -------------------------------------------------
                 -- -- POlicy Number 
                 -- -------------------------------------------------
                 
                 -- local myPolicy = display.newText( {text=sceneinfo.policytextlabel .. (polcurrentterm.policyNumber or ""), x=0, y=0, height=0,width=textwidth,font= myApp.fontBold, fontSize=sceneinfo.policytextfontsize,align="left" })
                 -- myPolicy:setFillColor( sceneinfo.policytextcolor.r,sceneinfo.policytextcolor.g,sceneinfo.policytextcolor.b,sceneinfo.policytextcolor.a )
                 -- myPolicy.anchorX = 0
                 -- myPolicy.anchorY = 0.5
                 -- myPolicy.x= textalignx
                 -- myPolicy.y=myName.y + myName.height  + 10
                 -- itemGrp:insert(myPolicy)


                 -------------------------------------------------
                 -- Terms
                 -------------------------------------------------
                 local effdate = common.dateDisplayFromIso(polcurrentterm.effDate.iso)
                 local expdate = common.dateDisplayFromIso(polcurrentterm.expDate.iso)
                 
                 local myTerm = display.newText( {text=sceneinfo.termtextlabel .. (effdate or "") .. " To " .. (expdate or "") , x=0, y=0, height=0,width=textwidth,font= myApp.fontBold, fontSize=sceneinfo.termtextfontsize,align="left" })
                 myTerm:setFillColor( sceneinfo.termtextcolor.r,sceneinfo.termtextcolor.g,sceneinfo.termtextcolor.b,sceneinfo.termtextcolor.a )
                 myTerm.anchorX = 0
                 myTerm.anchorY = 0.5
                 myTerm.x= textalignx
                 myTerm.y=myName.y + myName.height  + 10
                 itemGrp:insert(myTerm)


                 makepaymentButton = widget.newButton {
                        shape=sceneinfo.shape,
                        fillColor = { default={ sceneinfo.btncolor.r, sceneinfo.btncolor.g, sceneinfo.btncolor.b , sceneinfo.btndefaultcoloralpha}, over={ sceneinfo.btncolor.r, sceneinfo.btncolor.g, sceneinfo.btncolor.b, sceneinfo.btnovercoloralpha } },
                        label = sceneinfo.addpolicybtntext,
                        labelColor = { default={ sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b }, over={ sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b, sceneinfo.btnovercoloralpha } },
                        fontSize = sceneinfo.headerfontsize,
                        font = myApp.fontBold,
                        width = cellgroupwidth / 2 - sceneinfo.groupbetween ,
                        height = sceneinfo.btnheight,
                        x = 0,
                        y = startY + groupheight/2 + sceneinfo.btnheight/2 + sceneinfo.groupbetween,
                        onRelease = function() 
                                      myApp.showSubScreen({instructions=myApp.otherscenes.policyadd}) 

                                     end,
                      }
                 makepaymentButton.x = 0 - makepaymentButton.width/2 - sceneinfo.groupbetween
                 container:insert(makepaymentButton)

                 claimsButton = widget.newButton {
                        shape=sceneinfo.shape,
                        fillColor = { default={ sceneinfo.btncolor.r, sceneinfo.btncolor.g, sceneinfo.btncolor.b , sceneinfo.btndefaultcoloralpha}, over={ sceneinfo.btncolor.r, sceneinfo.btncolor.g, sceneinfo.btncolor.b, sceneinfo.btnovercoloralpha } },
                        label = sceneinfo.claimsbtntext,
                        labelColor = { default={ sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b }, over={ sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b, sceneinfo.btnovercoloralpha } },
                        fontSize = sceneinfo.headerfontsize,
                        font = myApp.fontBold,
                        width = cellgroupwidth / 2 - sceneinfo.groupbetween ,
                        height = sceneinfo.btnheight,
                        x = 0,
                        y = makepaymentButton.y,
                        onRelease = function() 
                                      

                                     end,
                      }
                 claimsButton.x = 0 + claimsButton.width/2  + sceneinfo.groupbetween
                 container:insert(claimsButton)



                 -------------------------------------------------
                 -- insert each individual group into the master group
                 -------------------------------------------------
 
                 container:insert(itemGrp)

                 ----------------------------------------------------
                 -- Table View
                 ----------------------------------------------------
                 myList = widget.newTableView {
                       x=0,
                       y= 0 + sceneinfo.groupheight/2 +  sceneinfo.btnheight/2 + sceneinfo.groupbetween , --myApp.cH/2 -  sceneinfo.tableheight/2 - myApp.tabs.tabBarHeight-sceneinfo.edge, 
                       width = cellgroupwidth , 
                       height = myApp.sceneHeight - sceneinfo.groupheight - sceneinfo.btnheight - sceneinfo.groupbetween*4,
                       onRowRender = onRowRender,
                       onRowTouch = onRowTouch,
                       listener = scrollListener,
                    }
                 container:insert(myList )

                 if common.testNetworkConnection()  then

                     native.setActivityIndicator( true ) 
                     parse:run(myApp.otherscenes.policydetails.functionname.getdocuments,
                        {
                         ["policyNumber"] = (polcurrentterm.policyNumber or ""),
                         },
                         ------------------------------------------------------------
                         -- Callback inline function
                         ------------------------------------------------------------
                         function(e) 
                            native.setActivityIndicator( false ) 
                            --debugpopup ("here from get policies")
                            if not e.error then  
                                 
 

                            else    -- on get policies rturn error check    error on the getpolicies

                            end  -- end of error check
                         end )  -- end of policies parse call anf callback


                 end    -- end of network connection check
 
            end    -- end check for policyterms
 
        end

    ----------------------------------
    -- Did Show
    ----------------------------------
    elseif ( phase == "did" ) then
        parse:logEvent( "Scene", { ["name"] = currScene} )
 

        justcreated = false
    end   -- phase check
	

end

function scene:hide( event )
    local group = self.view
    local phase = event.phase
    print ("Hide:" .. phase.. " " .. currScene)

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end

end

function scene:destroy( event )
	 
    print ("Destroy "   .. currScene)
end


function scene:myparams( event )
       return sceneparams
end

function scene:overlay( parms )
     print ("overlay happening on top of " .. currScene .. " " .. parms.type .. " " .. parms.phase)
end

---------------------------------------------------
-- use if someone wants us to transition away
-- for navigational appearnaces
-- used from the more button
---------------------------------------------------
function scene:morebutton( parms )

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene