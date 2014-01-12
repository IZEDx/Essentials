function ModulesLoad()
	Events:FireRegisteredEvent( "HelpAddItem",
        {
            name = "ZED Essentials V2.0",
            text = 
				"Need to do this:"
        } )
end

function ModuleUnload()
    Events:FireRegisteredEvent( "HelpRemoveItem",
        {
            name = "ZED Essentials V2.0"
        } )
end

Events:Subscribe("ModulesLoad", ModulesLoad)
Events:Subscribe("ModuleUnload", ModuleUnload)