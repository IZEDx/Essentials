class 'GameEvents'

function GameEvents:__init()
	Network:Subscribe("GameEvent", self, self.GameEvent)
end

function  GameEvents:GameEvent(args)
	Game:FireEvent(args)
end