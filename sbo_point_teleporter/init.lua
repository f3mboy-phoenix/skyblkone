local S = minetest.get_translator("sbo_point_teleporter")

local REACH = 20.0

teletool = {}

--[[ Load settings, apply default settings ]]
teletool.settings = {}
teletool.settings.avoid_collisions = true
teletool.settings.adjust_head = true
teletool.settings.cost_mana = 20

local adjust_head = minetest.settings:get_bool("teletool_adjust_head")
if adjust_head ~= nil then
	teletool.settings.adjust_head = adjust_head
end



function teletool.teleport(player, pointed_thing)
	local pos = pointed_thing.above
	local src = player:get_pos()
	local dest = {x=pos.x, y=math.ceil(pos.y)-0.5, z=pos.z}
	local over = {x=dest.x, y=dest.y+1, z=dest.z}
	local destnode = minetest.get_node({x=dest.x, y=math.ceil(dest.y), z=dest.z})
	local overnode = minetest.get_node({x=over.x, y=math.ceil(over.y), z=over.z})

	if teletool.settings.adjust_head then
		-- This trick prevents the player's head to spawn in a walkable node if the player clicked on the lower side of a node
		-- NOTE: This piece of code must be updated as soon the collision boxes of players become configurable
		dest.y = dest.y + 1
		if minetest.registered_nodes[overnode.name].walkable then
			dest.y = dest.y - 1
		end
	end

	local setter = minetest.add_particlespawner
    if minetest.set_particlespawner then
        setter = minetest.set_particlespawner
    end
    setter({
		amount = 25,
		time = 0.1,
		minpos = {x=src.x-0.4, y=src.y+0.25, z=src.z-0.4},
		maxpos = {x=src.x+0.4, y=src.y+0.75, z=src.z+0.4},
		minvel = {x=-0.1, y=-0.1, z=-0.1},
		maxvel = {x=0, y=0.1, z=0},
		minexptime=1,
		maxexptime=1.5,
		minsize=1,
		maxsize=1.25,
		texture = "teletool_particle_departure.png",
	})
	minetest.sound_play( {name="teletool_teleport1", gain=1}, {pos=src, max_hear_distance=12}, true)

	player:set_pos(dest)
	setter({
		amount = 25,
		time = 0.1,
		minpos = {x=dest.x-0.4, y=dest.y+0.25, z=dest.z-0.4},
		maxpos = {x=dest.x+0.4, y=dest.y+0.75, z=dest.z+0.4},
		minvel = {x=0, y=-0.1, z=0},
		maxvel = {x=0.1, y=0.1, z=0.1},
		minexptime=1,
		maxexptime=1.5,
		minsize=1,
		maxsize=1.25,
		texture = "teletool_particle_arrival.png",
	})
	minetest.after(0.5, function(dest) minetest.sound_play( {name="teletool_teleport2", gain=1}, {pos=dest, max_hear_distance=12}, true) end, dest)

	return true
end

-- doc_items help texts
local base = S("Point teleporters are short-range teleportation devices which allow the user to teleport instantly towards a block they point at.")
local inf = S("Infinite point teleporters are very powerful, they can be used without limits.")
local baseuse = S("To use this tool, point to a face of a block and punch to teleport in front of it. The target location must have a minimum amount of space for you to stand in, otherwise, teleportation will fail.")
local desc_inf = base .. "\n" .. inf
local use_inf = baseuse

minetest.register_tool("sbo_point_teleporter:porter", {
	description = S("Short Range Teleporter"),
	-- Special fields for [tt] and [doc_items] mods
	_tt_help = S("Punch location to teleport"),
	range = REACH,
	tool_capabilities = {},
	wield_image = "teletool_teletool_infinite.png",
	inventory_image = "teletool_teletool_infinite.png",
	on_use = function(itemstack, user, pointed_thing)
		local failure = false
		if(pointed_thing.type == "node") then
			failure = not teletool.teleport(user, pointed_thing)
		else
			failure = true
		end
		if failure then
			local setter = minetest.add_particlespawner
			if minetest.set_particlespawner then
				setter = minetest.set_particlespawner
			end
			local src = user:get_pos()
			setter({
				amount = 25,
				time = 0.1,
				minpos = {x=src.x-0.4, y=src.y+0.25, z=src.z-0.4},
				maxpos = {x=src.x+0.4, y=src.y+0.75, z=src.z+0.4},
				minvel = {x=-0.1, y=-0.1, z=-0.1},
				maxvel = {x=0, y=0.1, z=0},
				minexptime=1,
				maxexptime=1.5,
				minsize=1,
				maxsize=1.25,
				texture = "teletool_particle_fail.png",
			})
			minetest.sound_play( {name="teletool_fail", gain=0.5}, {pos=user:get_pos(), max_hear_distance=4}, true)
		end
		return itemstack
	end,
	groups = { teletool = 1, disable_repair = 1, upgrade_curio = 1 },
})

minetest.register_craft({
	output = "sbo_point_teleporter:porter",
	recipe = {
		{"", "sbz_resources:phlogiston_blob", ""},
		{"sbz_resources:matter_plate", "sbz_resources:refined_firmament", "sbz_resources:matter_plate"},
		{"sbz_resources:matter_plate", "sbo_creox_bat:battery", "sbz_resources:matter_plate"}
	}
})

sbo_api.quests.on_craft["sbo_point_teleporter:porter"] = "Point Teleporters'"
sbo_api.quests.register_to("Questline: Chemistry",{
        type = "quest",
        title = "Point Teleporters'",
        text =
        [[  Point teleporters are short-range teleportation devices which allow the user to teleport instantly towards a block they point at.]],
        requires = { "Refined Firmament"}
})
