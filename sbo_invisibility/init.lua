
-- global

invisibility = {
	effect_time = core.settings:get("invisibility.effect_time") or 180 -- 3 mins
}

-- translation and player table

local S = core.get_translator("sbo_invisibility")
local players = {}

-- reset player invisibility if they go offline or die

core.register_on_leaveplayer(function(player)

	local name = player:get_player_name()

	if players[name] then players[name] = nil end
end)

core.register_on_dieplayer(function(player)
	invisibility.invisible(player, nil)
end)

-- creative check

local creative_mode_cache = core.settings:get_bool("creative_mode")
local function is_creative(name)
	return creative_mode_cache or core.check_player_privs(name, {creative = true})
end

-- invisibility functions

function invisibility.is_visible(player_name)

	if players[player_name] then return false end

	return true
end

function invisibility.invisible(player, toggle)

	if not player then return false end

	local name = player:get_player_name()

	players[name] = toggle

	local prop

	if toggle == true then -- hide player and name tag

		prop = {visual_size = {x = 0, y = 0}}

		player:set_nametag_attributes({
			color = {a = 0, r = 255, g = 255, b = 255}
		})
	else -- show player and tag
		prop = {visual_size = {x = 1, y = 1}}

		player:set_nametag_attributes({
			color = {a = 255, r = 255, g = 255, b = 255}
		})
	end

	player:set_properties(prop)
end

-- invisibility potion

core.register_craftitem("sbo_invisibility:potion", {
	description = S("Invisibility Potion"),
	inventory_image = "invisibility_potion.png",
	wield_image = "invisibility_potion.png",
	groups = {upgrade_curio = 1, },
	--sounds = default.node_sound_glass_defaults(),

	on_use = function(itemstack, user)

		local pos = user:get_pos()
		local name = user:get_player_name()

		-- are we already invisible?
		if players[name] then

			core.chat_send_player(name, S(">>> You are already invisible!"))

			return itemstack
		end

		-- make player invisible
		invisibility.invisible(user, true)

		-- play sound
		core.sound_play("pop", {
				pos = pos, gain = 1.0, max_hear_distance = 5}, true)

		-- display 10 second warning
		core.after(invisibility.effect_time - 10, function()

			if players[name] and user:get_pos() then

				core.chat_send_player(name,
						S(">>> You have 10 seconds before invisibility wears off!"))
			end
		end)

		-- make player visible 5 minutes later
		core.after(invisibility.effect_time, function()

			if players[name] and user:get_pos() then

				-- show hidden player
				invisibility.invisible(user, nil)

				-- play sound
				core.sound_play("pop", {
						pos = user:get_pos(), gain = 1.0, max_hear_distance = 5}, true)
			end
		end)

		-- take potion, return empty bottle (and rest of potion stack)
		if not is_creative(name) then

			local item_count = user:get_wielded_item():get_count()
			local inv = user:get_inventory()
			local giving_back = ""

			if inv and item_count > 1 then
				giving_back = "sbo_invisibility:potion " .. tostring(item_count - 1)
			end

			return ItemStack(giving_back)
		end

	end
})

-- craft recipe

core.register_craft( {
	output = "sbo_invisibility:potion",
	type = "shapeless",
	recipe = {
		"sbz_bio:stemfruit", "sbz_bio:pyrograss", "sbz_bio:moss",
		"sbz_bio:warpshroom", "sbz_bio:shockshroom", "sbz_bio:cleargrass",
		"sbz_bio:fiberweed", "sbz_bio:screen_inverter_potion", "sbz_bio:algae"
	}
})

-- vanish command (admin only)

core.register_chatcommand("vanish", {
	params = "<name>",
	description = S("Make player invisible"),
	privs = {server = true},

	func = function(name, param)

		-- player online
		if param ~= "" and core.get_player_by_name(param) then

			name = param

		-- player not online
		elseif param ~= "" then

			return false, S("Player @1 is offline!", param)
		end

		local player = core.get_player_by_name(name)
		local msg

		-- hide / show player
		if players[name] then

			invisibility.invisible(player, nil) ; msg = "visible"
		else
			invisibility.invisible(player, true) ; msg = "invisible"
		end

		return true, S("Player @1 is now @2!", name, S(msg))
	end
})
sbo_api.quests.on_craft["sbo_invisibility:potion"] = "Invisibility"
sbo_api.quests.register_to("Questline: Organics",{
        type = "quest",
        title = "Invisibility",
        text =
        [[  By mixing your previous Drug with some plants you can make yourself invisible
        ]],
        requires = { "Stemfruit", "Warpshrooms", 'Fiberweed', 'Shockshrooms', 'Cleargrass',}
})
