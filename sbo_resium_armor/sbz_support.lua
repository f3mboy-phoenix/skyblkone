-- Armor

local armor_types_to_names = {
    head = "Helmet",
    legs = "Leggings",
    feet = "Boots",
    torso = "Chestplate"
}
for armor_type, armor_name in pairs(armor_types_to_names) do
    sbz_api.armor.register("sbo_resium_armor:resium_" .. armor_name:lower(), {
        description = "Resium " .. armor_name,
        armor_type = armor_type,
        inventory_image = ("(armor_%s_inv.png^[multiply:%s)"):format(armor_name:lower(), "#5BA54B"),
        armor_texture = ("(armor_%s_body.png^[multiply:%s)"):format(armor_name:lower(), "#5BA54B"),
        armor_groups = function(player, stack)
            if stack:get_wear() == 65535 then
                return {}
            end
            return sbz_api.armor.recipes.get_protection({
                matter = 85,
                antimatter = 85,
                light = 100,
                strange = 100,
            }, armor_name:lower())
        end,
        custom_wear = false,
        -- 0.5 power/damage resisted
        durability = 16000, -- 16000 damage that can be handled by this armor, not used
    })
end
local mat = "sbo_resium:crystal"
local mal = "sbo_resium:circuit"
minetest.register_craft({
    output = "sbo_resium_armor:resium_helmet",
    recipe = {
        { mat, mat, mat },
        { mat, mal, mat }
    }
})

minetest.register_craft({
    output = "sbo_resium_armor:resium_chestplate",
    recipe = {
        { mat, mal, mat },
        { mat, mat, mat },
        { mat, mat, mat }
    }
})

minetest.register_craft({
    output = "sbo_resium_armor:resium_leggings",
    recipe = {
        { mat, mat, mat },
        { mat, mal, mat },
        { mat, "",  mat }
    }
})

minetest.register_craft({
    output = "sbo_resium_armor:resium_boots",
    recipe = {
        { mat, mal, mat },
        { mat, "",  mat }
    }
})
sbo_api.register_wiki_page({
    type = "quest",
    title = "Resium Armor",
    text = "Armor made out of Resium can repair itself",
})
