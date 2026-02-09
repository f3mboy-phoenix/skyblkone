local modpath = minetest.get_modpath("sbo_jetpacks")

dofile(modpath .. "/extrosim.lua")
dofile(modpath .. "/resim.lua")

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Jetpacks",
    text =
        [[Adds:
 * Extrosim Jetpack: Fire trail
 * Resium Jetpack: Right click to select trail color, Auto Recharge
]],
})
