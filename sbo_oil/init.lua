minetest.register_craftitem("sbo_oil:oil", {
    description = "Oil" .. minetest.colorize("#777", "\n\nRemoves 5 hunger"),
    inventory_image = "oil.png",
    on_use = hbhunger.item_eat(-5),
    stack_max = 256,
})
hbhunger.register_food("sbo_oil:oil", -5)
unified_inventory.add_category_item('food', "sbo_oil:oil")

sbz_api.recipe.register_craft {
    output = 'sbo_oil:oil',
    items = { 'sbo_atomic:hydrogen 27', 'sbo_atomic:phosphorus 24', "sbo_atomic:oxygen 16", "sbo_atomic:carbon 32" },
    type = 'atomic',
}
sbo_api.quests.in_inven["sbo_oil:oil"] = "Oil"
sbo_api.quests.register_to("Questline: Atomic",{
        type = "quest",
        title = "Oil",
        text = [[It is a crafting ingredient, often considered a lubricant.]],
        requires = {"Automation", "Atomic Reconstructor"}
})
