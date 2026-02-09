sbz_api.register_machine("sbo_sup_ext:extractor", {
    description = "Super Matter Extractor",
    tiles = { "sup_extractor.png" },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    on_rightclick = function(pos, node, player, pointed_thing)
        minetest.get_meta(pos):set_string("formspec", [[
        formspec_version[7]
        size[8.2,9]
        style_type[list;spacing=.2;size=.8]
        list[context;main;3.5,2;1,1;]
        list[current_player;main;0.2,5;8,4;]
        listring[]
    ]])
    end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 1)
    end,
    action = function(pos, node, meta, supply, demand)
        local inv = meta:get_inventory()

        local itemstack = ItemStack("sbz_resources:matter_dust")
        itemstack:set_count(7)

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
                texture = "matter_dust.png",
                glow = 10
            })
        end
    end,
    action_interval = 5,
    power_needed = 15,
    output_inv = "main",
})

minetest.register_craft({
    output = "sbo_sup_ext:extractor",
    recipe = {
        { "sbz_resources:core_dust",       "sbz_resources:matter_blob",        "sbz_resources:core_dust" },
        { "sbz_resources:matter_blob", "sbz_resources:matter_annihilator", "sbz_resources:matter_blob" },
        { "sbz_resources:core_dust",       "sbo_extrex:extrex_ingot",          "sbz_resources:core_dust" }
    }
})


sbo_api.quests.on_craft["sbo_sup_ext:extractor"] = "Super Matter Extractor"
sbo_api.quests.register_to("Questline: Extrosim",{
    type = "quest",
    title = "Super Matter Extractor",
    text =
        [[Useful for automation. Creates 7 Matter Dust per second.]],
    requires = { "Automation", }
})

