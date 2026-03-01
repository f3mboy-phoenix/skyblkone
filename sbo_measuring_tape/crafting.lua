
local shell_mat = "sbz_resources:antimatter_plate"
local case_mat = "sbz_resources:matter_plate"
local dye_mat = "sbz_resources:phlogiston"
local extra_mat = "sbo_modded_elem:white_gold_ingot"

minetest.register_craft({
	output = "sbo_mesuring_tape:tape",
	recipe = {
		{shell_mat, dye_mat, ""},
		{shell_mat, case_mat, extra_mat},
		{"", "", ""},
	}
})
