minetest.register_craftitem("sbo_diamond:diamond", {
    description = "Diamond",
    inventory_image = "diamond.png",
    stack_max = 256,
})
sbz_api.recipe.register_craft {
    output = 'sbo_diamond:diamond',
    items = { 'sbo_atomic:carbon 15', 'sbo_atomic:gallium' },
    type = 'atomic',
}
