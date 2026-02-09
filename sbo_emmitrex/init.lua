sbz_api.recipe.register_craft {
    output = 'sbo_emmitrex:emmitrex_powder',
    items = { 'sbz_resources:raw_emittrium', 'sbo_modded_elem:mercury_powder' },
    type = 'alloying',
}

sbz_api.register_element("emmitrex", "#380038", "Emmitrex %s",
    { part_of_enhanced_drops = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_emmitrex:")

sbo_api.quests.in_inven["sbo_emmitrex:emmitrex_powder"] = "Emmitrex"
sbo_api.quests.register_to("Questline: Emittrium",{
    type = "quest",
    title = "Emmitrex",
    text = [[Emmitrex is a high end Emittrium Crafting Ingredient.
Crafted using the Alloy Furnace, Requires 4 Raw Emittrium and 2 Mercury Powder
]],
    requires = { "Simple Alloy Furnace", }
})
