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
        sbz_api.displayDialogLine(puncher:get_player_name(), "Resium can only be mined using tools or machines.")
    end
    for _ = 1, minetest.get_item_group(tool_name, "core_drop_multi") do
        if math.random(1, 10) >= 10 then
            puncher:get_inventory():add_item("main", "sbo_resium:crystal")
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
                texture = "resium_crystal.png",
                glow = 10
            })
            unlock_achievement(puncher:get_player_name(), "Obtain Resium")
        else
            minetest.sound_play("punch_core", {
                gain = 1.0,
                max_hear_distance = 32,
                pos = pos
            })
        end
    end
end

minetest.register_node("sbo_resium:resium", {
    description = "Resium Crystal",
    tiles = { "resium.png" },
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
    label = "Resium Particles",
    nodenames = { "sbo_resium:resium" },
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
            texture = "star.png^[colorize:green",
            glow = 10
        })
    end,
})

minetest.register_ore({
    ore_type = "scatter",
    ore = "sbo_resium:resium",
    wherein = "air",
    clust_scarcity = 80 * 80 * 80,
    clust_num_ores = 1,
    clust_size = 1,
    _min = -31000,
    y_max = 31000,
})


minetest.register_craftitem("sbo_resium:crystal", {
    description = "Resium Crystals",
    inventory_image = "resium_crystal.png",
    stack_max = 256
})

minetest.register_craftitem("sbo_resium:circuit", {
    description = "Resium Circuit",
    inventory_image = "resium_circuit.png",
    stack_max = 256,
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_resium:circuit",
    recipe = { "sbz_resources:charged_particle", "sbz_resources:retaining_circuit", "sbo_resium:crystal", "sbz_resources:antimatter_plate" }
})


minetest.register_node("sbo_resium:movable_emitter", {
    description = "Movable Resium Emitter",
    tiles = { "resium_movable_emitter.png" },
    groups = { transparent = 1, matter = 1, level = 2 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
    on_punch = action,
    on_rightclick = action
})
core.register_craft {
    output = "sbo_resium:movable_emitter",
    recipe = {
        { "sbo_resium:crystal", "sbo_resium:crystal", "sbo_resium:crystal", },
        { "sbo_resium:crystal", "sbo_resium:crystal", "sbo_resium:crystal", },
        { "sbo_resium:crystal", "sbo_resium:crystal", "sbo_resium:crystal", },
    }
}
sbz_api.quests[#sbz_api.quests+1]={ type = "text", title = "Questline: Resium", text = "????" }
sbz_api.achievment_table["sbo_resium:movable_emitter"] = "Movable Resium Emitter"
sbz_api.register_quest_to("Questline: Resium",{
        type = "quest",
        title = "Movable Resium Emitter",
        text = "Movable Resium Emitter work like normal Movable Emitters but for Resium",
        requires = { "Centrifuge" }
})
sbz_api.register_quest_to("Questline: Resium",{
        type = "quest",
        title = "Obtain Resium",
        text =
        [[Do you see those green stars in the distance? They're called Resium Emitters. To obtain Resium from them, you will have to build a bridge over to one.
I would recommend to choose the closest one to you, but any Emitter works. Next, you'll need a Matter Annihilator. You can't destroy the Emitters, but you can chip away at them.

Punch your Emitter of choice until it yields some 'Resium Crystals'. We'll refine the Resium later, but for now we just need it in its raw state.

Emitters have a 1/10 chance of producing Raw Resium.
]],
        requires = { "Annihilator" }
})
sbz_api.achievment_table["sbo_resium:circuit"] = "Resium Circuit"
sbz_api.register_quest_to("Questline: Resium",{
        type = "quest",
        title = "Resium Circuit",
        text = "Yet another circuit...",
        requires = { "Obtain Resium" }
})
