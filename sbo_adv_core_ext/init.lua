-- Advanced Pebble Extractor Node
sbz_api.register_machine("sbo_adv_core_ext:extractor", {
    description =
    "Advanced Compressing Core Extractor",
    tiles = { "sbo_adv_core_ext.png" },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    on_rightclick = function(pos, node, player, pointed_thing)
        local player_name = player:get_player_name()
        minetest.show_formspec(player_name, "sbz_power:sbo_adv_core_ext",
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
            to_player = player_name or "singleplayer",
            gain = 1.0,
            pos = pos,
        })
    end,
    action = function(pos, node, meta)
        local inv = meta:get_inventory()
        local itemstack = ItemStack("sbz_resources:compressed_core_dust")
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
                texture = "compressed_core_dust.png",
                glow = 10
            })
        end
    end,
    power_needed = 50,
    action_interval = 1,
    output_inv = "main",
})

minetest.register_craft({
    output = "sbo_adv_core_ext:extractor",
    recipe = {
        { "sbz_resources:compressed_core_dust", "sbz_resources:compressed_core_dust",      "sbz_resources:compressed_core_dust" },
        { "sbz_resources:compressed_core_dust", "sbo_simp_core_ext:simple_core_extractor", "sbz_resources:compressed_core_dust" },
        { "sbz_resources:compressed_core_dust", "sbo_resium:circuit",                      "sbz_resources:compressed_core_dust" }
    }
})
