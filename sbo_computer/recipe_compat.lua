sbo_computer.recipe_compat = {
	-- Init all used vars to avoid crash if missed
	tin = 'sbz_chem:tin_ingot',
        copper = 'sbz_chem:copper_ingot',
        gold = 'sbz_chem:gold_ingot',
	steel = 'sbz_chem:invar_ingot',
        glass = 'sbz_resources:emittrium_glass',
        diamond = 'sbz_resources:phlogiston',
	silicon = 'sbz_chem:silicon_ingot',
        fiber = 'sbz_bio:fiberweed',
	gates_diode = 'sbz_resources:simple_circuit',
        gates_and = 'sbz_resources:retaining_circuit',
        gates_or = 'sbz_resources:emittrium_circuit',
	gates_nand = 'sbz_resources:phlogiston_circuit',
        gates_xor = 'sbz_resources:prediction_circuit',
        gates_not = 'sbo_colorium_circuit:colorium_circuit',
	fpga = 'sbo_extrosim_circuit:extrosim_circuit',
        programmer = 'sbz_resources:simple_processor',
        delayer = 'sbz_resources:antimatter_blob',
	controller = 'sbz_logic:lua_controller',
        light_red = 'sbz_resources:matter_dust',
        light_green = 'sbz_resources:core_dust',
	light_blue = 'sbz_resources:charged_particle',
        plastic = 'sbz_resources:matter_blob',
        motor = 'sbz_resources:warp_crystal',
        battery = 'sbz_power:battery',
        lv_transformer = 'sbz_instatube:instantinium',
}

local rc = sbo_computer.recipe_compat

