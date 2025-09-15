minetest.register_craftitem("sbo_wood:stick", {
    description = "Stick",
    inventory_image = "stick.png",
    stack_max = 256,
})
minetest.register_craft({
    output = "sbo_wood:stick 4",
    recipe = {
        { "", "", "" },
        { "", "sbz_bio:colorium_planks", "" },
        { "", "sbz_bio:colorium_planks", "" }
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "sbz_bio:colorium_planks 4",
    recipe = { "sbz_bio:colorium_tree_core" }
})

