sbo_resium_armor = {}

sbo_resium_armor.S = minetest.get_translator("sbo_resitrex")
sbo_resium_armor.modpath = minetest.get_modpath("sbo_resitrex")

-- The direct durability for the armors
sbo_resium_armor.uses = 365
sbo_resium_armor.heal = 3 -- 2

-- The amount repaired per global step
sbo_resium_armor.factor = 42 -- 36

-- Do we log that we did something? (Specifically used for debug
sbo_resium_armor.log = not true

-- Only support repairing armor when the player is wearing it
local function check_player(player, timer)
        -- Checking for armors in 3d_armor slots
        local armor_inv = minetest.get_inventory({type="detached", name="sbz_armor:" .. player:get_player_name()})
        if not armor_inv then return end
        for i, stack in pairs(armor_inv:get_list("main")) do
            if not stack:is_empty() then
                local name = stack:get_name()
                if name:sub(1, 12) == "sbo_resitrex" then
                    --if stack:get_wear() ~= 0 then
                        stack:add_wear(-sbo_resium_armor.factor)
                        armor_inv:set_stack("main", i, stack)
                        if sbo_resium_armor.log == true then
                            minetest.log("action", "[sbo_resium_armor] ["..i.."] "..stack:get_wear())
                            print("[sbo_resium_armor] ["..i.."] "..stack:get_wear())
                        end
                    --end
                end
            end
        end
end

-- Armor

local armor_types_to_names = {
    head = "Helmet",
    legs = "Leggings",
    feet = "Boots",
    torso = "Chestplate"
}
for armor_type, armor_name in pairs(armor_types_to_names) do
    sbz_api.armor.register("sbo_resitrex:" .. armor_name:lower(), {
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
local mat = "sbo_resitrex:resitrex_ingot"
local mal = "sbo_resium:circuit"
minetest.register_craft({
    output = "sbo_resitrex:helmet",
    recipe = {
        { mat, mat, mat },
        { mat, mal, mat }
    }
})

minetest.register_craft({
    output = "sbo_resitrex:chestplate",
    recipe = {
        { mat, mal, mat },
        { mat, mat, mat },
        { mat, mat, mat }
    }
})

minetest.register_craft({
    output = "sbo_resitrex:leggings",
    recipe = {
        { mat, mat, mat },
        { mat, mal, mat },
        { mat, "",  mat }
    }
})

minetest.register_craft({
    output = "sbo_resitrex:boots",
    recipe = {
        { mat, mal, mat },
        { mat, "",  mat }
    }
})

core.register_alias("sbo_resium_armmor:resium_helmet", "sbo_resitrex:helmet")
core.register_alias("sbo_resium_armmor:resium_chestplate", "sbo_resitrex:chestplate")
core.register_alias("sbo_resium_armmor:resium_leggings", "sbo_resitrex:leggings")
core.register_alias("sbo_resium_armmor:resium_boots", "sbo_resitrex:boots")


sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Resitrex Armor",
    text = "Armor made out of Resium can repair itself",
})

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 3 then
        for _, player in ipairs(minetest.get_connected_players()) do
            check_player(player, timer)
        end
        timer = 0
    end
end)

minetest.log("action", "[sbo_resium_armor] Ready")
