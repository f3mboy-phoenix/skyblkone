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

sbo_api.register_wiki_page({
    type = "quest",
    info = true,
    title = "Resium Glass",
    text = [[
Just another kind of glass.
They are made with:
    4 Resium crystals
    4 Antimatter dust]],
})
color = "#63BD63"
stairs.register("sbo_resium_glass:resium_glass", {
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
