minetest.register_node("sbo_rein_colorium:reinforced_colorium", {
    description = "Reinforced Colorium",
    drawtype = "glasslike",
    tiles = { "reinforced_colorium.png" },
    groups = { matter = 1, },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 10,
    walkable = true,
})
minetest.register_craft({
    output = "sbo_rein_colorium:reinforced_colorium",
    recipe = {
        { "",                                  "sbo_colorium_plate:colorium_plate", "" },
        { "sbo_colorium_plate:colorium_plate", "unifieddyes:colorium_blob",         "sbo_colorium_plate:colorium_plate" },
        { "",                                  "sbo_colorium_plate:colorium_plate", "" }
    }
})
