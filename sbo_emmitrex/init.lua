sbz_api.recipe.register_craft {
    output = 'sbo_emmitrex:emmitrex_powder',
    items = { 'sbz_resources:raw_emittrium', 'sbo_modded_elem:mercury_powder' },
    type = 'alloying',
}

sbz_api.register_element("emmitrex", "#380038", "Emmitrex %s",
    { part_of_enhanced_drops = false, part_of_crusher_drops = false }, "sbo_emmitrex:")

sbo_api.register_wiki_page({
    type = "quest",
    title = "Emmitrex",
    text = [[Emmitrex is a high end Emittrium Crafting Recipe.
Crafted using the Alloy Furnace, Requires 4 Raw Emittrium and 2 Mercury Powder
]],
})
