local S = minetest.get_translator("sbo_lavalamp")

lavalamp = {}

minetest.register_node("sbo_lavalamp:lavalamp", {
	description = S("Lava Lamp"),
	drawtype = "mesh",
	mesh = "lavalamp.obj",
	tiles = {
		{ name = "lavalamp_metal.png" },
		{ name = "lavalamp_lamp_liquid.png" },
	},
	overlay_tiles = {
		"",
		{
			name="lavalamp_lamp_anim.png",
			animation={
				type="vertical_frames",
				aspect_w=40,
				aspect_h=40,
				length=6.0,
			},
		},
	},
    use_texture_alpha = "blend",
	inventory_image = "lavalamp_lamp_inv.png",
	paramtype = "light",
	--paramtype2 = "color",
	--paramtype2 = "color",
	--palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	},
	groups = {matter=2,oddly_breakable_by_hand=3, },
	is_ground_content = false,
	--on_construct = unifieddyes.on_construct,
	--on_dig = unifieddyes.on_dig,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "sbo_lavalamp:lavalamp_off"
		minetest.swap_node(pos, node)
		return itemstack
	end
})

minetest.register_node("sbo_lavalamp:lavalamp_off", {
	description = S("Lava Lamp/Light (off)"),
	drawtype = "mesh",
	mesh = "lavalamp.obj",
	tiles = {
		{ name = "lavalamp_metal.png", color = 0xffffffff },
		"lavalamp_lamp_off.png",
	},
	paramtype = "light",
	--paramtype2 = "color",
	--palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25,0.5, 0.25 },
	},
	groups = {matter=2,oddly_breakable_by_hand=3, not_in_creative_inventory=1, },
	is_ground_content = false,
	--on_construct = unifieddyes.on_construct,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "sbo_lavalamp:lavalamp"
		minetest.swap_node(pos, node)
		return itemstack
	end,
	drop = {
		items = {
			{items = {"sbo_lavalamp:lavalamp"}, inherit_color = true },
		}
	}
})

minetest.register_craft({
	output = "sbo_lavalamp:lavalamp",
	recipe = {
		{"sbz_resources:matter_plate", "sbz_chem:water_fluid_cell", "sbz_resources:matter_plate", },
		{"sbz_resources:emittrium_glass", "sbo_light_blk:light_block", "sbz_resources:emittrium_glass", },
		{"sbz_resources:matter_plate", "sbz_resources:heating_element", "sbz_resources:matter_plate", }
	},
	replacements = {{"sbz_chem:water_fluid_cell", "sbz_chem:empty_fluid_cell"}}
})
unified_inventory.add_category_item('deco', "sbo_lavalamp:lavalamp")

sbo_api.quests.on_craft["sbo_lavalamp:lavalamp"] = "Lava Lamp"
sbo_api.quests.register_to("Questline: Decorator",{
    type = "quest",
    title = "Lava Lamp",
    text =
        [[Decoration: Lava lamp.        
After placing a lava lamp, the player can turn it off/on again by right-clicking on it.
]],
    requires = { "Block of Light??", }
})
