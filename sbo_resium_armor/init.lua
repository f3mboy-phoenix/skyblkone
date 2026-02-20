sbo_resium_armor = {}

sbo_resium_armor.S = minetest.get_translator("sbo_resium_armor")
sbo_resium_armor.modpath = minetest.get_modpath("sbo_resium_armor")

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
                if name:sub(1, 16) == "sbo_resium_armor" then
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

dofile(sbo_resium_armor.modpath.."/sbz_support.lua")

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= .5 then
        for _, player in ipairs(minetest.get_connected_players()) do
            check_player(player, timer)
        end
        timer = 0
    end
end)

minetest.log("action", "[sbo_resium_armor] Ready")
