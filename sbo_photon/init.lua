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

sbz_api.achievment_table["sbo_photon:photon"] = "Photons"
sbz_api.register_quest_to("Questline: Chemistry",{
        type = "quest",
        title = "Photons",
        text = [[Let there be Light!]],
        requires = { "Antimatter", "Introduction" }
})
