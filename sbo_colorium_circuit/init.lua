unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_colorium_circuit:colorium_circuit",
    items = {
        "unifieddyes:colorium 4",
        "sbz_resources:antimatter_plate 2"
    },
    width = 2,
    height = 1
})
minetest.register_craftitem("sbo_colorium_circuit:colorium_circuit", {
    description = "Colorium Circuit",
    inventory_image = "colorium_circuit.png",
    stack_max = 256,
})
sbz_api.achievment_table["sbo_colorium_circuit:colorium_circuit"] = "Colorium Plate"
sbz_api.register_quest_to("Questline: Colorium",{
        type = "quest",
        title = "Colorium Circuit",
        text = [[Colorium Circuits are often used for machinery. They are simple to craft, yet very important.

Crafted using the Ele Fab, Requires 4 Colorium and 2 Antimatter Plates
]],
        requires = {"Coloring Tool"}
})
