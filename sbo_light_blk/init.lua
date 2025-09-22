minetest.register_node("sbo_light_blk:light_block", {
    description = "Light Block\n\nLight Source Only. Strength: 14.",
    drawtype = "glasslike",
    tiles = { "light_block.png" },
    groups = { matter = 1, explody = 3 },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 20,
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
sbz_api.achievment_table["sbo_light_blk:light_block"] = "Block of Light??"
sbz_api.register_quest_to("Questline: Chemistry",{
    type = "quest",
    title = "Block of Light??",
    text = [[A Block of Light ????]],
    requires = { "Photons" }
})
