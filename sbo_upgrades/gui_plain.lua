local S = sbo_api.upgrades.translator

minetest.register_chatcommand("sbo_upgrades", {
	description = S("Allows using upgrade packs without CSM"),
	func = function(name, param)
		minetest.show_formspec(name, "sbo_upgrades:gui_plain", ([[
			size[8,7]
			label[3,0;%s]
			list[current_player;ugpacks;2,1;4,1;]
			list[current_player;main;0,3;8,4;]
			listring[]
			]]):format(S("Upgrades"))
		)
	end
})
