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
sbz_api.achievment_table["sbo_shock_circuit:shock_circuit"] = "Shock Circuit"
sbz_api.register_quest_to("Questline: Resources",{
        type = "quest",
        title = "Shock Circuit",
        text = [[You made a Shock Circuit, it is required for crafting]],
})
sbz_api.achievment_table["sbo_shock_circuit:shock_processor"] = "Shock Processor"
sbz_api.register_quest_to("Questline: Resources",{
        type = "quest",
        title = "Shock Processor",
        text = [[You made a Shock Processor, it is required for crafting]],
})
