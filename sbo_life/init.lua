minetest.register_craftitem("sbo_life:essence", {
    description = "Life Essence",
    inventory_image = "essence.png",
    stack_max = 256,
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:warpshroom" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:shockshroom" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:stemfruit_plant" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:pyrograss" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:razorgrass" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:cleargrass" }
})
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbz_bio:fiberweed" }
})
