rnd = {}

--MP = Mod Path
rnd.mp = minetest.get_modpath(minetest.get_current_modname())..'/apps/rnd/'



--If default is loaded, grab its hotbar background image
local hotbar_bg = ""

if default then
	hotbar_bg = default.get_hotbar_bg(0,5.2)
end

--The size and player inventory menu, used for both the research and duplication menus
rnd.base_inv_formspec = "size[8,9.1]"..
			"list[current_player;main;0,5.2;8,1;]"..
			"list[current_player;main;0,6.35;8,3;8]"..
			hotbar_bg

if unified_inventory then
	rnd.base_unified_formspec = 
			"list[current_player;main;0,4.5;8,4;]"
end

--A custom API file that I find a little more convenient than the usual mod storage API.
dofile(rnd.mp.."storage.lua")

--All of the functionality of the research menu
dofile(rnd.mp.."research.lua")

--All of the functionality of the duplication menu
dofile(rnd.mp.."duplication.lua")

sbo_computer.register_app("research", {
	app_name = "Research",
	app_info = "Research",
	formspec_func = rnd.research.research_formspec,
	receive_fields_func = rnd.research.on_player_receive_fields_research,
	app_icon = "rnd_button_research_page.png",
})

sbo_computer.register_app("duplicate", {
	app_name = "Duplicate",
	app_info = "Duplicate",
	formspec_func = rnd.duplication.duplication_formspec,
	receive_fields_func = rnd.duplication.on_player_receive_fields_duplication,
	app_icon = "rnd_button_duplication_page.png",
})

