sbz_api.register_modded_element("cuticr", "#814f2f", "Chromatic Metal %s (CuTiCr)", { disabled = false, part_of_crusher_drops = false }, "sbo_chromatic_metal:")
    unified_inventory.register_craft {
        output = "sbo_chromatic_metal:cuticr_ingot 2",
        type = "blast_furnace",
        items = {
            "sbz_chem:copper_powder 2",
            "sbz_chem:titanium_powder 4",
            "sbo_chromium:chromium_powder 12"
        },
    }

    sbz_api.blast_furnace_recipes[#sbz_api.blast_furnace_recipes + 1] = {
        recipe = {
            "sbz_chem:copper_powder 2",
            "sbz_chem:titanium_powder 4",
            "sbo_chromium:chromium_powder 12"
        },
        names = {
            "sbz_chem:copper_powder",
            "sbz_chem:titanium_powder",
            "sbo_chromium:chromium_powder"
        },
        output = "sbo_chromatic_metal:cuticr_ingot 2",
        chance = 1 / (9 * 2)
    }
