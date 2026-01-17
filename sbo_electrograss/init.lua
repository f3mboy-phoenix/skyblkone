sbo_api.register_modded_plant("electrograss", {
    description = "Electrograss Plant",
    drop = "sbz_resources:charged_particle 25",
    growth_rate = 8,
    family = "pyrograss",
    width = 0.25,
    height_min = -0.375,
    height_max = 0,
    sbz_player_inside = function(pos, player)
        playereffects.apply_effect_type("shocked", 2, player)
    end
}, "sbo_electrograss:")
minetest.register_craftitem("sbo_electrograss:grass", {
    description = "Electrograss",
    inventory_image = "electrograss_4.png",
    groups = { burn = 30, eat = 1 },
    on_place = sbz_api.plant_plant("sbo_electrograss:electrograss_1", { "group:soil" })
})
core.register_craft {
    type = "shapeless",
    output = "sbo_electrograss:grass",
    recipe = {
        "sbz_bio:pyrograss", "sbz_resources:charged_particle",
    }
}
