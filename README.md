ZED Essentials V2.1
==========
***Now With Commands+!***

Essentials plugin for JC2 MP - Requires [ZED Base] (https://github.com/IZEDx/ZED) to function.   
Also, check out [ZED Groups] (https://github.com/IZEDx/Groups) and the [ZED Wiki!] (https://github.com/IZEDx/ZED/wiki)

List of Commands
==========

***Money Related Commands:***   
				
**/setmoney or /sm <name/id> <amount>**   
*Sets the player's total money to the value.*   

**/getmoney or /gm <name/id>**   
*Shows the total money of the player.*   

**/addmoney or /am <name/id> <amount>**   
*Adds the value to the player.*   

**/takemoney or /tm <name/id> <amount>**    
*Takes the value from the player and gives it to you.*   

**/loan or /pay <name/id> <amount>**   
*Gives the player the value from your money.*   

***Player Related Commands:***   

**/sky <name/id>**   
*Sends the player 800 meters up.*   

**/me <text>**   
*Broadcasts text from you in a random color.*   

**/id <name/id>**   
*Outputs the SteamID of the player.*   

**/makeitrain or /mir <0-5>**   
*Gives $10,000 per server tick to all players for specified time in seconds.*   

**/heal <name/id>**   
*Sets the player's health to 100.*   

**/sethealth or /psh <name/id> <0.00-1>**   
*Sets the player's health to the value. 0.5 is 50%, etc.*   

**/takeveh or /steal <name/id>**   
*Steals the vehicle of the player and puts them in the passenger seat. Only works in close proximity.*   

**/getplypos or /gpp <name/id>**   
*Shows coordinates of player.*   

**/delplyveh or /dpv <name/id>**   
*Deletes the player's current vehicle.*   

**/giveveh or /gv <name/id> <model id>**   
*Gives the player the specified vehicle.*   

**/givewep or /gw <name/id> <slot> <model id>**   
*Gives the player the specified weapon in the specified slot.*   

**/SAM or /sam**   
*Purchases a SAM launcher for $1,000. Requires at least $1,000 to work.*   

**/tpu**   
*Sends you 10 meters up.*   

**/tpd**   
*Sends you 10 meters down.*   

**/tpe**   
*Sends you 10 meters east.*   

**/tpw**   
*Sends you 10 meters west.*   

**/tpn**   
*Sends you 10 meters north.*   

**/tps**   
*Sends you 10 meters south.*   

**/clearinventory or /ci**   
*Clears your inventory.*    

**/disableaa or /daa**   
*Disables Auto Aim.*    

**/enableaa or /eaa**   
*Enables Auto Aim.*    

**/disablepc or /dpc**   
*Disables player collisions.*    

**/enablepc or /epc**    
*Enables player collisions.*    

**/disablevc or /dvc**    
*Disables vehicle collisions.*    

**/enablevc or /evc**    
*Enables vehicle collisions.*    

**/getaimtarget or /gat**    
*Outputs info on what you're aiming at.*    

**/getinventory or /gi**   
*Shows what's in your inventory.*    

**/model <model id>**    
*Changes your playermodel to the specified id.*    

**/slay <name/id>**    
*Kills the player.*      

**/jump <distance>**     
*Teleports you along the Y axis the value specified.*    

**/getpos**   
*Displays your current coordinates.*    

**/goto <name/id>**   
*Teleports you to the player.*     

**/tppos <x> <y> <z>**   
*Teleports you to the specified coordinates.*    

**/bring <name/id>**  
*Teleports the player to you.*    

**/enact <name/id> <action id>**    
*Runs the action on the player.*    

**/disact <name/id> <action id>**    
*Stops the action on the player.*    

**/mute <name/id>**    
*Restricts the player from using chat.*    

**/unmute <name/id>**    
*Allows the player to use chat again.*    

**/freeze <name/id>**    
*Stops the player from moving.*    

**/unfreeze <name/id>**    
*Allows player to move again.*    

**/notify or /ntf <text>**    
*Displays text on top of screen to all players.*    

**/notifyply or /ntfply <name/id> <text>**     
*Displays text on top of screen for specified player only.*   

**/whisper or /pm or /w <name/id> <text>**    
*Sends private message to player.*    

**/disarm <name/id>**    
*Strips the player of their weapons.*     

**/kick <name/id>**    
*Kicks the player from the server.*    

**/ban <name/id>**    
*Bans the player from the server.*    

**/wep <slot> <model id>**    
*Gives you the specified weapon in the specified slot.*   

***Vehicle Related Commands:***    

**/forcepassenger or /fp <name/id>**    
*Forces the player into your vehicle. Works only in close proximity.*     

**/mass <amount>**   
*Sets your vehicle's mass to the specified amount.*    

**/repair or /vr**    
*Respawns your car at your location for $300.*    

**/fix or /vf**    
*Sets your vehicle's health to 100 for $300.*    

**/vsh <0.00-1>**    
*Sets your vehicle's health. 0.5 = 50%, etc.*    

**/killcar or /kc**    
*Destroys your vehicle (and you!) for $100.*    

**/vehcolor or /vc <red> <green> <blue>**    
*Sets both of your vehicle's color tones to the specified RGB.*    

**/vehcolor2 or /vc2 <red> <green> <blue> <red 2> <green 2> <blue 2>**    
*Sets your vehicle's color tones to the specified RGB.*    

**/vjump <amount>**    
*Moves your vehicle along the Y axis the specified amount.*    

**/vgoto <name/id>**    
*Teleports your vehicle to the specified player. Works only in close proximity.*    

**/woet**    
*You know what this does.*    

**/woet2**    
*Even better. Sometimes.*    

**/getvehicleid or /gvi**    
*Shows your vehicle's model id.*    

**/getvehicledecal or /gvd**   
*Shows your vehicle's decal.*     

**/getvehicletemplate or /gvt**    
*Shows your vehicle's template.*    

**/getoccupants or /gpvo**     
*Shows the occupants of the specified player's vehicle.*    

**/settemplate or /svt <template>**    
*Sets your vehicle's template.*    

**/setdecal or /svd <decal>**   
*Sets your vehicle's decal.*    

**/spawn <model id> <template> <decal>**     
*Spawns a vehicle with the specified arguments.*     

**/veh <model id>**    
*Spawns the specified vehicle with standard settings.*    

**/delveh**    
*Deletes your current vehicle.*      

**/delallveh**     
*Deletes all vehicles in game. Even default ones.*   

***World Related Commands:***   

**/weather <0.0-2>**       
*Sets weather severity. 0 = clear, 2 = stormy.*        

**/time <0-24>**   
*Sets the time.*   

**/timestep <0-1000>**     
*Sets how fast time goes. Negative numbers don't work.*    
