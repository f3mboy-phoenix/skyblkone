minetest.register_craftitem("sbo_emittrium_plate:emittrium_plate", {
    description = "Emittrium Plate",
    inventory_image = "emittrium_plate.png",
    stack_max = 256,
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_emittrium_plate:emittrium_plate",
    items = {
        "sbz_resources:raw_emittrium 2",
    },
    width = 2,
    height = 1
})
sbz_api.achievement_in_inventory_table["sbo_emittrium_plate:emittrium_plate"] = "Emittrium Plate"
sbz_api.register_quest_to("Questline: Emittrium",{
        type = "quest",
        title = "Emittrium Plate",
        text = [[Emittrium Plates are often used for machinery. They are simple to craft, yet very important.

You can get one Emittrium Plates by placing two Raw Emittrium into the Ele Fab.]],
        requires = {"Obtain Emittrium","Ele Fabs"}
})
