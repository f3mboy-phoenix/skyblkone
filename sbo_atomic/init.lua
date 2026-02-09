-- concept shamelessly borrowed from techage

local animation_def = {
    type = "vertical_frames",
    aspect_w = 16,
    aspect_h = 16,
    length = 1,
}

local function get_possible_recipe(list, rtype, inv)
    -- this is not the ideal way to do it
    -- lets just say that LMAO
    -- this is O(spagetti)

    -- if you need to copy this function
    -- consider making an api for this, and making it like... more efficent

    -- Phoenix: Maybe next update lol
    local internal_recipe_list = {}
    local out = {}
    for k, v in pairs(list) do
        local str = v:get_name()
        internal_recipe_list[#internal_recipe_list + 1] = unified_inventory.get_usage_list(str)
    end
    for k, v in pairs(internal_recipe_list) do
        for kk, vv in ipairs(v) do
            if vv.type == rtype then
                out[#out + 1] = {
                    out = vv.output,
                    items = vv.items,
                }
            end
        end
    end

    for k, v in pairs(out) do
        local succ = true
        for kk, vv in pairs(v.items) do
            if not inv:contains_item("input", vv) then
                succ = false
                break
            end
        end
        if succ then
            return v
        end
    end
    return {}
end

sbz_api.recipe.register_craft_type {
    type = 'atomic',
    description = 'Atomic Reconstruction',
    icon = 'reconstructor.png^[verticalframe:8:1',
    width = 2,
    height = 2,
    uses_crafting_grid = 1,
    single = false,
}


local power_needed = 30000

sbz_api.register_stateful_machine("sbo_atomic:reconstructor", {
    description = "Atomic Reconstructor",
    tiles = {
        "reconstructor_top.png",
        "reconstructor_top.png",
        "reconstructor.png^[verticalframe:8:1"
    },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("input", 4)
        inv:set_size("output", 1)
        meta:set_string("formspec", [[
formspec_version[7]
size[8.2,9]
style_type[list;spacing=.2;size=.8]
list[context;output;6,2;1,1;]
list[context;input;1,2;2,2;]
list[current_player;main;0.2,5;8,4;]
listring[current_player;main]listring[context;input]listring[current_player;main]listring[context;output]listring[current_player;main]
]])
    end,
    autostate = true,
    action = function(pos, node, meta, supply, demand)
        local inv = meta:get_inventory()

        local recipe = get_possible_recipe(inv:get_list("input"), "atomic", inv)
        if not recipe.out then
            meta:set_string("infotext", "Idle")
            return 0
        end

        if not inv:room_for_item("output", recipe.out) then
            meta:set_string("infotext", "Full")
            return 0
        end

        if demand + power_needed > supply then
            meta:set_string("infotext", "Not enough power")
            return power_needed, false
        end

        for k, v in pairs(recipe.items) do
            inv:remove_item("input", v)
        end
        inv:add_item("output", recipe.out)

        meta:set_string("infotext", "Working")

        return power_needed
    end,
    input_inv = "input",
    output_inv = "output",
    groups = {
        matter = 1,
    }
}, {
    light_source = 14,
    tiles = {
        [3] = { name = "reconstructor.png", animation = animation_def },
    }
})

minetest.register_craft {
    output = "sbo_atomic:reconstructor",
    recipe = {
        { "sbo_extrex:extrex_block",           "sbo_colorium_plate:colorium_plate", "sbo_extrex:extrex_block" },
        { "sbo_shock_circuit:shock_processor", "sbo_resium_reactor:reactor_glass",  "sbo_shock_circuit:shock_processor" },
        { "sbz_power:simple_charged_field",    "sbo_colorium_plate:colorium_plate", "sbz_power:simple_charged_field" }
    }
}


minetest.register_craftitem("sbo_atomic:carbon", {
    description = "Carbon",
    inventory_image = "atom.png^[colorize:black:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:nitrogen", {
    description = "Nitrogen",
    inventory_image = "atom.png^[colorize:green:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:oxygen", {
    description = "Oxygen",
    inventory_image = "atom.png^[colorize:aqua:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:hydrogen", {
    description = "Hydrogen",
    inventory_image = "atom.png^[colorize:blue:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:helium", {
    description = "Helium",
    inventory_image = "atom.png^[colorize:red:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:fluorine", {
    description = "Fluorine",
    inventory_image = "atom.png^[colorize:green:75",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:phosphorus", {
    description = "Phosphorus",
    inventory_image = "atom.png^[colorize:red:75",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:sulfur", {
    description = "Sulfur",
    inventory_image = "atom.png^[colorize:yellow:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:chlorine", {
    description = "Chlorine",
    inventory_image = "atom.png^[colorize:green:90",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:neon", {
    description = "Neon",
    inventory_image = "atom.png^[colorize:white:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:iodine", {
    description = "Iodine",
    inventory_image = "atom.png^[colorize:blue:75",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:technetium", {
    description = "Technetium",
    inventory_image = "atom.png^[colorize:grey:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:indium", {
    description = "Indium",
    inventory_image = "atom.png^[colorize:purple:50",
    stack_max = 256,
})
minetest.register_craftitem("sbo_atomic:gallium", {
    description = "Gallium",
    inventory_image = "atom.png^[colorize:orange:50",
    stack_max = 256,
})
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:gallium',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:core_dust' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:indium',
    items = { 'sbo_nexus:alloy537_powder', 'sbo_emmitrex:emmitrex_powder' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:technetium',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:matter_dust' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:iodine',
    items = { 'sbo_nexus:alloy537_powder', 'sbo_photon:photon' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:neon',
    items = { 'sbo_nexus:alloy537_powder', 'unifieddyes:colorium_powder' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:chlorine',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:strange_dust' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:sulfur',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:shock_crystal' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:phosphorus',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:phlogiston' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:fluorine',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:pebble' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:oxygen',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_instatube:instantinium' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:helium',
    items = { 'sbo_nexus:alloy537_powder', 'sbo_neutrons:neutron' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:hydrogen',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:antimatter_dust' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:nitrogen',
    items = { 'sbo_nexus:alloy537_powder', 'sbz_resources:charged_particle' },
    type = 'atomic',
}
sbz_api.recipe.register_craft {
    output = 'sbo_atomic:carbon',
    items = { 'sbo_nexus:alloy537_powder', 'sbo_life:essence' },
    type = 'atomic',
}

sbo_api.quests.on_craft["sbo_atomic:reconstructor"] = "Atomic Reconstructor"
sbo_api.quests.register_to("Questline: Atomic",{
    type = "quest",
    title = "Atomic Reconstructor",
    text =
        [[So the atomic reconstructor takes in Alloy 537 and a catalyst to create a new element
not really much use for them yet but maybe in the future]],
    requires = { "Colorium Plate", "Shock Circuit", }
})
