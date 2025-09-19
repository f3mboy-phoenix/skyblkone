sbz_api.register_element("cuti", "#814f2f", "Copper Titanium %s (CuTi)", { disabled = false, part_of_crusher_drops = false }, "sbo_cuti:")
sbz_api.recipe.register_craft {
    output = 'sbo_cuti:cuti_powder',
    items = { 'sbz_chem:copper_powder',
     'sbz_chem:titanium_powder' },
    type = 'alloying',
}
