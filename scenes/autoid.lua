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
                                          break
                                      end
                                   end  -- for ptv = 1, #polcurrentterm.vehicles  do
                                end -- #polcurrentterm.vehicles > 0 
                             end   -- have a term 
                        end -- loop thru policyVehs  (term)
                     end --if polgroup.policyVehs
             end  -- loop thru policies    


            ----------------------------------
            -- at this point we should have the specific information for the policy / term and vehicle and agency
            ----------------------------------
            if polcurrentveh and polagency then       
               print ("we have vehicle " .. polcurrentveh.objectId .. " " .. polcurrentveh.vehvin .. " " .. polcurrentterm.policynumber)
               print ("we have vehicle for agency " .. (polagency[agencymapping.name] or ""))


                 
                 -------------------------------------------------
                 -- Background
                 -------------------------------------------------
                 local myRoundedRect = display.newRoundedRect(50, 100 ,200,  150, 1 )
                 myRoundedRect:setFillColor(sceneinfo.groupbackground.r,sceneinfo.groupbackground.g,sceneinfo.groupbackground.b,sceneinfo.groupbackground.a )
                 itemGrp:insert(myRoundedRect)

                 -------------------------------------------------
                 -- Header Background
                 -------------------------------------------------

                 local myRoundedTop = display.newRoundedRect(50, 100 ,200,  50, 1 )
                 --local headcolor = sceneinfo.groupheader
                 --myRoundedTop:setFillColor(headcolor.r,headcolor.g,headcolor.b,headcolor.a )
                 myRoundedTop:setFillColor(sceneinfo.groupheader)
                 itemGrp:insert(myRoundedTop)
                 
                 -------------------------------------------------
                 -- Header text
                 -------------------------------------------------
                 local myText = display.newText(  (polcurrentveh.vehvin or ""), 0, 90,  myApp.fontBold, sceneinfo.headerfontsize )
                 myText:setFillColor( sceneinfo.headercolor.r,sceneinfo.headercolor.g,sceneinfo.headercolor.b,sceneinfo.headercolor.a )
                 myText.anchorX = 0
                 myText.x= 20
                 itemGrp:insert(myText)


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