local modpath = core.get_modpath("sbo_crystals")

dofile(modpath.."/geodes.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/crafting.lua")
dofile(modpath.."/budding.lua")
dofile(modpath.."/lantern.lua")

geodes_lib:register_geode({
    wherein = "sbz_planets:dwarf_stone",
    y_min = -31000,
    y_max = 31000,
    scarcity = 50,
    inner = "sbo_crystals:amethyst",
    inner_alt = "sbo_crystals:amethyst_budding",
    inner_alt_chance = 50, --%
    shell = {"sbo_crystals:basalt", "sbo_crystals:calcite"},
    radius_min = 2,
    radius_max = 10,
})
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Crystals",
    text =
        [[Adds Grimstone Calcite and Amethyst]],
})
