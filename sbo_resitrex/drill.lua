resium_tools = {}

-- The direct durability for the tools
resium_tools.uses = 365

-- The amount repaired per global step
resium_tools.factor = 42 -- 36

-- Do we log when we repair? Used for debugging
resium_tools.log = false

resium_tools.modpath = minetest.get_modpath("sbo_resitrex")

-- Only support repairing tools when they are in the main inventory of the player
local function check_player(player, timer)
    local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
    for i, stack in pairs(inv:get_list("main")) do
        if not stack:is_empty() then
            local charges = stack:get_definition().groups.resium
            if charges then
                if stack:get_wear() ~= 0 then
                    stack:add_wear( -resium_tools.factor )
                    --stack:get_meta():set_string("info_extra",tostring(stack:get_wear()))
                    inv:set_stack("main", i, stack)
                    if resium_tools.log == true then
                        minetest.log("action", "[resium_tools] ["..i.."] "..stack:get_wear())
                    end
                end
            end
        end
    end
end

minetest.register_tool("sbo_resitrex:drill", {
    description = "Resium Drill",
    inventory_image = "resium_tool.png",
    groups = {
        core_drop_multi = 24,
        resium = 1,
        can_mine_resium = 1,
        can_mine_extrosim = 1,
    },
    -- Tool properties
    tool_capabilities = {
        full_punch_interval = 0.1,
        damage_groups = { matter = 1, antimatter = 1, amethyst = 1 },
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
            amethyst = {
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
core.register_alias("sbo_resium_tools:drill", "sbo_resitrex:drill")


minetest.register_craft {
    recipe = {
        { "sbo_resitrex:resitrex_ingot",   "sbo_emmitrex:drill", "sbo_resitrex:resitrex_ingot" },
        { "sbo_resitrex:resitrex_ingot",   "sbo_oil:oil",  "sbo_resitrex:resitrex_ingot" },
        { "sbz_resources:phlogiston_blob", "sbo_resium:circuit",        "sbz_resources:phlogiston_blob" }
    },
    output = "sbo_resitrex:drill"
}

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Resium Drill",
    text =
       [[
A Drill made out of Resium can repair itself. It has 4500 uses.
It also has 24x core drops.
]],
})


local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 15 then
        for _, player in ipairs(minetest.get_connected_players()) do
            check_player(player, timer)
        end
        timer = 0
    end
end)

minetest.log("action", "[resium_tools] Ready")

