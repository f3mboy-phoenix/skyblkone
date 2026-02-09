local actions = function(pos, _, puncher)
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
        sbz_api.displayDialogLine(puncher:get_player_name(), "Colorium can only be mined using tools or machines.")
    end
    for _ = 1, minetest.get_item_group(tool_name, "core_drop_multi") do
        if math.random(1, 10) >= 1 then
            puncher:get_inventory():add_item("main", "unifieddyes:colorium_powder")
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
                texture = "powder.png",
                glow = 10
            })
        end
    end
end
minetest.register_node("sbo_emmiters:colorium", {
    description = "Movable Colorium Emitter",
    tiles = { "colorium_movable_emitter.png" },
    groups = { transparent = 1, matter = 1, level = 2 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
    on_punch = actions,
    on_rightclick = actions
})
core.register_craft {
    output = "sbo_emmiters:colorium",
    recipe = {
        { "unifieddyes:colorium_powder", "unifieddyes:colorium_powder", "unifieddyes:colorium_powder", },
        { "unifieddyes:colorium_powder", "sbz_planets:dwarf_orb", "unifieddyes:colorium_powder", },
        { "unifieddyes:colorium_powder", "unifieddyes:colorium_powder", "unifieddyes:colorium_powder", },
    }
}
----------------------------------------------------------------------------------------------------------
local actions = function(pos, _, puncher)
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
        sbz_api.displayDialogLine(puncher:get_player_name(), "Strange Dust can only be mined using tools or machines.")
    end
    for _ = 1, minetest.get_item_group(tool_name, "core_drop_multi") do
        if math.random(1, 10) >= 1 then
            puncher:get_inventory():add_item("main", "sbz_resources:strange_dust")
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
                texture = "strange_dust.png",
                glow = 10
            })
        end
    end
end
minetest.register_node("sbo_emmiters:strange_dust", {
    description = "Movable Strange Dust Emitter",
    tiles = { "strange_movable_emitter.png" },
    groups = { transparent = 1, matter = 1, level = 2 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
    on_punch = actions,
    on_rightclick = actions
})
core.register_craft {
    output = "sbo_emmiters:strange_dust",
    recipe = {
        { "sbz_resources:strange_dust", "sbz_resources:strange_dust", "sbz_resources:strange_dust", },
        { "sbz_resources:strange_dust", "sbz_chem:plutonium_block", "sbz_resources:strange_dust", },
        { "sbz_resources:strange_dust", "sbz_resources:strange_dust", "sbz_resources:strange_dust", },
    }
}
----------------------------------------------------------------------------------------------------------
local actions = function(pos, _, puncher)
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
        sbz_api.displayDialogLine(puncher:get_player_name(), "Neutronium can only be mined using tools or machines.")
    end
    for _ = 1, minetest.get_item_group(tool_name, "core_drop_multi") do
        if math.random(1, 10) >= 1 then
            puncher:get_inventory():add_item("main", "sbz_meteorites:neutronium")
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
                texture = "neutronium.png",
                glow = 10
            })
        end
    end
end
minetest.register_node("sbo_emmiters:neutronium", {
    description = "Movable Neutronium Emitter",
    tiles = { "neutronium_movable_emitter.png" },
    groups = { transparent = 1, matter = 1, level = 2 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
    on_punch = actions,
    on_rightclick = actions
})
core.register_craft {
    output = "sbo_emmiters:neutronium",
    recipe = {
        { "sbz_meteorites:neutronium", "sbz_meteorites:neutronium", "sbz_meteorites:neutronium", },
        { "sbz_meteorites:neutronium", "sbz_planets:dwarf_orb", "sbz_meteorites:neutronium", },
        { "sbz_meteorites:neutronium", "sbz_meteorites:neutronium", "sbz_meteorites:neutronium", },
    }
}

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    title = "Emitters",
    info = true,
    text =
        [[Adds Neutronium, Strange Dust, and Colorium Movable emitters]],
})
