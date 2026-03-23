minetest.register_craftitem("sbo_diamond:diamond", {
    description = "Diamond",
    inventory_image = "diamond.png",
    stack_max = 256,
})
sbz_api.recipe.register_craft {
    output = 'sbo_diamond:diamond',
    items = { 'sbo_atomic:carbon 15', 'sbo_atomic:gallium' },
    type = 'atomic',
}
sbo_api.quests.in_inven["sbo_diamond:diamond"] = "DIAMONDS!!"
sbo_api.quests.register_to("Questline: Atomic",{
    type = "quest",
    title = "DIAMONDS!!",
    text =
        [[Diamonds are made in the atomic recontructor from carbon while using gallium as a catalyst]],
    requires = { "Atomic Reconstructor", }
})
minetest.register_tool("sbo_diamond:drill", {
    description = "Diamond Plated Resium Drill",
    inventory_image = "dresium_tool.png",
    groups = {
        core_drop_multi = 48,
        resium = 1,
        can_mine_resium = 1,
        can_mine_extrosim = 1,
    },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        damage_groups = { matter = 1, antimatter = 1 },
        max_drop_level = 1,
        groupcaps = {
            matter = {
                times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
                uses = 0,
                leveldiff = 2,
                maxlevel = 2
            },
            antimatter = {
                times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
                uses = 0,
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
        { "sbo_diamond:diamond",         "sbo_resitrex:drill",             "sbo_diamond:diamond" },
        { "sbz_resources:reinforced_antimatter", "sbo_colorium_circuit:colorium_circuit", "sbz_resources:reinforced_antimatter" }
    },
    output = "sbo_diamond:drill"
}
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    title = "Diamond Drill",
    info = true,
    text =
        [[Adds Diamond Plated Resium drill, infinite duribility and 48x core drops]],
})
-- Armor

local armor_types_to_names = {
    head = "Helmet",
    legs = "Leggings",
    feet = "Boots",
    torso = "Chestplate"
}
for armor_type, armor_name in pairs(armor_types_to_names) do
    sbz_api.armor.register("sbo_diamond:" .. armor_name:lower(), {
        description = "Diamond Plated Resium " .. armor_name,
        armor_type = armor_type,
        inventory_image = ("(armor_%s_inv.png^[multiply:%s)"):format(armor_name:lower(), "#4BA57F"),
        armor_texture = ("(armor_%s_body.png^[multiply:%s)"):format(armor_name:lower(), "#4BA57F"),
        armor_groups = function(player, stack)
            if stack:get_wear() == 65535 then
                return {}
            end
            return sbz_api.armor.recipes.get_protection({
                matter = 95,
                antimatter = 95,
                light = 100,
                strange = 100,
            }, armor_name:lower())
        end,
        custom_wear = false,
        -- 0.5 power/damage resisted
        durability = 16000, -- 16000 damage that can be handled by this armor, not used
    })
end
local mat = "sbo_diamond:diamond"

minetest.register_craft({
    output = "sbo_diamond:helmet",
    recipe = {
        { mat, mat, mat },
        { mat, "sbo_resitrex:helmet", mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond:chestplate",
    recipe = {
        { mat, "sbo_resitrex:chestplate", mat },
        { mat, mat, mat },
        { mat, mat, mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond:leggings",
    recipe = {
        { mat, mat, mat },
        { mat, "sbo_resitrex:leggings", mat },
        { mat, "",  mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond:boots",
    recipe = {
        { mat, "sbo_resitrex:boots", mat },
        { mat, "",  mat }
    }
})
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Diamond Armor",
    text =
        [[Adds Diamond Plated Resium Armor, making you immune to lasers, strange matter, and 95% of everything else]],
})

core.register_alias("sbo_diamond_armor:helmet", "sbo_diamond:helmet")
core.register_alias("sbo_diamond_armor:chestplate", "sbo_diamond:chestplate")
core.register_alias("sbo_diamond_armor:leggings", "sbo_diamond:leggings")
core.register_alias("sbo_diamond_armor:boots", "sbo_diamond:boots")
core.register_alias("sbo_diamond_plated_drill:drill", "sbo_diamond:drill")
