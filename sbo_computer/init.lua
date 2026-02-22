sbo_computer = {}
sbo_computer.class_lib = {}
dofile(minetest.get_modpath('sbo_computer')..'/themes.lua')
dofile(minetest.get_modpath('sbo_computer')..'/block_devices.lua')
dofile(minetest.get_modpath('sbo_computer')..'/app_fw.lua')
dofile(minetest.get_modpath('sbo_computer')..'/mtos.lua')
dofile(minetest.get_modpath('sbo_computer')..'/hardware_fw.lua')
dofile(minetest.get_modpath('sbo_computer')..'/recipe_compat.lua')
dofile(minetest.get_modpath('sbo_computer')..'/hardware_nodes.lua')
dofile(minetest.get_modpath('sbo_computer')..'/craftitems.lua')

unified_inventory.register_category('sbo_computer', {
	symbol = "sbo_computer:usbstick",
	label = "Computer"
})
quests[#quests+1]={ type = "text", title = "Questline: Computer", text = [[This questline explains how to create a computer]] }

unified_inventory.add_category_item('sbo_computer', "sbo_computer:cpu_65536")
sbo_api.quests.on_craft["sbo_computer:cpu_65536"] = "Cpu"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Cpu",
    text = [[The Brain of the Computer.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:case")
sbo_api.quests.on_craft["sbo_computer:case"] = "Case"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Case",
    text = [[The Skin of the Computer.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:crt")
sbo_api.quests.on_craft["sbo_computer:cpu_65536"] = "Crt"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Crt",
    text = [[The Hands of the computer?]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:gpu")
sbo_api.quests.on_craft["sbo_computer:gpu"] = "Gpu"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Gpu",
    text = [[The Eyes of the Computer.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:HDD")
sbo_api.quests.on_craft["sbo_computer:HDD"] = "Hard drive"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Hard drive",
    text = [[The computers clothing pockets.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:motherboard")
sbo_api.quests.on_craft["sbo_computer:motherboard"] = "Motherboard"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Motherboard",
    text = [[The Other organs of the computer.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:psu")
sbo_api.quests.on_craft["sbo_computer:psu"] = "Power Supply Unit"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Power Supply Unit",
    text = [[The God of the Computer.]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:usbstick")
sbo_api.quests.on_craft["sbo_computer:usbstick"] = "Usb stick"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Usb stick",
    text = [[A USB Stick is a mobile form of storage can be used for moving things between computers.
can be placed in upgrades inventory]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:printed_paper")

unified_inventory.add_category_item('sbo_computer', "sbo_computer:printer_off")
sbo_api.quests.on_craft["sbo_computer:printer_off"] = "Printer"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "Printer",
    text = [[The Mouth of the computer.
Requites Matter Dust in the dye tray, Paper in the paper tray. when you print, printed paper will appear in the output tray]],
    requires = { "Automation", }
})

unified_inventory.add_category_item('sbo_computer', "sbo_computer:cube_off")
sbo_api.quests.on_craft["sbo_computer:cube_off"] = "The Computer"
sbo_api.quests.register_to("Questline: Computer",{
    type = "quest",
    title = "The Computer",
    text = [[
The Computer has no actual uses in sbz uses yet but can be used for developement, entertainment, and comunication.

Apps:
	MineBrowse: Internet Browser
	Calculator: Simple calculator app.
	CS-BOS Prompt: The command line interface, Type HELP to start
	Settings: allows you to change the theme.
	Lua VM: allows you to manualy run raw lua code only if you have server Privs (somthing you dont have by default in singleplayer)
	Mail: send electronic mail (only really useful in multiplayer)
	Painting: Draw saveable pictures on a 16x16 or 32x32 grid.
	Real Chess: Chess board game
	Removable Storage: access usb ports
	Notepad: Write saveable notes
	Tetris: Play Tetris
	Tnt Sweeper: Play Tnt Sweeper
]],
    requires = { "Automation"}
})


