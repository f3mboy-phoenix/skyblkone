-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani:matter_annihilator", {
    description = "Super Matter Annihilator",
    inventory_image = "compmatter_annihilator.png", -- Replace with your own image file

    groups = { core_drop_multi = 9 },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        max_drop_level = 1,
        groupcaps = {
            matter = { times = { [1] = 0.3, [2] = 0.1, [3] = 0.09 }, uses = 9000, maxlevel = 1 },
            antimatter = { times = { [1] = 3.00, [2] = 1.60, [3] = 0.90 }, uses = 10, maxlevel = 1 },
        },
    },

    sound = {
        punch_use = {
            name = "block_annihilated",
            gain = 1.0,
        }
    },
})
minetest.register_craft({
    output = "sbo_comp_ani:matter_annihilator",
    recipe = {
        { "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator" },
        { "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator" },
        { "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator" }
    }
})
