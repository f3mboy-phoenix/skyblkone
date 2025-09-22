local S = sbo_upgrades.translator
local ui = unified_inventory

ui.register_button("ugpacks", {
	type = "image",
	image = "heart.png",
	tooltip = S("Upgrades")
})

ui.register_page("ugpacks", {
	get_formspec = function(player, perplayer_formspec)
		local y = perplayer_formspec.formspec_y

		return { formspec = (
			ui.style_full.standard_inv_bg ..
			ui.make_inv_img_grid(.5, (y+0.6), 8, 3, true) ..
			"no_prepend[]" ..
			"label["..ui.style_full.form_header_x..","..ui.style_full.form_header_y..";" .. S("Upgrades") .. "]" ..
			"list[current_player;ugpacks;.5," .. (y + 0.7) .. ";8,3;]" ..
			"listring[current_player;main]"..
			"listring[current_player;ugpacks]"
		), draw_inventory = true}
	end
})
