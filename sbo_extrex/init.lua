unified_inventory.register_craft {
    output = 'sbo_extrex:extrex_powder',
    items = { 'sbo_extrosim:raw_extrosim 2', 'sbo_cuti:cuti_powder 5' },
    type = 'ele_fab',
    width = 2,
    height = 1
}

sbz_api.register_element("extrex", "#FF8800", "Extrex %s",
    { part_of_enhanced_drops = false, part_of_crusher_drops = false, fluid = 1 }, "sbo_extrex:")

sbo_api.quests.in_inven["sbo_extrex:extrex_powder"] = "Extrex"
sbo_api.quests.register_to("Questline: Extrosim",{
    type = "quest",
    title = "Extrex",
    text =
        [[Extrex is a high end Extrosim Crafting Recipe.
Crafted using the Ele fab, Requires 4 Extrosim Crystals and 2 Copper Titanium Powder
]],
    requires = { "Ele Fab", "Obtain Extrosim" }
})
