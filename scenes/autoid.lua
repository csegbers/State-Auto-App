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

local runit  
local justcreated  

local container
local itemGrp

local polcurrentterm
local polcurrentveh
local polgroup
local polagency
local agencymapping = myApp.mappings.objects["Agency"].mapping


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
        sceneinfo = myApp.otherscenes.autoid 

        print ("Auto id sceneid " .. sceneid)

        ------------------------------------------------
        -- clear thing out for this luanhc
        ------------------------------------------------
        if (runit or justcreated) then 

             display.remove( container )           -- wont exist initially no biggie
             container = nil

             container  = common.SceneContainer()
             group:insert(container)

             ---------------------------------------------
             -- Header group
             -- text gets set in Show evvent
             ---------------------------------------------

             itemGrp = display.newGroup(  )
             local startX = 0


             ----------------------------------
             -- loop thru all policiies terms and vehciles to find the object
             -- do this so you can use this scene from anywhere so long as you have that uniqe object we will find the policy / term
             ----------------------------------
             polcurrentterm = nil
             polcurrentveh = nil
             polgroup = nil
             polagency = myApp.authentication.agencies

             -------------------------
             -- loop thru policies
             -------------------------
             for k,v in pairs(myApp.authentication.policies) do 
                    polgroup = myApp.authentication.policies[k]
                    ------------------------------
                    -- vehicle groups policy terms on this policy ?
                    ------------------------------
                     if polgroup.policyVehs then

                        for kv,iv in pairs(polgroup.policyVehs) do
                             polcurrentterm = polgroup.policyVehs[kv]
                             if polcurrentterm  then 
                               ------------------------------
                               -- loop thru actual vehicles on the term
                               ------------------------------
                                if #polcurrentterm.vehicles > 0 then
                                   for ptv = 1, #polcurrentterm.vehicles  do
                                      local veh = polcurrentterm.vehicles[ptv]
                                      print (veh.objectId )
                                      if veh.objectId == sceneparams.objectId then
                                          polcurrentveh = veh
                                      end
                                      if polcurrentveh  then break end
                                   end  -- for ptv = 1, #polcurrentterm.vehicles  do
                                end -- #polcurrentterm.vehicles > 0 
                             end   -- have a term 
                             if polcurrentveh  then break end
                        end -- loop thru policyVehs  (term)   for kv,iv in pairs(polgroup.policyVehs) do
                     end --if polgroup.policyVehs
                     if polcurrentveh  then break end
             end  -- loop thru policies    


            ----------------------------------
            -- at this point we should have the specific information for the policy / term and vehicle and agency
            ----------------------------------
            if polcurrentveh and polagency then       
               print ("we have vehicle " .. polcurrentveh.objectId .. " " .. polcurrentveh.vehvin .. " " .. polcurrentterm.policynumber)
               print ("we have vehicle for agency " .. (polagency[agencymapping.name] or ""))

                 local idwidth = myApp.sceneHeight-sceneinfo.edge * 2    -- since we rotate 90 degrees use height for the width
                 local idheight = myApp.sceneWidth-sceneinfo.edge * 2    -- since we rotate 90 degrees use height for the width
                 
                 -------------------------------------------------
                 -- Background
                 -------------------------------------------------
                 local myRoundedRect = display.newRect(0, 0 ,idwidth,  idheight, 1 )
                 myRoundedRect:setFillColor(sceneinfo.groupbackground.r,sceneinfo.groupbackground.g,sceneinfo.groupbackground.b,sceneinfo.groupbackground.a )
                 itemGrp:insert(myRoundedRect)

                 -------------------------------------------------
                 --  image ?
                 -------------------------------------------------

                 local myIcon = display.newImageRect(myApp.imgfld .. sceneinfo.groupicon,  sceneinfo.iconwidth , sceneinfo.iconheight )
                 common.fitImage( myIcon,   sceneinfo.iconwidth   )
                 myIcon.x = 0 - idwidth/2 + myIcon.width/2 + sceneinfo.inneredge
                 myIcon.y = 0 - idheight/2 + myIcon.height/2 + sceneinfo.inneredge
                 itemGrp:insert(myIcon)
 

                 local AddText = function (txtparms)

                         local myText = display.newText( {text=(txtparms.text or ""), x=0, y=0  ,font= myApp.fontBold, fontSize=txtparms.fontsize ,align="left" })
             
                         myText:setFillColor( txtparms.textcolor.r,txtparms.textcolor.g,txtparms.textcolor.b,txtparms.textcolor.a )
                         myText.anchorX = 0
                         myText.anchorY = 0
                         myText.x=  txtparms.x
                         myText.y=  txtparms.y
                         itemGrp:insert(myText)   
                         return myText           
                 end

                 -------------------------------------------------
                 -- here we go
                 -------------------------------------------------

                 local starty = 0 - idheight/2 + 5

                 -----------------------
                 -- state name
                 -----------------------
                 local sttext = AddText({text=polcurrentterm.policystatename, fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= 0 - idwidth/2 + myIcon.width + 20, y =  starty})
                 AddText({text="(STATE)" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= sttext.x, y =  sttext.y + sttext.height + sceneinfo.inneredge})
 
                 -----------------------
                 -- group name and standard text
                 -----------------------               
                 local insgrptext = AddText({text=polcurrentterm.policyinsurancegroup, fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= 0, y =  starty})
                 insgrptext.x = idwidth/2 - insgrptext.width - sceneinfo.edge

                 starty = starty + insgrptext.height + sceneinfo.inneredge
                 local idtext = AddText({text=sceneinfo.autoidtext, fontsize=sceneinfo.headerfontsizelarge, textcolor=sceneinfo.headercolor, x= 0, y =  starty})
                 idtext.x = idwidth/2 - idtext.width - sceneinfo.edge  




                 local leftedge = sceneinfo.edge*2
                 -----------------------
                 -- naic company
                 -----------------------    
                 starty = starty + idtext.height + sceneinfo.edge        
                 local naictext = AddText({text="NAIC NUMBER" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/2 +  leftedge , y =  starty})
                 local companytext = AddText({text="COMPANY" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/5, y =  starty})

                 starty = starty + naictext.height + sceneinfo.inneredge         
                 local naicvalue = AddText({text=polcurrentterm.policynaic ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= naictext.x, y =  starty})
                 local companyvalue = AddText({text=polcurrentterm.policycompanyname ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= companytext.x, y =  starty})

                 -----------------------
                 -- policy
                 -----------------------    
                 starty = starty + companyvalue.height + sceneinfo.edge        
                 local polnumtext = AddText({text="POLICY NUMBER" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/2 +  leftedge, y =  starty})
                 local efftext = AddText({text="EFFECTIVE DATE" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/8, y =  starty})
                 local exptext = AddText({text="EXPIRATION DATE" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= idwidth/5, y =  starty})

                 starty = starty + polnumtext.height + sceneinfo.inneredge         
                 local polnumvalue = AddText({text=polcurrentterm.policynumber ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= polnumtext.x, y =  starty})
                 local effvalue = AddText({text=common.dateDisplayFromIso(polcurrentterm.effdate ) ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= efftext.x, y =  starty})
                 local expvalue = AddText({text=common.dateDisplayFromIso(polcurrentterm.expdate ) ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= exptext.x, y =  starty})


                 -----------------------
                 -- vehicle
                 -----------------------    
                 starty = starty + expvalue.height + sceneinfo.edge         
                 local yeartext = AddText({text="YEAR" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/2 +  leftedge, y =  starty})
                 local maketext = AddText({text="MAKE/MODEL" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= 0-idwidth/3, y =  starty})
                 local vintext = AddText({text="VEHICLE IDENTIFICATION NUMBER" ,fontsize=sceneinfo.headerfontsizesmall, textcolor=sceneinfo.headercolor, x= idwidth/11, y =  starty})

                 starty = starty + yeartext.height + sceneinfo.inneredge         
                 local yearvalue = AddText({text=polcurrentveh.vehyear ,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= yeartext.x, y =  starty})
                 local makevalue = AddText({text=(polcurrentveh.vehmake .. " "  .. polcurrentveh.vehmodel),fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= maketext.x, y =  starty})
                 local vinvalue = AddText({text=polcurrentveh.vehvin,fontsize=sceneinfo.headerfontsize, textcolor=sceneinfo.headercolor, x= vintext.x, y =  starty})

                 itemGrp:rotate( 90 )



            end








             container:insert(itemGrp)

 
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