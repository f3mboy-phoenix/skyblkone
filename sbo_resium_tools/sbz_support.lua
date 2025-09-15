minetest.register_tool("sbo_resium_tools:drill", {
    description = "Resium Drill",
    inventory_image = "resium_tool.png",
    groups = { core_drop_multi = 2 },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        damage_groups = { matter = 1, antimatter = 1 },
        max_drop_level = 1,
        groupcaps = {
            matter = { 
                times = { [1] = 1.50 / 2, [2] = 0.30 / 2, [3] = 0.10 / 2 },
                uses = 60,
                leveldiff = 2, 
                maxlevel = 2
            },
            antimatter = { 
                times = { [1] = 1.50 / 2, [2] = 0.30 / 2, [3] = 0.10 / 2 },
                uses = 60,
                leveldiff = 2, 
                maxlevel = 2
            },
        },
    },

    sound = {
        punch_use = {
            name = "drill_dig",
            gain = 1,
        }
    }
})


minetest.register_craft {
    recipe = {
        { "sbz_chem:titanium_ingot",         "sbz_resources:robotic_arm",       "sbz_chem:titanium_ingot" },
        { "sbz_chem:titanium_ingot",         "sbz_power:battery",               "sbz_chem:titanium_ingot" },
        { "sbz_resources:reinforced_matter", "sbo_resium:circuit", "sbz_resources:reinforced_matter" }
    },
    output = "sbo_resium_tools:drill"
}
