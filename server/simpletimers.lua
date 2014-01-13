--[[
Simple timers API by Donkie
]]

simpletimers = {}

local timers = {}
function simpletimers.Simple(sec, func)
	timers[#timers + 1] = {timer = Timer(), delay = sec, func = func}
end

local function PostTick()
	for k,v in pairs(timers) do
		if v.timer:GetSeconds() >= v.delay then
			v.func()
			timers[k] = nil
		end
	end
end
Events:Subscribe("PostTick", PostTick)
