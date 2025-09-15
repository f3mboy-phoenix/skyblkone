sbz_api.register_modded_element("chromium", "#e3e3e3", "Chromium %s (Cr)", {part_of_enhanced_drops = true }, "sbo_chromium:")
--sbo_chromium:chromium
unified_inventory.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance = 100,
    items = {
        "sbz_resources:sand"
    }
}

unified_inventory.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance =50,
    items = {
        "sbz_resources:white_sand"
    }
}
unified_inventory.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance = 25,
    items = {
        "sbz_resources:dark_sand"
    }
}
