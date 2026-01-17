sbz_api.recipe.register_craft {
    output = 'sbo_resitrex:resitrex_powder',
    items = { 'sbo_resium:crystal', 'sbo_chromatic_metal:cuticr_ingot' },
    type = 'atomic',
}

sbz_api.register_element("resitrex", "#7AE051", "Resitrex %s",
    { part_of_enhanced_drops = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_resitrex:")

sbo_api.register_wiki_page({
    type = "quest",
    title = "Resitrex",
    text = [[Resitrex is a high end Resium Crafting Recipe.
Crafted using the Alloy Furnace, Requires 4 Resium Crystals and 2 Chromatic Metal Ingots
]],
})
