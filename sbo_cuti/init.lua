sbz_api.register_modded_element("cuti", "#814f2f", "Copper Titanium %s (CuTi)", { disabled = false, part_of_crusher_drops = false }, "sbo_cuti:")
sbz_api.simple_alloy_furnace_recipes[#sbz_api.simple_alloy_furnace_recipes+1]={ recipe = { "sbz_chem:titanium_powder", "sbz_chem:copper_powder" }, output = { "sbo_cuti:cuti_powder" } }
