local S = sbo_upgrades.translator

sfinv.register_page("sbo_upgrades:ugpacks", {
	title = S("Upgrades"),
	get = function(self, player, context)
		local name = player:get_player_name()
		return sfinv.make_formspec(player, context, ([[
			label[3,0.7;%s]
			list[current_player;ugpacks;3,1.5;2,2;]
			listring[current_player;main]"
			listring[current_player;ugpacks]
			]]):format(S("Upgrades")), true)
	end
})
