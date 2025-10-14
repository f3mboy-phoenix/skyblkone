minetest.register_craftitem("sbo_photon:photon", {
    description = "Photon",
    inventory_image = "photon.png",
    stack_max = 256,
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_photon:photon",
    recipe = { "sbz_resources:antimatter_dust", "sbz_resources:matter_dust" }
})

sbo_api.register_wiki_page({
    type = "quest",
    info = true,
    title = "Photons",
    text = [[Let there be Light!
Photons can be used in life making machines, and in light blocks.
They stack up to 256.]],
})
