core.register_craft {
    output = "sbz_resources:movable_emitter",
    recipe = {
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
    }
}
core.register_craft {
    output = "sbz_resources:charged_particle 9",
    type = "shapeless",
    recipe =  {"sbz_power:simple_charged_field"}
}
core.register_craft {
    output = "sbz_resources:core_dust 9",
    type = "shapeless",
    recipe =  {"sbz_resources:compressed_core_dust"}
}
core.register_craft {
    output = "sbz_resources:phlogiston 9",
    type = "shapeless",
    recipe =  {"sbz_resources:phlogiston_blob"}
}
