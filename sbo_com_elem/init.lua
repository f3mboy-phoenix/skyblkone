local craft = "centrifuging"
if sbz_api.recipe.registered_craft_types.centrifugeing then
	craft = "centrifugeing"
end

sbz_api.recipe.register_craft {
    output = "sbz_chem:silicon_powder 2",
    type = craft,
    chance = 75,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbz_chem:gold_powder",
    type = craft,
    chance = 30,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbz_resources:white_sand",
    type = craft,
    items = {
        "sbz_resources:sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbz_resources:dark_sand",
    type = craft,
    items = {
        "sbz_resources:white_sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbz_chem:silver_powder",
    chance = 20,
    type = craft,
    items = {
        "sbz_resources:white_sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbz_resources:black_sand",
    type = craft,
    items = {
        "sbz_resources:dark_sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbz_chem:silver_powder",
    chance = 10,
    type = craft,
    items = {
        "sbz_resources:dark_sand"
    }
}

sbz_api.recipe.register_craft {
    output = "sbz_chem:cobalt_powder",
    chance = 30,
    type = craft,
    items = {
        "sbz_resources:gravel"
    }
}
sbz_api.recipe.register_craft {
    output = "sbz_chem:lithium_powder",
    chance = 30,
    type = craft,
    items = {
        "sbz_resources:gravel"
    }
}
sbz_api.recipe.register_craft {
    output = "sbz_chem:titanium_powder",
    chance = 30,
    type = craft,
    items = {
        "sbz_resources:gravel"
    }
}
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    title = "Common Elements",
    info = true,
    text =
        [[Makes elements from centrifugeing more common, disable for default.]],
})
