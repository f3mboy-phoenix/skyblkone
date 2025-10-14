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
sbo_api.register_wiki_page({
	type = "quest",
	title = "Control Board",
	text = [[
Control boards are required for crafting.
They are made with:
	1 Shock circuit
	1 Colorium circuit
	1 Extrosim circuit
	1 Simple circuit
	1 Retaining circuit
	1 Emittrium circuit
	1 Phlogiston circuit
	1 Prediction circuit
	1 Simple logic circuit]],
})
