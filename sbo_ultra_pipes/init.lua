pipeworks.register_tube("sbo_ultra_pipes:uhp_tube", {
    description = "Ultra High Priority Tube",
    plain = { { name = "basic_tube_plain.png", backface_culling = pipeworks.tube_backface_culling, color = "purple" } },
    noctr = { { name = "basic_tube_noctr.png", backface_culling = pipeworks.tube_backface_culling, color = "purple" } },
    node_def = {
        tube = {
            priority = 200,
        },
        on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: 200")
		end
    }
})

minetest.register_craft({
    output = "sbo_ultra_pipes:uhp_tube_1 1",
    type = "shapeless",
    recipe = { "pipeworks:high_priority_tube_1", "sbz_resources:matter_dust" }
})

pipeworks.register_tube("sbo_ultra_pipes:ulp_tube", {
    description = "Ultra Low Priority Tube",
    plain = { { name = "basic_tube_plain.png", backface_culling = pipeworks.tube_backface_culling, color = "yellow" } },
    noctr = { { name = "basic_tube_noctr.png", backface_culling = pipeworks.tube_backface_culling, color = "yellow" } },
    node_def = {
        tube = {
            priority = -1,
        },
        on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: -1")
		end
    }
})

minetest.register_craft({
    output = "sbo_ultra_pipes:ulp_tube_1 1",
    type = "shapeless",
    recipe = { "pipeworks:low_priority_tube_1", "sbz_resources:antimatter_dust" }
})
pipeworks.register_tube("sbo_ultra_pipes:rlp_tube", {
    description = "Relitivly Low Priority Tube",
    plain = { { name = "basic_tube_plain.png", backface_culling = pipeworks.tube_backface_culling, color = "pink" } },
    noctr = { { name = "basic_tube_noctr.png", backface_culling = pipeworks.tube_backface_culling, color = "pink" } },
    node_def = {
        tube = {
            priority = 10,
        },
        on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: 10")
		end
    }
})

minetest.register_craft({
    output = "sbo_ultra_pipes:rlp_tube_1 1",
    type = "shapeless",
    recipe = { "pipeworks:low_priority_tube_1", "sbz_resources:matter_dust" }
})
pipeworks.register_tube("sbo_ultra_pipes:mlp_tube", {
    description = "Mid Low Priority Tube",
    plain = { { name = "basic_tube_plain.png", backface_culling = pipeworks.tube_backface_culling, color = "orange" } },
    noctr = { { name = "basic_tube_noctr.png", backface_culling = pipeworks.tube_backface_culling, color = "orange" } },
    node_def = {
        tube = {
            priority = 25,
        },
        on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: 25")
		end
    }
})

minetest.register_craft({
    output = "sbo_ultra_pipes:mlp_tube_1 1",
    type = "shapeless",
    recipe = { "sbo_ultra_pipes:rlp_tube_1", "sbz_resources:matter_dust" }
})
