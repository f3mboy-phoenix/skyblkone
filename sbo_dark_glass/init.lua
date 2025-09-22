minetest.register_node("sbo_dark_glass:dark_glass", {
    description = "Dark Glass",
    drawtype = "glasslike_framed_optional",
    tiles = { "dark_glass.png", "dark_glass_shine.png" },
    use_texture_alpha = "clip",
    paramtype = "light",
    sunlight_propagates = true,
    groups = { matter = 1, transparent = 1 },
    sounds = sbz_api.sounds.glass(),
})

minetest.register_craft({
    output = "sbo_dark_glass:dark_glass 16",
    recipe = {
        { "sbz_resources:black_sand",   "sbz_resources:antimatter_dust", "sbz_resources:black_sand" },
        { "sbz_resources:antimatter_dust", "",                              "sbz_resources:antimatter_dust" },
        { "sbz_resources:black_sand",   "sbz_resources:antimatter_dust", "sbz_resources:black_sand" }
    }
})

sbz_api.achievment_table["sbo_dark_glass:dark_glass"] = "Dark Glass"
sbz_api.register_quest_to("Questline: Decorator",{
        type = "quest",
        title = "Dark Glass",
        text = "Dark Glass looks cool for Glass",
        requires = { "Centrifuge" }
})

