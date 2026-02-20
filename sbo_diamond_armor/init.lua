-- Armor

local armor_types_to_names = {
    head = "Helmet",
    legs = "Leggings",
    feet = "Boots",
    torso = "Chestplate"
}
for armor_type, armor_name in pairs(armor_types_to_names) do
    sbz_api.armor.register("sbo_diamond_armor:" .. armor_name:lower(), {
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
local mal = "sbo_resium:circuit"
minetest.register_craft({
    output = "sbo_diamond_armor:helmet",
    recipe = {
        { mat, mat, mat },
        { mat, "sbo_resium_armor:resium_helmet", mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond_armor:chestplate",
    recipe = {
        { mat, "sbo_resium_armor:resium_chestplate", mat },
        { mat, mat, mat },
        { mat, mat, mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond_armor:leggings",
    recipe = {
        { mat, mat, mat },
        { mat, "sbo_resium_armor:resium_leggings", mat },
        { mat, "",  mat }
    }
})

minetest.register_craft({
    output = "sbo_diamond_armor:boots",
    recipe = {
        { mat, "sbo_resium_armor:resium_boots", mat },
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
