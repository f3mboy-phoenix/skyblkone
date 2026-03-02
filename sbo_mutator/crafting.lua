
local shell_mat = "sbz_resources:matter_plate"
local case_mat =  "sbz_power:battery"
local extra_mat = "sbo_adv_neu_emt:neutron_emitter_off"

minetest.register_craft({
	output = "sbo_mutator:gun",
	recipe = {
		{shell_mat, shell_mat, "sbz_resources:antimatter_plate"},
		{shell_mat, case_mat, extra_mat},
		{shell_mat, "", ""},
	}
})
