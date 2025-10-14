minetest.register_node("sbo_bookshelf:bookshelf", {
    description = "Bookshelf",
    tiles = {
        "colorium_planks.png",
        "colorium_planks.png",
        "bookshelf.png",
    },
    groups = { matter = 1, },
    walkable = true,
})
minetest.register_craft({
    output = "sbo_bookshelf:bookshelf",
    recipe = {
        { "sbz_bio:colorium_planks", "sbz_bio:colorium_planks", "sbz_bio:colorium_planks" },
        { "sbz_bio:book",            "sbz_bio:book",            "sbz_bio:book" },
        { "sbz_bio:colorium_planks", "sbz_bio:colorium_planks", "sbz_bio:colorium_planks" }
    }
})
