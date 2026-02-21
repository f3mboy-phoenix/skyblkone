minetest.register_craftitem("sbo_oil:oil", {
    description = "Oil",
    inventory_image = "oil.png",
    stack_max = 256,
})
sbz_api.recipe.register_craft {
    output = 'sbo_oil:oil',
    items = { 'sbo_atomic:hydrogen 68', 'sbo_atomic:phosphorus 24', "sbo_atomic:oxygen 16", "sbo_atomic:carbon 75" },
    type = 'atomic',
}
sbo_api.quests.on_craft["sbo_oil:oil"] = "Oil"
sbo_api.quests.register_to("Questline: Atomic",{
        type = "quest",
        title = "Oil",
        text = [[It is a crafting ingredient, often considered a lubricant.]],
        requires = {"Automation", "Atomic Reconstructor"}
})
