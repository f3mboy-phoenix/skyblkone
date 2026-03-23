unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:simple_circuit 4",
    items = {
        "sbz_resources:core_dust",
        "sbz_resources:matter_blob",
    },
    width = 2,
    height = 1
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:retaining_circuit 2",
    items = {
        "sbz_resources:charged_particle",
        "sbz_resources:simple_circuit",
        "sbz_resources:antimatter_dust",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:emittrium_circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:matter_plate",
        "sbz_resources:raw_emittrium",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:phlogiston_circuit 8",
    items = {
        "sbz_resources:emittrium_circuit 4",
        "sbz_resources:phlogiston 1",
        "sbz_resources:antimatter_blob",
        "sbz_resources:matter_blob",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:prediction_circuit 4",
    items = {
        "sbz_resources:emittrium_circuit 2",
        "sbz_chem:titanium_alloy_ingot",
        "sbz_resources:raw_emittrium 2",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_extrosim:circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:antimatter_plate",
        "sbo_extrosim:raw_extrosim",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_resium:circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:antimatter_plate",
        "sbo_resium:crystal",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_crystals:circuit 4",
    width = 2,
    height = 2,
    items = { "sbz_resources:charged_particle", "sbo_resium:circuit", "sbo_crystals:amethyst_shard", "sbz_resources:antimatter_plate" }
})

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Circuits",
    text =
        [[Adds shock circuits, processors, control boards, and elefab circuit crafts]],
})

core.register_craftitem("sbo_circuits:shock_processor", {
    description = "Shock Processor",
    inventory_image = "shock_procesor.png" -- someone correct the typo lmfao
})

minetest.register_craft({
    output = "sbo_circuits:shock_processor",
    type = "shapeless",
    recipe = {
        "sbz_resources:simple_processor",
        "sbz_instatube:instantinium",
        "sbz_instatube:instantinium",
        "sbz_resources:shock_crystal"
    },
})

core.register_alias("sbo_shock_circuit:shock_processor", "sbo_circuits:shock_processor")

minetest.register_craftitem("sbo_circuits:shock_circuit", {
    description = "Shock Circuit",
    inventory_image = "shock_circuit.png",
    stack_max = 256,
})
minetest.register_craft({
    output = "sbo_circuits:shock_circuit",
    type = "shapeless",
    recipe = {
        "sbo_circuits:shock_processor",
        "sbo_emmitrex:plate",
    },
})
core.register_alias("sbo_shock_circuit:shock_circuit", "sbo_circuits:shock_circuit")

sbo_api.quests.on_craft["sbo_circuits:shock_circuit"] = "Shock Circuit"
sbo_api.quests.register_to("Questline: Resources",{
        type = "quest",
        title = "Shock Circuit",
        text = [[
Shock Circuits are required for crafting.
They are made with:
    1 Shock Processor
    1 Emittrium plate]],
})
sbo_api.quests.on_craft["sbo_circuits:shock_processor"] = "Shock Processor"
sbo_api.quests.register_to("Questline: Resources",{
        type = "quest",
        title = "Shock Processor",
        text = [[
Shock Processors are required for crafting.
They are made with:
    1 Simple processor
    2 Instantinium
    1 Shock crystal]],
})

core.register_craftitem("sbo_circuits:control_board", {
	description = "Control Board",
	inventory_image = "control_board.png" -- someone correct the typo lmfao
})
minetest.register_craft({
	type = "shapeless",
	output = "sbo_circuits:control_board 4",
	recipe = {
		"sbo_circuits:shock_circuit",
		"sbo_colorium:circuit",
		"sbo_extrosim:circuit",
		"sbz_resources:simple_circuit",
		"sbz_resources:retaining_circuit",
		"sbz_resources:emittrium_circuit",
		"sbz_resources:phlogiston_circuit",
		"sbz_resources:prediction_circuit",
		"sbz_resources:simple_logic_circuit" }
})
core.register_alias("sbo_control_board:control_board", "sbo_circuits:control_board")


sbo_api.quests.on_craft["sbo_circuits:control_board"] = "Control Board"
sbo_api.quests.register_to("Questline: Resources",{
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
