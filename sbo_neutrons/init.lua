minetest.register_craftitem("sbo_neutrons:neutron", {
    description = "Neutron",
    inventory_image = "neutron.png",
    stack_max = 256,
})
sbz_api.recipe.register_craft {
    output = 'sbo_neutrons:neutron',
    items = { 'sbo_resium:crystal', 'sbz_resources:antimatter_dust' },
    type = 'atomic',
}
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
    recipe = {  "sbz_resources:antimatter_dust",
				"sbz_resources:antimatter_dust",
				"sbz_resources:antimatter_dust",
				"sbz_resources:antimatter_dust",
				"sbz_resources:antimatter_dust",
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

sbo_api.quests.on_craft["sbo_neutrons:neutron"] = "Neutrons"
sbo_api.quests.register_to("Questline: Atomic",{
    type = "quest",
    title = "Neutrons",
    text =
        [[Neutrons can be made from smashing resium into antimatter.
Neutrons can be turned into Neutronium or AntiNeutronium]],
    requires = { "Atomic Reconstructor"}
})
