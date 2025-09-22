core.register_craftitem("sbo_shock_circuit:shock_processor", {
    description = "Shock Processor",
    inventory_image = "shock_procesor.png" -- someone correct the typo lmfao
})

    unified_inventory.register_craft {
        output = "sbo_shock_circuit:shock_processor",
        type = "blast_furnace",
        items = {
            "sbz_resources:simple_processor",
            "sbz_chem:silicon_crystal 8",
            "sbz_resources:shock_crystal"
        },
    }

    sbz_api.blast_furnace_recipes[#sbz_api.blast_furnace_recipes + 1] = {
        recipe = {
            "sbz_resources:simple_processor",
            "sbz_chem:silicon_crystal 8",
            "sbz_resources:shock_crystal"
        },
        names = {
            "sbz_resources:simple_processor",
            "sbz_chem:silicon_crystal",
            "sbz_resources:shock_crystal"
        },
        output = "sbo_shock_circuit:shock_processor",
        chance = 1 / (9 * 2)
    }

unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_shock_circuit:shock_circuit",
    items = {
        "sbo_shock_circuit:shock_processor 4",
        "sbz_chem:uranium_crystal 2"
    },
    width = 2,
    height = 1
})
minetest.register_craftitem("sbo_shock_circuit:shock_circuit", {
    description = "Shock Circuit",
    inventory_image = "shock_circuit.png",
    stack_max = 256,
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
