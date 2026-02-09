-- disabled tech
sbz_api.register_element("zinc", "#7F7F7F", "Zinc %s (Zn)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("platinum", "#E5E4E2", "Platinum %s (Pt)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("mercury", "#B5B5B5", "Mercury %s (Hg)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("magnesium", "#DADADA", "Magnesium %s (Mg)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("calcium", "#F5F5DC", "Calcium %s (Ca)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("sodium", "#F4F4F4", "Sodium %s (Na)", { disabled = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:zinc_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:platinum_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:mercury_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:magnesium_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:calcium_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}
sbz_api.recipe.register_craft {
    output = "sbo_modded_elem:sodium_powder ",
    type = "centrifugeing",
    chance = 5,
    items = {
        "sbz_resources:sand"
    }
}


-- disabled alloys
sbz_api.register_element("white_gold", "#E5E4E2", "White Gold %s (AuNi)",
    { disabled = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_modded_elem:")
sbz_api.register_element("brass", "#B5A642", "Brass %s (CuZn)", { disabled = false, part_of_crusher_drops = false, fluid = 1 },
    "sbo_modded_elem:")
sbz_api.recipe.register_craft {
    output = 'sbo_modded_elem:white_gold_powder',
    items = { 'sbz_chem:gold_powder', 'sbz_chem:nickel_powder' },
    type = 'alloying',
}
sbz_api.recipe.register_craft {
    output = 'sbo_modded_elem:brass_powder',
    items = { 'sbz_chem:copper_powder', 'sbo_modded_elem:zinc_powder' },
    type = 'alloying',
}

minetest.register_on_mods_loaded(function()
for source, fluid_cell in pairs(sbz_api.sources2fluid_cells) do
    local def = core.registered_items[fluid_cell]
    local item = ItemStack(def.cooled_form)

    local source_stack = ItemStack(def.liquid_form)
    source_stack:get_meta():set_string("count_meta", "1kL")

    sbz_api.recipe.register_craft {
        type = "melting",
        output = source_stack,
        items = { item }
    }

    sbz_api.recipe.register_craft {
        type = "cooling",
        output = item,
        items = { source_stack }
    }
end
end)
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Modded Elements",
    text =
        [[Enables Disabled Elements so mods can use them]],
})
