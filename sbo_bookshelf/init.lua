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
sbo_api.quests.on_craft["sbo_bookshelf:bookshelf"] = "Bookshelf"
sbo_api.quests.register_to("Questline: Decorator",{
    type = "quest",
    title = "Bookshelf",
    text =
        [[Decoration bookshelf.]],
    requires = { "Getting Wood", }
})
