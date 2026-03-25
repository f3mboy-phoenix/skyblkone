
local S = core.get_translator("sbo_mobs")

-- peaceful player privilege

core.register_privilege("peaceful_player", {
	description = "Prevents Mobs Redo mobs from attacking player",
	give_to_singleplayer = false
})

-- fallback node

core.register_node("sbo_mobs:fallback_node", {
	description = S("Fallback Node"),
	tiles = {"mobs_fallback.png"},
	is_ground_content = false,
	groups = {handy = 1, crumbly = 3, not_in_creative_inventory = 1},
	drop = ""
})


local path = core.get_modpath("sbo_mobs")

dofile(path .. "/api.lua") -- mob API

dofile(path .. "/mount.lua") -- rideable mobs

dofile(path .. "/crafts.lua") -- items and crafts

dofile(path .. "/spawner.lua") -- mob spawner

print("[MOD] Mobs Redo loaded")
unified_inventory.register_category('mobs', {
	symbol = "sbo_mobs:nametag",
	label = "Mobs"
})
unified_inventory.add_category_item('mobs', "sbo_mobs:nametag")
unified_inventory.add_category_item('mobs', "sbo_mobs:leather")
unified_inventory.add_category_item('mobs', "sbo_mobs:lasso")
unified_inventory.add_category_item('mobs', "sbo_mobs:shears")
unified_inventory.add_category_item('mobs', "sbo_mobs:saddle")
unified_inventory.add_category_item('mobs', "sbo_mobs:spawner")
