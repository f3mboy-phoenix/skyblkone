function sbo_api.register_modded_plant(name, defs, modname)
    defs.description = defs.description or ""
    defs.drop = defs.drop
    defs.growth_rate = defs.growth_rate or 1
    defs.co2_demand = defs.co2_demand or 0
    defs.width = defs.width or 0.5
    defs.height_min = defs.height_min or 0.5
    defs.height_max = defs.height_max or 0.5
    defs.stages = defs.stages or 4

    local growth_boost_base = (defs.growth_boost or 0) / defs.stages
    local power_per_co2_base = (defs.power_per_co2 or 0) / defs.stages

    for i = 1, defs.stages - 1 do
        local interpolant = (i - 1) / (defs.stages - 1)
        local height = defs.height_min * (1 - interpolant) + defs.height_max * interpolant
        minetest.register_node(modname .. name .. "_" .. i, {
            description = defs.description,
            drawtype = "plantlike",
            tiles = { name .. "_" .. i .. ".png" },
            inventory_image = name .. "_" .. i .. ".png",
            selection_box = { type = "fixed", fixed = { -defs.width, -0.5, -defs.width, defs.width, height, defs.width } },
            paramtype = "light",
            sunlight_propagates = true,
            paramtype2 = "color",
            palette = "wilting_palette.png",
            walkable = false,
            groups = {
                dig_immediate = 2,
                attached_node = 1,
                plant = 1,
                needs_co2 = defs.co2_demand,
                habitat_conducts = 1,
                transparent = 1,
                not_in_creative_inventory = 1,
                burn = 1,
                nb_nodig = 1,
                no_wilt = defs.no_wilt and 1 or 0,
                growth_boost = growth_boost_base * i
            },
            drop = {},
            growth_tick = sbz_api.plant_growth_tick(defs.growth_rate, defs.mutation_chance or 10),
            grow = sbz_api.plant_grow(modname .. name .. "_" .. (i + 1)),
            wilt = sbz_api.plant_wilt(2),
            sbz_player_inside = defs.sbz_player_inside,
            power_per_co2 = power_per_co2_base * i
        })
    end
    minetest.register_node(modname .. name .. "_" .. defs.stages, {
        description = defs.description,
        drawtype = "plantlike",
        tiles = { name .. "_" .. defs.stages .. ".png" },
        inventory_image = name .. "_" .. defs.stages .. ".png",
        selection_box = { type = "fixed", fixed = { -defs.width, -0.5, -defs.width, defs.width, defs.height_max, defs.width } },
        paramtype = "light",
        sunlight_propagates = true,
        paramtype2 = "color",
        palette = "wilting_palette.png",
        walkable = false,
        groups = {
            oddly_breakable_by_hand = 3,
            matter = 3,
            attached_node = 1,
            plant = defs.use_co2_in_final_stage and 1 or 0,
            habitat_conducts = 1,
            transparent = 1,
            not_in_creative_inventory = 1,
            burn = 1,
            needs_co2 = defs.use_co2_in_final_stage and defs.co2_demand or 0,
            growth_boost = defs.growth_boost
        },
        drop = defs.drop,
        sbz_player_inside = defs.sbz_player_inside,
        power_per_co2 = defs.power_per_co2,
        growth_tick = defs.use_co2_in_final_stage and function() return true end,
        grow = defs.use_co2_in_final_stage and function() return true end,
        wilt = defs.use_co2_in_final_stage and sbz_api.plant_wilt(2)
    })
end
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Modded Plants",
    text =
        [[copy of internal code made external for mods]],
})
