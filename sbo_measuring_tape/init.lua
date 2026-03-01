
local S = minetest.get_translator("sbo_mesuring_tape")

local function measure(stack, player, pointed)
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
	local start = meta:get("start_pos")
	local spos = minetest.pos_to_string(pos)
	if not start then
		meta:set_string("start_pos", spos)
		minetest.chat_send_player(name, S("Start position set to @1", spos))
		return stack
	end
	start = minetest.string_to_pos(start)
	minetest.chat_send_player(name, S("End position set to @1", spos))
	meta:set_string("start_pos", "")
	local dist = vector.distance(start, pos)
	dist = string.format("%s", math.floor(dist * 100) / 100).."m"
	local offset = vector.subtract(pos, start)
	local x, y, z = math.abs(offset.x), math.abs(offset.y), math.abs(offset.z)
	local size = string.format("%s x %s x %s", x+1, y+1, z+1)
	minetest.chat_send_player(name, S("Distance: @1 | Size: @2", dist, size))
	return stack
end

minetest.register_tool("sbo_mesuring_tape:tape", {
	description = S("Measuring Tape"),
	inventory_image = "tape_measure_inv.png",
	wield_image = "tape_measure_wield.png",
	groups = {tool = 1, upgrade_curio = 1, },
	on_use = measure,
})

dofile(minetest.get_modpath("sbo_mesuring_tape").."/crafting.lua")
