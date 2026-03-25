
minetest.register_craft({
    output = "sbo_wormhole_storage:item",
    recipe = {
        {"sbz_resources:matter_plate", "sbz_resources:wormhole", "sbz_resources:matter_plate"},
        {"sbz_resources:matter_plate", "sbz_resources:storinator", "sbz_resources:matter_plate"},
        {"sbz_resources:matter_plate", "sbz_resources:stable_strange_blob", "sbz_resources:matter_plate"},
    }
})
