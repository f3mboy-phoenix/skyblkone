core.register_craftitem("sbo_colorium_plate:colorium_plate", {
    description = "Colorium Plate",
    inventory_image = "colorium_plate.png",
    stack_max = 256,
})
core.register_craft({
    type = "shapeless",
    output = "sbo_colorium_plate:colorium_plate 4",
    recipe = { "unifieddyes:colorium_blob" }
})
sbz_api.achievment_table["sbo_colorium_plate:colorium_plate"] = "Colorium Plate"
sbz_api.register_quest_to("Questline: Colorium",{
        type = "quest",
        title = "Colorium Plate",
        text = [[Colorium Plates are often used for machinery. They are simple to craft, yet very important.

You can get four Colorium Plates by placing one Colorium blob into the crafting grid.]],
        requires = {"Coloring Tool"}
})
