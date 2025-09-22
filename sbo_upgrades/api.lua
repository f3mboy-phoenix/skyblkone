function sbo_upgrades.meta_to_inv(player)
	local meta = player:get_meta()
	local inv = player:get_inventory()
	local data = meta:get("sbo_upgrades:ugpacks")

	inv:set_size("ugpacks", 24)
	if not data then
		return -- List was empty or it's a new player
	end

	local list = minetest.deserialize(data)
	if not list then
		-- This should not happen at all
		minetest.log("warning", "[sbo_upgrades] Failed to deserialize "
			.. "player meta of player " .. player:get_player_name())
	else
		for i = 1, 24 do
			list[i] = ItemStack(list[i])
		end
		inv:set_list("ugpacks", list)
	end
	meta:set_string("sbo_upgrades:ugpacks", "")
end

-- Metadata cannot be accessed directly
-- If this mod is disabled, the inventory list will be unavailable
function sbo_upgrades.inv_to_meta(player)
	local meta = player:get_meta()
	local inv = player:get_inventory()
	local list = inv:get_list("ugpacks")
	if list and not inv:is_empty("ugpacks") then
		for i, v in ipairs(list) do
			list[i] = v:to_table()
		end
		meta:set_string("sbo_upgrades:ugpacks", minetest.serialize(list))
	end
	inv:set_size("ugpacks", 0)
end

-- Maximum wear: (2^16 - 1)
function sbo_upgrades.add_wear(player, pack, amount)
	local lookup = sbo_upgrades[pack .. "_items"]

	local needs_update = false
	local inv = player:get_inventory()
	local list = inv:get_list("ugpacks")
	for i, stack in pairs(list) do
		if lookup[stack:get_name()] then
			assert(stack:add_wear(amount), "Wear out impossible: "
				.. stack:get_name())
			-- Trigger an update if it wore out
			if stack:is_empty() then
				needs_update = true
			end
		end
	end
	inv:set_list("ugpacks", list)
	if needs_update then
		sbo_upgrades.update_player(player)
	end
end

function sbo_upgrades.register_pack(name, pack, pack_def)
	assert(pack == "breath" or pack == "health" or pack == "hunger" or pack == "jump" or pack == "speed" or pack == "gravity")
	assert(pack_def.description)
	assert(pack_def.image)
	assert(pack_def.strength > 0)

	local def = {
		description = pack_def.description,
		inventory_image = pack_def.image,
		groups = pack_def.groups or {}
	}
	def.groups["upgrade_" .. pack] = pack_def.strength

	minetest.register_tool(name, def)
end
sbo_upgrades._speedid=nil
function sbo_upgrades.update_player(player)
	local inv = player:get_inventory()
	local health = minetest.PLAYER_MAX_HP_DEFAULT
	local breath = minetest.PLAYER_MAX_BREATH_DEFAULT
	local hunger = hbhunger.DEF_SAT_MAX
	local speed = 1
	local gravity = 1
	local jump = 1

	local health_items = sbo_upgrades.health_items
	local breath_items = sbo_upgrades.breath_items
	local hunger_items = sbo_upgrades.hunger_items
	local gravity_items = sbo_upgrades.gravity_items
	local jump_items = sbo_upgrades.jump_items
	local speed_items = sbo_upgrades.speed_items


	local list = inv:get_list("ugpacks")
	for i, stack in pairs(list) do
		local name = stack:get_name()
		if health_items[name] then
			health = health + health_items[name]
		elseif breath_items[name] then
			breath = breath + breath_items[name]
		elseif hunger_items[name] then
			hunger = hunger + hunger_items[name]
		elseif gravity_items[name] then
			gravity = gravity + gravity_items[name]
		elseif jump_items[name] then
			jump = jump + jump_items[name]
		elseif speed_items[name] then
			speed = speed + speed_items[name]
		end
	end

	hbhunger.SAT_MAX = hunger

	player:set_properties({
		hp_max = health,
		breath_max = breath
	})
	player:set_physics_override({
		--speed = speed,
		jump = jump,
		gravity = gravity
	})
	if sbo_upgrades._speedid then
		player_monoids.speed:del_change(player, 'upgrades:speed')
	end
	sbo_upgrades._speedid=player_monoids.speed:add_change(player, speed, 'upgrades:speed')
	--sbz_api.displayDialogLine(player:get_player_name(), "Run Update Hud")
	hbhunger.update_hud(player)
end
