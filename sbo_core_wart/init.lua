sbo_api.register_modded_plant("core_wart", {
    description = "Core Wart Plant",
    drop = "sbz_resources:core_dust 25",
    growth_rate = 4,
    family = "warpshroom",
    width = 0.25,
    height_min = -0.375,
    height_max = 0,
    no_wilt = true,
}, "sbo_core_wart:")
minetest.register_craftitem("sbo_core_wart:wart", {
    description = "Core Wart",
    inventory_image = "core_wart_4.png",
    groups = { burn = 30, eat = 1 },
    on_place = sbz_api.plant_plant("sbz_bio:pyrograss_1", { "group:soil" })
})
core.register_craft {
    type = "shapeless",
    output = "sbo_core_wart:wart 1",
    recipe = {
        "sbz_bio:warpshroom", "sbz_resources:core_dust",
    }
}
