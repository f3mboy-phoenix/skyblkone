sbz_power.register_battery("sbo_batterys:super_battery", {
    description = "Super Battery",
    tiles = { "super_battery.png" },
    groups = { matter = 1 },
    battery_max = 500000,
})


minetest.register_craft({
    output = "sbo_batterys:super_battery",
    recipe = {
        { "sbo_extrosim:raw_extrosim",             "sbo_colorium:plate",     "sbo_extrosim:raw_extrosim" },
        { "sbo_colorium:plate",     "sbz_power:very_advanced_battery",       "sbo_colorium:plate" },
        { "sbo_colorium:circuit", "sbo_extrosim:circuit", "sbo_colorium:circuit" }
    }
})

sbo_api.quests.on_craft["sbo_batterys:super_battery"] = "Super Battery"
sbo_api.quests.register_to("Questline: Colorium",{
        type = "quest",
        title = "Super Battery",
        text = [[Best Battery Ever Stores 500KCj]],
        requires = { "Colorium Plates", "Extrosim Circuit", "Colorium Circuit", }
    })
core.register_alias("sbo_sup_bat:super_battery", "sbo_batterys:super_battery")
