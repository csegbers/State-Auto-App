-------------------------------------------------
--
-- classlogin.lua class 
--
-------------------------------------------------

local common = require( "common" )

local login = {}
local login_mt = { __index = login }	-- metatable
 
-------------------------------------------------
-- PUBLIC FUNCTIONS
--
-- Constructor
-------------------------------------------------

function login.new( parms )	-- constructor
 
	local newlogin = 
	{
	    id = parms.id,
		view = display.newGroup(),
	}

	return setmetatable( newlogin, login_mt )
end

---------------------------------------------- 
--
-- Return a group
--
-----------------------------------------------
 
function login:UI()
	local function textFieldHandler( event )
		    --
		    -- event.text only exists during the editing phase to show what's being edited.  
		    -- It is **NOT** the field's .text attribute.  That is event.target.text
		    --
		    if event.phase == "began" then

		        -- user begins editing textField
		        print( "Begin editing", event.target.text )

		    elseif event.phase == "ended" or event.phase == "submitted" then

		        -- do something with defaulField's text
		        print( "Final Text: ", event.target.text)
		        native.setKeyboardFocus( nil )

		    elseif event.phase == "editing" then

		        print( event.newCharacters )
		        print( event.oldText )
		        print( event.startPosition )
		        print( event.text )

		    end
    end

    local Screen = self.view
	local textField = common.newTextField({
		    width = 250,
		    height = 30,
		    text = "Hello World",
		    fontSize = 18,
		    font = "HelveticaNeue-Light",
		    listener = textFieldHandler,
		})

textField.x = display.contentCenterX
textField.y = 100
	return Screen 
end

---------------------------------------------------------------------------------
-- Being overlayed
---------------------------------------------------------------------------------
function login:overlayBegan( event )

end
---------------------------------------------------------------------------------
-- overlay ended
---------------------------------------------------------------------------------
function login:overlayEnded( event )


end
--=======================================
--== called so that if there are any native inputs we clear them
--== and transition anything not in the view
--=======================================
function login:exitClass()

end

function login:removeSelf()


end

return login