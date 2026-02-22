minetest.register_craftitem("sbo_liquids:cooling_coil", {
	description = 'Cooiling coils',
	inventory_image = "cooling_coils.png",
})

minetest.register_craft({
	output = 'sbo_liquids:cooling_coil',
	recipe = {
		{"sbz_chem:copper_ingot", "sbz_chem:copper_ingot", "sbz_chem:copper_ingot"},
		{"sbo_modded_elem:zinc_ingot", 'sbo_modded_elem:zinc_ingot', "sbo_modded_elem:zinc_ingot"},
		{"sbz_resources:emittrium_circuit", "sbz_resources:emittrium_circuit", "sbz_resources:emittrium_circuit"},
	}
})
minetest.register_craft({
	output = 'sbz_chem:cooler_off',
	recipe = {
		{"sbz_resources:matter_blob", "sbz_resources:matter_blob", "sbz_resources:matter_blob"},
		{"sbz_resources:matter_blob", 'sbo_liquids:cooling_coil', "sbz_resources:matter_blob"},
		{"sbz_resources:matter_blob", "sbz_resources:matter_blob", "sbz_resources:matter_blob"},
	}
})
minetest.register_craft({
	output = 'sbz_chem:melter_off',
	recipe = {
		{"sbz_resources:matter_blob", "sbz_resources:matter_blob",     "sbz_resources:matter_blob"},
		{"sbz_resources:matter_blob", 'sbz_resources:heating_element', "sbz_resources:matter_blob"},
		{"sbz_resources:matter_blob", "sbz_resources:matter_blob",     "sbz_resources:matter_blob"},
	}
})



sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Liquids",
    text = [[Adds cooling Coils and provides a decipe for the melter and cooler]],
})
