sbz_api.recipe.register_craft {
    output = 'sbo_resitrex:resitrex_powder',
    items = { 'sbo_resium:crystal', 'sbo_chromatic_metal:cuticr_ingot' },
    type = 'atomic',
}

sbz_api.register_element("resitrex", "#7AE051", "Resitrex %s",
    { part_of_enhanced_drops = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_resitrex:")

sbo_api.quests.on_craft["sbo_resitrex:resitrex_powder"] = "Resitrex"
sbo_api.quests.register_to("Questline: Resium",{
    type = "quest",
    title = "Resitrex",
    text =
        [[Resitrex is a high end Resium Crafting Recipe.
Crafted using the Atomic Reconstructor, Requires 4 Resium Crystals and 2 Chromatic Meectal Ingots
]],
    requires = { "Automation", "Atomic Reconstructor", "Obtain Resium" }
})
