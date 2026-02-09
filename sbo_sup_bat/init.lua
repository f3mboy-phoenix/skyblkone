local t = sbz_api.power_tick -- ticks/second
local tph = t * 60 * 60      -- ticks/hour

function sbz_power.round_power(n)
    return math.round(n * 100) / 100
end

function sbz_power.cj2cjh(cj)
    return sbz_power.round_power(cj / tph)
end

function sbz_power.cjh2cj(cjh)
    return sbz_power.round_power(cjh * tph)
end

sbz_power.register_battery("sbo_sup_bat:super_battery", {
    description = "Super Battery",
    tiles = { "super_battery.png" },
    groups = { matter = 1 },
    battery_max = sbz_power.cjh2cj(150),
})


minetest.register_craft({
    output = "sbo_sup_bat:super_battery",
    recipe = {
        { "sbo_extrosim:raw_extrosim",             "sbo_colorium_plate:colorium_plate",     "sbo_extrosim:raw_extrosim" },
        { "sbo_colorium_plate:colorium_plate",     "sbz_power:very_advanced_battery",       "sbo_colorium_plate:colorium_plate" },
        { "sbo_colorium_circuit:colorium_circuit", "sbo_extrosim_circuit:extrosim_circuit", "sbo_colorium_circuit:colorium_circuit" }
    }
})

sbo_api.quests.on_craft["sbo_sup_bat:super_battery"] = "Super Battery"
sbo_api.quests.register_to("Questline: Extrosim",{
        type = "quest",
        title = "Super Battery",
        text = [[Best Battery Ever Stores 150cjh]],
        requires = { "Colorium Plates", "Extrosim Circuit", "Colorium Circuit", }
    })
