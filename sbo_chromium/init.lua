sbz_api.register_element("chromium", "#e3e3e3", "Chromium %s (Cr)", {part_of_enhanced_drops = true, fluid = 1 }, "sbo_chromium:")
--sbo_chromium:chromium
sbz_api.recipe.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance = 100,
    items = {
        "sbz_resources:sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance =50,
    items = {
        "sbz_resources:white_sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_chromium:chromium_powder",
    type = "centrifugeing",
    chance = 25,
    items = {
        "sbz_resources:dark_sand"
    }
}
