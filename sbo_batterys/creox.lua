sbz_power.register_battery("sbo_batterys:creox_battery", {
    description = "Creox Battery",
    tiles = { "creox_battery.png" },
    groups = { matter = 1 },
    battery_max = 1000000,
})


minetest.register_craft({
    output = "sbo_batterys:creox_battery",
    recipe = {
        { "sbo_resium:crystal",             "sbz_resources:matter_plate",     "sbo_resium:crystal" },
        { "sbz_resources:matter_plate",     "sbz_power:very_advanced_battery",       "sbz_resources:matter_plate" },
        { "sbo_resium:circuit", "sbo_nexus:creox_fab_cube", "sbo_resium:circuit" }
    }
})

sbo_api.quests.on_craft["sbo_batterys:creox_battery"] = "Creox Battery"
sbo_api.quests.register_to("Questline: Creox",{
        type = "quest",
        title = "Creox Battery",
        text = [[Best Battery Ever. Stores 1M.]],
        requires = { "Resium Circuit", "Creox Fabrication Cube", "Very Advanced Batteries", }
    })
core.register_alias("sbo_creox_bat:battery:", "sbo_batterys:creox_battery")
