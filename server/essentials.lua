
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
	
	if strEquals(args[1], "veh") then
		if(args[2])then
			status, veh = pcall(Vehicle.Create, tonumber(args[2]), ply:GetPosition(), ply:GetAngle())
			if status then
				ply:EnterVehicle(veh, 0)
			else
				SendChatMessage(ply, Color(200,0,0,255),"Invalid ID.")
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /veh <id>")
		end
	end
	
	if strEquals(args[1], "wep") then
		if(args[2] and args[3])then
			if pcall(ply.GiveWeapon, ply, tonumber(args[2]), Weapon(tonumber(args[3]), 999, 999)) then
			else
				SendChatMessage(ply, Color(200,0,0,255),"Invalid ID.", Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /wep <slot> <id>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "model") then
		if(args[2])then
			if pcall(ply.SetModelId, ply, tonumber(args[2])) then
			else
				SendChatMessage(ply, Color(200,0,0,255),"Invalid ID.", Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /model <id>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "slay") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				target:SetHealth(0)
				SendChatMessage(target, Color(0,200,0,255),"You have been slayed by " .. ply:GetName())
				SendChatMessage(ply, Color(0,200,0,255),"You have succesfully slayed " .. target:GetName())
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:SetHealth(0)
				SendChatMessage(target, Color(0,200,0,255),"You have been slayed by " .. ply:GetName())
				SendChatMessage(ply, Color(0,200,0,255),"You have succesfully slayed " .. target:GetName())
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2])
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /slay <name>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "jump") then
		if(args[2])then
			ply:SetPosition(ply:GetPosition() + Vector3(0,tonumber(args[2]),0))
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /jump <distance>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "delveh") then
		if(ply:InVehicle())then
			ply:GetVehicle():Remove()
		else
			SendChatMessage(ply, Color(200,0,0,255),"You must be sitting in a vehicle.")
		end
	end
	
	if strEquals(args[1], "delallveh") then
		for vehicle in Server:GetVehicles() do
			vehicle:Remove()
		end
		Broadcast(Color(200,0,0), ply:GetName(), " removed all vehicles.")
	end
	
	if strEquals(args[1], "getpos") then
		SendChatMessage(ply, Color(200,200,0),"Your Position: " .. tostring(ply:GetPosition()), Color(200,200,0))
	end
	
	if strEquals(args[1], "goto") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				ply:SetPosition(target:GetPosition())
				SendChatMessage(target,Color(0,200,0),ply:GetName() .. " teleported to you.", Color(0,200,0,255))
				SendChatMessage(ply, Color(0,200,0),"You teleported to " .. target:GetName(), Color(0,200,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				ply:SetPosition(target:GetPosition())
				SendChatMessage(target,Color(0,200,0),ply:GetName() .. " teleported to you.", Color(0,200,0,255))
				SendChatMessage(ply, Color(0,200,0),"You teleported to " .. target:GetName(), Color(0,200,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /goto <name/id>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "tppos") then
		if (not args[2]) or (not args[4]) or (not args[3]) then
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /tppos <x> <y> <z>")
			return
		end
		pos = Vector3(tonumber(args[2]), tonumber(args[3]), tonumber(args[4]))
		if(pos)then
			ply:SetPosition(pos)
			SendChatMessage(ply, Color(0,200,0,255),"You teleported to " .. args[2] .. ", " .. args[3] .. ", " .. args[4], Color(0,200,0,255))
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /tppos <x> <y> <z>", Color(200,0,0,255))
		end
	end

	if strEquals(args[1], "bring") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				target:SetPosition(ply:GetPosition())
				SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " teleported you to him.")
				SendChatMessage(ply, Color(0,200,0,255),"You teleported " .. target:GetName() .. " to you.", Color(0,200,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:SetPosition(ply:GetPosition())
				SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " teleported you to him.")
				SendChatMessage(ply, Color(0,200,0,255),"You teleported " .. target:GetName() .. " to you.", Color(0,200,0,255))
			elseif args[2] == "*" then
				for target in Server:GetPlayers() do
					target:SetPosition(ply:GetPosition())
				end
				Broadcast(Color(0,200,0,255), ply:GetName(), " teleported everyone to him.")
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(pl, Color(200,0,0,255),"Syntax: /bring <name>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "disact") then
		if(args[2])then
			if GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Network:Send(target, "ZEDDisableAction", {action=tonumber(args[3])})
				else
					SendChatMessage(ply, Color(200,0,0,255),"Please specify an action", Color(200,0,0,255))
				end
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /disact <name> <id>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "enact") then
		if(args[2])then
			if GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Network:Send(target, "ZEDEnableAction", {action=tonumber(args[3])})
				else
					SendChatMessage(ply, Color(200,0,0,255),"Please specify an action", Color(200,0,0,255))
				end
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /enact <name> <id>", Color(200,0,0,255))
		end
	end

	if strEquals(args[1], "mute") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						SendChatMessage(ply, Color(200,0,0,255),"This player is already muted.", Color(200,0,0,255))
						return
					end
				end
				MutedPlayers[tostring(target:GetSteamId())]=true
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " muted you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You muted ", target:GetName(), Color(200,0,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						SendChatMessage(ply, Color(200,0,0,255),"This player is already muted.", Color(200,0,0,255))
						return
					end
				end
				MutedPlayers[tostring(target:GetSteamId())]=true
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " muted you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You muted ", target:GetName(), Color(200,0,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /mute <name>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "unmute") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						MutedPlayers[k] = nil
						SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " unmuted you.", Color(200,0,0,255))
						SendChatMessage(ply, Color(0,200,0,255),"You unmuted ", target:GetName(), Color(200,0,0,255))
						return
					end
				end
				SendChatMessage(ply, Color(200,0,0,255),"This player is not muted.", Color(200,0,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(MutedPlayers) do
					if k == tostring(target:GetSteamId()) then
						MutedPlayers[k] = nil
						SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " unmuted you.", Color(200,0,0,255))
						SendChatMessage(ply, Color(0,200,0,255),"You unmuted ", target:GetName(), Color(200,0,0,255))
						return
					end
				end
				SendChatMessage(ply, Color(200,0,0,255),"This player is not muted.", Color(200,0,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /unmute <name>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "freeze") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDDisableAction", {action=v})
				end
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " froze you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You froze ", target:GetName(), Color(200,0,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDDisableAction", {action=v})
				end
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " froze you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You froze ", target:GetName(), Color(200,0,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /freeze <name>", Color(200,0,0,255))
		end
	end

	if strEquals(args[1], "unfreeze") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDEnableAction", {action=v})
				end
				SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " unfrozed you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You unfroze ", target:GetName(), Color(200,0,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				for k,v in pairs(FreezeActions) do
					Network:Send(target, "ZEDEnableAction", {action=v})
				end
				SendChatMessage(target, Color(0,200,0,255),ply:GetName() .. " unfroze you.", Color(200,0,0,255))
				SendChatMessage(ply, Color(0,200,0,255),"You unfroze ", target:GetName(), Color(200,0,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /unfreeze <name>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "notify") then
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
		end
	end
	
	if strEquals(args[1], "notifyply") then
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
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /notifyply <name> <message>")
		end
	end
	
	if strEquals(args[1], "disarm") then
		if(args[2])then
			if(tonumber(args[2]))then
				target = Player.GetById(tonumber(args[2]))
				target:ClearInventory()
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " disarmed you.", Color(200,0,0,255))
			elseif GetPlayer(args[2]) then
				target = GetPlayer(args[2])
				target:ClearInventory()
				SendChatMessage(target, Color(200,0,0,255),ply:GetName() .. " disarmed you.", Color(200,0,0,255))
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /disarm <name/id>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "kick") then
		if(args[2])then
			if tonumber(args[2]) then
				target = Player.GetById(tonumber(args[2]))
				Broadcast(Color(0,200,0,255), ply:GetName() .. " kicked ".. target:GetName() .. ".")
				target:Kick("No reason specified.")
			elseif GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Broadcast(Color(0,200,0,255), ply:GetName() .. " kicked ".. target:GetName() .. ". Reason: " .. args[3])
					target:Kick(args[3])
				else
					target = GetPlayer(args[2])
					Broadcast(Color(0,200,0,255), ply:GetName() .. " kicked ".. target:GetName() .. ".")
					target:Kick("No reason specified.")
				end
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /kick <name> <reason>", Color(200,0,0,255))
		end
	end
	
	if strEquals(args[1], "ban") then
		if(args[2])then
			if(tonumber(args[2]))then
				target = Player.GetById(tonumber(args[2]))
				Broadcast(Color(0,200,0,255),ply:GetName() .. " banned ".. target:GetName() .. "." , Color(0,200,0,255))
				target:Ban("No reason specified.")
			elseif GetPlayer(args[2]) then
				if(args[3])then
					target = GetPlayer(args[2])
					Broadcast(Color(0,200,0,255), ply:GetName() .. " banned ".. target:GetName() .. ". Reason: " .. args[3], Color(0,200,0,255))
					target:Ban(args[3])
				else
					target = GetPlayer(args[2])
					Broadcast(Color(0,200,0,255),ply:GetName() .. " banned ".. target:GetName() .. "." , Color(0,200,0,255))
					target:Ban("No reason specified.")
				end
			else
				SendChatMessage(ply, Color(200,0,0,255),"Can't find " .. args[2], Color(200,0,0,255))
			end
		else
			SendChatMessage(ply, Color(200,0,0,255),"Syntax: /banned <name> <reason>", Color(200,0,0,255))
		end
	end
	
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
		Slay=slay
	}})
end)

Events:Subscribe("ZEDAllowPlayerChat", function(args)
	if(MutedPlayers[tostring(args.player:GetSteamId())])then
		return false
	end
end)
