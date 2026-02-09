sbz_api.register_element("cuti", "#814f2f", "Copper Titanium %s (CuTi)", { disabled = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_cuti:")
sbz_api.recipe.register_craft {
    output = 'sbo_cuti:cuti_powder',
    items = { 'sbz_chem:copper_powder',
     'sbz_chem:titanium_powder' },
    type = 'alloying',
}
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    title = "Copper Titanium",
    info = true,
    text =
        [[Adds alloy Copper Titanium, made from copper and titanium in a alloy smelter]],
})
