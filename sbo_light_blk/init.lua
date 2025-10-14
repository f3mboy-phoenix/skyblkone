minetest.register_node("sbo_light_blk:light_block", {
    description = "Light Block",
    drawtype = "glasslike",
    tiles = { "light_block.png" },
    groups = { matter = 1, explody = 3 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 14,
    walkable = true,
})
minetest.register_craft({
    output = "sbo_light_blk:light_block",
    recipe = {
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" },
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" },
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" }
    }
})
sbo_api.register_wiki_page({
    type = "quest",
    info = true,
    title = "Light Blocks",
    text = [[Light blocks are made from 9 photons and give off a light level of 14.]],
})
