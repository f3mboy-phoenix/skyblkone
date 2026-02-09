local drill_times = { [1] = 1.50, [2] = 0.30, [3] = 0.10 }
local drill_max_wear = 500 * 3
local drill_power_per_1_use = 10

local tool_caps = {
    full_punch_interval = 0.1,
    damage_groups = { -- yeaa slightly deadly
        matter = 3,
        antimatter = 3,
    },
    punch_attack_uses = drill_max_wear,
    max_drop_level = 1,
    groupcaps = {
        matter = {
            times = drill_times,
            --uses = 30,
            maxlevel = 4
        },
        antimatter = {
            times = drill_times,
            --uses = 30,
            maxlevel = 4
        },
    },
}

minetest.register_tool("sbo_extrosim_drill:drill", {
    description = "Extrex Drill",
    inventory_image = "edrill.png",
    info_extra = {
        "Powered by electricity. Wear bar indicates the amount of charge left.",
        ("%s uses"):format(drill_max_wear),
        "\"Place\" it on a battery to re-charge it."
    },
    groups = { core_drop_multi = 20, disable_repair = 1, power_tool = 1, can_mine_extrosim = 1, can_mine_resium = 1 },
    -- Tool properties
    tool_capabilities = tool_caps,
    after_use = function(stack, user, node, digparams)
        stack:add_wear_by_uses(drill_max_wear + digparams.wear)
        if stack:get_wear() >= 65535 then
            stack:get_meta():set_tool_capabilities({})
        end
        return stack
    end,
    on_place = sbz_api.on_place_recharge((drill_max_wear / 65535) * drill_power_per_1_use, function(stack, user, pointed)
        if stack:get_wear() < 65530 then
            stack:get_meta():set_tool_capabilities(tool_caps)
        end
    end),
    powertool_charge = sbz_api.powertool_charge((drill_max_wear / 65535) * drill_power_per_1_use),
    charge_per_use = drill_power_per_1_use,
    wear_represents = "power",

    wear_color = { color_stops = { [0] = "lime" } },
    sound = { punch_use = { name = "drill_dig", } },
})
minetest.register_craft {
    recipe = {
        { "sbo_extrex:extrex_ingot",               "sbz_resources:robotic_arm",             "sbo_extrex:extrex_ingot" },
        { "sbo_extrex:extrex_ingot",               "sbo_emmitrex_drill:drill",              "sbo_extrex:extrex_ingot" },
        { "sbo_rein_colorium:reinforced_colorium", "sbo_extrosim_circuit:extrosim_circuit", "sbo_rein_colorium:reinforced_colorium" }
    },
    output = "sbo_extrosim_drill:drill"
}
sbo_api.quests.in_inven["sbo_emmitrex_drill:drill"] = "Extrex Drill"
sbo_api.quests.register_to("Questline: Resium",{
    type = "quest",
    title = "Extrex Drill",
    text = [[An Extrex Drill is required to mine Resium, also has a better battey efficency and 20x core drops]],
    requires = { "Extrex", }
})
