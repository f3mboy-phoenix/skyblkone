minetest.register_tool("sbo_diamond_plated_drill:drill", {
    description = "Diamond Plated Resium Drill",
    inventory_image = "dresium_tool.png",
    groups = {
        core_drop_multi = 50,
        resium = 1,
        can_mine_resium = 1
    },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        damage_groups = { matter = 1, antimatter = 1 },
        max_drop_level = 1,
        groupcaps = {
            matter = {
                times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
                uses = 500 * 3 * 3 * 3,
                leveldiff = 2,
                maxlevel = 2
            },
            antimatter = {
                times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
                uses = 500 * 3 * 3 * 3,
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
        { "sbo_diamond:diamond",         "sbz_resources:robotic_arm",       "sbo_diamond:diamond" },
        { "sbo_diamond:diamond",         "sbo_resium_tools:drill",             "sbo_diamond:diamond" },
        { "sbz_resources:reinforced_antimatter", "sbo_colorium_circuit:colorium_circuit", "sbz_resources:reinforced_antimatter" }
    },
    output = "sbo_diamond_plated_drill:drill"
}
