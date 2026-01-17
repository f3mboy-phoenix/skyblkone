sbz_power.register_battery("sbo_creox_bat:battery", {
    description = "Creox Battery",
    tiles = { "creox_battery.png" },
    groups = { matter = 1 },
    battery_max = 1000000,
})


minetest.register_craft({
    output = "sbo_creox_bat:battery",
    recipe = {
        { "sbo_resium:crystal",             "sbz_resources:matter_plate",     "sbo_resium:crystal" },
        { "sbz_resources:matter_plate",     "sbz_power:very_advanced_battery",       "sbz_resources:matter_plate" },
        { "sbo_resium:circuit", "sbo_nexus:creox_fab_cube", "sbo_resium:circuit" }
    }
})

sbo_api.register_wiki_page({
    type = "quest",
    title = "Creox Battery",
    text = [[Best Battery Ever, stores 1M.
]],
})
