function ModulesLoad()
	Events:FireRegisteredEvent( "HelpAddItem",
        {
            name = "ZED Commands+ V3.0",
            text = 
				"Idea by David1544. Converted for ZED Admin Mod by ROODAY.\n" ..
                "This plugin adds the following commands to ZED Admin Mod.\n\n" ..
				
				"/repair\n" .. 
				"Will repair your vehicle. It costs $300 to repair.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/killcar\n" .. 
				"Your car will be destroyed. It costs $100 to destroy.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/id <name/id>\n" .. 
				"Will give the Steam ID of the player specified.\n" ..
				"Adapted from ZED Essentials.\n\n" ..
				
				"/heal <name/id>\n" .. 
				"Will restore the specified player's health.\n" ..
				"Created by ROODAY.\n\n" ..
				
				"/sethealth <name/id> <0-100>\n" .. 
				"Sets the health of the specified player to the specified value.\n" ..
				"Created by ROODAY.\n\n" ..
				
				"/sky <name/id> \n" .. 
				"Will send the player specified into the sky!\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/vehcolor <Red Value> <Green Value> <Blue Value>\n" .. 
				"Specify the RGB value of the color you wish to change your vehicle to. It costs $300 to do.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n" ..
				"Thanks to Donkie for his Simple Timers script! He fixed this!\n\n" ..
				
				"/vehcolor2 <Red Value> <Green Value> <Blue Value> <Red Value 2> <Green Value 2> <Blue Value 2>\n" .. 
				"Specify the RGB values of the colors of both tones you wish to change your vehicle to. It costs $300 to do.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n" ..
				"Thanks to Donkie for his Simple Timers script! He fixed this!\n\n" ..
				
				"/setmoney  <name/id> <amount>\n" .. 
				"Specify the player and the amount to set their bank account to that value.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/forcepassenger <name/id>\n" ..
				"Teleports the specified player into your passenger seat. Does not work for all vehicles.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/addmoney <name/id> <amount>\n"..
				"Adds the specified amount to the specified player's bank account.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/takemoney <name/id> <amount>\n"..
				"Removes the specified amount from the specified player's bank account.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/getmoney <name/id>\n"..
				"Shows the money in the specified player's bank account.\n" ..
				"Adapted from Cain's Admin Commands and Functions.\n\n" ..
				
				"/mass <amount>\n" ..
				"Sets the mass of your vehicle to the specified amount.\n" ..
				"Adapted from RightClickHarder's Set Vehicle Mass.\n\n" ..
				
				"/weather <0-2>\n" ..
				"Sets the weather severity to the specified value. 0 is clear, 2 is stormy.\n" ..
				"Adapted from Eraknelo's Set Time and Weather.\n\n" ..
				
				"/time <0-24>\n" ..
				"Sets the time to the specified value. Only 0 through 24 will work.\n" ..
				"Adapted from Eraknelo's Set Time and Weather.\n\n" ..
				
				"/timestep <0+>\n" ..
				"Sets the timestep to the specified value. Only 0 and greater will work.\n" ..
				"Adapted from Eraknelo's Set Time and Weather.\n\n" ..
				
				"/vjump <amount>\n" ..
				"Teleports your vehicle along the Y axis the specified amount. Negative values will work, but be careful of the ground.\n" ..
				"Adapted from X-Nobody-X's NAdmin.\n\n" ..
				
				"/takeveh <name/id>\n" ..
				"Steal the vehicle of the specified player.\n" ..
				"Adapted from X-Nobody-X's NAdmin.\n\n" ..
				
				"/vgoto <name/id>\n" ..
				"Send you and your vehicle 25 meters above the specified player.\n" ..
				"Created by ROODAY.\n\n" ..
				
				"/getplypos <name/id>\n" ..
				"Gets the coordinates of the specified player.\n" ..
				"Adapted from ZED Essentials.\n\n" ..
				
				"/delplyveh <name/id>\n" ..
				"Deletes the vehicle the specified player is in.\n" ..
				"Adapted from ZED Essentials.\n\n" ..
				
				"/givewep <name/id> <slot> <weapon id>\n" ..
				"Give the specified player the specified weapon in the specified slot.\n" ..
				"Adapted from ZED Essentials.\n\n" ..
				
				"/giveveh <name/id> <vehicle id>\n" ..
				"Gives the specified player the specified vehicle.\n" ..
				"Adapted from ZED Essentials." ..

				"/makeitrain\n" ..
				"Makin it rain, hoes!\n" ..
				"Adapted from X-Nobody-X's NAdmin.\n\n"
        } )
end

function ModuleUnload()
    Events:FireRegisteredEvent( "HelpRemoveItem",
        {
            name = "ZED Commands+ V3.0"
        } )
end

Events:Subscribe("ModulesLoad", ModulesLoad)
Events:Subscribe("ModuleUnload", ModuleUnload)