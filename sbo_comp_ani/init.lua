-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani:annihilator2x", {
    description = "Super Matter Annihilator",
    inventory_image = "compmatter_annihilator2x.png",

    groups = { core_drop_multi = 3 },
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
    output = "sbo_comp_ani:annihilator2x",
    recipe = {
        { "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator" },
        { "sbz_resources:matter_annihilator", "sbz_resources:emittrium_circuit", "sbz_resources:matter_annihilator" },
        { "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator", "sbz_resources:matter_annihilator" }
    }
})

sbo_api.quests.on_craft["sbo_comp_ani:annihilator2x"] = "Super Annihilator"
sbo_api.quests.register_to("Questline: Secrets",{
        type = "secret",
        title = "Super Annihilator",
        text = [[Super Annihilators give 3x core drops and are made from 8 Matter Annihilators and an Emittrium Circuit]],
})
core.register_alias("sbo_comp_ani:matter_annihilator", "sbo_comp_ani:annihilator2x")

-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani:annihilator3x", {
    description = "Super Super Matter Annihilator",
    inventory_image = "compmatter_annihilator3x.png",

    groups = { core_drop_multi = 9 },
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
    output = "sbo_comp_ani:annihilator3x",
    recipe = {
        { "sbo_comp_ani:annihilator2x", "sbo_comp_ani:annihilator2x",            "sbo_comp_ani:annihilator2x" },
        { "sbo_comp_ani:annihilator2x", "sbo_extrosim_circuit:extrosim_circuit", "sbo_comp_ani:annihilator2x" },
        { "sbo_comp_ani:annihilator2x", "sbo_comp_ani:annihilator2x",            "sbo_comp_ani:annihilator2x" }
    }
})

sbo_api.quests.on_craft["sbo_comp_ani:annihilator3x"] = "Super Super Annihilator"
sbo_api.quests.register_to("Questline: Secrets",{
        type = "secret",
        title = "Super Super Annihilator",
        text = [[Super super annihilators give 9x core drops, and are made from 8 Super Annihilators and an Extrosim Circuit]],
})
core.register_alias("sbo_comp_ani_2x:matter_annihilator", "sbo_comp_ani:annihilator3x")


-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani:annihilator4x", {
    description = "Super Super Dupper Matter Annihilator",
    inventory_image = "compmatter_annihilator4x.png",

    groups = { core_drop_multi = 27 },

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
    output = "sbo_comp_ani:annihilator4x",
    recipe = {
        { "sbo_comp_ani:annihilator3x", "sbo_comp_ani:annihilator3x", "sbo_comp_ani:annihilator3x" },
        { "sbo_comp_ani:annihilator3x", "sbo_resium:circuit",         "sbo_comp_ani:annihilator3x" },
        { "sbo_comp_ani:annihilator3x", "sbo_comp_ani:annihilator3x", "sbo_comp_ani:annihilator3x" }
    }
})

sbo_api.quests.on_craft["sbo_comp_ani:annihilator4x"] = "Super Super Dupper Annihilator"
sbo_api.quests.register_to("Questline: Secrets",{
        type = "secret",
        title = "Super Super Dupper Annihilator",
        text = [[Super super dupper annihilators give 27x core drops, and are made from 8 Super Super Annihilators and a Resium Circuit]],
})

-- Define a new pickaxe
minetest.register_tool("sbo_comp_ani:annihilator5x", {
    description = "Super Super Uuper Dupper Matter Annihilator",
    inventory_image = "compmatter_annihilator5x.png",

    groups = { core_drop_multi = 81 },

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
    output = "sbo_comp_ani:annihilator5x",
    recipe = {
        { "sbo_comp_ani:annihilator4x", "sbo_comp_ani:annihilator4x", "sbo_comp_ani:annihilator4x" },
        { "sbo_comp_ani:annihilator4x", "sbo_crystals:circuit",         "sbo_comp_ani:annihilator4x" },
        { "sbo_comp_ani:annihilator4x", "sbo_comp_ani:annihilator4x", "sbo_comp_ani:annihilator4x" }
    }
})

sbo_api.quests.on_craft["sbo_comp_ani:annihilator3x"] = "Super Super Duper Annihilator"
sbo_api.quests.register_to("Questline: Secrets",{
        type = "secret",
        title = "Super Super Duper Annihilator",
        text = [[Super super duper annihilators give 27x core drops, and are made from 8 Super Super Annihilators and a Resium Circuit]],
})
