local modpath = minetest.get_modpath("sbo_qol")

dofile(modpath .. "/crusher.lua")
dofile(modpath .. "/centrifuge.lua")
dofile(modpath .. "/chem.lua")
dofile(modpath .. "/recipes.lua")
dofile(modpath .. "/comp.lua")
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "QOL",
    text =
        [[Quality of life mod adding various recipes]],
})
