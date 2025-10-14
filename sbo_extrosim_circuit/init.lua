minetest.register_craftitem("sbo_extrosim_circuit:extrosim_circuit", {
    description = "Extrosim Circuit",
    inventory_image = "extrosim_circuit.png",
    stack_max = 256,
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_extrosim_circuit:extrosim_circuit",
    recipe = { "sbz_resources:charged_particle", "sbz_resources:retaining_circuit", "sbo_extrosim:raw_extrosim", "sbz_resources:antimatter_plate" }
})

sbo_api.register_wiki_page({
    type = "quest",
    info = true,
    title = "Extrosim Circuit",
    text = [[A circuit made from Extrosim]],
    requires = { "Obtain Extrosim" }
})
