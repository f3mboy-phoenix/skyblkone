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
