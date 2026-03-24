core.register_node("sbo_crystals:basalt", {
    description = "Grimstone",
    tiles = {"amethyst_basalt.png"},
    groups = {matter = 2},
})

core.register_node("sbo_crystals:basalt_block", {
    description = "Grimstone Block",
    tiles = {"amethyst_basalt_block.png"},
    groups = {matter = 2},
})
unified_inventory.add_category_item('deco', "sbo_crystals:basalt_block")


core.register_node("sbo_crystals:basalt_brick", {
    description = "Grimstone Brick",
    tiles = {"amethyst_basalt_brick.png"},
    groups = {matter = 2},
})
unified_inventory.add_category_item('deco', "sbo_crystals:basalt_brick")

core.register_node("sbo_crystals:calcite", {
    description = "Calcite",
    tiles = {"amethyst_calcite.png"},
    groups = {matter = 2},
})

core.register_node("sbo_crystals:calcite_block", {
    description = "Calcite Block",
    tiles = {"amethyst_calcite_block.png"},
    groups = {matter = 2},
})
unified_inventory.add_category_item('deco', "sbo_crystals:calcite_block")

core.register_node("sbo_crystals:calcite_brick", {
    description = "Calcite Brick",
    tiles = {"amethyst_calcite_brick.png"},
    groups = {matter = 2},
})
unified_inventory.add_category_item('deco', "sbo_crystals:calcite_brick")

core.register_node("sbo_crystals:checkerboard", {
    description = "Checkerboard Block",
    tiles = {"amethyst_checkerboard.png"},
    paramtype2 = "facedir",
    groups = {matter = 2},
})
unified_inventory.add_category_item('deco', "sbo_crystals:checkerboard")

core.register_node("sbo_crystals:amethyst", {
    description = "Amethyst Block",
    tiles = {"amethyst_block.png"},
    groups = {matter = 3},
})

core.register_node("sbo_crystals:amethyst_budding", {
    description = "Budding Amethyst Block",
    tiles = {"amethyst_block.png^[combine:16x80:0,-48=crack_anylength.png"},
    groups = {matter = 3},
    drop = "sbo_crystals:amethyst_shard",
})

core.register_node("sbo_crystals:cluster_small", {
    description = "Small Amethyst Cluster",
    tiles = {"amethyst_cluster_small.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 4,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-4/16, -7/16, -4/16, 4/16, -3/16, 4/16},
    },
    groups = {amethyst = 3, not_in_creative_inventory = 1},
    drop = {
        max_items = 1,
        items = {
            items = {"sbo_crystals:amethyst_shard"},
            rarity = 6,
        }
    },
})

core.register_node("sbo_crystals:cluster_medium", {
    description = "Medium Amethyst Cluster",
    tiles = {"amethyst_cluster_medium.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 7,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, -2/16, 5/16},
    },
    groups = {amethyst = 3, not_in_creative_inventory = 1},
    drop = {
        max_items = 1,
        items = {
            items = {"sbo_crystals:amethyst_shard"},
            rarity = 3,
        }
    },
})

core.register_node("sbo_crystals:cluster_large", {
    description = "Large Amethyst Cluster",
    tiles = {"amethyst_cluster_large.png"},
    drawtype = "plantlike",
    sunlight_propagates = true,
    light_source = 10,
    paramtype = "light",
    paramtype2 = "wallmounted",
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-5/16, -8/16, -5/16, 5/16, 4/16, 5/16},
    },
    groups = {amethyst = 3},
    drop = "sbo_crystals:amethyst_shard",
})

core.register_node("sbo_crystals:tinted_glass", {
    description = "Tinted Glass",
    drawtype = "glasslike_framed_optional",
    tiles = {"amethyst_tinted_glass.png", "amethyst_tinted_glass_detail.png"},
    use_texture_alpha = "blend",
    sunlight_propagates = false,
    groups = {matter = 3},
})
unified_inventory.add_category_item('deco', "sbo_crystals:tinted_glass")

if core.get_modpath("stairs") then
    stairs.register("sbo_crystals:basalt")
    stairs.register("sbo_crystals:basalt_block")
    stairs.register("sbo_crystals:basalt_brick")
    stairs.register("sbo_crystals:calcite")
    stairs.register("sbo_crystals:calcite_block")
    stairs.register("sbo_crystals:calcite_brick")
    stairs.register("sbo_crystals:checkerboard")
end


core.register_craftitem("sbo_crystals:amethyst_shard", {
    description = "Amethyst Shard",
    inventory_image = "amethyst_shard.png",
})

core.register_craftitem("sbo_crystals:circuit", {
    description = "Amethyst Circuit",
    inventory_image = "amethyst_circuit.png",
    stack_max = 256,
})
core.register_craft({
    type = "shapeless",
    output = "sbo_crystals:circuit",
    recipe = { "sbz_resources:charged_particle", "sbo_resium:circuit", "sbo_crystals:amethyst_shard", "sbz_resources:antimatter_plate" }
})
