minetest.register_tool("sbo_resium_tools:drill", {
    description = "Resium Drill",
    inventory_image = "resium_tool.png",
    groups = {
        core_drop_multi = 25,
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
                times = { [1] = 1.50 / 2, [2] = 0.30 / 2, [3] = 0.10 / 2 },
                uses = 500 * 3 * 3,
                leveldiff = 2,
                maxlevel = 2
            },
            antimatter = {
                times = { [1] = 1.50 / 2, [2] = 0.30 / 2, [3] = 0.10 / 2 },
                uses = 500 * 3 * 3,
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
        { "sbo_resitrex:resitrex_ingot",   "sbz_resources:robotic_arm", "sbo_resitrex:resitrex_ingot" },
        { "sbo_resitrex:resitrex_ingot",   "sbo_extrosim_drill:drill",  "sbo_resitrex:resitrex_ingot" },
        { "sbz_resources:phlogiston_blob", "sbo_resium:circuit",        "sbz_resources:phlogiston_blob" }
    },
    output = "sbo_resium_tools:drill"
}
sbo_api.register_wiki_page({
    info = true,
    title = "Resium Drill",
    text = [[
A Drill made out of Resium can repair itself. It has 4500 uses.
It also has 25x core drops.
]],
})
