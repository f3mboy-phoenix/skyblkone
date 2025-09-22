core.register_craftitem("sbo_control_board:control_board", {
    description = "Control Board",
    inventory_image = "control_board.png" -- someone correct the typo lmfao
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_control_board:control_board 4",
    recipe = {
		"sbo_shock_circuit:shock_circuit",
		"sbo_colorium_circuit:colorium_circuit",
		"sbo_extrosim_circuit:extrosim_circuit",
		"sbz_resources:simple_circuit",
		"sbz_resources:retaining_circuit",
		"sbz_resources:emittrium_circuit",
		"sbz_resources:phlogiston_circuit",
		"sbz_resources:prediction_circuit",
		"sbz_resources:simple_logic_circuit" }
})
sbz_api.achievment_table["sbo_control_board:control_board"] = "Control Board"
sbz_api.register_quest_to("Questline: Resources",{
        type = "quest",
        title = "Control Board",
        text = [[You made a control board, it is required for crafting]],
})
