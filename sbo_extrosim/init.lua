-- Extrosim Node

local action = function(pos, _, puncher)
    local itemstack = puncher:get_wielded_item()
    local tool_name = itemstack:get_name()
    local can_extract_from_emitter = minetest.get_item_group(tool_name, "core_drop_multi") > 0
    if not can_extract_from_emitter then
        minetest.sound_play("punch_core", {
            gain = 1.0,
            max_hear_distance = 32,
            pos = pos
        })
        if puncher.is_fake_player then return end
        displayDialougeLine(puncher:get_player_name(), "Extrosim can only be mined using tools or machines.")
    end
    for _ = 1, minetest.get_item_group(tool_name, "core_drop_multi") do
        if math.random(1, 10) >= 1 then
            puncher:get_inventory():add_item("main", "sbo_extrosim:raw_extrosim")
            minetest.sound_play("punch_core", {
                gain = 1.0,
                max_hear_distance = 32,
                pos = pos
            })
            minetest.add_particlespawner({
                amount = 50,
                time = 1,
                minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
                minvel = { x = -1, y = -1, z = -1 },
                maxvel = { x = 1, y = 1, z = 1 },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                minexptime = 3,
                maxexptime = 5,
                minsize = 0.5,
                maxsize = 1.0,
                collisiondetection = false,
                vertical = false,
                texture = "raw_extrosim.png",
                glow = 10
            })
            unlock_achievement(puncher:get_player_name(), "Obtain Extrosim")
        else
            minetest.sound_play("punch_core", {
                gain = 1.0,
                max_hear_distance = 32,
                pos = pos
            })
            local items = { "sbz_resources:core_dust", "sbz_resources:matter_dust", "sbz_resources:charged_particle" }
            local item = items[math.random(#items)]

            if puncher and puncher:is_player() then
                local inv = puncher:get_inventory()
                if inv then
                    local leftover = inv:add_item("main", item)
                    if not leftover:is_empty() then
                        minetest.add_item(pos, leftover)
                    end
                end

                unlock_achievement(puncher:get_player_name(), "Introduction")
            end
        end
    end
end

minetest.register_node("sbo_extrosim:extrosim", {
    description = "Extrosim",
    tiles = { "extrosim.png" },
    groups = { unbreakable = 1, transparent = 1 },
    drop = "",
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
    on_punch = action,
    on_rightclick = action
})


minetest.register_abm({
    label = "Extrosim Particles",
    nodenames = { "sbo_extrosim:extrosim" },
    interval = 1,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        minetest.add_particlespawner({
            amount = 5,
            time = 1,
            minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
            maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
            minvel = { x = -5, y = -5, z = -5 },
            maxvel = { x = 5, y = 5, z = 5 },
            minacc = { x = 0, y = 0, z = 0 },
            maxacc = { x = 0, y = 0, z = 0 },
            minexptime = 30,
            maxexptime = 50,
            minsize = 0.5,
            maxsize = 1.0,
            collisiondetection = false,
            vertical = false,
            texture = "star.png",
            glow = 10
        })
    end,
})

minetest.register_ore({
    ore_type = "scatter",
    ore = "sbo_extrosim:extrosim",
    wherein = "air",
    clust_scarcity = 80 * 80 * 80,
    clust_num_ores = 1,
    clust_size = 1,
    _min = -31000,
    y_max = 31000,
})

-- Emitter Resources
minetest.register_craftitem("sbo_extrosim:raw_extrosim", {
    description = "Raw Extrosim",
    inventory_image = "raw_extrosim.png",
    stack_max = 256,
})

sbz_api.quests[#sbz_api.quests+1]={ type = "text", title = "Questline: Extrosim", text = "Extrosim is a new item from Skyblock: One." }
sbz_api.register_quest_to("Questline: Extrosim",{
        type = "quest",
        title = "Obtain Extrosim",
        text =
        [[Do you see those blue stars in the distance? They're called Extrosim Emitters. To obtain Extrosim from them, you will have to build a bridge over to one.
I would recommend to choose the closest one to you, but any Emitter works. Next, you'll need a Matter Annihilator. You can't destroy the Emitters, but you can chip away at them.

Punch your Emitter of choice until it yields some 'Raw Extrosim'. We'll refine the Extrosim later, but for now we just need it in its raw state.

Emitters have a 1/10 chance of producing Raw Extrosim, and a 9/10 chance of just producing the same materials that core does.
]],
        requires = { "Annihilator" }
})

