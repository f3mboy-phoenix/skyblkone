quests[#quests+1]={ type = "text", title = "Questline: Colorium", text = "Colorium Based Questline" }
sbo_api.quests.on_craft["sbz_bio:colorium_planks"] = "Getting Wood"
sbo_api.quests.register_to("Questline: Colorium",{
    type = "quest",
    title = "Getting Wood",
    text =
        [[Punch a tree until a block of wood pops out.]],
    requires = { "Dirt", }
})

--sbo_colorium_circuit
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_colorium:circuit",
    items = {
        "unifieddyes:colorium 4",
        "sbz_resources:antimatter_plate 2"
    },
    width = 2,
    height = 1
})
minetest.register_craftitem("sbo_colorium:circuit", {
    description = "Colorium Circuit",
    inventory_image = "colorium_circuit.png",
    stack_max = 256,
})

core.register_alias("sbo_colorium_circuit:colorium_circuit", "sbo_colorium:circuit")

sbo_api.quests.on_craft["sbo_colorium:circuit"] = "Colorium Circuit"
sbo_api.quests.register_to("Questline: Colorium",{
        type = "quest",
        title = "Colorium Circuit",
        text = [[Colorium Circuits are often used for machinery. They are simple to craft, yet very important.

Crafted using the Ele Fab, Requires 4 Colorium and 2 Antimatter Plates
]],
        requires = {"Coloring Tool"}
})

--sbo_colorium_plate
core.register_craftitem("sbo_colorium:plate", {
    description = "Colorium Plate",
    inventory_image = "colorium_plate.png",
    stack_max = 256,
})
core.register_alias("sbo_colorium_plate:colorium_plate", "sbo_colorium:plate")

core.register_craft({
    type = "shapeless",
    output = "sbo_colorium:plate 4",
    recipe = { "unifieddyes:colorium_blob" }
})
sbo_api.quests.on_craft["sbo_colorium:plate"] = "Colorium Plate"
sbo_api.quests.register_to("Questline: Colorium",{
        type = "quest",
        title = "Colorium Plate",
        text = [[Colorium Plates are often used for machinery. They are simple to craft, yet very important.

You can get four Colorium Plates by placing one Colorium blob into the crafting grid.]],
        requires = {"Coloring Tool"}
})

--sbo_rein_colorium
minetest.register_node("sbo_colorium:reinforced_colorium", {
    description = "Reinforced Colorium",
    drawtype = "glasslike",
    tiles = { "reinforced_colorium.png" },
    groups = { matter = 1, },
    sunlight_propagates = true,
    paramtype = "light",
    light_source = 10,
    walkable = true,
})
core.register_alias("sbo_rein_colorium:reinforced_colorium", "sbo_colorium:reinforced_colorium")

minetest.register_craft({
    output = "sbo_rein_colorium:reinforced_colorium",
    recipe = {
        { "",                   "sbo_colorium:plate",        "" },
        { "sbo_colorium:plate", "unifieddyes:colorium_blob", "sbo_colorium:plate" },
        { "",                   "sbo_colorium:plate",        "" }
    }
})
sbo_api.quests.on_craft["sbo_colorium:reinforced_colorium"] = "Reinforced Colorium"
sbo_api.quests.register_to("Questline: Colorium",{
    type = "quest",
    title = "Reinforced Colorium",
    text =
        [[Colorium that is blast resistive.]],
})

