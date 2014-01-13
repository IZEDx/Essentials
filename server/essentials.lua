FreezeActions = {39, 152, 48, 47, 67, 66, 68, 69, 36, 118, 146, 76, 19, 37, 116, 113, 115, 114, 117, 45, 46, 11, 81, 12, 13, 14, 82, 43, 57, 132, 50, 56, 49, 55, 53, 54, 51, 52, 78, 35, 4, 5, 6, 3, 1, 137, 31, 30, 32, 33, 70, 17, 72, 71, 147, 148, 65, 64, 59, 62, 63, 60, 61, 18, 144, 145, 16, 7, 40, 9, 126, 125, 128, 127, 44, 119, 75, 73, 74, 77, 10, 15, 41, 42, 38, 8, 138, 139, 34, 29, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 83, 84 }
MutedPlayers = {}

strFind = function(v1, v2)
	if(string.find(string.lower(tostring(v1)), string.lower(tostring(v2))))then
		return true
	else
		return false
	end
end
strEquals = function(v1, v2)
	if(string.lower(tostring(v1)) == string.lower(tostring(v2)))then
		return true
	else
		return false
	end
end
function Broadcast(...)
	args = {...}
	if type(args[1]) == "table" then
		Events:Fire("ZEDBroadcast", args[1])
	else
		Events:Fire("ZEDBroadcast", {...})
	end
end
function SendChatMessage(ply, ...)
	args = {...}
	if type(args[1]) == "table" then
		Events:Fire("ZEDSendChatMessage", {player=ply, message=args[1]})
	else
		Events:Fire("ZEDSendChatMessage", {player=ply, message={...}})
	end
end
GetPlayer = function( str)
	for player in Server:GetPlayers() do
		if(string.find(string.lower(player:GetName()), string.lower(str)))then
			return player
		end
	end
end

Events:Subscribe("ZEDExecuteCommand", function(a)
	local ply = a.player
	local args = a.cmd
	
	--//            \\--
	--  Money Related --
	--\\            //--
	
	if (strEquals(args[1], "setmoney")) or (strEquals(args[1], "sm")) then
		if args[2] and tonumber(args[3]) then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " set your money to $" .. args[3] .. "!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s money has been set to $" .. args[3])
				target:SetMoney(tonumber(args[3]))
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " set your money to $" .. args[3] .. "!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s money has been set to $" .. args[3])
				target:SetMoney(tonumber(args[3]))
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /setmoney <name/id/*> <amount>")
			return false
		end
	end
	
	if (strEquals(args[1], "getmoney")) or (strEquals(args[1], "gm")) then
		if(args[2])then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				SendChatMessage(ply, Color(20,200,0),"[ZED]: " .. target:GetName() .. " currently has $" .. target:GetMoney())
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				SendChatMessage(ply, Color(20,200,0),"[ZED]: " .. target:GetName() .. " currently has $" .. target:GetMoney())
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /getmoney <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "addmoney")) or (strEquals(args[1], "am")) then
		if args[2] and tonumber(args[3]) then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " gave you $" .. args[3] .. "!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " received $" .. args[3])
				target:SetMoney(target:GetMoney() + tonumber(args[3]))
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " gave you $" .. args[3] .. "!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " received $" .. args[3])
				target:SetMoney(target:GetMoney() + tonumber(args[3]))
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /addmoney <name/id/*> <amount>")
			return false
		end
	end
	
	if (strEquals(args[1], "takemoney")) or (strEquals(args[1], "tm")) then
		if args[2] and tonumber(args[3]) then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " took $" .. args[3] .. " from you!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " lost $" .. args[3])
				target:SetMoney(target:GetMoney() - tonumber(args[3]))
				ply:SetMoney(ply:GetMoney() + tonumber(args[3]))
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " took $" .. args[3] .. " from you!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " lost $" .. args[3])
				target:SetMoney(target:GetMoney() - tonumber(args[3]))
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /takemoney <name/id/*> <amount>")
			return false
		end
	end
	
	if (strEquals(args[1], "loan")) or (strEquals(args[1], "pay")) then
		if args[2] and tonumber(args[3]) then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " paid you $" .. args[3] .. "!")
				SendChatMessage(ply, Color(200,20,200),"[ZED]: You gave " .. target:GetName() .. " $" .. args[3] .. "!")
				target:SetMoney(target:GetMoney() + tonumber(args[3]))
				ply:SetMoney(ply:GetMoney() - tonumber(args[3]))
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " paid you $" .. args[3] .. "!")
				SendChatMessage(ply, Color(200,20,200),"[ZED]: You gave " .. target:GetName() .. " $" .. args[3] .. "!")
				target:SetMoney(target:GetMoney() + tonumber(args[3]))
				ply:SetMoney(ply:GetMoney() - tonumber(args[3]))
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /loan <name/id/*> <amount>")
			return false
		end
	end
	
	--//             \\--
	--  Player Related --
	--\\             //--
	
	if strEquals(args[1], "sky") then
		if(args[2])then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				local pos = target:GetPosition()
				target:Teleport(Vector3(pos.x, pos.y + 800, pos.z), target:GetAngle())
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " sent you into the sky!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " has been sent into the sky!")
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				local pos = target:GetPosition()
				target:Teleport(Vector3(pos.x, pos.y + 800, pos.z), target:GetAngle())
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " sent you into the sky!")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " has been sent into the sky!")
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /sky <name/id/*>")
			return false
		end
	end
	
	if strEquals(args[1], "me") then
		if(args[2])then
			local text = ""
			for k,v in pairs(args) do
				if k > 1 then
					text = text .. " " .. tostring(v)
				end
			end
			Broadcast(Color(math.random(0,255), math.random(0,255), math.random(0,255)), "* ", ply:GetName() ,": ", text)
			return true
		else
			SendChatMessage(ply, Color(200,20,20), "[ZED]: Syntax: /me <text>")
			return false
		end
	end
	
	if strEquals(args[1], "id") then
		if(args[2])then
			if(tonumber(args[2])) then
				local target = Player.GetById(tonumber(args[2]))
				local id = tostring(target:GetSteamId())
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s Steam ID is " .. id)
				return true
			elseif GetPlayer(args[2]) then
				local target = GetPlayer(args[2])
				local id = tostring(target:GetSteamId())
				SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s Steam ID is " .. id)
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /id <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "makeitrain")) or (strEquals(args[1], "mir")) then
		if(args[2])then
			if(tonumber(args[2])) then
				timer = Timer()
				length = tonumber(args[2])
				if (tonumber(args[2])) > 0 then
					if (tonumber(args[2])) <= 5 then
						while tonumber(timer:GetSeconds()) <= length do
							for player in Server:GetPlayers() do
								player:SetMoney(player:GetMoney() + 10000)
							end
						end
						Broadcast(Color(20, 200, 20), "[ZED]: " .. ply:GetName() , " has made it rain!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too long: " .. args[2])
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too short: " .. args[2])
					return false
				end		
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /makeitrain <0-5>")
			return false
		end
	end
	
	if strEquals(args[1], "heal") then
		if(args[2])then
			if(tonumber(args[2])) then
				target = Player.GetById(tonumber(args[2]))
				if target:GetHealth() < 100 then
					target:SetHealth(100)
					SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " healed you!")
					SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " has been healed!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is already at full health!")
					return false
				end
			elseif GetPlayer(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				if target:GetHealth() < 100 then
					target:SetHealth(100)
					SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " healed you!")
					SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " has been healed!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is already at full health!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /id <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "sethealth")) or (strEquals(args[1], "psh")) then
		if (args[2]) and tonumber(args[3]) then
			if(tonumber(args[2])) then
				if tonumber(args[3]) >= 0 then
					if tonumber(args[3]) <= 1 then
						target = Player.GetById(tonumber(args[2]))
						health = tonumber(args[3])
						target:SetHealth(health)
						SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " set your health to " .. args[3] .. "!")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s health has been set to " .. args[3] .. "!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[3] .. " is too high!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[3] .. " is too low!")
					return false
				end
			elseif GetPlayer(args[2]) then
				if tonumber(args[3]) >= 0 then
					if tonumber(args[3]) <= 1 then
						target = GetPlayer(args[2])
						health = tonumber(args[3])
						target:SetHealth(health)
						SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " set your health to " .. args[3] .. "!")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. "'s health has been set to " .. args[3] .. "!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[3] .. " is too high!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[3] .. " is too low!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /sethealth <name/id> <0.000-1>")
			return false
		end
	end
	
	if (strEquals(args[1], "takeveh")) or (strEquals(args[1], "steal")) then
		if(args[2])then
			if(tonumber(args[2])) then
				target = Player.GetById(tonumber(args[2]))
				if target:GetVehicle() then
					car = target:GetVehicle()
					target:SetPosition(target:GetPosition())
					ply:EnterVehicle(car, VehicleSeat.Driver)
					target:EnterVehicle(car, VehicleSeat.Passenger)
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has stolen your car!")
					SendChatMessage(ply, Color(20,200,20),"[ZED]: It's yours now!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is not in a vehicle!")
					return false
				end
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				if target:GetVehicle() then
					car = target:GetVehicle()
					target:SetPosition(target:GetPosition())
					ply:EnterVehicle(car, VehicleSeat.Driver)
					target:EnterVehicle(car, VehicleSeat.Passenger)
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has stolen your car!")
					SendChatMessage(ply, Color(20,200,20),"It's yours now!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /takeveh <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "getplypos")) or (strEquals(args[1], "gpp")) then
		if(args[2])then
			if(tonumber(args[2])) then
				target = Player.GetById(tonumber(args[2]))
				SendChatMessage(ply, Color(200,200,0),"[ZED]: " .. target:GetName() .. " is at: " .. tostring(target:GetPosition()))
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				SendChatMessage(ply, Color(200,200,0),"[ZED]: " .. target:GetName() .. " is at: " .. tostring(target:GetPosition()))
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /getplypos <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "delplyveh")) or (strEquals(args[1], "dpv")) then
		if(args[2])then
			if(tonumber(args[2])) then
				target = Player.GetById(tonumber(args[2]))
				if(target:InVehicle())then
					target:GetVehicle():Remove()
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " deleted your vehicle!")
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You have successfully deleted " .. target:GetName() .. "'s vehicle.")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is not in a vehicle.")
					return false
				end
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				if(target:InVehicle())then
					target:GetVehicle():Remove()
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " deleted your vehicle!")
					SendChatMessage(ply, Color(200,20,20),"You have successfully deleted " .. target:GetName() .. "'s vehicle.")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. target:GetName() .. " is not in a vehicle.")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /delplyveh <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "giveveh")) or (strEquals(args[1], "gv")) then
		if(args[2])then
			if tonumber(args[2]) and tonumber(args[3]) then
				target = Player.GetById(tonumber(args[2]))
				status, veh = pcall(Vehicle.Create, tonumber(args[3]), target:GetPosition(), target:GetAngle())
				name = veh:GetName()
				if status then
					target:EnterVehicle(veh, 0)
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " put you in a " .. name .. "!")
					SendChatMessage(ply, Color(20,200,20),"[ZED]: You have successfully put " .. target:GetName() .. " in a " .. name .. "!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: Invalid ID.")
					return false
				end
			elseif GetPlayer(args[2]) then	
				target = GetPlayer(args[2])
				status, veh = pcall(Vehicle.Create, tonumber(args[3]), target:GetPosition(), target:GetAngle())
				name = veh:GetName()
				if status then
					target:EnterVehicle(veh, 0)
					SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " put you in a " .. name .. "!")
					SendChatMessage(ply, Color(20,200,20),"You have successfully put " .. target:GetName() .. " in a " .. name .. "!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"Invalid ID.")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /giveveh <name/id> <vehicle id>")
			return false
		end
	end

	if (strEquals(args[1], "givewep")) or (strEquals(args[1], "gw")) then
		if(args[2])then
			if tonumber(args[2]) and tonumber(args[3]) and tonumber(args[4]) then
				target = Player.GetById(tonumber(args[2]))
				if pcall(ply.GiveWeapon, target, tonumber(args[3]), Weapon(tonumber(args[4]), 999, 999)) then
					SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " gave you a gun!")
					SendChatMessage(ply, Color(20,200,20),"[ZED]: You have successfully given " .. target:GetName() .. " a gun!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: Invalid ID.")
					return false
				end
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				if pcall(ply.GiveWeapon, target, tonumber(args[3]), Weapon(tonumber(args[4]), 999, 999)) then
					SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " gave you a gun!")
					SendChatMessage(ply, Color(20,200,20),"You have successfully given " .. target:GetName() .. " a gun!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"Invalid ID.")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"Syntax: /givewep <name/id> <slot> <weapon id>")
			return false
		end
	end
	
	if (strEquals(args[1], "SAM")) or (strEquals(args[1], "sam")) then
		if ply:GetMoney() > 1000 then
			ply:GiveWeapon(2, Weapon(31,1,9))
			ply:SetMoney(ply:GetMoney() - 1000)
			SendChatMessage(ply, Color(20,200,20), "[ZED]: You have purchased a SAM launcher!")
			return true
		else
			SendChatMessage(ply, Color(200,20,20), "[ZED]: You need at least $1,000 for a SAM laucnher!")
			return false
		end
	end
	
	if (strEquals(args[1], "tpu")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(0,10,0))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters higher!")
		return true
	end
	
	if (strEquals(args[1], "tpd")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(0,-10,0))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters lower!")
		return true
	end
	
	if (strEquals(args[1], "tpe")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(-10,0,0))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters to the east!")
		return true
	end
	
	if (strEquals(args[1], "tpw")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(10,0,0))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters to the west!")
		return true
	end
	
	if (strEquals(args[1], "tpn")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(0,0,-10))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters to the north!")
		return true
	end
	
	if (strEquals(args[1], "tps")) then
		pos = ply:GetPosition()
		ply:SetPosition(pos + Vector3(0,0,10))
		SendChatMessage(ply, Color(20,200,20), "[ZED]: You are now 10 meters to the south!")
		return true
	end
	
	if (strEquals(args[1], "clearinventory")) or (strEquals(args[1], "ci")) then
		ply:ClearInventory()
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Inventory cleared!")
		return true
	end
	
	if (strEquals(args[1], "disableaa")) or (strEquals(args[1], "daa")) then
		ply:DisableAutoAim(ply)
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Autoaim disabled!")
		return true
	end
	
	if (strEquals(args[1], "disablepc")) or (strEquals(args[1], "dpc")) then
		ply:DisableCollision(1)
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Player Collisions Disabled!")
		return true
	end
	
	if (strEquals(args[1], "disablevc")) or (strEquals(args[1], "dvc")) then
		ply:DisableCollision(16)
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Vehicle Collisions Disabled!")
		return true
	end
	
	if (strEquals(args[1], "enableaa")) or (strEquals(args[1], "eaa")) then
		ply:EnableAutoAim(ply)
		SendChatMessage(ply, Color(20,200,20), "[ZED]: Autoaim enabled!")
		return true
	end
	
	if (strEquals(args[1], "enablepc")) or (strEquals(args[1], "epc")) then
		ply:EnableCollision(1)
		SendChatMessage(ply, Color(20,200,20), "[ZED]: Player Collisions enabled!")
		return true
	end
	
	if (strEquals(args[1], "enablevc")) or (strEquals(args[1], "evc")) then
		ply:EnableCollision(16)
		SendChatMessage(ply, Color(20,200,20), "[ZED]: Vehicle Collisions enabled!")
		return true
	end
	
	if (strEquals(args[1], "getaimtarget")) or (strEquals(args[1], "gat")) then
		local word = tostring(ply:GetAimTarget())
		local results = ply:GetAimTarget()
		if results.position then
			SendChatMessage(ply, Color(200,20,20), "[ZED]: aim.position " .. tostring(results.position))
			pos = ply:GetPosition()
			x = pos.x
			y = pos.y
			z = pos.z
			return true
		elseif results.player then
			SendChatMessage(ply, Color(200,20,20), "[ZED]: aim.player " .. tostring(results.player))
			return true
		elseif results.vehicle then
			local v = results.vehicle
			vid = tostring(v:GetId())
			vtm = tostring(v:GetTemplate())
			SendChatMessage(ply, Color(200,20,20), "[ZED]: aim.vehicle " .. tostring(results.vehicle) .. " " .. tostring(vtm) .. " " .. tostring(vid))
			return true
		else
			return false
		end
	end
	
	if (strEquals(args[1], "getinventory")) or (strEquals(args[1], "gi")) then
		str = tostring(ply:GetInventory())
		voc = ply:GetInventory()
		gun1  = voc[1]
		gun2  = voc[2]
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Slot 1 " .. tostring(gun1.id) .. " | Ammo in Clip " .. tostring(gun1.ammo_clip).. " | Ammo in Reserve "  .. tostring(gun1.ammo_reserve))
		SendChatMessage(ply, Color(200,20,20), "[ZED]: Slot 2 " .. tostring(gun2.id) .. " | Ammo in Clip " .. tostring(gun2.ammo_clip).. " | Ammo in Reserve "  .. tostring(gun1.ammo_reserve)) 
		return true
	end
	
	if (strEquals(args[1], "getstate")) or (strEquals(args[1], "gps")) then
		if(args[2])then
			if tonumber(args[2]) and tonumber(args[3]) and tonumber(args[4]) then
				target = Player.GetById(tonumber(args[2]))
				local state = target:GetState()
				SendChatMessage(ply, Color(20,200,20), "[ZED]: " .. target:GetName() .. " is in state " .. state .. "!")
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				local state = target:GetState()
				SendChatMessage(ply, Color(20,200,20), "[ZED]: " .. target:GetName() .. " is in state " .. state .. "!")
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /getstate <name/id>")
			return false
		end
	end
	
	if strEquals(args[1], "model") then
		if(args[2])then
			if pcall(ply.SetModelId, ply, tonumber(args[2])) then
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Invalid ID.")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /model <id>")
			return false
		end
	end
	
	if strEquals(args[1], "slay") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				target:SetHealth(0)
				SendChatMessage(target, Color(200,20,20),"[ZED]: You have been slayed by " .. ply:GetName())
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You have succesfully slayed " .. target:GetName())
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:SetHealth(0)
				SendChatMessage(target, Color(200,20,20),"[ZED]: You have been slayed by " .. ply:GetName())
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You have succesfully slayed " .. target:GetName())
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /slay <name>")
			return false
		end
	end
	
	if strEquals(args[1], "jump") then
		if(args[2])then
			ply:SetPosition(ply:GetPosition() + Vector3(0,tonumber(args[2]),0))
			return true
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /jump <distance>")
			return false
		end
	end
	
	if strEquals(args[1], "getpos") then
		SendChatMessage(ply, Color(200,200,0),"[ZED]: Your Position: " .. tostring(ply:GetPosition()))
		return true
	end
	
	if strEquals(args[1], "goto") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				ply:SetPosition(target:GetPosition())
				SendChatMessage(target,Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported to you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported to " .. target:GetName())
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				ply:SetPosition(target:GetPosition())
				SendChatMessage(target,Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported to you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported to " .. target:GetName())
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /goto <name/id>")
		end
	end
	
	if strEquals(args[1], "tppos") then
		if (not args[2]) or (not args[4]) or (not args[3]) then
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /tppos <x> <y> <z>")
			return true
		end
		pos = Vector3(tonumber(args[2]), tonumber(args[3]), tonumber(args[4]))
		if(pos)then
			ply:SetPosition(pos)
			SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported to " .. args[2] .. ", " .. args[3] .. ", " .. args[4])
			return true
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /tppos <x> <y> <z>")
			return false
		end
	end

	if strEquals(args[1], "bring") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				target:SetPosition(ply:GetPosition())
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported you to him.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported " .. target:GetName() .. " to you.")
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:SetPosition(ply:GetPosition())
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported you to him.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported " .. target:GetName() .. " to you.")
				return true
			elseif args[2] == "*" then
				for target in Server:GetPlayers() do
					target:SetPosition(ply:GetPosition())
				end
				Broadcast(Color(20,200,20), "[ZED]: " .. ply:GetName(), " teleported everyone to him.")
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(pl, Color(200,20,20),"[ZED]: Syntax: /bring <name>")
			return false
		end
	end
	
	if strEquals(args[1], "disact") then
		if(args[2])then
			if GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Network:Send(target, "ZEDDisableAction", {action=tonumber(args[3])})
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: Please specify an action")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /disact <name> <id>")
			return false
		end
	end
	
	if strEquals(args[1], "enact") then
		if(args[2])then
			if GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Network:Send(target, "ZEDEnableAction", {action=tonumber(args[3])})
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: Please specify an action")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /enact <name> <id>")
			return false
		end
	end

	if strEquals(args[1], "mute") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This player is already muted.")
						return true
					end
				end
				MutedPlayers[tostring(target:GetSteamId())]=true
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " muted you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You muted ", target:GetName())
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This player is already muted.")
						return true
					end
				end
				MutedPlayers[tostring(target:GetSteamId())]=true
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " muted you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You muted ", target:GetName())
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /mute <name>")
			return false
		end
	end
	
	if strEquals(args[1], "unmute") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						MutedPlayers[k] = nil
						SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " unmuted you.")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: You unmuted ", target:GetName())
						return true
					end
				end
				SendChatMessage(ply, Color(200,20,20),"[ZED]: This player is not muted.")
				return false
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						MutedPlayers[k] = nil
						SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " unmuted you.")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: You unmuted ", target:GetName())
						return true
					end
				end
				SendChatMessage(ply, Color(200,20,20),"[ZED]: This player is not muted.")
				return false
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /unmute <name>")
			return false
		end
	end
	
	if strEquals(args[1], "freeze") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDDisableAction", {action=v})
				end
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " froze you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You froze ", target:GetName())
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDDisableAction", {action=v})
				end
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " froze you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You froze ", target:GetName())
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /freeze <name>")
			return false
		end
	end

	if strEquals(args[1], "unfreeze") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDEnableAction", {action=v})
				end
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " unfrozed you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You unfroze ", target:GetName())
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDEnableAction", {action=v})
				end
				SendChatMessage(target, Color(20,200,20),"[ZED]: " .. ply:GetName() .. " unfroze you.")
				SendChatMessage(ply, Color(20,200,20),"[ZED]: You unfroze ", target:GetName())
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /unfreeze <name>")
			return false
		end
	end
	
	if (strEquals(args[1], "notify")) or (strEquals(args[1], "ntf")) then
		for target in Server:GetPlayers() do
			local text = ""
			for k,v in pairs(args) do
				if(tonumber(k))then
					if k > 1 then
						text = text .. " " .. tostring(v)
					end
				end
			end
			Events:Fire("ZEDNotify", {player=target, time=4, color=Color(200,0,0), text=text, size=50})
			return true
		end
	end
	
	if (strEquals(args[1], "notifyply")) or (strEquals(args[1], "ntfply")) then
		if(args[2] and args[3])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				local text = ""
				for k,v in pairs(args) do
					if(tonumber(k))then
						if k > 2 then
							text = text .. " " .. tostring(v)
						end
					end
				end
				Events:Fire("ZEDNotify", {player=target, time=4, color=Color(200,0,0), text=text, size=50})
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				local text = ""
				for k,v in pairs(args) do
					if(tonumber(k))then
						if k > 2 then
							text = text .. " " .. tostring(v)
						end
					end
				end
				Events:Fire("ZEDNotify", {player=target, time=4, color=Color(200,0,0), text=text, size=50})
				return
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /notifyply <name> <message>")
			return false
		end
	end
	
	if strEquals(args[1], "w") or strEquals(args[1], "whisper") or strEquals(args[1], "pm") then
		if(args[2] and args[3])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				local text = ""
				for k,v in pairs(args) do
					if(tonumber(k))then
						if k > 2 then
							text = text .. " " .. tostring(v)
						end
					end
				end
				SendChatMessage(target, ply:GetColor(), "[ZED]: " .. ply:GetName(), " to you: ", Color(200,200,200), text)
				SendChatMessage(ply, target:GetColor(), "[ZED]: You to ", target:GetName(), ": ", Color(200,200,200), text)
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				local text = ""
				for k,v in pairs(args) do
					if(tonumber(k))then
						if k > 2 then
							text = text .. " " .. tostring(v)
						end
					end
				end
				SendChatMessage(target, ply:GetColor(), "[ZED]: " .. ply:GetName(), " to you: ", Color(200,200,200), text)
				SendChatMessage(ply, target:GetColor(), "[ZED]: You to ", target:GetName(), ": ", Color(200,200,200), text)
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /w <name/id> <message>")
			return false
		end
	end
	
	if strEquals(args[1], "disarm") then
		if(args[2])then
			if(tonumber(args[2]))then
				target = Player.GetById(tonumber(args[2]))
				target:ClearInventory()
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " disarmed you.")
				return true
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:ClearInventory()
				SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName() .. " disarmed you.")
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /disarm <name/id>")
			return false
		end
	end
	
	if strEquals(args[1], "kick") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				Broadcast(Color(200,20,20), "[ZED]: " .. ply:GetName() .. " kicked ".. target:GetName() .. ".")
				target:Kick("No reason specified.")
				return true
			elseif GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Broadcast(Color(200,20,20), "[ZED]: " .. ply:GetName() .. " kicked ".. target:GetName() .. ". Reason: " .. args[3])
					target:Kick(args[3])
					return true
				else
					target = GetPlayer(args[2])
					Broadcast(Color(200,20,20), "[ZED]: " .. ply:GetName() .. " kicked ".. target:GetName() .. ".")
					target:Kick("No reason specified.")
					return true
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /kick <name> <reason>")
			return false
		end
	end
	
	if strEquals(args[1], "ban") then
		if(args[2])then
			if(tonumber(args[2]))then
				target = Player.GetById(tonumber(args[2]))
				Broadcast(Color(20,200,20),"[ZED]: " .. ply:GetName() .. " banned ".. target:GetName() .. "." )
				target:Ban("No reason specified.")
				return true
			elseif GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Broadcast(Color(20,200,20), "[ZED]: " .. ply:GetName() .. " banned ".. target:GetName() .. ". Reason: " .. args[3])
					target:Ban(args[3])
					return true
				else
					target = GetPlayer(args[2])
					Broadcast(Color(20,200,20),"[ZED]: " .. ply:GetName() .. " banned ".. target:GetName() .. "." )
					target:Ban("No reason specified.")
					return true
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /banned <name> <reason>")
			return false
		end
	end
	
	if strEquals(args[1], "wep") then
		if(args[2] and args[3])then
			if pcall(ply.GiveWeapon, ply, tonumber(args[2]), Weapon(tonumber(args[3]), 999, 999)) then
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Invalid ID.")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /wep <slot> <id>")
			return false
		end
	end
	
	if strEquals(args[1], "fireevent") then
		local text = ""
		for k,v in pairs(args) do
			if(tonumber(k))then
				if k > 1 then
					text = text .. " " .. tostring(v)
				end
			end
		end
		event = tostring(v)
		Network:Send("GameEvent", event)
		return true
	end
	
	--//              \\--
	--  Vehicle Related --
	--\\              //--
	
	if (strEquals(args[1], "forcepassenger")) or (strEquals(args[1], "fp")) then
		if(args[2])then
			if(tonumber(args[2])) then
				if ply:GetVehicle()  then
					target = Player.GetById(tonumber(args[2]))
					veh = ply:GetVehicle()
					voc = veh:GetOccupants()
					print(voc)
					passenger = tonumber(voc[1])
					passenger1 = tonumber(voc[2])
					passenger2 = tonumber(voc[3])
					passenger3 = tonumber(voc[4])
					passenger4 = tonumber(voc[5])
					mountedgun1 = tonumber(voc[6])
					mountedgun2 = tonumber(voc[7])
					if not passenger then
						target:EnterVehicle(veh, VehicleSeat.Passenger)
						SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now riding shotgun!")
						return true
					else
						if not passenger1 then
							target:EnterVehicle(veh, VehicleSeat.Passenger1)
							SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
							SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now riding in passenger seat 2!")
							return true
						else
							if not passenger2 then
								target:EnterVehicle(veh, VehicleSeat.Passenger2)
								SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
								SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 3!")
								return true
							else
								if not passenger3 then
									target:EnterVehicle(veh, VehicleSeat.Passenger3)
									SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
									SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 4!")
									return true
								else
									if not passenger4 then
										target:EnterVehicle(veh, VehicleSeat.Passenger4)
										SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
										SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 5!")
										return true
									else
										if not mountedgun1 then
											target:EnterVehicle(veh, VehicleSeat.MountedGun1)
											SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
											SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in mounted gun 1!")
											return true
										else
											if not mountedgun2 then
												target:EnterVehicle(veh, VehicleSeat.MountedGun2)
												SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
												SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in mounted gun 2!")
												return true 
											else
												SendChatMessage(ply, Color(200,20,20),"[ZED]: There are no more open seats in your vehicle!")
												return false
											end
										end
									end
								end
							end
						end
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			elseif GetPlayer(args[2]) then
				if ply:GetVehicle()  then
					target = GetPlayer(args[2])
					veh = ply:GetVehicle()
					voc = veh:GetOccupants()
					print(voc)
					passenger = tonumber(voc[1])
					passenger1 = tonumber(voc[2])
					passenger2 = tonumber(voc[3])
					passenger3 = tonumber(voc[4])
					passenger4 = tonumber(voc[5])
					mountedgun1 = tonumber(voc[6])
					mountedgun2 = tonumber(voc[7])
					if not passenger then
						target:EnterVehicle(veh, VehicleSeat.Passenger)
						SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
						SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now riding shotgun!")
						return true
					else
						if not passenger1 then
							target:EnterVehicle(veh, VehicleSeat.Passenger1)
							SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
							SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now riding in passenger seat 2!")
							return true
						else
							if not passenger2 then
								target:EnterVehicle(veh, VehicleSeat.Passenger2)
								SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
								SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 3!")
								return true
							else
								if not passenger3 then
									target:EnterVehicle(veh, VehicleSeat.Passenger3)
									SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
									SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 4!")
									return true
								else
									if not passenger4 then
										target:EnterVehicle(veh, VehicleSeat.Passenger4)
										SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
										SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in passenger seat 5!")
										return true
									else
										if not mountedgun1 then
											target:EnterVehicle(veh, VehicleSeat.MountedGun1)
											SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
											SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in mounted gun 1!")
											return true
										else
											if not mountedgun2 then
												target:EnterVehicle(veh, VehicleSeat.MountedGun2)
												SendChatMessage(target, Color(200,20,20),"[ZED]: " .. ply:GetName()  .. " has forced you into their vehicle!")
												SendChatMessage(ply, Color(20,200,20),"[ZED]: " .. target:GetName() .. " is now in mounted gun 2!")
												return true 
											else
												SendChatMessage(ply, Color(200,20,20),"[ZED]: There are no more open seats in your vehicle!")
												return false
											end
										end
									end
								end
							end
						end
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /forcepassenger <name/id>")
			return false
		end
	end
	
	if strEquals(args[1], "mass") then
		if(args[2])then
			if(tonumber(args[2])) then
				if ply:GetVehicle() then
					if ply:GetState() == PlayerState.InVehicle then
						car = ply:GetVehicle()
						car:SetMass(tonumber(args[2]))
						SendChatMessage(ply, Color(20,200,20),"[ZED]: Your vehicle's mass is now " .. args[2] .. "!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not a valid amount: " .. args[2] .. "!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /mass <amount>")
			return false
		end
	end
	
	if (strEquals(args[1], "repair")) or (strEquals(args[1], "vr")) then
		if ply:GetMoney() >= 300 then
			if ply:GetVehicle() then
				if ply:GetState() == PlayerState.InVehicle then
					veh = ply:GetVehicle()
					curPos = ply:GetPosition()
					curAngle = ply:GetAngle()
					curVel = veh:GetLinearVelocity()
					veh:Respawn()
					simpletimers.Simple(0.2, function()
					if not IsValid(veh) then return end 
					veh:SetPosition(curPos)
					veh:SetAngle(curAngle)
					veh:SetLinearVelocity(curVel)
					ply:EnterVehicle(veh, VehicleSeat.Driver)
					end)
					ply:SetMoney(ply:GetMoney() - 300)
					SendChatMessage(ply, Color(20,200,20),"[ZED]: Your vehicle has been repaired for $300!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
				return false
			end
		else 
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You don't have enough money!")
			return false
		end
	end
	
	if (strEquals(args[1], "fix")) or (strEquals(args[1], "vf")) then
		if ply:GetMoney() >= 300 then
			if ply:GetVehicle() then
				if ply:GetState() == PlayerState.InVehicle then
					veh = ply:GetVehicle()
					if veh:GetHealth() < 1 then
						veh:SetHealth(1)
						ply:SetMoney(ply:GetMoney() - 300)
						SendChatMessage(ply, Color(20,200,20),"[ZED]: Your vehicle has been repaired for $300!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: Your vehicle is already at full health!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
				return false
			end
		else 
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You don't have enough money!")
			return false
		end
	end
	
	if strEquals(args[1], "vsh") then
		if(args[2])then
			if(tonumber(args[2])) then
				if ply:GetVehicle() then
					if ply:GetState() == PlayerState.InVehicle then
						veh = ply:GetVehicle()
						health = tonumber(args[2])
						if health < 1 then
							if health > 0 then
								veh:SetHealth(health)
								per = health * 100
								SendChatMessage(ply, Color(20,200,20),"[ZED]: Vehicle's health set to " .. per .. "%.")
								return true
							else
								SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[2] .. " is too low!")
								return false
							end
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[2] .. " is too high!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: " .. args[2] .. " is not a valid number!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /vsh <0.000-1>")
			return false
		end
	end
	
	if (strEquals(args[1], "killcar")) or (strEquals(args[1], "kc")) then
		if ply:GetMoney() >= 100 then
			if ply:GetVehicle() then
				if ply:GetState() == PlayerState.InVehicle then
					car = ply:GetVehicle()
					car:SetHealth(0)
					ply:SetMoney(ply:GetMoney() - 200)
					SendChatMessage(ply, Color(20,200,20),"[ZED]: Your vehicle has been destroyed! Why did you want that?!")
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You don't have enough money!")
			return false
		end
	end
	
	if (strEquals(args[1], "vehcolor")) or (strEquals(args[1], "vc")) then
		if ply:GetMoney()  >= 300 then
			if ply:GetWorld() == DefaultWorld then
				if ply:GetState() == PlayerState.InVehicle then
					if tonumber(args[2]) and tonumber(args[3]) and tonumber(args[4]) then
						red = tonumber(args[2])
						green = tonumber(args[3])
						blue = tonumber(args[4])
						curPos = ply:GetPosition()
						curAngle = ply:GetAngle()
						veh = ply:GetVehicle()
						veh:SetColors(Color(red, green, blue), Color(red, green, blue))
						veh:Respawn()
						simpletimers.Simple(0.2, function()
						if not IsValid(veh) then return end
						veh:SetPosition(curPos)
						veh:SetAngle(curAngle)
						ply:EnterVehicle(veh, VehicleSeat.Driver)
						end)
						ply:SetMoney(ply:GetMoney()  - 300)
						SendChatMessage(ply, Color(20,200,20),"[ZED]: You have changed your vehicle's color for $300!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /vehcolor <Red: 0-255> <Green: 0-255> <Blue: 0-255>")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not in the default world!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You don't have enough money!")
			return false
		end
	end
	
	if (strEquals(args[1], "vehcolor2")) or (strEquals(args[1], "vc2")) then
		if ply:GetMoney()  >= 300 then
			if ply:GetWorld() == DefaultWorld then
				if ply:GetState() == PlayerState.InVehicle then
					if tonumber(args[2]) and tonumber(args[3]) and tonumber(args[4]) and tonumber(args[5]) and tonumber(args[6]) and tonumber(args[7]) then
						red = tonumber(args[2])
						green = tonumber(args[3])
						blue = tonumber(args[4])
						red2 = tonumber(args[5])
						green2 = tonumber(args[6])
						blue2 = tonumber(args[7])
						curPos = ply:GetPosition()
						curAngle = ply:GetAngle()
						veh = ply:GetVehicle()
						veh:SetColors(Color(red, green, blue), Color(red2, green2, blue2))
						veh:Respawn()
						simpletimers.Simple(0.2, function()
						if not IsValid(veh) then return end
						veh:SetPosition(curPos)
						veh:SetAngle(curAngle)
						ply:EnterVehicle(veh, VehicleSeat.Driver)
						end)
						ply:SetMoney(ply:GetMoney()  - 300)
						SendChatMessage(ply, Color(20,200,20),"[ZED]: You have changed your vehicle's color for $300!")
						return true
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /vehcolor <Red: 0-255> <Green: 0-255> <Blue: 0-255> <Red 2: 0-255> <Green 2: 0-255> <Blue 2: 0-255>")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not in the default world!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You don't have enough money!")
			return false
		end
	end
	
	if strEquals(args[1], "vjump") then
		if(args[2])then
			if(tonumber(args[2])) then
				if ply:GetVehicle() then
					if ply:GetWorld() == DefaultWorld then
						if ply:GetState() == PlayerState.InVehicle then
							y = tonumber(args[2])
							curPos = ply:GetPosition()
							newPos = curPos + Vector3(0, y, 0)
							ply:GetVehicle():SetPosition(newPos)
							SendChatMessage(ply, Color(20,200,20),"[ZED]: WHOOSH!")
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not in the default world!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /vjump <value>")
			return false
		end
	end
	
	if strEquals(args[1], "vgoto") then
		if(args[2])then
			if(tonumber(args[2])) then
				if ply:GetVehicle() then
					if ply:GetWorld() == DefaultWorld then
						if ply:GetState() == PlayerState.InVehicle then
							target = Player.GetById(tonumber(args[2]))
							tarPos = target:GetPosition()
							newPos = tarPos + Vector3(0, 25, 0)
							car = ply:GetVehicle()
							ply:SetPosition(newPos)
							car:SetPosition(newPos)
							ply:EnterVehicle(car, VehicleSeat.Driver)
							SendChatMessage(target,Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported with their vehicle to you.")
							SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported with your vehicle to " .. target:GetName())
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not in the default world!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			elseif GetPlayer(args[2]) then
				if ply:GetVehicle() then
					if ply:GetWorld() == DefaultWorld then
						if ply:GetState() == PlayerState.InVehicle then
							target = Player.GetById(tonumber(args[2]))
							tarPos = target:GetPosition()
							newPos = tarPos + Vector3(0, 25, 0)
							car = ply:GetVehicle()
							ply:SetPosition(newPos)
							car:SetPosition(newPos)
							ply:EnterVehicle(car, VehicleSeat.Driver)
							SendChatMessage(target,Color(20,200,20),"[ZED]: " .. ply:GetName() .. " teleported with their vehicle to you.")
							SendChatMessage(ply, Color(20,200,20),"[ZED]: You teleported with your vehicle to " .. target:GetName())
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not the driver!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: You are not in the default world!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /vgoto <name/id>")
			return false
		end
	end
	
	if strEquals(args[1], "woet") then
		if ply:GetVehicle() then
			if ply:GetWorld() == DefaultWorld then
				if ply:GetState() == PlayerState.InVehicle then
					count = 0
					while count <= 5 do
						veh = ply:GetVehicle()
						dir = veh:GetAngle() * Vector3(0, 0, -1)
						veh:SetAngularVelocity( dir * 30 )
						count = count + 1
					end
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in the main world!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
			return false
		end
	end
	
	if strEquals(args[1], "woet2") then
		if ply:GetVehicle() then
			if ply:GetWorld() == DefaultWorld then
				if ply:GetState() == PlayerState.InVehicle then
					local count = 0
					local veh = ply:GetVehicle()
					local dir = veh:GetAngle() * Vector3(0, 0, -1)
					local forward = veh:GetAngle() * Vector3(0, 0, -1)
					local vel = veh:GetLinearVelocity()
					local new_vel = vel + (forward * 10)
					local ran = math.random(-66, 66)
					while count <= 10 do
						veh:SetAngularVelocity( dir * ran )
						veh:SetLinearVelocity( new_vel )
						count = count + 1
					end
					return true
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not the driver!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in the main world!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You're not in a vehicle!")
			return false
		end
	end
	
	if (strEquals(args[1], "getvehicleid")) or (strEquals(args[1], "gvi")) then
		if ply:GetVehicle() then
			local id = ply:GetVehicle():GetModelId()
			SendChatMessage(ply, Color(20,200,20), "[ZED]: Your vehicle's id is " .. id .. "!")
			return true
		else
			SendChatMessage(ply, Color(200,20,20), "[ZED]: You are not in a vehicle!")
			return false
		end
	end
	
	if (strEquals(args[1], "getvehicledecal")) or (strEquals(args[1], "gvd")) then
		if ply:GetVehicle() then
			v = ply:GetVehicle()
			vid = v:GetDecal()
			SendChatMessage(ply, Color(20,200,20), "[ZED]: Vehicle's Decal is " .. vid)
			return true
		else
			SendChatMessage(ply, Color(200,20,20), "[ZED]: You are not in a vehicle!")
			return false
		end
	end
	
	if (strEquals(args[1], "getvehicletemplate")) or (strEquals(args[1], "gvt")) then
		if ply:GetVehicle() then
			local vname = tostring( ply:GetVehicle() )
			v = ply:GetVehicle()
			vid = v:GetId()
			vte = v:GetTemplate()
			SendChatMessage(ply, Color(20,200,20), "[ZED]: Your vehicle's template is: ".. vte)
			return true
		else
			SendChatMessage(ply, Color(200,20,20), "[ZED]: You are not in a vehicle!")
			return false
		end
	end
	
	if (strEquals(args[1], "getoccupants")) or (strEquals(args[1], "gpvo")) then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				if target:GetVehicle() then
					v = target:GetVehicle()
					driver = v:GetDriver()
					voc = v:GetOccupants()
					voc1 = tostring(voc[2])
					voc2 = tostring(voc[3])
					voc3 = tostring(voc[4])
					voc4 = tostring(voc[5])
					voc5 = tostring(voc[6])
					voc6 = tostring(voc[7])
					vdr = v:GetDriver()
					SendChatMessage(ply, Color(20,200,20),"[ZED]: Driver " .. tostring(vdr) .. " Occupants " .. " 1 " .. tostring(voc1) .. " 2 " .. tostring(voc2) ..	" 3 ".. tostring(voc3) .. " 4 ".. tostring(voc4) .. " 5 ".. tostring(voc5) .. " 6 ".. tostring(voc6))
					return true
				else
					SendChatMessage(ply, Color(200,20,20), "[ZED]: The target is not in a vehicle!")
					return false
				end
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				if target:GetVehicle() then
					v = target:GetVehicle()
					driver = v:GetDriver()
					voc = v:GetOccupants()
					voc1 = tostring(voc[2])
					voc2 = tostring(voc[3])
					voc3 = tostring(voc[4])
					voc4 = tostring(voc[5])
					voc5 = tostring(voc[6])
					voc6 = tostring(voc[7])
					vdr = v:GetDriver()
					SendChatMessage(ply, Color(20,200,20),"[ZED]: Driver " .. tostring(vdr) .. " Occupants " .. " 1 " .. tostring(voc1) .. " 2 " .. tostring(voc2) ..	" 3 ".. tostring(voc3) .. " 4 ".. tostring(voc4) .. " 5 ".. tostring(voc5) .. " 6 ".. tostring(voc6))
					return true
				else
					SendChatMessage(ply, Color(200,20,20), "[ZED]: The target is not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Can't find " .. args[2])
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /getoccupants <name/id>")
			return false
		end
	end
	
	if (strEquals(args[1], "settemplate")) or (strEquals(args[1], "svt")) then
		if(args[2])then
			if tostring(args[2]) then
				if ply:GetVehicle() then
					local v = ply:GetVehicle()	
					local vtm = tostring(args[2])	
					local vc1 , vc2 = v:GetColors()				
					local spawnArgs = {}
					spawnArgs.position = ply:GetPosition()
					spawnArgs.angle = ply:GetAngle()
					spawnArgs.model_id = v:GetModelId()
					spawnArgs.world = ply:GetWorld()
					spawnArgs.decal = v:GetDecal()
					spawnArgs.linear_velocity = v:GetLinearVelocity()
					spawnArgs.tone1 = vc1
					spawnArgs.tone2 = vc2
					spawnArgs.template = vtm
					v:Remove()
					local veh = Vehicle.Create( spawnArgs )
					ply:EnterVehicle( veh, VehicleSeat.Driver )
					SendChatMessage(ply, Color(200,20,20), "[ZED]: New Template is: " .. args[2])
					return true
				else
					SendChatMessage(ply, Color(200,20,20), "[ZED]: You are not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not valid: " .. args[2] .. "!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /settemplate <template>")
			return false
		end
	end
	
	if (strEquals(args[1], "setdecal")) or (strEquals(args[1], "svd")) then
		if(args[2])then
			if tonumber(args[2]) then
				if ply:GetVehicle() then
					local v = ply:GetVehicle()	
					local vde = tostring(args[2])
					local vc1 , vc2 = v:GetColors()
					local spawnArgs = {}
					spawnArgs.position = ply:GetPosition()
					spawnArgs.angle = ply:GetAngle()
					spawnArgs.model_id = v:GetModelId()
					spawnArgs.world = ply:GetWorld()
					spawnArgs.linear_velocity = v:GetLinearVelocity()
					spawnArgs.template = v:GetTemplate()
					spawnArgs.tone1 = vc1
					spawnArgs.tone2 = vc2
					spawnArgs.decal = vde
					v:Remove()
					local veh = Vehicle.Create( spawnArgs )
					ply:EnterVehicle( veh, VehicleSeat.Driver )
					SendChatMessage(ply, Color(200,20,20), "[ZED]: New Decal is: " .. args[2])
					return true
				else
					SendChatMessage(ply, Color(200,20,20), "[ZED]: You are not in a vehicle!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not valid: " .. args[2] .. "!")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /setdecal <decal>")
			return false
		end
	end
	
	if (strEquals(args[1], "spawn")) then
		if (tonumber(args[2])) and (tostring(args[3])) and (tostring(args[4])) then
			if ply:GetVehicle() then
				local v = ply:GetVehicle()
				local spawnArgs = {}
				spawnArgs.position = ply:GetPosition()
				spawnArgs.angle = ply:GetAngle()
				spawnArgs.model_id = tonumber(args[2])
				spawnArgs.world = ply:GetWorld()
				spawnArgs.tone1 = Color(0, 0, 0)
				spawnArgs.tone2 = Color(255, 255, 255)
				spawnArgs.template = tostring(args[3])
				spawnArgs.decal = tostring(args[4])
				v:Remove()
				local veh = Vehicle.Create(spawnArgs)
				ply:EnterVehicle( veh, VehicleSeat.Driver )
				SendChatMessage(ply, Color(200,20,20), "[ZED]: You have spawned a " .. veh:GetName())
				return true
			else
				local spawnArgs = {}
				spawnArgs.position = ply:GetPosition()
				spawnArgs.angle = ply:GetAngle()
				spawnArgs.model_id = tonumber(args[2])
				spawnArgs.world = ply:GetWorld()
				spawnArgs.tone1 = Color(0, 0, 0)
				spawnArgs.tone2 = Color(255, 255, 255)
				spawnArgs.template = tostring(args[3])
				spawnArgs.decal = tostring(args[4])
				local veh = Vehicle.Create(spawnArgs)
				ply:EnterVehicle( veh, VehicleSeat.Driver )
				SendChatMessage(ply, Color(200,20,20), "[ZED]: You have spawned a " .. veh:GetName())
				return true
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"[ZED]: Syntax: /spawn <ModelID> <Template> <Decal>")
			return false
		end
	end
	
	if strEquals(args[1], "veh") then
		if(args[2])then
			status, veh = pcall(Vehicle.Create, tonumber(args[2]), ply:GetPosition(), ply:GetAngle())
			if status then
				ply:EnterVehicle(veh, 0)
				return true
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Invalid ID.")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /veh <id>")
			return false
		end
	end
	
	if strEquals(args[1], "delveh") then
		if(ply:InVehicle())then
			ply:GetVehicle():Remove()
			return true
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You must be sitting in a vehicle.")
			return false
		end
	end
	
	if strEquals(args[1], "delallveh") then
		for vehicle in Server:GetVehicles() do
			vehicle:Remove()
		end
		Broadcast(Color(200,20,20), "[ZED]: " .. ply:GetName(), " removed all vehicles.")
		return true
	end
	
	--//            \\--
	--  World Related --
	--\\            //--
	
	if strEquals(args[1], "weather") then
		if ply:GetWorld() == DefaultWorld then
			if(args[2])then
				if(tonumber(args[2])) then
					local wth = tonumber(args[2])
					if wth >= 0 then
						if wth <= 2 then
							DefaultWorld:SetWeatherSeverity(wth)
							Broadcast(Color(200, 20, 20),"[ZED]: " .. ply:GetName() , " set the weather severity to " .. wth .. "!")
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too high!: " .. args[2] .. "!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too low!: " .. args[2] .. "!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not a valid weather severity!: " .. args[2] .. "!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /weather <0-2>")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You must be in the default world!")
			return false
		end
	end
	
	if strEquals(args[1], "time") then
		if ply:GetWorld() == DefaultWorld then
			if(args[2])then
				if(tonumber(args[2])) then
					local t = tonumber(args[2])
					if t >= 0 then
						if t <= 24 then
							DefaultWorld:SetTime(tonumber(args[2]))
							Broadcast(Color(200, 20, 20), "[ZED]: " .. ply:GetName() , " set the time to " .. t .. "!")
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too high!: " .. t .. "!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too low!: " .. t .. "!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not a time!: " .. args[2] .. "!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /time <0-24>")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You must be in the default world!")
			return false
		end
	end
	
	if strEquals(args[1], "timestep") then
		if ply:GetWorld() == DefaultWorld then
			if(args[2])then
				if(tonumber(args[2])) then
					local ts = tonumber(args[2])
					if ts >= 0 then
						if ts <= 1000 then
							DefaultWorld:SetTimeStep(tonumber(args[2]))
							Broadcast(Color(200, 20, 20), "[ZED]: " .. ply:GetName() , " set the timestep to " .. ts .. "!")
							return true
						else
							SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too high!: " .. ts .. "!")
							return false
						end
					else
						SendChatMessage(ply, Color(200,20,20),"[ZED]: This is too low!: " .. ts .. "!")
						return false
					end
				else
					SendChatMessage(ply, Color(200,20,20),"[ZED]: This is not a valid value!: " .. args[2] .. "!")
					return false
				end
			else
				SendChatMessage(ply, Color(200,20,20),"[ZED]: Syntax: /timestep <any non-negative integer>")
				return false
			end
		else
			SendChatMessage(ply, Color(200,20,20),"[ZED]: You must be in the default world!")
			return false
		end
	end
	
	--//            \\--
	--      END       --
	--\\            //--
	
end)

Console:Subscribe("s", function(args)
	Broadcast(Color(200,0,0), "Console: ", Color(255,255,255), args.text)
end)


Events:Subscribe("ZEDScoreboardUpdate", function()
	local ban = {}
	local kick = {}
	local disarm = {}
	local unfreeze = {}
	local freeze = {}
	local mute = {}
	local unmute = {}
	local goto2 = {}
	local bring = {}
	local slay = {}
	local sky = {}
	local addmoney = {}
	local getmoney = {}
	local forcepassenger = {}
	local id = {}
	local takeveh = {}
	local vgoto = {}
	local getplypos = {}
	local delplyveh = {}
	local heal = {}
	local getoccupants = {}
	for player in Server:GetPlayers() do
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="ban"}) then
			ban[player:GetId()] = "ban"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="kick"}) then
			kick[player:GetId()] = "kick"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="disarm"}) then
			disarm[player:GetId()] = "disarm"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="unfreeze"}) then
			unfreeze[player:GetId()] = "unfreeze"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="freeze"}) then
			freeze[player:GetId()] = "freeze"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="mute"}) then
			mute[player:GetId()] = "mute"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="unmute"}) then
			unmute[player:GetId()] = "unmute"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="goto"}) then
			goto2[player:GetId()] = "goto"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="bring"}) then
			bring[player:GetId()] = "bring"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="slay"}) then
			slay[player:GetId()] = "slay"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="sky"}) then
			sky[player:GetId()] = "sky"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="getmoney"}) then
			getmoney[player:GetId()] = "getmoney"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="forcepassenger"}) then
			forcepassenger[player:GetId()] = "forcepassenger"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="id"}) then
			id[player:GetId()] = "id"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="takeveh"}) then
			takeveh[player:GetId()] = "takeveh"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="vgoto"}) then
			vgoto[player:GetId()] = "vgoto"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="getplypos"}) then
			getplypos[player:GetId()] = "getplypos"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="delplyveh"}) then
			delplyveh[player:GetId()] = "delplyveh"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="heal"}) then
			heal[player:GetId()] = "heal"
		end
		if not Events:Fire("ZEDPlayerHasPermission", {player=player, permission="getoccupants"}) then
			getoccupants[player:GetId()] = "getoccupants"
		end
	end
	Events:Fire("ZEDUpdateScoreboard", {Extra={},Columns={},Buttons={
		Ban=ban,
		Kick=kick,
		Disarm=disarm,
		Unfreeze=unfreeze,
		Freeze=freeze,
		Mute=mute,
		Unmute=unmute,
		Goto=goto2,
		Bring=bring,
		Slay=slay,
		GetMoney=getmoney,
		Sky=sky,
		ForcePassenger=forcepassenger,
		StealVeh=takeveh,
		SteamID=id,
		VehGoto=vgoto,
		GetPos=getplypos,
		DelVeh=delplyveh,
		Heal=heal,
		GetOccupants=getoccupants
	}})
end)

Events:Subscribe("ZEDAllowPlayerChat", function(args)
	if(MutedPlayers[tostring(args.player:GetSteamId())])then
		return false
	end
end)
