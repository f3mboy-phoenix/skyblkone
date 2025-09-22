sbz_api.register_element("cuticr", "#814f2f", "Chromatic Metal %s (CuTiCr)", { disabled = false, part_of_crusher_drops = false }, "sbo_chromatic_metal:")
    sbz_api.recipe.register_craft {
        output = "sbo_chromatic_metal:cuticr_ingot 2",
        type = "blast_furnace",
        items = {
            "sbz_chem:copper_powder 2",
            "sbz_chem:titanium_powder 4",
            "sbo_chromium:chromium_powder 12"
        },
    }
