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
        { "sbz_resources:black_sand",      "sbz_resources:antimatter_dust", "sbz_resources:black_sand" },
        { "sbz_resources:antimatter_dust", "",                              "sbz_resources:antimatter_dust" },
        { "sbz_resources:black_sand",      "sbz_resources:antimatter_dust", "sbz_resources:black_sand" }
    }
})

sbo_api.quests.on_craft["sbo_dark_glass:dark_glass"] = "Dark Glass"
sbo_api.quests.register_to("Questline: Decorator",{
        type = "quest",
        title = "Dark Glass",
        text = [[
Just another kind of glass.
They are made with:
    4 Black sand
    4 Antimatter dust]],
        requires = { "Centrifuge" }
})
