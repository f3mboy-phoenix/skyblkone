sbz_api.register_structure({
	offset = {
		x = 3,
		y = 3,
		z = 3,
	},
	map = {
		{
			{ "sbo_nexus:alloy537_block", "sbo_nexus:storage",        "sbo_nexus:alloy537_block", },
			{ "sbo_nexus:storage",        "sbo_nexus:alloy537_block", "sbo_nexus:storage", },
			{ "sbo_nexus:alloy537_block", "sbo_nexus:storage",        "sbo_nexus:alloy537_block", }
		},
		{
			{ "sbo_nexus:storage",        "sbo_nexus:alloy537_block", "sbo_nexus:storage", },
			{ "sbo_nexus:alloy537_block", "sbo_nexus:core",           "sbo_nexus:alloy537_block", },
			{ "sbo_nexus:storage",        "sbo_nexus:alloy537_block", "sbo_nexus:storage", }
		},
		{
			{ "sbo_nexus:alloy537_block", "sbo_nexus:storage",        "sbo_nexus:alloy537_block", },
			{ "sbo_nexus:storage",        "sbo_nexus:alloy537_block", "sbo_nexus:storage", },
			{ "sbo_nexus:alloy537_block", "sbo_nexus:storage",        "sbo_nexus:alloy537_block", }
		},
	}
})

sbz_api.register_element("alloy537", "#FFFFFF", "Alloy #537 %s",
	{ disabled = false, part_of_crusher_drops = false, part_of_enhanced_drops = false, }, "sbo_nexus:")

core.register_craftitem("sbo_nexus:creox_fab_cube", {
	description = "Creox Fabrication Cube",
	inventory_image = "fab_cube.png",
	stack_max = 256,
})


core.register_node("sbo_nexus:storage", {
	description = "Loot Box",
	drawtype = "glasslike",
	tiles = {
		"nexus_storage.png",
	},
	groups = {
		matter = 1,
		not_in_creative_inventory = 1,
	},
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,
	on_punch = sbz_api.get_lootbox_on_punch("nexus", "sbo_nexus:storage_open")
})

core.register_node("sbo_nexus:storage_open", {
	description = 'Nexus Storage',
	tiles = { 'nexus_storage.png' },
	paramtype = 'light',
	light_source = 10,
	groups = { matter = 1 },
	drop = "sbo_nexus:storage_open",
	sounds = sbz_api.sounds.matter(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 32)

		minetest.sound_play("machine_build", {
			to_player = player_name,
			gain = 1.0,
			pos = pos,
		})
		meta:set_string("formspec", [[
formspec_version[7]
size[8.2,9]
style_type[list;spacing=0.2;size=0.8]
list[context;main;0.2,0.2;8,4;]
style_type[list;spacing=0.2;size=.8]
list[current_player;main;0.2,5;8,4;]
listring[]
                    ]])
	end,

})
minetest.register_node('sbo_nexus:core', {
	description = 'Nexus Core',
	tiles = { 'nexus_core.png' },
	paramtype = 'light',
	light_source = 10,
	groups = { matter = 1 },
	drop = "sbo_nexus:creox_fab_cube",
	sounds = sbz_api.sounds.matter(),
})

sbz_api.register_loottype("nexus", "sbo_nexus:storage_open", "Nexus")
sbz_api.register_loot("nexus", "rare", "sbz_chem:compressor_off", 3)
sbz_api.register_loot("nexus", "rare", "sbz_chem:centrifuge_off", 3)
sbz_api.register_loot("nexus", "god", "sbz_bio:neutron_emitter_off", 2)
sbz_api.register_loot("nexus", "rare", "sbz_bio:habitat_regulator", 1)
sbz_api.register_loot("nexus", "rare", "sbz_bio:burner", 4)
sbz_api.register_loot("nexus", "rare", "pipeworks:puncher", 3)
sbz_api.register_loot("nexus", "rare", "pipeworks:deployer", 2)
sbz_api.register_loot("nexus", "rare", "pipeworks:autocrafter", 5)
sbz_api.register_loot("nexus", "rare", "pipeworks:automatic_filter_injector", 2)
sbz_api.register_loot("nexus", "god", "sbz_bio:dna_extractor_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_decor:cnc", 2)
sbz_api.register_loot("nexus", "god", "sbz_chem:xray_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_chem:simple_alloy_furnace_off", 1)
sbz_api.register_loot("nexus", "god", "sbz_chem:pebble_enhancer_off", 2)
sbz_api.register_loot("nexus", "god", "sbz_chem:nuclear_reactor_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_chem:high_power_electric_furnace_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_chem:engraver_off", 4)
sbz_api.register_loot("nexus", "god", "sbz_chem:decay_accel_off", 2)
sbz_api.register_loot("nexus", "god", "sbz_chem:crystal_grower_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_chem:crusher_off", 5)
sbz_api.register_loot("nexus", "god", "sbz_chem:melter_off", 1)
sbz_api.register_loot("nexus", "god", "sbz_chem:cooler_off", 1)
sbz_api.register_loot("nexus", "rare", "sbz_resources:simple_processor", 3)
sbz_api.register_loot("nexus", "rare", "sbz_resources:simple_logic_circuit", 3)
sbz_api.register_loot("nexus", "rare", "sbz_resources:simple_inverted_logic_circuit", 3)
sbz_api.register_loot("nexus", "common", "sbz_resources:simple_circuit", 6)
sbz_api.register_loot("nexus", "rare", "sbz_resources:robotic_arm", 100)
sbz_api.register_loot("nexus", "common", "sbz_resources:retaining_circuit", 4)
sbz_api.register_loot("nexus", "common", "sbz_resources:ram_stick_1mb", 12)
sbz_api.register_loot("nexus", "god", "sbz_resources:prediction_circuit", 3)
sbz_api.register_loot("nexus", "god", "sbz_resources:phlogiston_circuit", 3)
sbz_api.register_loot("nexus", "rare", "sbz_resources:lua_chip", 2)
sbz_api.register_loot("nexus", "rare", "sbz_resources:heating_element", 7)
sbz_api.register_loot("nexus", "rare", "sbz_resources:emittrium_circuit", 5)
sbz_api.register_loot("nexus", "god", "sbz_power:very_advanced_battery", 3)
sbz_api.register_loot("nexus", "rare", "sbz_power:switching_station", 1)
sbz_api.register_loot("nexus", "common", "sbz_power:starlight_collector", 4)
sbz_api.register_loot("nexus", "common", "sbz_power:simple_charge_generator_off", 5)
sbz_api.register_loot("nexus", "common", "sbz_power:power_pipe", 30)
sbz_api.register_loot("nexus", "god", "sbz_power:phlogiston_fuser_off", 3)
sbz_api.register_loot("nexus", "rare", "sbz_power:ele_fab_off", 2)
sbz_api.register_loot("nexus", "common", "sbz_power:battery", 6)
sbz_api.register_loot("nexus", "rare", "sbz_power:airtight_power_cable", 25)
sbz_api.register_loot("nexus", "rare", "sbz_power:advanced_battery", 2)
sbz_api.register_loot("nexus", "rare", "sbz_power:antimatter_generator_off", 3)
sbz_api.register_loot("nexus", "god", "sbz_planets:planet_teleporter", 1)
sbz_api.register_loot("nexus", "rare", "sbz_meteorites:meteorite_radar", 3)

if minetest.get_modpath("sbo_warp_maker") then
	sbz_api.register_loot("nexus", "god", "sbo_warp_maker:warp_maker", 1)
end
if minetest.get_modpath("sbo_shockshroom_grower") then
	sbz_api.register_loot("nexus", "god", "sbo_shockshroom_grower:shockshroom_grower", 1)
end
if minetest.get_modpath("sbo_simp_core_ext") then
	sbz_api.register_loot("nexus", "rare", "sbo_simp_core_ext:simple_core_extractor", 2)
end
if minetest.get_modpath("sbo_simp_charge_ext") then
	sbz_api.register_loot("nexus", "rare", "sbo_simp_charge_ext:simple_charge_extractor", 2)
end
if minetest.get_modpath("sbo_plant_inc") then
	sbz_api.register_loot("nexus", "god", "sbo_plant_inc:plant_incubator", 1)
end
if minetest.get_modpath("sbo_sup_bat") then
	sbz_api.register_loot("nexus", "god", "sbo_sup_bat:super_battery", 4)
end
if minetest.get_modpath("sbo_colorium_circuit") then
	sbz_api.register_loot("nexus", "god", "sbo_colorium_circuit:colorium_circuit", 7)
end
if minetest.get_modpath("sbo_anti_ext") then
	sbz_api.register_loot("nexus", "rare", "sbo_anti_ext:simple_antimatter_extractor", 3)
end
if minetest.get_modpath("sbo_adv_peb_ext") then
	sbz_api.register_loot("nexus", "god", "sbo_adv_peb_ext:advanced_peb_extractor", 2)
end
if minetest.get_modpath("sbo_adv_fuser") then
	sbz_api.register_loot("nexus", "god", "sbo_adv_fuser:phlogiston_fuser_off", 1)
end
if minetest.get_modpath("sbo_adv_chg_gen") then
	sbz_api.register_loot("nexus", "rare", "sbo_adv_chg_gen:advanced_charge_generator_off", 2)
end
if minetest.get_modpath("sbo_adv_blob_ext") then
	sbz_api.register_loot("nexus", "god", "sbo_adv_blob_ext:advanced_blob_extractor", 1)
end
if minetest.get_modpath("sbo_rein_cable") then
	sbz_api.register_loot("nexus", "common", "sbo_rein_cable:power_pipe", 50)
end
if minetest.get_modpath("laptop") then
	sbz_api.register_loot("nexus", "rare", "laptop:HDD", 5)
end
if minetest.get_modpath("sbo_shock_circuit") then
	sbz_api.register_loot("nexus", "god", "sbo_shock_circuit:shock_processor", 3)
	sbz_api.register_loot("nexus", "god", "sbo_shock_circuit:shock_circuit", 5)
end
if minetest.get_modpath("sbo_resium") then
	sbz_api.register_loot("nexus", "god", "sbo_resium:circuit", 3)
end
if minetest.get_modpath("sbo_extrosim_circuit") then
	sbz_api.register_loot("nexus", "rare", "sbo_extrosim_circuit:extrosim_circuit", 3)
end
if minetest.get_modpath("sbo_control_board") then
	sbz_api.register_loot("nexus", "god", "sbo_control_board:control_board", 3)
end
