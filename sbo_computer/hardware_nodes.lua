
sbo_computer.register_hardware("sbo_computer:printer", {
	description = "Flash Printex",
	--infotext = 'Flash Printex',
	sequence = { "off", "powersave", "on" },
	custom_theme = "PrintOS",
	custom_launcher = "printer_launcher",
	hw_capabilities = {"hdd"},
	node_defs = {

		["powersave"] = {
			hw_state = "power_off",
			_power_off_seq = "off",
			tiles = {
				"laptop_printer_top.png",
				"laptop_printer_bottom.png",
				"laptop_printer_right.png",
				"laptop_printer_left.png",
				"laptop_printer_back.png",
				"laptop_printer_front.png",
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {choppy=2, oddly_breakably_by_hand=2, dig_immediate = 2, laptop_printer = 1, technic_machine = 1, technic_lv = 1},
			node_box = {
				type = "fixed",
				fixed = {
					{-0.375, -0.5, -0.125, 0.375, -0.125, 0.3125}, -- core
					{-0.25, -0.5, -0.375, 0.25, -0.4375, -0.125}, -- tray
					{-0.25, -0.125, 0.25, 0.25, 0.125, 0.3125}, -- charger
				}
			}
		},
		["on"] = {
			hw_state = "power_on",
			_power_off_seq = "off",
			_eu_demand = 100,
			tiles = {
				"laptop_printer_top.png",
				"laptop_printer_bottom.png",
				"laptop_printer_right.png",
				"laptop_printer_left.png",
				"laptop_printer_back.png",
				"laptop_printer_front_on.png",
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {choppy=2, oddly_breakably_by_hand=2, dig_immediate = 2, laptop_printer = 1, technic_machine = 1, technic_lv = 1},
			node_box = {
				type = "fixed",
				fixed = {
					{-0.375, -0.5, -0.125, 0.375, -0.125, 0.3125}, -- core
					{-0.25, -0.5, -0.375, 0.25, -0.4375, -0.125}, -- tray
					{-0.25, -0.125, 0.25, 0.25, 0.125, 0.3125}, -- charger
				  }
			       },
                        action=function()return 1000 end,
                        power_needed = 1000
			    },
		["off"] = {
			hw_state = "power_off",
			tiles = {
				"laptop_printer_top.png",
				"laptop_printer_bottom.png",
				"laptop_printer_right.png",
				"laptop_printer_left.png",
				"laptop_printer_back.png",
				"laptop_printer_front_off.png",
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.375, -0.5, -0.125, 0.375, -0.125, 0.3125}, -- core
					{-0.25, -0.5, -0.375, 0.25, -0.4375, -0.125}, -- tray
					{-0.25, -0.125, 0.25, 0.25, 0.125, 0.3125}, -- charger
				}
			}
		}
	}
})

minetest.register_craft({
	output = 'sbo_computer:printer_off',
	recipe = {
	{'', 'sbo_computer:motherboard', '', },
	{'', 'sbo_computer:psu', '', },
	{'', 'sbo_computer:case', '', },
	}
})

sbo_computer.register_hardware("sbo_computer:cube", {
	description = "CUBE PC",
	--infotext = "CUBE PC",
	os_version = '10.00',
	sequence = { "off", "on"},
	hw_capabilities = { "hdd", "floppy", "net", "liveboot", "usb" },
	node_defs = {
		["on"] = {
			hw_state = "power_on",
			_power_off_seq = "off",
			_eu_demand = 150,
			light_source = 4,
			tiles = {
				"laptop_cube_monitor_top.png^laptop_cube_tower_top.png",
				"laptop_cube_monitor_bottom.png^laptop_cube_tower_bottom.png",
				"laptop_cube_monitor_right.png^laptop_cube_tower_right.png",
				"laptop_cube_monitor_left.png^laptop_cube_tower_left.png",
				"laptop_cube_monitor_back.png^laptop_cube_tower_back.png",
				"laptop_cube_monitor_front_on.png^laptop_cube_tower_front_on.png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			node_box = {
					type = "fixed",
					fixed = {
					{-0.5, -0.5, -0.1875, 0.5, -0.1875, 0.5}, -- cube tower
					{-0.5, -0.5, -0.5, 0.1875, -0.4375, -0.25}, -- cube keyboard
					{0.25, -0.5, -0.5, 0.4375, -0.4375, -0.25}, -- cube mouse
					{-0.3125, -0.5, -0.125, 0.3125, 0.5, 0.4375}, -- cube monitor
				}
			},
                        action=function()return 1000 end,
                        power_needed = 1000
		},
		["off"] = {
			hw_state = "power_off",
			tiles = {
				"laptop_cube_monitor_top.png^laptop_cube_tower_top.png",
				"laptop_cube_monitor_bottom.png^laptop_cube_tower_bottom.png",
				"laptop_cube_monitor_right.png^laptop_cube_tower_right.png",
				"laptop_cube_monitor_left.png^laptop_cube_tower_left.png",
				"laptop_cube_monitor_back.png^laptop_cube_tower_back.png",
				"laptop_cube_monitor_front.png^laptop_cube_tower_front.png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			node_box = {
					type = "fixed",
					fixed = {
					{-0.5, -0.5, -0.1875, 0.5, -0.1875, 0.5}, -- cube tower
					{-0.5, -0.5, -0.5, 0.1875, -0.4375, -0.25}, -- cube keyboard
					{0.25, -0.5, -0.5, 0.4375, -0.4375, -0.25}, -- cube mouse
					{-0.3125, -0.5, -0.125, 0.3125, 0.5, 0.4375}, -- cube monitor
				}
			}
		}
	}
})

minetest.register_craft({
	output = 'sbo_computer:cube_off',
	recipe = {
	{'sbo_computer:gpu', 'sbo_computer:crt', 'sbo_liquids:cooling_coil', },
	{'sbo_computer:HDD', 'sbo_computer:motherboard', 'sbo_computer:psu', },
	{'sbo_computer:cpu_65536', 'sbo_computer:case', 'unifieddyes:colorium', },
	}
})
