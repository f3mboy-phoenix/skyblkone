resium_tools = {}

-- The direct durability for the tools
resium_tools.uses = 365

-- The amount repaired per global step
resium_tools.factor = 42 -- 36

-- Do we log when we repair? Used for debugging
resium_tools.log = false

resium_tools.modpath = minetest.get_modpath("sbo_resium_tools")

-- Only support repairing tools when they are in the main inventory of the player
local function check_player(player, timer)
    local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
    for i, stack in pairs(inv:get_list("main")) do
        if not stack:is_empty() then
            local name = stack:get_name()
            if name:sub(1,16) == "sbo_resium_tools" then
                if stack:get_wear() ~= 0 then
                    stack:add_wear( -resium_tools.factor )
                    inv:set_stack("main", i, stack)
                    if resium_tools.log == true then
                        minetest.log("action", "[resium_tools] ["..i.."] "..stack:get_wear())
                    end
                end
            end
        end
    end
end

dofile(resium_tools.modpath.."/sbz_support.lua")


local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 2 then
        for _, player in ipairs(minetest.get_connected_players()) do
            check_player(player, timer)
        end
        timer = 0
    end
end)

minetest.log("action", "[resium_tools] Ready")
