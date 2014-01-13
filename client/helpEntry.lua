function ModulesLoad()
	Events:FireRegisteredEvent( "HelpAddItem",
        {
            name = "ZED Essentials V2.1",

			text = 
				"Here is a list of all the commands in ZED Essentials.\n" ..
				"Created by IZED. Some commands by ROODAY.\n\n" ..

				"Money Related Commands:\n\n" ..
				
				"/setmoney or /sm <name/id> <amount>\n" ..
				"Sets the player's total money to the value.\n\n" ..
				
				"/getmoney or /gm <name/ide>\n" ..
				"Shows the total money of the player.\n\n" ..
				
				"/addmoney or /am <name/id> <amount>\n" ..
				"Adds the value to the player.\n\n" ..
				
				"/takemoney or /tm <name/id> <amount>\n" ..
				"Takes the value from the player and gives it to you.\n\n" ..
				
				"/loan or /pay <name/id> <amount>\n" ..
				"Gives the player the value from your money.\n\n" ..
				
				"Player Related Commands:\n\n" ..
				
				"/sky <name/id>\n" ..
				"Sends the player 800 meters up.\n\n" ..
				
				"/me <text>\n" ..
				"Broadcasts text from you in a random color.\n\n" ..
				
				"/id <name/id>\n" ..
				"Outputs the SteamID of the player.\n\n" ..
				
				"/makeitrain or /mir <0-5>\n" ..
				"Gives $10,000 per server tick to all players for specified time in seconds.\n\n" ..
				
				"/heal <name/id>\n" ..
				"Sets the player's health to 100.\n\n" ..
				
				"/sethealth or /psh <name/id> <0.00-1>\n" ..
				"Sets the player's health to the value. 0.5 is 50%, etc.\n\n" ..
				
				"/takeveh or /steal <name/id>\n" ..
				"Steals the vehicle of the player and puts them in the passenger seat. Only works in close proximity.\n\n" ..
				
				"/getplypos or /gpp <name/id>\n" ..
				"Shows coordinates of player.\n\n" ..
				
				"/delplyveh or /dpv <name/id>\n" ..
				"Deletes the player's current vehicle.\n\n" ..
				
				"/giveveh or /gv <name/id> <model id>\n" ..
				"Gives the player the specified vehicle.\n\n" ..
				
				"/givewep or /gw <name/id> <slot> <model id>\n" ..
				"Gives the player the specified weapon in the specified slot.\n\n" ..
				
				"/SAM or /sam\n" ..
				"Purchases a SAM launcher for $1,000. Requires at least $1,000 to work.\n\n" ..
				
				"/tpu\n" ..
				"Sends you 10 meters up.\n\n" ..
				
				"/tpd\n" ..
				"Sends you 10 meters down.\n\n" ..
				
				"/tpe\n" ..
				"Sends you 10 meters east.\n\n" ..
				
				"/tpw\n" ..
				"Sends you 10 meters west.\n\n" ..
				
				"/tpn\n" ..
				"Sends you 10 meters north.\n\n" ..
				
				"/tps\n" ..
				"Sends you 10 meters south.\n\n" ..
				
				"/clearinventory or /ci\n" ..
				"Clears your inventory.\n\n" ..
				
				"/disableaa or /daa\n" ..
				"Disables Auto Aim.\n\n" ..
				
				"/enableaa or /eaa\n" ..
				"Enables Auto Aim.\n\n" ..
				
				"/disablepc or /dpc\n" ..
				"Disables player collisions.\n\n" ..
				
				"/enablepc or /epc\n" ..
				"Enables player collisions.\n\n" ..
				
				"/disablevc or /dvc\n" ..
				"/Disables vehicle collisions.\n\n" ..
				
				"/enablevc or /evc\n" ..
				"Enables vehicle collisions.\n\n" ..
				
				"/getaimtarget or /gat\n" ..
				"Outputs info on what you're aiming at.\n\n" ..
				
				"/getinventory or /gi\n" ..
				"Shows what's in your inventory.\n\n" ..
				
				"/model <model id>\n" ..
				"Changes your playermodel to the specified id.\n\n" ..
				
				"/slay <name/id>\n" ..
				"Kills the player.\n\n" ..
				
				"/jump <distance>\n" ..
				"Teleports you along the Y axis the value specified.\n\n" ..
				
				"/getpos\n" ..
				"Displays your current coordinates.\n\n" ..
				
				"/goto <name/id>\n" ..
				"Teleports you to the player.\n\n" ..
				
				"/tppos <x> <y> <z>\n" ..
				"Teleports you to the specified coordinates.\n\n" ..
				
				"/bring <name/id>\n" ..
				"Teleports the player to you.\n\n" ..
				
				"/enact <name/id> <action id>\n" ..
				"Runs the action on the player.\n\n" ..
				
				"/disact <name/id> <action id>\n" ..
				"Stops the action on the player.\n\n" ..
				
				"/mute <name/id>\n" ..
				"Restricts the player from using chat.\n\n" ..
				
				"/unmute <name/id>\n" ..
				"Allows the player to use chat again.\n\n" ..
				
				"/freeze <name/id>\n" ..
				"Stops the player from moving.\n\n" ..
				
				"/unfreeze <name/id>\n\n" ..
				"Allows player to move again.\n\n" ..
				
				"/notify or /ntf <text>\n" ..
				"Displays text on top of screen to all players.\n\n" ..
				
				"/notifyply or /ntfply <name/id> <text>\n" ..
				"Displays text on top of screen for specified player only.\n\n" ..
				
				"/whisper or /pm or /w <name/id> <text>\n" ..
				"Sends private message to player.\n\n" ..
				
				"/disarm <name/id>\n" ..
				"Strips the player of their weapons.\n\n" ..
				
				"/kick <name/id>\n" ..
				"Kicks the player from the server.\n\n" ..
				
				"/ban <name/id>\n" ..
				"Bans the player from the server.\n\n" ..
				
				"/wep <slot> <model id>\n" ..
				"Gives you the specified weapon in the specified slot.\n\n" ..
				
				"Vehicle Related Commands:\n\n" ..
				
				"/forcepassenger or /fp <name/id>\n" ..
				"Forces the player into your vehicle. Works only in close proximity.\n\n" ..
				
				"/mass <amount>\n" ..
				"Sets your vehicle's mass to the specified amount.\n\n" ..
				
				"/repair or /vr\n" ..
				"Respawns your car at your location for $300.\n\n" ..
				
				"/fix or /vf\n" ..
				"Sets your vehicle's health to 100 for $300.\n\n" ..
				
				"/vsh <0.00-1>\n" ..
				"Sets your vehicle's health. 0.5 = 50%, etc.\n\n" ..
				
				"/killcar or /kc \n" ..
				"Destroys your vehicle (and you!) for $100.\n\n" ..
				
				"/vehcolor or /vc <red> <green> <blue>\n" ..
				"Sets both of your vehicle's color tones to the specified RGB.\n\n" ..
				
				"/vehcolor2 or /vc2 <red> <green> <blue> <red 2> <green 2> <blue 2>\n" ..
				"Sets your vehicle's color tones to the specified RGB.\n\n" ..
				
				"/vjump <amount>\n" ..
				"Moves your vehicle along the Y axis the specified amount.\n\n" ..
				
				"/vgoto <name/id>\n" ..
				"Teleports your vehicle to the specified player. Works only in close proximity.\n\n" ..
				
				"/woet\n" ..
				"You know what this does.\n\n" ..
				
				"/woet2\n" ..
				"Even better. Sometimes.\n\n" ..
				
				"/getvehicleid or /gvi\n" ..
				"Shows your vehicle's model id.\n\n" ..
				
				"/getvehicledecal or /gvd\n" ..
				"Shows your vehicle's decal.\n\n" ..
				
				"/getvehicletemplate or /gvt\n" ..
				"Shows your vehicle's template.\n\n" ..
				
				"/getoccupants or /gpvo\n" ..
				"Shows the occupants of the specified player's vehicle.\n\n" ..
				
				"/settemplate or /svt <template>\n" ..
				"Sets your vehicle's template.\n\n" ..
				
				"/setdecal or /svd <decal>\n" ..
				"Sets your vehicle's decal.\n\n" ..
				
				"/spawn <model id> <template> <decal>\n" ..
				"Spawns a vehicle with the specified arguments.\n\n" ..
				
				"/veh <model id>\n" ..
				"Spawns the specified vehicle with standard settings.\n\n" ..
				
				"/delveh\n" ..
				"Deletes your current vehicle.\n\n" ..
				
				"/delallveh\n" ..
				"Deletes all vehicles in game. Even default ones.\n\n" ..
				
				"World Related Commands:\n\n" ..
				
				"/weather <0.0-2>\n" ..
				"Sets weather severity. 0 = clear, 2 = stormy.\n\n" ..
				
				"/time <0-24>\n" ..
				"Sets the time.\n\n" ..
				
				"/timestep <0-1000>\n" ..
				"Sets how fast time goes. Negative numbers don't work.\n\n"
				
        } )
end

function ModuleUnload()
    Events:FireRegisteredEvent( "HelpRemoveItem",
        {
            name = "ZED Essentials V2.1"
        } )
end

Events:Subscribe("ModulesLoad", ModulesLoad)
Events:Subscribe("ModuleUnload", ModuleUnload)