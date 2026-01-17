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
sbo_api.register_wiki_page({
    type = "quest",
    title = "Emmitrex Plate",
    text = [[Emmitrex Plates are often used for machinery. They are simple to craft, yet very important.

You can get one Emmitrex Plates by placing two Emmitrex powder into the Ele Fab.]],
    requires = { "Obtain Emittrium", "Ele Fabs" }
})
