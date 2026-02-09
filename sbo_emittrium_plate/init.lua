minetest.register_craftitem("sbo_emittrium_plate:emittrium_plate", {
    description = "Emmitrex Plate",
    inventory_image = "emittrium_plate.png",
    stack_max = 256,
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_emittrium_plate:emittrium_plate",
    items = {
        "sbo_emmitrex:emmitrex_powder 2",
    },
    width = 2,
    height = 1
})
sbo_api.quests.in_inven["sbo_emittrium_plate:emittrium_plate"] = "Emittrium Plate"
sbo_api.quests.register_to("Questline: Emittrium",{
        type = "quest",
        title = "Emittrium Plate",
        text = [[Emittrium Plates are often used for machinery. They are simple to craft, yet very important.

You can get one Emittrium Plates by placing two Raw Emittrium into the Ele Fab.]],
        requires = {"Obtain Emittrium","Ele Fabs"}
})
