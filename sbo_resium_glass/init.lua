minetest.register_node("sbo_resium_glass:resium_glass", {
    description = "Resium Glass",
    drawtype = "glasslike_framed_optional",
    tiles = { "resium_glass.png", "resium_glass_shine.png" },
    use_texture_alpha = "clip",
    paramtype = "light",
    sunlight_propagates = true,
    groups = { matter = 1, transparent = 1 },
    sounds = sbz_api.sounds.glass(),
})

minetest.register_craft({
    output = "sbo_resium_glass:resium_glass 16",
    recipe = {
        { "sbo_resium:crystal",            "sbz_resources:antimatter_dust", "sbo_resium:crystal" },
        { "sbz_resources:antimatter_dust", "",                              "sbz_resources:antimatter_dust" },
        { "sbo_resium:crystal",            "sbz_resources:antimatter_dust", "sbo_resium:crystal" }
    }
})

sbz_api.achievment_table["sbo_resium_glass:resium_glass"] = "Resium Glass"
sbz_api.register_quest_to("Questline: Resium",{
        type = "quest",
        title = "Resium Glass",
        text = "Resium Glass?",
        requires = { "Obtain Resium" }
})

