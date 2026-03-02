
local S = minetest.get_translator("sbo_mutator")

sbo_api.mutations= {}
sbo_api.mutations.can_turn_into = sbz_api.bio_can_turn_into
sbo_api.mutations.special_cases = sbz_api.bio_special_cases

local function mutate(stack, player, pointed)
	if not stack or not player or not pointed then
		return
	end
	local controls = player:get_player_control()
	local pos
	if controls.aux1 then
		pos = vector.round(player:get_pos())
	elseif pointed.type == "node" then
		if controls.sneak then
			pos = pointed.above
		else
			pos = pointed.under
		end
	else
		return
	end
	local name = player:get_player_name()
	
	local meta = stack:get_meta()
	local node = minetest.get_node(pos)
	local spos = minetest.pos_to_string(pos)
	local val = core.get_item_group(node.name, 'plant')
	if val and val == 1 and stack:get_wear() ~= 65000 then
		local nn = node.name
		local basename = string.sub(nn, 1, -3)
		local stage = string.sub(nn, -2)
		local possibilities = sbo_api.mutations.can_turn_into[basename]
		local should_turn_into = possibilities[math.random(1, #possibilities)]
		local newnode = table.copy(node)
		local nodepos = vector.copy(pos)
		if sbo_api.mutations.special_cases[should_turn_into] then
			if should_turn_into == 'sbz_bio:fiberweed' then
				if core.get_node(vector.subtract(nodepos, vector.new(0, 1, 0))).name == 'sbz_bio:dirt' then
					nodepos = vector.subtract(nodepos, vector.new(0, 1, 0))
					should_turn_into = 'sbz_bio:fiberweed'
				else
					return true -- can't mutate
				end
			end
			newnode.name = should_turn_into
		else
			newnode.name = should_turn_into .. stage
		end
		minetest.chat_send_player(name,tostring(newnode.name))
		core.swap_node(nodepos, newnode)
		minetest.chat_send_player(name,tostring(stack:get_wear()))
        stack:add_wear(5000)
    end
	return stack
end

minetest.register_tool("sbo_mutator:gun", {
	description = S("Mutator"),
	inventory_image = "mutator_inv.png",
	wield_image = "mutator_wield.png",
	groups = {tool = 1, upgrade_curio = 1, },
	on_use = mutate,

    on_place = sbz_api.on_place_recharge((500 / 65535) * 10, function(stack, user, pointed)
		minetest.chat_send_player(user:get_player_name(),tostring(stack:get_wear()))
    end),
    powertool_charge = sbz_api.powertool_charge((500 / 65535) * 10),
    charge_per_use = 10,
    wear_represents = "power",

    wear_color = { color_stops = { [0] = "lime" } },
})

dofile(minetest.get_modpath("sbo_mutator").."/crafting.lua")
