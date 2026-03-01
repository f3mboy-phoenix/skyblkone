--from itemextensions
--[[
pi -->
	last_list,
	last_index,
	last_stack,
]]

itemextensions.wield = {}

-- [1] _on_select, [2] _on_deselect, [3] _on_step
local registers = {
	{}, {}, {},
}

-- call all registered funcs for this event
local function on_select(stack, player)
	for i, func in ipairs(registers[1]) do
		stack = func(ItemStack(stack), player) or stack
	end
	return stack
end
-- call all registered funcs for this event
local function on_deselect(stack, player)
	for i, func in ipairs(registers[2]) do
		stack = func(ItemStack(stack), player) or stack
	end
	return stack
end
-- call all registered funcs for this event
local function on_step(stack, player, dtime)
	for i, func in ipairs(registers[3]) do
		stack = func(ItemStack(stack), player, dtime) or stack
	end
	return stack
end

-- function(stack, player) ==> nil | itemstack
function itemextensions.register_on_select(func)
	registers[1][#registers[1]+1] = func
end
-- functionct(stack, player) ==> nil | itemstack
function itemextensions.register_on_deselect(func)
	registers[2][#registers[1]+1] = func
end
-- function(stack, player, dtime) ==> nil | itemstack
function itemextensions.register_on_wield_step(func)
	registers[3][#registers[1]+1] = func
end

-- runs through checks and callbacks and sets stacks if the callbacks return any
local function player_tick(player, dtime)
	local pi = itemextensions.pi(player)
	if not pi then return end
	local first_tick_for_player = (not pi.init)
	pi.init = true
	local inv = player:get_inventory()

	local current = {}
	current.stack = player:get_wielded_item()
	current.list = player:get_wield_list()
	current.index = player:get_wield_index()

	local previous
	if not first_tick_for_player and pi.last_index then
		previous = {
			stack = pi.last_stack or ItemStack("")
		}
	end

	-- only trigger calls if it changed, but forget meta and wear
	current.changed = (not previous) or (current.stack:get_name() ~= previous.stack:get_name())
	current.changed = current.changed or ((pi.last_index ~= current.index) or pi.last_list ~= current.list)
	current.changed = current.changed or not current.stack:equals(inv:get_stack(pi.last_list, pi.last_index))

	-- if wield changed, or is first time ticked
	-- if (not f) or not w.stack:equals(f.stack) then w.changed = true end

	current.def = current.stack:get_definition() or {}

	-- if the wield item has changed, run through the on deselect and select funcs

	-- on deselect previous stack
	if current.changed and previous then
		local ret
		previous.def = previous.stack:get_definition() or {}
		-- on deselect
		ret = on_deselect(ItemStack(previous.stack), player)
		ret = (previous.def._on_deselect and previous.def._on_deselect(ItemStack(ret or previous.stack), player)) or ret
		if (ret ~= nil) and not ret:equals(previous.stack) then
			previous.stack_changed = true -- later, only set if there's a change
			previous.stack = ItemStack(ret)
		end
	end

	-- on select for current stack
	if current.changed then
		local ret
		ret = on_select(ItemStack(current.stack), player)
		ret = (current.def._on_select and current.def._on_select(ItemStack(ret or current.stack), player)) or ret
		if (ret ~= nil) and not ret:equals(current.stack) then
			current.stack_changed = true -- later, only set if there's a change
			current.stack = ItemStack(ret)
		end
	end

	-- on step for current stack
	if current.def._on_step then
		local ret = on_step(ItemStack(current.stack), player, dtime)
		ret = current.def._on_step(ItemStack(ret or current.stack), player, dtime) or ret
		if (ret ~= nil) and not current.stack:equals(ret) then
			current.stack_changed = true -- later, only set if there's a change
			current.stack = ItemStack(ret)
		end
	end

	-- modify current stack if changed due to callbacks
	if current.stack_changed then
		inv:set_stack(current.list, current.index, current.stack)
	end
	-- modify previous stack if it was deselected and changed due to callbacks
	if previous and previous.stack_changed then
		inv:set_stack(pi.last_list, pi.last_index, previous.stack)
	end
	-- update "last" data so it can be compared again next step
	pi.last_list = current.list
	pi.last_index = current.index
	pi.last_stack = current.stack

	-- run equipment checks and callbacks
	itemextensions.equipment._on_player_step(player, dtime)
end

core.register_globalstep(function(dtime)
	for i, player in ipairs(core.get_connected_players()) do
		player_tick(player, dtime)
	end
end)

-- forcibly deselect the item, such as on logout
local function deselect_wielded(player, fromstack, allow_set_stack)
	local last_list = player:get_wield_list()
	local last_index = player:get_wield_index()
	local inv = player:get_inventory()

	local previous = {stack = fromstack or inv:get_stack(last_list, last_index)}
	local ret
	previous.def = previous.stack:get_definition()
	-- on deselect
	ret = on_deselect(ItemStack(previous.stack), player)
	ret = (previous.def._on_deselect and previous.def._on_deselect(ItemStack(ret or previous.stack), player)) or ret
	if (ret ~= nil) and not ret:equals(previous.stack) then
		previous.stack_changed = true -- later, only set if there's a change
		previous.stack = ItemStack(ret)
	end
	if allow_set_stack and previous and previous.stack_changed then
		inv:set_stack(last_list, last_index, previous.stack)
	end
	return previous.stack
end

-- must do this after all other modifications to this function
core.register_on_mods_loaded(function()
	-- save the builtin drop function
	local core_item_drop = core.item_drop
	---@diagnostic disable-next-line: duplicate-set-field
	core.item_drop = function(itemstack, dropper, pos)
		local pi = itemextensions.pi(dropper)
		if not pi then
			return core_item_drop(itemstack, dropper, pos)
		end

		-- no idea how any of this works anymore have fun

		local do_set = false
		local idef = itemstack:get_definition()

		if idef._on_drop then
			local ret = idef._on_drop(ItemStack(itemstack), dropper)
			if ret == false then
				return itemstack, nil
			else
				itemstack = ret
				do_set = true
			end
		end

		-- could be incorrect, may require testing for if will be empty
		-- might also be completely unnecessary
		if itemstack:equals(dropper:get_wielded_item()) then
			itemstack = deselect_wielded(dropper, itemstack, false) or itemstack
			pi.last_list = dropper:get_wield_list()
			pi.last_index = dropper:get_wield_index()
			do_set = true
		end

		local item_obj
		itemstack, item_obj = core_item_drop(itemstack, dropper, pos)

		if item_obj and idef._on_dropped then
			local ret = idef._on_dropped(itemstack, dropper, item_obj)
			if ret then
				itemstack = ret
				do_set = true
			end
		end

		if do_set then
			pi.last_stack = itemstack
		end
		return itemstack, item_obj
	end
end)

core.register_on_leaveplayer(function(player, timed_out)
	deselect_wielded(player, nil, true)
end)


