local function wire(len, stretch_to)
    local full = 0.5
    local base_box = { -len, -len, -len, len, len, len }
    if stretch_to == "top" then
        base_box[5] = full
    elseif stretch_to == "bottom" then
        base_box[2] = -full
    elseif stretch_to == "front" then
        base_box[3] = -full
    elseif stretch_to == "back" then
        base_box[6] = full
    elseif stretch_to == "right" then
        base_box[4] = full
    elseif stretch_to == "left" then
        base_box[1] = -full
    end
    return base_box
end

local wire_size = 1 / 8

minetest.register_node("sbo_rein_cable:power_pipe", {
    description = "Reinforced Power Cable",
    connects_to = { "group:pipe_connects" },
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },

    tiles = { "rein_power_pipe.png" },
    drawtype = "nodebox",
    light_source = 3,
    paramtype = "light",
    sunlight_propagates = true,

    groups = { matter = 1, cracky = 3, pipe_connects = 1, pipe_conducts = 1, habitat_conducts = 1 },

    node_box = {
        type = "connected",
        disconnected = wire(wire_size),
        connect_top = wire(wire_size, "top"),
        connect_bottom = wire(wire_size, "bottom"),
        connect_front = wire(wire_size, "front"),
        connect_back = wire(wire_size, "back"),
        connect_left = wire(wire_size, "left"),
        connect_right = wire(wire_size, "right"),
    },
    use_texture_alpha = "clip",
})

minetest.register_craft({
    type = "shapeless",
    output = "sbo_rein_cable:power_pipe",
    recipe = { "sbz_power:power_pipe", "sbo_emittrium_plate:emittrium_plate" }
})

minetest.register_node("sbo_rein_cable:airtight_power_cable", {
    description = "Reinforced Airtight Emittrium Power Cable",
    connects_to = { "group:pipe_connects" },
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },

    tiles = { "rein_airtight_power_cable.png" },

    drawtype = "mesh",
    mesh = "voxelmodel.obj",
    light_source = 3,
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,

    groups = { matter = 1, cracky = 3, pipe_connects = 1, pipe_conducts = 1, habitat_conducts = 0 },

    use_texture_alpha = "clip",
})

minetest.register_craft {
    output = "sbo_rein_cable:airtight_power_cable",
    type = "shapeless",
    recipe = {
        "sbo_rein_cable:power_pipe", "sbz_resources:emittrium_glass",
    }
}
