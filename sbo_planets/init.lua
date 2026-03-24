-- Prepare for api change in sbz
local default_matter_sounds = {}
if core.get_modpath('sbz_audio') then
    default_matter_sounds = sbz_audio.matter()
else
    default_matter_sounds = sbz_api.sounds.matter()
end

core.register_node('sbo_planets:purple_stone1', {
    description = 'Purple Stone',
    tiles = { { name = 'purple_stone1.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:purple_stone1'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:purple_stone1" }
}

core.register_node('sbo_planets:purple_stone2', {
    description = 'Purple Stone',
    tiles = { { name = 'purple_stone2.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:purple_stone2'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:purple_stone2" }
}

core.register_node('sbo_planets:purple_stone3', {
    description = 'Purple Stone',
    tiles = { { name = 'purple_stone3.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:purple_stone3'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:purple_stone3" }
}

core.register_node('sbo_planets:pink_stone1', {
    description = 'Pink Stone',
    tiles = { { name = 'pink_stone1.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:pink_stone1'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:pink_stone1" }
}

core.register_node('sbo_planets:pink_stone2', {
    description = 'Pink Stone',
    tiles = { { name = 'pink_stone2.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:pink_stone2'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:pink_stone2" }
}

core.register_node('sbo_planets:pink_stone3', {
    description = 'Pink Stone',
    tiles = { { name = 'pink_stone3.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:pink_stone3'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:pink_stone3" }
}

core.register_node('sbo_planets:blue_stone1', {
    description = 'Blue Stone',
    tiles = { { name = 'blue_stone1.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:blue_stone1'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:blue_stone1" }
}

core.register_node('sbo_planets:blue_stone2', {
    description = 'Blue Stone',
    tiles = { { name = 'blue_stone2.png' } },
    groups = { matter = 1, charged = 1, explody = 10 },
    sounds = default_matter_sounds,
})
stairs.register 'sbo_planets:blue_stone2'
sbz_api.recipe.register_craft {
    type = "crushing",
    output = "sbz_resources:pebble 9",
    items = { "sbo_planets:blue_stone2" }
}

local c = core.get_content_id

local c_nickel_fluid = c("sbz_chem:thorium_fluid_source")
local c_iron_fluid = c("sbz_chem:plutonium_fluid_source")

local c_gravel = c("sbo_crystals:amethyst")

local c_red_sand = c("sbo_planets:purple_stone1")
local c_sand = c("sbo_planets:pink_stone1")
local c_white_sand = c("sbo_planets:purple_stone2")
local c_dark_sand = c("sbo_planets:pink_stone3")
local c_black_sand = c("sbo_planets:purple_stone3")

local c_stone = c("sbo_enhanced:stone")
local c_red_stone = c("sbo_planets:blue_stone1")
local c_basalt = c("sbz_planets:blue_stone")
local c_marble = c("sbo_planets:pink_stone2")
local c_granite = c("sbo_planets:blue_stone2")

sbz_api.planets.register_type {
    name = "Purple",
    radius = { min = 120, max = 500 },
    gravity = 1,
    light = 6,
    ring_chance = 10, -- 1 in 5
    num_planets = 250,
    mapgen = function(area, minp, maxp, seed, noises, data, pdata, center)
        local shapenoise = noises.shape.noise
        local cave1noise = noises.cave1.noise
        local cave2noise = noises.cave2.noise
        local geology_noise = noises.geology.noise
        local stone_type_noise = noises.stone_type.noise
        local random_noise = noises.random.noise
        local prad = pdata[2]
        -- noise index
        local ni = 1
        local vi = 1

        local function rocks(noise)
            if stone_type_noise[ni] >= 0.1 then
                if noise <= 0.1 then
                    return c_stone
                else
                    return c_red_stone
                end
            else
                if noise > 0.25 and stone_type_noise[ni] > 0.2 then
                    return c_basalt
                elseif noise > 0.25 then
                    return c_marble
                else
                    return c_granite
                end
            end
        end


        local function mapgen(x, y, z)
            local xyzvec = vector.new(x, y, z)
            local dist_to_center = vector.distance(xyzvec, center)
            if dist_to_center <= prad - (shapenoise[ni] * 1.1) then
                -- rewriting of https://github.com/gaelysam/valleys_mapgen/blob/9a672a7a2beca2baf9f4bc99a1fb2707c02a90f7/mapgen.lua#L409 i guess(?)
                data[vi] = c_stone
                local n1, n2 = math.abs(cave1noise[ni]) < 0.07, math.abs(cave2noise[ni]) < 0.07
                if (n1 and n2) and not (dist_to_center <= (prad / 4.5)) then
                    data[vi] = c_air
                end

                if data[vi] == c_stone then
                    -- do the geology stuff
                    -- THE CORE
                    if dist_to_center <= prad / 5 then
                        if dist_to_center <= prad / 8 then   -- Dead core
                            data[vi] = c_dead_core
                        elseif geology_noise[ni] > 0.35 then -- nickel
                            data[vi] = c_nickel_fluid
                        else
                            data[vi] = c_iron_fluid
                        end
                    elseif dist_to_center >= prad - 21 and dist_to_center <= prad + 20 then -- surface, not mountains
                        if geology_noise[ni] > 0.6 then                                     -- normal sand
                            data[vi] = c_sand
                        elseif geology_noise[ni] > 0.3 then                                 -- gravel
                            data[vi] = c_gravel
                        elseif geology_noise[ni] > 0.1 then                                 -- sand shades
                            if geology_noise[ni] > 0.2 then
                                data[vi] = c_white_sand
                            elseif geology_noise[ni] > 0.15 then
                                data[vi] = c_dark_sand
                            else
                                data[vi] = c_black_sand
                            end
                        else -- red sand
                            data[vi] = c_red_sand
                        end
                    else
                        data[vi] = rocks(geology_noise[ni])
                    end
                end
            end
        end

        local should_have_rings, angles = has_rings(pdata[1], pdata[2])

        local rrad = prad + sbz_api.planets.ring_size
        local width = math.max(10, math.floor(prad / 50))
        rrad = rrad - (width + 1)

        for z = minp.z, maxp.z do
            for y = minp.y, maxp.y do
                vi = area:index(minp.x, y, z)
                for x = minp.x, maxp.x do
                    local v = vector.new(x, y, z)
                    local dist = vector.distance(v, center)
                    mapgen(x, y, z)
                    if should_have_rings and dist >= (rrad - (width + 5)) and dist <= (rrad + width + 5) and random_noise[ni] > 0.95 then
                        -- very simple, just gravel

                        -- ok now the math is not so simple... crap...
                        v = vector.add(center, vector.rotate(vector.subtract(v, center), angles))
                        if (math.sqrt((v.x - center.x) ^ 2 + (v.y - center.y) ^ 2) - rrad) ^ 2 + (v.z - center.z) ^ 2 <= width ^ 2 then
                            data[vi] = c_gravel
                        end
                    end
                    vi = vi + 1
                    ni = ni + 1
                end
            end
        end
    end
}

