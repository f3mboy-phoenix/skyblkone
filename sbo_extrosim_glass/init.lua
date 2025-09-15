minetest.register_node("sbo_extrosim_glass:extrosim_glass", {
    description = "Extrosim Glass",
    drawtype = "glasslike_framed_optional",
    tiles = { "extrosim_glass.png", "extrosim_glass_shine.png" },
    use_texture_alpha = "clip",
    paramtype = "light",
    sunlight_propagates = true,
    groups = { matter = 1, transparent = 1 },
    sounds = sbz_api.sounds.glass(),
})

minetest.register_craft({
    output = "sbo_extrosim_glass:extrosim_glass 16",
    recipe = {
        { "sbo_extrosim:raw_extrosim",   "sbz_resources:antimatter_dust", "sbo_extrosim:raw_extrosim" },
        { "sbz_resources:antimatter_dust", "",                              "sbz_resources:antimatter_dust" },
        { "sbo_extrosim:raw_extrosim",   "sbz_resources:antimatter_dust", "sbo_extrosim:raw_extrosim" }
    }
})

sbz_api.achievment_table["sbo_extrosim_glass:extrosim_glass"] = "Extrosim Glass"
sbz_api.register_quest_to("Questline: Extrosim",{
        type = "quest",
        title = "Extrosim Glass",
        text = "Extrosim Glass?",
        requires = { "Obtain Extrosim" }
})

