core.register_craft({
    output = "sbo_crystals:basalt_block 9",
    recipe = {
        {"sbo_crystals:basalt", "sbo_crystals:basalt", "sbo_crystals:basalt"},
        {"sbo_crystals:basalt", "sbo_crystals:basalt", "sbo_crystals:basalt"},
        {"sbo_crystals:basalt", "sbo_crystals:basalt", "sbo_crystals:basalt"},
    },
})

core.register_craft({
    output = "amethyst_new:calcite_block 9",
    recipe = {
        {"sbo_crystals:calcite", "sbo_crystals:calcite", "sbo_crystals:calcite"},
        {"sbo_crystals:calcite", "sbo_crystals:calcite", "sbo_crystals:calcite"},
        {"sbo_crystals:calcite", "sbo_crystals:calcite", "sbo_crystals:calcite"},
    },
})

core.register_craft({
    output = "sbo_crystals:basalt_brick 4",
    recipe = {
        {"sbo_crystals:basalt", "sbo_crystals:basalt"},
        {"sbo_crystals:basalt", "sbo_crystals:basalt"},
    },
})

core.register_craft({
    output = "amethyst_new:calcite_brick 4",
    recipe = {
        {"sbo_crystals:calcite", "sbo_crystals:calcite"},
        {"sbo_crystals:calcite", "sbo_crystals:calcite"},
    },
})

core.register_craft({
    output = "sbo_crystals:checkerboard 4",
    recipe = {
        {"sbo_crystals:calcite", "sbo_crystals:basalt"},
        {"sbo_crystals:basalt", "sbo_crystals:calcite"},
    },
})

core.register_craft({
    output = "sbo_crystals:amethyst_shard 9",
    recipe = {
        {"sbo_crystals:amethyst"},
    },
})

core.register_craft({
    output = "sbo_crystals:amethyst",
    recipe = {
        {"sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard"},
        {"sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard"},
        {"sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard", "sbo_crystals:amethyst_shard"},
    },
})

core.register_craft({
    output = "sbo_crystals:tinted_glass 2",
    recipe = {
        {"", "sbo_crystals:amethyst_shard", ""},
        {"sbo_crystals:amethyst_shard", "sbo_dark_glass:dark_glass", "sbo_crystals:amethyst_shard"},
        {"", "sbo_crystals:amethyst_shard", ""},
    },
})


core.register_craft({
    output = "sbo_crystals:lantern",
    recipe = {
        {"sbz_chem:bronze_ingot", "sbo_crystals:amethyst", "sbz_chem:bronze_ingot"},
        {"sbo_crystals:amethyst", "sbo_flashlight:flashlight", "sbo_crystals:amethyst"},
        {"sbz_chem:bronze_ingot", "sbo_crystals:amethyst", "sbz_chem:bronze_ingot"},
    },
})

sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_crystals:basalt" }
}
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbo_modded_elem:calcium_powder 9",
    items = { "sbo_crystals:calcite" }
}
