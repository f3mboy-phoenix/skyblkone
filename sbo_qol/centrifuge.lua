local craft = "centrifuging"
if sbz_api.recipe.registered_craft_types.centrifugeing then
	craft = "centrifugeing"
end

unified_inventory.register_craft {
    output = "sbz_chem:iron_powder",
    type = craft,
    chance = 10, -- 10%
    items = {
        "sbz_resources:red_sand"
    }
}

unified_inventory.register_craft {
    output = "sbz_chem:iron_powder",
    type = craft,
    chance = 10, -- 10%
    items = {
        "sbz_resources:red_sand_nofall"
    }
}

unified_inventory.register_craft {
    output = "sbz_resources:white_sand",
    type = craft,
    items = {
        "sbz_resources:red_sand"
    }
}

unified_inventory.register_craft {
    output = "sbz_resources:white_sand",
    type = craft,
    items = {
        "sbz_resources:red_sand_nofall"
    }
}

unified_inventory.register_craft {
    output = "sbz_chem:gold_powder",
    type = craft,
    chance = 10, -- 10%
    items = {
        "sbz_resources:sand_nofall"
    }
}

unified_inventory.register_craft {
    output = "sbz_resources:white_sand",
    type = craft,
    items = {
        "sbz_resources:sand_nofall"
    }
}

unified_inventory.register_craft {
    output = "sbz_chem:iron_powder",
    type = craft,
    chance = 1, -- 1%
    items = {
        "sbz_resources:dark_sand_nofall"
    }
}

unified_inventory.register_craft {
    output = "sbz_resources:black_sand",
    type = craft,
    items = {
        "sbz_resources:dark_sand_nofall"
    }
}
