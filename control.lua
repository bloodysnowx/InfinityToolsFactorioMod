function Set (list)
	local set = {}
	for _, l in ipairs(list) do set[l] = true end
	return set
end

local tools = Set {
	"transport-belt",
	"underground-belt",
	"inserter",
	"electric-pole",
	"mining-drill",
	"pipe",
	"pipe-to-ground",
	"furnace",
	"assembling-machine",
	"splitter",
}

local refill_tools = function(inventory, tool)
	local tool_count = inventory.get_item_count(tool)
	if tool_count < 50 then
		inventory.insert{name=tool, count=1}
	end	
end

local on_built_entity_event = function(event)
	local player = game.players[event.player_index]
	local item = event.created_entity
	if tools[item.type] ~= nil then
		refill_tools(player.get_main_inventory(), item.name)
	end
end

script.on_event(defines.events.on_built_entity, don_built_entity_event)