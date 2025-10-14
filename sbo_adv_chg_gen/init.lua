local generator_power_production = 90
sbz_api.register_stateful_generator("sbo_adv_chg_gen:advanced_charge_generator", {
    description = "Advanced Charge Generator",
    tiles = { "advanced_charge_generator_off.png" },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    on_rightclick = function(pos, node, player, pointed_thing)
        local player_name = player:get_player_name()
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", [[
formspec_version[7]
size[8.2,9]
style_type[list;spacing=.2;size=.8]
item_image[3.4,1.9;1,1;sbz_resources:core_dust]
list[context;main;3.5,2;1,1;]
list[current_player;main;0.2,5;8,4;]
listring[]
]])
        minetest.sound_play("machine_open", {
            to_player = player_name,
            gain = 1.0,
            pos = pos,
        })
    end,

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 1)


        minetest.sound_play("machine_build", {
            to_player = player_name,
            gain = 1.0,
            pos = pos,
        })
    end,
    action_interval = 10,
    action = function(pos, node, meta)
        local inv = meta:get_inventory()
        -- check if fuel is there
        if not inv:contains_item("main", "sbz_resources:core_dust") then
            minetest.add_particlespawner({
                amount = 10,
                time = 1,
                minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
                minvel = { x = -0.5, y = -0.5, z = -0.5 },
                maxvel = { x = 0.5, y = 0.5, z = 0.5 },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                minexptime = 5,
                maxexptime = 10,
                minsize = 0.5,
                maxsize = 1.0,
                collisiondetection = false,
                vertical = false,
                texture = "error_particle.png",
                glow = 10
            })
            meta:set_string("infotext", "Stopped")
            return 0, true
        end
        local stack = inv:get_stack("main", 1)
        if stack:is_empty() then
            meta:set_string("infotext", "Stopped")
            return 0, true
        end

        stack:take_item(1)
        inv:set_stack("main", 1, stack)

        minetest.add_particlespawner({
            amount = 25,
            time = 1,
            minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
            maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
            minvel = { x = 0, y = 5, z = 0 },
            maxvel = { x = 0, y = 5, z = 0 },
            minacc = { x = 0, y = 0, z = 0 },
            maxacc = { x = 0, y = 0, z = 0 },
            minexptime = 1,
            maxexptime = 3,
            minsize = 0.5,
            maxsize = 1.0,
            collisiondetection = false,
            vertical = false,
            texture = "charged_particle.png",
            glow = 10
        })
        meta:set_string("infotext", "Running")
        return generator_power_production, false
    end,
    input_inv = "main",
    output_inv = "main",
    info_generated = 90,
    info_extra = "Consumes 1 core dust/10 seconds",
    autostate = true,
}, {
    light_source = 14,
    tiles = { "advanced_charge_generator.png" }
})


minetest.register_craft({
    output = "sbo_adv_chg_gen:advanced_charge_generator",
    recipe = {
        { "sbz_power:simple_charged_field", "sbz_resources:matter_blob",         "sbz_power:simple_charged_field" },
        { "sbz_resources:matter_blob",      "sbz_power:simple_charge_generator", "sbz_resources:matter_blob" },
        { "sbz_power:simple_charged_field", "sbo_extrosim:raw_extrosim",         "sbz_power:simple_charged_field" }
    }
})

sbo_api.register_wiki_page({
    type = "quest",
    title = "Advanced Generators",
    text =
    [[  If you have made Generators then you can make Advanced versions as well.
    They produce 90 power
    Craft with 4 Simple Charged Fields, 3 Matter Blobs, 1 Extrosim Circuit and 1 Generator]],
})
