
local S = core.get_translator("sbo_mobs")
local FS = function(...) return core.formspec_escape(S(...)) end
local mc2 = core.get_modpath("mcl_core")
local mod_def = core.get_modpath("default")

-- determine which sounds to use, default or mcl_sounds

local function sound_helper(snd)

	mobs[snd] = (mod_def and default[snd]) or (mc2 and mcl_sounds[snd])
			or function() return {} end
end

sound_helper("node_sound_defaults")
sound_helper("node_sound_stone_defaults")
sound_helper("node_sound_dirt_defaults")
sound_helper("node_sound_sand_defaults")
sound_helper("node_sound_gravel_defaults")
sound_helper("node_sound_wood_defaults")
sound_helper("node_sound_leaves_defaults")
sound_helper("node_sound_ice_defaults")
sound_helper("node_sound_metal_defaults")
sound_helper("node_sound_water_defaults")
sound_helper("node_sound_snow_defaults")
sound_helper("node_sound_glass_defaults")

-- helper function to add {eatable} group to food items

function mobs.add_eatable(item, hp, ftype)

	local def = core.registered_items[item]

	if def then

		local groups = table.copy(def.groups) or {}

		groups.eatable = hp ; groups.flammable = 2 ; groups.food = ftype or 2

		core.override_item(item, {groups = groups})
	end
end

-- recipe items

local items = {
	paper = "sbz_bio:paper",
	dye_black = "sbz_resources:matter_dust",
	dye_red = "sbz_bio:stemfruit",
	string = "sbz_bio:rope",
	stick = "sbo_wood:stick",
	diamond = "sbo_diamond:diamond",
	steel_ingot = "sbz_chem:iron_ingot",
	gold_block = "sbz_chem:gold_block",
	diamond_block = "sbz_chem:silicon_block",
	stone = "sbz_resources:stone",
	mese_crystal = "sbz_resources:phlogiston",
	wood = "sbz_bio:colorium_planks",
	meat_raw = "group:food_meat_raw",
	meat_cooked = "group:food_meat",
	obsidian = "sbz_resources:reinforced_matter"
}

-- name tag

core.register_craftitem("sbo_mobs:nametag", {
	description = S("Name Tag") .. " " .. S("\nRight-click Mobs to apply"),
	inventory_image = "mobs_nametag.png",
	groups = {flammable = 2, nametag = 1}
})

core.register_craft({
	output = "sbo_mobs:nametag",
	recipe = {
		{ items.paper, items.dye_black, items.string }
	}
})

-- leather

core.register_craftitem("sbo_mobs:leather", {
	description = S("Leather"),
	inventory_image = "mobs_leather.png",
	groups = {flammable = 2, leather = 1}
})

-- raw meat

core.register_craftitem("sbo_mobs:meat_raw", {
	description = S("Raw Meat") .. minetest.colorize("#777", "\nRestores 3 hunger"),
	inventory_image = "mobs_meat_raw.png",
	on_use = hbhunger.item_eat(3),
	groups = {ui_food = 1, food_meat_raw = 1}
})

mobs.add_eatable("sbo_mobs:meat_raw", 3)
hbhunger.register_food("sbo_mobs:meat_raw", 3)
unified_inventory.add_category_item('food', "sbo_mobs:meat_raw")

-- cooked meat

core.register_craftitem("sbo_mobs:meat", {
	description = S("Meat") .. minetest.colorize("#777", "\nRestores 8 hunger"),
	inventory_image = "mobs_meat.png",
	on_use = hbhunger.item_eat(8),
	groups = {ui_food = 1, food_meat = 1}
})

mobs.add_eatable("sbo_mobs:meat", 8)
hbhunger.register_food("sbo_mobs:meat", 8)
unified_inventory.add_category_item('food', "sbo_mobs:meat")

core.register_craft({
	type = "cooking",
	output = "sbo_mobs:meat",
	recipe = "sbo_mobs:meat_raw",
	cooktime = 5
})

-- lasso

core.register_tool("sbo_mobs:lasso", {
	description = S("Lasso (right-click animal to put in inventory)"),
	inventory_image = "mobs_magic_lasso.png",
	groups = {flammable = 2}
})

core.register_craft({
	output = "sbo_mobs:lasso",
	recipe = {
		{ items.string, "", items.string},
		{ "", items.diamond, "" },
		{ items.string, "", items.string }
	}
})

core.register_alias("sbo_mobs:magic_lasso", "sbo_mobs:lasso")


-- shears (right click to shear animal)

core.register_tool("sbo_mobs:shears", {
	description = S("Steel Shears (right-click to shear)"),
	inventory_image = "mobs_shears.png",
	groups = {flammable = 2}
})

core.register_craft({
	output = "sbo_mobs:shears",
	recipe = {
		{ "", items.steel_ingot, "" },
		{ "", items.stick, items.steel_ingot }
	}
})

-- saddle

core.register_craftitem("sbo_mobs:saddle", {
	description = S("Saddle"),
	inventory_image = "mobs_saddle.png",
	groups = {flammable = 2, saddle = 1}
})

core.register_craft({
	output = "sbo_mobs:saddle",
	recipe = {
		{"group:leather", "group:leather", "group:leather"},
		{"group:leather", items.steel_ingot, "group:leather"},
		{"group:leather", items.steel_ingot, "group:leather"}
	}
})

-- Meat Block

core.register_node("sbo_mobs:meatblock", {
	description = S("Meat Block") .. minetest.colorize("#777", "\nRestores 20 hunger"),
	tiles = {"mobs_meat_top.png", "mobs_meat_bottom.png", "mobs_meat_side.png"},
	paramtype2 = "facedir",
	groups = {matter = 1, oddly_breakable_by_hand = 1, explody = 1, ui_food = 1},
	is_ground_content = false,
	sounds = mobs.node_sound_dirt_defaults(),
	on_place = core.rotate_node,
	on_use = hbhunger.item_eat(20),
})

mobs.add_eatable("sbo_mobs:meatblock", 20)
hbhunger.register_food("sbo_mobs:meatblock", 20)
unified_inventory.add_category_item('food', "sbo_mobs:meatblock")

core.register_craft({
	output = "sbo_mobs:meatblock",
	recipe = {
		{ items.meat_cooked, items.meat_cooked, items.meat_cooked },
		{ items.meat_cooked, items.meat_cooked, items.meat_cooked },
		{ items.meat_cooked, items.meat_cooked, items.meat_cooked }
	}
})

-- Meat Block (raw)

core.register_node("sbo_mobs:meatblock_raw", {
	description = S("Raw Meat Block") .. minetest.colorize("#777", "\nRestores 10 hunger"),
	tiles = {"mobs_meat_raw_top.png", "mobs_meat_raw_bottom.png", "mobs_meat_raw_side.png"},
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand = 1, matter = 1, explody = 1, ui_food = 1},
	is_ground_content = false,
	sounds = mobs.node_sound_dirt_defaults(),
	on_place = core.rotate_node,
	on_use = hbhunger.item_eat(10),
})

mobs.add_eatable("sbo_mobs:meatblock_raw", 10)
hbhunger.register_food("sbo_mobs:meatblock_raw", 10)
unified_inventory.add_category_item('food', "sbo_mobs:meatblock_raw")

core.register_craft({
	output = "sbo_mobs:meatblock_raw",
	recipe = {
		{ items.meat_raw, items.meat_raw, items.meat_raw },
		{ items.meat_raw, items.meat_raw, items.meat_raw },
		{ items.meat_raw, items.meat_raw, items.meat_raw }
	}
})

core.register_craft({
	type = "cooking",
	output = "sbo_mobs:meatblock",
	recipe = "sbo_mobs:meatblock_raw",
	cooktime = 30
})
