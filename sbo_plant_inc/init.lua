-- Plant Incubator Node
sbz_api.register_machine("sbo_plant_inc:plant_incubator", {
    description =
    "Plant Incubator",
    tiles = { "plant_incubator.png" },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    use_texture_alpha = "clip",
    drawtype = "glasslike_framed_optional",
    paramtype = "light",
    on_rightclick = function(pos, node, player, pointed_thing)
        local player_name = player:get_player_name()
        minetest.show_formspec(player_name, "sbz_power:plant_incubator_formspec",
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
        local itemstack = ItemStack("sbz_bio:moss")
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
                texture = "stemfruit.png",
                glow = 10
            })
        end
    end,
    power_needed = 20,
    action_interval = 2,
    output_inv = "main",
})

minetest.register_craft({
    output = "sbo_plant_inc:plant_incubator",
    recipe = {
        { "sbo_photon:photon",          "sbz_resources:matter_plate",            "sbz_bio:moss" },
        { "sbz_resources:matter_plate", "sbo_extrosim_circuit:extrosim_circuit", "sbz_resources:matter_plate" },
        { "sbz_bio:moss",               "sbz_resources:matter_blob",             "sbo_photon:photon" }
    }
})

sbo_api.quests.on_craft["sbo_plant_inc:plant_incubator"] = "Plants Galore"
sbo_api.quests.register_to("Questline: Organics",{
        type = "quest",
        title = "Plants Galore",
        text =
        [[  You can create Plant Incubators.
    2 photons, 2 peices of moss, 4 matter blobs, 1 simple circuit
        ]],
        requires = { "Generators", "Extrosim Circuit"}
})
