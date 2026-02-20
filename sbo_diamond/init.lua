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
sbo_api.quests.in_inven["sbo_diamond:diamond"] = "Diamonds"
sbo_api.quests.register_to("Questline: Atomic",{
    type = "quest",
    title = "Diamonds",
    text =
        [[Diamonds are made in the atomic recontructor from carbon while using gallium as a catalyst]],
    requires = { "Atomic Reconstructor", }
})
