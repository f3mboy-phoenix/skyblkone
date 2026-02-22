local rc = sbo_computer.recipe_compat -- Recipe items from other mods

----------------------------
---------PROCESSORS---------
----------------------------

minetest.register_craftitem("sbo_computer:cpu_65536", {
	description = 'Transpose 65536 Processor',
	inventory_image = "laptop_cpu_65536.png",
})

minetest.register_craft({
	output = 'sbo_computer:cpu_65536',
	recipe = {
		{'', '', ''},
		{rc.silicon, rc.copper, rc.silicon},
		{rc.gates_not, rc.fpga, rc.delayer},
	}
})

minetest.register_craftitem("sbo_computer:case", {
	description = 'Case',
	inventory_image = "laptop_case.png",
})

minetest.register_craft({
	output = 'sbo_computer:case',
	recipe = {
		{'sbo_emmitrex:emmitrex_ingot', 'sbo_emmitrex:emmitrex_ingot', 'sbo_emmitrex:emmitrex_ingot'},
		{'sbo_emmitrex:emmitrex_ingot', '',                            'sbo_emmitrex:emmitrex_ingot'},
		{'sbo_emmitrex:emmitrex_ingot', 'sbo_emmitrex:emmitrex_ingot', 'sbo_emmitrex:emmitrex_ingot'},
	}
})

minetest.register_craftitem("sbo_computer:crt", {
	description = 'CRT Screen',
	inventory_image = "laptop_crt.png",
})

minetest.register_craft({
	output = 'sbo_computer:crt',
	recipe = {
		{rc.glass, rc.glass, rc.glass},
		{rc.light_red , rc.light_green, rc.light_blue},
		{rc.steel, "sbo_extrosim_glass:extrosim_glass", rc.steel},
	}
})

minetest.register_craftitem("sbo_computer:gpu", {
	description = 'GPU',
	inventory_image = "laptop_gpu.png",
})

minetest.register_craft({
	output = 'sbo_computer:gpu',
	recipe = {
		{rc.steel, rc.silicon, rc.steel},
		{'sbo_liquids:cooling_coil', rc.fpga, 'sbo_liquids:cooling_coil'},
		{rc.steel, rc.silicon, rc.steel},
	}
})

minetest.register_craftitem("sbo_computer:HDD", {
	description = 'Hard Drive',
	inventory_image = "laptop_harddrive.png",
})

minetest.register_craft({
	output = 'sbo_computer:HDD',
	recipe = {
		{rc.steel, rc.steel, rc.steel},
		{rc.steel, "sbz_logic:data_disk", rc.steel},
		{rc.steel, rc.steel, rc.steel},
	}
})

minetest.register_craftitem("sbo_computer:motherboard", {
	description = 'Motherboard',
	inventory_image = "laptop_motherboard.png",
})

minetest.register_craft({
	output = 'sbo_computer:motherboard',
	recipe = {
		{rc.controller, rc.fpga, rc.gates_nand},
		{'unifieddyes:colorium', 'unifieddyes:colorium', 'unifieddyes:colorium'},
		{rc.steel, rc.copper, rc.steel},
	}
})

minetest.register_craftitem("sbo_computer:psu", {
	description = 'PSU',
	inventory_image = "laptop_psu.png",
})

minetest.register_craft({
	output = 'sbo_computer:psu',
	recipe = {
		{rc.steel, rc.lv_transformer, rc.steel},
		{"sbz_resources:phlogiston", rc.fpga, 'sbo_liquids:cooling_coil'},
		{rc.steel, rc.lv_transformer, rc.steel},
	}
})

minetest.register_craftitem("sbo_computer:usbstick", {
	description = 'USB storage stick',
	inventory_image = "laptop_usb.png",
	groups = {laptop_removable_usb = 1, upgrade_curio = 1},
	stack_max = 1,
})

minetest.register_craft({
	output = 'sbo_computer:usbstick',
	recipe = {
		{'', rc.silicon, ''},
		{'', rc.programmer, ''},
		{'', rc.plastic, ''},
	}
})

minetest.register_craftitem("sbo_computer:printed_paper", {
	description = 'Printed paper',
	inventory_image = "laptop_printed_paper.png",
	groups = {not_in_creative_inventory = 1},
	stack_max = 1,
	on_use = function(itemstack, user)
		local meta = itemstack:get_meta()
		local data = meta:to_table().fields
		local formspec = "size[8,8]" .. --default.gui_bg .. default.gui_bg_img ..
				"label[0,0;" .. minetest.formspec_escape(data.title or "unnamed") ..
				" by " .. (data.author or "unknown") .. " from " .. os.date("%c", data.timestamp) .. "]"..
				"textarea[0.5,1;7.5,7;;" ..
				minetest.formspec_escape(data.text or "test text") .. ";]"
	minetest.show_formspec(user:get_player_name(), "sbo_computer:printed_paper", formspec)
	return itemstack
	end
})
