sbo_computer.register_app("shell", {
	app_name = "Shell",
	app_info = "CS-BOS Graphic Shell",
	fullscreen = true,
	app_icon = "laptop_????.png",
	os_min_version = '1.00',
	os_max_version = "4.99",
	formspec_func = function(...)
		--re-use the default launcher screen
		return sbo_computer.apps["launcher"].formspec_func(...)
	end,
	receive_fields_func = function(...)
		--re-use the default launcher processing
		return sbo_computer.apps["launcher"].receive_fields_func(...)
	end,
	appwindow_formspec_func = function(...)
		--re-use the default launcher theming
		return sbo_computer.apps["launcher"].appwindow_formspec_func(...)
	end,
})
