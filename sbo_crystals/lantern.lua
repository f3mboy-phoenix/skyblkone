local lantern_rules = {
    {x = 1, y = 0, z = 0},
    {x =-1, y = 0, z = 0},
    {x = 0, y = 1, z = 0},
    {x = 0, y =-1, z = 0},
    {x = 0, y = 0, z = 1},
    {x = 0, y = 0, z =-1},
}

local on_def = {
    description = "Bronze Amethyst Lantern",
    tiles = {"amethyst_block.png^amethyst_lantern_frame.png"},
    groups = {cracky = 1, level = 2},
    paramtype = "light",
    light_source = 14,
}

local off_def = {
    description = "Bronze Amethyst Lantern",
    tiles = {"amethyst_block.png^amethyst_lantern_frame.png"},
    groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
    drop = "sbo_crystals:lantern",
}

off_def.on_punch = function(pos, node, puncher)
    local name = puncher:get_player_name() or ""
    if core.is_protected(pos, name) then return end
    node.name = "sbo_crystals:lantern"
    core.swap_node(pos, node)
end
on_def.on_punch = function(pos, node, puncher)
    local name = puncher:get_player_name() or ""
    if core.is_protected(pos, name) then return end
    node.name = "sbo_crystals:lantern_off"
    core.swap_node(pos, node)
end

core.register_node("sbo_crystals:lantern", on_def)
core.register_node("sbo_crystals:lantern_off", off_def)
unified_inventory.add_category_item('deco', "sbo_crystals:lantern")
