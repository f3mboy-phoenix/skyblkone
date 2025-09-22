local modpath = minetest.get_modpath("sbo_qol")

dofile(modpath .. "/crusher.lua")
dofile(modpath .. "/centrifuge.lua")
dofile(modpath .. "/chem.lua")

core.register_craft {
    output = "sbz_resources:movable_emitter",
    recipe = {
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
        { "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", "sbz_resources:raw_emittrium", },
    }
}
