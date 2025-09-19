sbz_api.register_machine("sbo_grim_grower:grim_grower", {
    description = "Grime Grower",
    tiles = { "grim_grower.png" },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    use_texture_alpha = "clip",
    drawtype = "glasslike_framed_optional",
    paramtype = "light",
    on_rightclick = function(pos, node, player, pointed_thing)
        local player_name = player:get_player_name()
        minetest.show_formspec(player_name, "sbz_power:grim_grower_formspec",
            "formspec_version[7]" ..
            "size[8.2,9]" ..
            "style_type[list;spacing=.2;size=.8]" ..
            "list[nodemeta:" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ";main;2.5,2;3,1;]" ..
            "list[current_player;main;0.2,5;8,4;]" ..
            "listring[]")


        minetest.sound_play("machine_open", {
            to_player = player_name,
            gain = 1.0,
            pos = pos,
        })
    end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 3)

        minetest.sound_play("machine_build", {
            to_player = player_name,
            gain = 1.0,
            pos = pos,
        })
    end,
    action = function(pos, node, meta)
        local inv = meta:get_inventory()
        local itemstack = ItemStack("sbz_bio:algae")
        itemstack:set_count(1)


        if inv:room_for_item("main", itemstack) then
            inv:add_item("main", itemstack)

            minetest.add_particlespawner({
                amount = 10,
                time = 1,
                minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
                minvel = { x = -2, y = -2, z = -2 },
                maxvel = { x = 2, y = 2, z = 2 },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                minexptime = 5,
                maxexptime = 10,
                minsize = 0.5,
                maxsize = 1.0,
                collisiondetection = false,
                vertical = false,
                texture = "algae.png",
                glow = 10
            })
        end
    end,
    power_needed = 20,
    action_interval = 2,
    output_inv = "main",
})

minetest.register_craft({
    output = "sbo_grim_grower:grim_grower",
    recipe = {
        { "sbo_photon:photon",   "sbz_resources:matter_plate",        "sbz_bio:algae" },
        { "sbz_resources:matter_plate", "sbo_extrosim_circuit:extrosim_circuit","sbz_resources:matter_plate" },
        { "sbz_bio:algae",   "sbz_resources:matter_blob",        "sbo_photon:photon" }
    }
})

sbz_api.achievment_table["sbo_grim_grower:grim_grower"] = "Grime Growin'"
sbz_api.register_quest_to("Questline: Organics",{
        type = "quest",
        title = "Grime Growin'",
        text =
        [[  You can create Grime Grower.
    2 photons, 2 peices of algae, 4 matter blobs, 1 simple circuit
        ]],
        requires = { "Generators", "Extrosim Circuit"}
})
