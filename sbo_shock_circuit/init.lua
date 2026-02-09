core.register_craftitem("sbo_shock_circuit:shock_processor", {
    description = "Shock Processor",
    inventory_image = "shock_procesor.png" -- someone correct the typo lmfao
})

minetest.register_craft({
    output = "sbo_shock_circuit:shock_processor",
    type = "shapeless",
    recipe = {
        "sbz_resources:simple_processor",
        "sbz_instatube:instantinium",
        "sbz_instatube:instantinium",
        "sbz_resources:shock_crystal"
    },
})

minetest.register_craftitem("sbo_shock_circuit:shock_circuit", {
    description = "Shock Circuit",
    inventory_image = "shock_circuit.png",
    stack_max = 256,
})
minetest.register_craft({
    output = "sbo_shock_circuit:shock_circuit",
    type = "shapeless",
    recipe = {
        "sbo_shock_circuit:shock_processor",
        "sbo_emittrium_plate:emittrium_plate",
    },
})

sbo_api.quests.on_craft["sbo_shock_circuit:shock_circuit"] = "Shock Circuit"
sbo_api.quests.register_to("Questline: Resources",{
        type = "quest",
        title = "Shock Circuit",
        text = [[
Shock Circuits are required for crafting.
They are made with:
    1 Shock Processor
    1 Emittrium plate]],
})
sbo_api.quests.on_craft["sbo_shock_circuit:shock_processor"] = "Shock Processor"
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
