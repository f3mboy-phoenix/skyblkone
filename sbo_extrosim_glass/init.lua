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
        { "sbo_extrosim:raw_extrosim",     "sbz_resources:antimatter_dust", "sbo_extrosim:raw_extrosim" },
        { "sbz_resources:antimatter_dust", "",                              "sbz_resources:antimatter_dust" },
        { "sbo_extrosim:raw_extrosim",     "sbz_resources:antimatter_dust", "sbo_extrosim:raw_extrosim" }
    }
})

color = "#C88D60"
stairs.register("sbo_extrosim_glass:extrosim_glass", {
	tiles = {
		"block_frame.png^[colorize:" .. color .. ":200",
        "block_frame.png^[colorize:" .. color .. ":200",
        "block_frame.png^[colorize:" .. color .. ":200",
        "block_frame.png^[colorize:" .. color .. ":200",
        "block_frame.png^[colorize:" .. color .. ":200",
        "block_frame.png^[colorize:" .. color .. ":200",
    },
    tex = {
        stair_front = "block_stair_front.png^[colorize:" .. color .. ":200",
        stair_side =  "block_stair_side.png^[colorize:" .. color .. ":200",
        stair_cross = "block_stair_cross.png^[colorize:" .. color .. ":200",
    }
})
sbo_api.quests.on_craft["sbo_extrosim_glass:extrosim_glass"] = "Extrosim Glass"
sbo_api.quests.register_to("Questline: Extrosim",{
        type = "quest",
        title = "Extrosim Glass",
        text = [[
Just another kind of glass.
They are made with:
    4 Extrosim crystals
    4 Antimatter dust]],
        requires = { "Obtain Extrosim" }
})
