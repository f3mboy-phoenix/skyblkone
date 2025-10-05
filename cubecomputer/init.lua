laptop = {}
laptop.class_lib = {}
dofile(minetest.get_modpath('laptop')..'/themes.lua')
dofile(minetest.get_modpath('laptop')..'/block_devices.lua')
dofile(minetest.get_modpath('laptop')..'/app_fw.lua')
dofile(minetest.get_modpath('laptop')..'/mtos.lua')
dofile(minetest.get_modpath('laptop')..'/hardware_fw.lua')
dofile(minetest.get_modpath('laptop')..'/recipe_compat.lua')
dofile(minetest.get_modpath('laptop')..'/hardware_nodes.lua')
dofile(minetest.get_modpath('laptop')..'/craftitems.lua')

unified_inventory.register_category('laptop', {
	symbol = "laptop:floppy",
	label = "Computer"
})
unified_inventory.add_category_item('laptop', "laptop:cpu_65536")
unified_inventory.add_category_item('laptop', "laptop:case")
unified_inventory.add_category_item('laptop', "laptop:crt")
unified_inventory.add_category_item('laptop', "laptop:gpu")
unified_inventory.add_category_item('laptop', "laptop:HDD")
unified_inventory.add_category_item('laptop', "laptop:motherboard")
unified_inventory.add_category_item('laptop', "laptop:fan")
unified_inventory.add_category_item('laptop', "laptop:psu")
unified_inventory.add_category_item('laptop', "laptop:floppy")
unified_inventory.add_category_item('laptop', "laptop:usbstick")
unified_inventory.add_category_item('laptop', "laptop:printed_paper")
unified_inventory.add_category_item('laptop', "laptop:printer_off")
unified_inventory.add_category_item('laptop', "laptop:cube_off")
