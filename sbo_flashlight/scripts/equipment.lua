--from itemextensions
local equipment_lists = {}

itemextensions.equipment = {}

local function _make_register()
	local callbacks = {}
	-- registers a callback for this event
	return callbacks, function(callback)
		table.insert(callbacks, callback)
	end
end

itemextensions.equipment._registered_on_equipped,
itemextensions.equipment.register_on_equipped = _make_register()
itemextensions.equipment._registered_on_unequipped,
itemextensions.equipment.register_on_unequipped = _make_register()
itemextensions.equipment._registered_on_equipment_step,
itemextensions.equipment.register_on_equipment_step = _make_register()

itemextensions.equipment.equipment_lists = equipment_lists

function itemextensions.equipment.add_equipment_list(listname)
	equipment_lists[listname] = true
end

function itemextensions.equipment.remove_equipment_list(listname)
	equipment_lists[listname] = nil
end

function itemextensions.equipment._on_equipped(stack, player, info, idef)
	local old_stack = ItemStack(stack)
	if idef and idef._on_equipped then
		stack = idef._on_equipped(stack, player, info) or stack
	end
	for i, callback in ipairs(itemextensions.equipment._registered_on_equipped) do
		stack = callback(ItemStack(stack)) or stack
	end
	if old_stack:equals(stack) then return end
	local inv = player:get_inventory()
	inv:set_stack(info.to_list, info.to_index, stack)
end

function itemextensions.equipment._on_unequipped(stack, player, info, idef)
	local old_stack = ItemStack(stack)
	if idef and idef._on_unequipped then
		idef._on_unequipped(stack, player, info)
	end
	for i, callback in ipairs(itemextensions.equipment._registered_on_unequipped) do
		stack = callback(ItemStack(stack)) or stack
	end
	if old_stack:equals(stack) then return end
	local inv = player:get_inventory()
	inv:set_stack(info.to_list, info.to_index, stack)
end

function itemextensions.equipment._is_equipped(itemstack, player, list_name, list_index)
	if not list_name then return false end
	return equipment_lists[list_name]
end

function itemextensions.equipment._on_player_step(player, dtime)
	local pi = itemextensions.pi(player) or {}
	local inv = player:get_inventory()
	local wield_list = player:get_wield_list()
	local wield_index = player:get_wield_index()
	for listname, list in pairs(inv:get_lists()) do
		for k, stack in ipairs(list or {}) do repeat
			local idef = stack:get_definition()
			if not idef then break end
			local is_equipped = itemextensions.equipment._is_equipped(stack, player, listname, k)
			local old_stack = ItemStack(stack)
			if (not is_equipped) and (idef._on_inventory_step ~= nil) then
				stack = idef._on_inventory_step(ItemStack(stack), player, dtime, listname, k) or stack
			elseif is_equipped and (idef._on_equipment_step ~= nil) then
				stack = idef._on_equipment_step(ItemStack(stack), player, dtime, listname, k) or stack
				-- call any callbacks for `register_on_equipment_step`
				for i, callback in ipairs(itemextensions.equipment._registered_on_equipment_step) do
					stack = callback(ItemStack(stack)) or stack
				end
			end
			-- change the item in inventory if there was a return
			if not old_stack:equals(stack) then
				inv:set_stack(listname, k, stack)
				if (wield_list == listname) and (wield_index == k) then
					pi.last_list = listname
					pi.last_index = k
					pi.last_stack = stack
				end
			end
		until true end
	end
end

function itemextensions.equipment._test_and_call_equipment(stack, player, info, idef)
	if not idef then return end

	local was_equipped = itemextensions.equipment._is_equipped(stack, player, info.from_list, info.from_index)
	local now_equipped = itemextensions.equipment._is_equipped(stack, player, info.to_list, info.to_index)

	if now_equipped and not was_equipped then
		itemextensions.equipment._on_equipped(stack, player, info, idef)
	elseif was_equipped and not now_equipped then
		itemextensions.equipment._on_unequipped(stack, player, info, idef)
	end
end
--TODO: make equipment unequip on logout
