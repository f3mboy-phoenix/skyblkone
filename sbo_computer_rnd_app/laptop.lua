
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
	receive_fields_func = rnd.duplication.on_player_receive_fields_duplicate,
	app_icon = "rnd_button_duplication_page.png",
})

