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

unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_photon:photon",
    items = {
        "sbz_resources:antimatter_dust",
        "sbz_resources:matter_dust"
    },
    width = 2,
    height = 1
})
sbo_api.quests.on_craft["sbo_photon:photon"] = "Photons"
sbo_api.quests.register_to("Questline: Chemistry",{
        type = "quest",
        title = "Photons",
        text = [[Let there be Light!
Photons can be used in life making machines, and in light blocks.
They stack up to 256.]],
        requires = { "Antimatter", "Introduction" }
})

minetest.register_node("sbo_photon:light_block", {
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
    output = "sbo_photon:light_block",
    recipe = {
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" },
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" },
        { "sbo_photon:photon", "sbo_photon:photon", "sbo_photon:photon" }
    }
})
sbo_api.quests.on_craft["sbo_light_blk:light_block"] = "Block of Light??"
sbo_api.quests.register_to("Questline: Chemistry",{
    type = "quest",
    title = "Block of Light??",
    text = [[A Block of Light ????]],
    requires = { "Photons" }
})
core.register_alias("sbo_light_blk:light_block", "sbo_photon:light_block")
