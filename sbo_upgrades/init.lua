sbo_api.upgrades = {}
sbo_api.upgrades.health_items = {}
sbo_api.upgrades.hunger_items = {}
sbo_api.upgrades.breath_items = {}
sbo_api.upgrades.speed_items = {}
sbo_api.upgrades.jump_items = {}
sbo_api.upgrades.gravity_items = {}
sbo_api.upgrades.translator = minetest.get_translator("sbo_upgrades")

local modpath = minetest.get_modpath("sbo_upgrades")

dofile(modpath .. "/api.lua")
dofile(modpath .. "/packs.lua")
if minetest.get_modpath("unified_inventory")
	and not unified_inventory.sfinv_compat_layer then
	dofile(modpath .. "/gui_unified_inventory.lua")
elseif minetest.get_modpath("sfinv") then
	dofile(modpath .. "/gui_sfinv.lua")
else
	dofile(modpath .. "/gui_plain.lua")
end


-- Cache items which are interesting for this mod
minetest.after(0, function()
	local items = minetest.registered_items
	local health_items = {}
	local breath_items = {}
	local hunger_items = {}
	local speed_items = {}
	local jump_items = {}
	local gravity_items = {}

	for name, def in pairs(items) do
		local groups = def.groups or {}
		if groups.upgrade_health
			and groups.upgrade_health ~= 0 then
			health_items[name] = groups.upgrade_health
		end
		if groups.upgrade_breath
			and groups.upgrade_breath ~= 0 then
			breath_items[name] = groups.upgrade_breath
		end
		if groups.upgrade_hunger
			and groups.upgrade_hunger ~= 0 then
			hunger_items[name] = groups.upgrade_hunger
		end
		if groups.upgrade_jump
			and groups.upgrade_jump ~= 0 then
			jump_items[name] = groups.upgrade_jump
		end
		if groups.upgrade_speed
			and groups.upgrade_speed ~= 0 then
			speed_items[name] = groups.upgrade_speed
		end
		if groups.upgrade_gravity
			and groups.upgrade_gravity ~= 0 then
			gravity_items[name] = groups.upgrade_gravity
		end
	end
	sbo_api.upgrades.health_items = health_items
	sbo_api.upgrades.breath_items = breath_items
	sbo_api.upgrades.hunger_items = hunger_items
	sbo_api.upgrades.speed_items = speed_items
	sbo_api.upgrades.jump_items = jump_items
	sbo_api.upgrades.gravity_items = gravity_items
end)

-- Hacky: Set the hp_max and breath_max value first
table.insert(minetest.registered_on_joinplayers, 1, function(player)
	sbz_api.displayDialogLine(player:get_player_name(), "Welcome " .. player:get_player_name())
	sbo_api.upgrades.meta_to_inv(player)
	sbo_api.upgrades.update_player(player)
	--hb.change_hudbar(player, "satiation", nil, hbhunger.SAT_MAX)
	if hbhunger then
		hbhunger.update_hud(player)
		hb.change_hudbar(player, "satiation", nil, hbhunger.SAT_MAX)
	end
end)

minetest.register_on_leaveplayer(sbo_api.upgrades.inv_to_meta)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, user)
	if hp_change == 0 then
		return
	end
	-- Undo some of the wear when eating instead of dying
	sbo_api.upgrades.add_wear(user, "health", hp_change * -100)
end)

minetest.register_on_player_hpchange(function(player, hp_change, reason)
	if hp_change >= 0 then
		return hp_change
	end
	if reason.type == "drown" then
		sbo_api.upgrades.add_wear(player, "breath", hp_change * -2000)
	else
		sbo_api.upgrades.add_wear(player, "health", hp_change * -200)
	end

	return hp_change
end, true)

minetest.register_allow_player_inventory_action(function(player, action, inv, data)
	if data.to_list ~= "ugpacks" then
		return -- Not interesting for this mod
	end
	local stack = inv:get_stack(data.from_list, data.from_index)

	if sbo_api.upgrades.health_items[stack:get_name()] then
		return 1
	end
	if sbo_api.upgrades.breath_items[stack:get_name()] then
		return 1
	end
	if sbo_api.upgrades.hunger_items[stack:get_name()] then
		return 1
	end
	if sbo_api.upgrades.speed_items[stack:get_name()] then
		return 1
	end
	if sbo_api.upgrades.jump_items[stack:get_name()] then
		return 1
	end
	if sbo_api.upgrades.gravity_items[stack:get_name()] then
		return 1
	end

	return 0
end)

minetest.register_on_player_inventory_action(function(player, action, inv, data)
	if data.to_list == "ugpacks" or data.from_list == "ugpacks" then
		sbo_api.upgrades.update_player(player)
		--sbo_api.upgrades.update_player(player)

		hbhunger.update_hud(player)
	end
end)

sbo_api.register_wiki_page({
	type = "text",
	info = true,
	title = "Upgrades",
	text =
	[[This mod adds upgrade packs for modifires such as speed, health, gravity, jump, and hunger. ]]
})
