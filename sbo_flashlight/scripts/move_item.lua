--from itemextensions
itemextensions.on_move = {}

itemextensions.on_move.registered_on_move_item = {}
itemextensions.on_move.registered_on_move_any_item = {}
itemextensions.on_move.registered_on_any_item_changed = {}

-- Register a callback to be notified when a specific item is moved, put or taken from any player inventory.
--[[

	itemextensions.register_on_move_item(item_name, function(itemstack, player, info)
		-- return itemstack or nil
	end)
]]
function itemextensions.register_on_move_item(name, func)
	if not itemextensions.on_move.registered_on_move_item[name] then
		itemextensions.on_move.registered_on_move_item[name] = {}
	end
	table.insert(itemextensions.on_move.registered_on_move_item[name], func)
end

-- Register a callback to be notified when any item is moved, put or taken from any player inventory.
--[[

	itemextensions.register_on_move_any_item(function(itemstack, player, info)
		-- return itemstack or nil
	end)

	info = {
		-- take, move
		from_stack : ItemStack
		from_list : string | nil
		from_index : number | nil
		-- put, move
		to_stack : ItemStack | nil
		to_list : string | nil
		to_index : number | nil
		stack : ItemStack
	}
]]
function itemextensions.register_on_move_any_item(func)
	table.insert(itemextensions.on_move.registered_on_move_any_item, func)
end

-- Register a callback to be notified when any item is changed in any manner including metadata and wear, by polling the entire inventory.
-- Does not handle any return value or modify the inventory.
--[[

	itemextensions.register_on_any_item_changed(function(itemstack, player, listname, listindex, oldstack)
		core.log(tostring(itemstack))
		return nil
	end)
]]
function itemextensions.register_on_any_item_changed(func)
	table.insert(itemextensions.on_move.registered_on_any_item_changed, func)
end

-- make a standard inventory_info table instead of having to do this logic within other functions
local function fix_bad_inventory_info_fields(player, action, inventory, inventory_info)
	local info = {}
	-- deal with the silly way this callback gives its parameters
	if (action == "move") then
		info.to_list = inventory_info.to_list
		info.to_index = inventory_info.to_index
		info.from_list = inventory_info.from_list
		info.from_index = inventory_info.from_index
		info.from_stack = inventory:get_stack(inventory_info.from_list, inventory_info.from_index)
		info.to_stack = inventory:get_stack(inventory_info.to_list, inventory_info.to_index)
		info.stack = info.from_stack
	elseif (action == "put") then
		info.to_list = inventory_info.listname
		info.to_index = inventory_info.index
		info.from_stack = inventory_info.stack
		info.stack = inventory_info.stack
	elseif (action == "take") then
		info.from_list = inventory_info.listname
		info.from_index = inventory_info.index
		info.from_stack = inventory_info.stack
		info.stack = inventory_info.stack
	end
	return info
end

-- notify that an item has been moved
core.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	local info = fix_bad_inventory_info_fields(player, action, inventory, inventory_info)
	itemextensions.on_move._on_moved(player, info)
end)


function itemextensions.on_move._on_any_item_changed(itemstack, player, listname, listindex, oldstack)
	for i, func in pairs(itemextensions.on_move.registered_on_any_item_changed) do
		func(ItemStack(itemstack), player, listname, listindex, oldstack)
	end
end

function itemextensions.on_move._on_moved(player, info)
	if not info.to_stack then
		return
	end
	local stack = info.to_stack
	local name = stack:get_name()
	local idef = stack:get_definition()
	if not idef then return end

	if idef._on_inventory_moved then
		stack = idef._on_inventory_moved(ItemStack(stack), player, info) or stack
	end

	for i, func in pairs(itemextensions.on_move.registered_on_move_item[name] or {}) do
		stack = func(ItemStack(stack), player, info) or stack
	end

	for i, func in pairs(itemextensions.on_move.registered_on_move_any_item) do
		stack = func(ItemStack(stack), player, info) or stack
	end

	itemextensions.equipment._test_and_call_equipment(stack, player, info, idef)
end

-- when joining, pretend all the items got put in the inventory, in case they need to run init
core.register_on_joinplayer(function(player, last_login)
	core.after(0.1, function()
		if not player then return end
		local inv = player:get_inventory()
		if not inv then return end
		for listname, list in pairs(inv:get_lists()) do
			for i, stack in ipairs(list) do
				local name = stack:get_name()
				if (name ~= "") then
					itemextensions.on_move._on_moved(player, {
						to_list = listname,
						to_index = i,
						from_stack = stack,
						stack = stack,
						is_from_joining = true,
					})
				end
			end
		end
	end)
end)

-----------------------------------------------------------------
-- binding groups to inventory slots and lists, allowing movement
-----------------------------------------------------------------

itemextensions.on_move._inventory_slot_groups = {}
itemextensions.on_move._inventory_list_groups = {}

-- allow items in this group to be placed in this specific slot
function itemextensions.bind_group_to_inventory_slot(group, listname, listindex)
	local invslots = itemextensions.on_move._inventory_slot_groups
	if not invslots[listname] then invslots[listname] = {} end
	if not invslots[listname][listindex] then invslots[listname][listindex] = {} end
	table.insert(invslots[listname][listindex], group)
end

-- allow items in this group to be placed in this list
function itemextensions.bind_group_to_inventory_list(group, listname)
	local invslots = itemextensions.on_move._inventory_list_groups
	if not invslots[listname] then invslots[listname] = {} end
	table.insert(invslots[listname], group)
end

-- return 0 to prevent, else nil for allow, a number for num of items allowed to move
core.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
	local info = fix_bad_inventory_info_fields(player, action, inventory, inventory_info)

	-- core.log(tostring(info.from_stack) .. "  :  " .. tostring(info.to_stack))

	local idef = info.from_stack and info.from_stack:get_definition()
	if not idef then return end

	-- run any callbacks in the item
	if idef._on_inventory_move_allow then
		local ret = idef._on_inventory_move_allow(info.from_stack, player, info)
		if ret ~= nil then return ret end
	end

	-- nothing is defined for this list name so just forget about it
	if not itemextensions.on_move._inventory_slot_groups[info.to_list] then return end

	-- go through the groups that are allowed for this list
	local listgroups = itemextensions.on_move._inventory_list_groups[info.to_list]
	if listgroups then
		for i, groupname in ipairs(listgroups) do
			if (idef.groups[groupname] or 0) > 0 then return end
		end
	end

	-- go through the groups that are allowed for this slot
	local listslots = itemextensions.on_move._inventory_slot_groups[info.to_list]
	local slotgroups = listslots[info.to_index]

	-- nothing is defined for this index so just forget about it
	if not slotgroups then return end

	for i, groupname in ipairs(slotgroups) do
		if (idef.groups[groupname] or 0) > 0 then return end
	end

	-- return 0 will prevent any item from being moved
	return 0
end)

-- poll entire inventory every step to see absolutely all changes
-- this is contextless of course so useless for making changes in response
local _i = 0
core.register_globalstep(function(dtime)
	local playerlist = core.get_connected_players()
	local count = #playerlist
	for k = 1, 10 do
		_i = _i + 1
		if _i > count then _i = 0; break end
		local player = playerlist[_i]
		local pi = itemextensions.pi(player) or {}
		local inv = player:get_inventory()
		if not pi.last_lists then pi.last_lists = inv:get_lists() end
		for listname, list in pairs(inv:get_lists()) do
			for i, itemstack in ipairs(list) do
				local oldstack = (pi.last_lists[listname] or {})[i] or ItemStack("")
				if not (itemstack:equals(oldstack)) then
					itemextensions.on_move._on_any_item_changed(itemstack, player, listname, i, oldstack)
				end
			end
		end
		local new_lists = inv:get_lists()
		pi.last_lists = new_lists
	end
end)
