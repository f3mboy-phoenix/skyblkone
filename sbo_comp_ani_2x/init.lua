-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani_2x:matter_annihilator", {
    description = "Super Super Matter Annihilator",
    inventory_image = "compmatter_annihilator2.png",

    groups = { core_drop_multi = 18 },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        max_drop_level = 1,
        groupcaps = {
            matter = { times = { [1] = 0.3, [2] = 0.1, [3] = 0.09 }, uses = 9000, maxlevel = 1 },
            --antimatter = { times = { [1] = 3.00, [2] = 1.60, [3] = 0.90 }, uses = 10, maxlevel = 1 },
        },
    },

    sound = {
        punch_use = {
            name = "block_annihilated",
            gain = 1,
        }
    },
})
minetest.register_craft({
    output = "sbo_comp_ani_2x:matter_annihilator",
    recipe = {
        { "sbo_comp_ani:matter_annihilator", "sbo_comp_ani:matter_annihilator", "sbo_comp_ani:matter_annihilator" },
        { "sbo_comp_ani:matter_annihilator", "sbz_resources:emittrium_circuit", "sbo_comp_ani:matter_annihilator" },
        { "sbo_comp_ani:matter_annihilator", "sbo_comp_ani:matter_annihilator", "sbo_comp_ani:matter_annihilator" }
    }
})

sbo_api.quests.on_craft["sbo_comp_ani:matter_annihilator"] = "Super Super Annihilator"
sbo_api.quests.register_to("Questline: Secrets",{
        type = "secret",
        title = "Super Super Annihilator",
        text = [[Super super annihilators give 72x core drops, and are made from 9 Super Annihilators]],
})
