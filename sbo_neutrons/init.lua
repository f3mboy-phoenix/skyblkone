minetest.register_craftitem("sbo_neutrons:neutron", {
    description = "Neutron",
    inventory_image = "neutron.png",
    stack_max = 256,
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_neutrons:neutron",
    recipe = { "sbo_resium:crystal", "sbz_resources:antimatter_dust" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbz_meteorites:neutronium",
    recipe = {  "sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron" }
})

sbz_api.recipe.register_craft {
    type = "compressing",
    output = "sbz_meteorites:neutronium",
    items = { "sbo_neutrons:neutron 9", }
}

minetest.register_craft({
    type = "shapeless",
    output = "sbz_meteorites:antineutronium",
    recipe = {  "sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron",
				"sbo_neutrons:neutron" }
})

unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_meteorites:antineutronium",
    items = {
        "sbz_resources:antimatter_dust 5",
        "sbo_neutrons:neutron 4"
    },
    width = 2,
    height = 1
})
