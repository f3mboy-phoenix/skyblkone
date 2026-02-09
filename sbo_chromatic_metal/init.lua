sbz_api.register_element("cuticr", "#814f2f", "Chromatic Metal %s (CuTiCr)", { disabled = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_chromatic_metal:")
    sbz_api.recipe.register_craft {
        output = "sbo_chromatic_metal:cuticr_ingot 2",
        type = "blast_furnace",
        items = {
            "sbz_chem:copper_powder 2",
            "sbz_chem:titanium_powder 4",
            "sbo_chromium:chromium_powder 12"
        },
    }
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    title = "Chromatic Metal",
    info = true,
    text =
        [[Adds the alloy Chromatic metal made from copper titanium and chromium]],
})
