------------------------------------------------------------------------
--- Structures
----

minetest.register_on_generated(function(minp, maxp, seed)
	local pr = PcgRandom(seed)
	if math.random(1, 100) == 1 then
		local x = math.random(minp.x, maxp.x)
		local y = math.random(minp.y, maxp.y)
		local z = math.random(minp.z, maxp.z)

		struct = sbo_api.structures[math.random(1, #sbo_api.structures)]
		for a = 1, struct.offset.x do
			for b = 1, struct.offset.y do
				for c = 1, struct.offset.z do
					if struct.map[a][b][c] then
						minetest.set_node({ x = x + a, y = y + b, z = z + c }, { name = struct.map[a][b][c] })
					end
				end
			end
		end
		if struct.mobs then
			for i = 1, #struct.mobs do
				minetest.add_entity(struct.mobs[i].pos, struct.mobs[i].name)
			end
		end
	end
end)

sbo_api.structures = {
	{
		offset = {
			x = 1,
			y = 1,
			z = 1
		},
		map = {
			{
				{ "sbo_structures:unopened_sky_loot" }
			}
		},
	}
}
function sbo_api.register_structure(struct)
	table.insert(sbo_api.structures, struct)
end

---------------------------------------------------------
--- Loot
----
function sbo_api.register_loot(struct, teir, name, max_amount)
	if sbo_api.loottables[struct] and sbo_api.loottables[struct][teir] and type(name) == "string" and type(max_amount) == "number" then
		table.insert(sbo_api.loottables[struct][teir], { name, max_amount })
		unified_inventory.register_craft {
			type = "z_"..struct .. teir,
			output = name,
			items = { sbo_api.loottables[struct].nodename },
			width = 1,
			height = 1,
		}
	end
end

function sbo_api.register_loottype(name, nodename, nicename)
	sbo_api.loottables[name] = {
		common = {},
		rare = {},
		god = {},
		nodename = nodename
	}
	unified_inventory.register_craft_type("z_"..name .. "common", {
		description = nicename .. " loot. Common",
		icon = "storinator_side.png^[colorize:green:100",
		width = 1,
		height = 1,
		uses_crafting_grid = false,
	})
	unified_inventory.register_craft_type("z_"..name .. "rare", {
		description = nicename .. " loot. Rare",
		icon = "storinator_side.png^[colorize:cyan:100",
		width = 1,
		height = 1,
		uses_crafting_grid = false,
	})
	unified_inventory.register_craft_type("z_"..name .. "god", {
		description = nicename .. " loot. Mystic",
		icon = "storinator_side.png^[colorize:purple:100",
		width = 1,
		height = 1,
		uses_crafting_grid = false,
	})
end

sbo_api.loottables = {}
sbo_api.register_loottype("sky_loot", "sbo_structures:unopened_sky_loot", "Sky")
sbo_api.register_loot("sky_loot", "common", "sbz_resources:matter_dust", 25)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:antimatter_dust", 25)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:matter_blob", 5)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:antimatter_plate", 5)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:matter_plate", 5)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:charged_particle", 20)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:core_dust", 30)
sbo_api.register_loot("sky_loot", "common", "sbz_bio:paper", 3)
sbo_api.register_loot("sky_loot", "common", "sbz_power:power_pipe", 10)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:pebble", 50)
sbo_api.register_loot("sky_loot", "common", "sbz_power:simple_charged_field", 12)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:raw_emittrium", 5)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:simple_circuit", 9)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:retaining_circuit", 4)
sbo_api.register_loot("sky_loot", "common", "sbz_resources:emittrium_glass", 4)
sbo_api.register_loot("sky_loot", "rare", "sbz_bio:rope", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_bio:book", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:simple_processor", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:strange_dust", 5)
sbo_api.register_loot("sky_loot", "rare", "unifieddyes:colorium_powder", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:raw_emittrium", 25)

sbo_api.register_loot("sky_loot", "rare", "sbz_resources:antimatter_blob", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_power:manual_crafter", 2)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:emittrium_circuit", 2)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:lua_chip", 2)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:luanium", 8)
sbo_api.register_loot("sky_loot", "rare", "sbz_resources:ram_stick_1mb", 3)
sbo_api.register_loot("sky_loot", "rare", "sbz_bio:screen_inverter_potion", 3)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:drill", 100)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:shock_crystal", 2)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:strange_blob", 3)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:ram_stick_1mb", 25)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:heating_element", 3)
sbo_api.register_loot("sky_loot", "god", "sbz_resources:bomb_stick", 3)
sbo_api.register_loot("sky_loot", "god", "sbz_instatube:instantinium", 3)
sbo_api.register_loot("sky_loot", "god", "sbz_meteorites:neutronium", 3)

if minetest.get_modpath("sbo_fish") then
	sbo_api.register_loot("sky_loot", "common", "sbo_fish:fish", 3)
end
if minetest.get_modpath("sbz_planets") then
	sbo_api.register_loot("sky_loot", "rare", "sbz_planets:snowball", 3)
	sbo_api.register_loot("sky_loot", "god", "sbz_planets:dwarf_orb", 1)
end

if minetest.get_modpath("sbo_extrosim") then
	sbo_api.register_loot("sky_loot", "rare", "sbo_extrosim:raw_extrosim", 15)
end
if minetest.get_modpath("sbo_life") then
	sbo_api.register_loot("sky_loot", "god", "sbo_life:essence", 10)
end
if minetest.get_modpath("sbo_resium") then
	sbo_api.register_loot("sky_loot", "god", "sbo_resium:crystal", 10)
end
if minetest.get_modpath("laptop") then
	sbo_api.register_loot("sky_loot", "rare", "laptop:fan", 3)
end
if minetest.get_modpath("sbo_control_board") then
	sbo_api.register_loot("sky_loot", "god", "sbo_control_board:control_board", 3)
end
if minetest.get_modpath("sbo_colorium_plate") then
	sbo_api.register_loot("sky_loot", "rare", "sbo_colorium_plate:colorium_plate", 3)
end
if minetest.get_modpath("sbo_laser") then
	sbo_api.register_loot("sky_loot", "rare", "sbo_laser:laser_weapon", 15)
end
if minetest.get_modpath("sbo_rein_cable") then
	sbo_api.register_loot("sky_loot", "common", "sbo_rein_cable:power_pipe", 15)
end
if minetest.get_modpath("sbo_photon") then
	sbo_api.register_loot("sky_loot", "common", "sbo_photon:photon", 15)
end
if minetest.get_modpath("sbo_emittrium_plate") then
	sbo_api.register_loot("sky_loot", "common", "sbo_emittrium_plate:emittrium_plate", 4)
end

--------------------------------------------------------------------------------------------
--- Loot Box
----

minetest.register_node("sbo_structures:unopened_sky_loot", {
	description = "Loot Box",
	drawtype = "glasslike",
	tiles = {
		"storinator_side.png",
		"storinator_side.png",
		"storinator_side.png",
		"storinator_side.png",
		"storinator_side.png",
		"storinator_empty.png"
	},
	groups = { matter = 1 },
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,
	on_punch = function(pos)
		minetest.set_node(pos, { name = "sbz_resources:storinator" })
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local pr = PcgRandom(minetest.get_mapgen_setting("seed") + pos.x + pos.y + pos.z)
		for i = 1, 32 do
			if math.random(1, 100) > 68 then
				local item = nil
				if math.random(1, 100) >= 30 then
					item = sbo_api.loottables.sky_loot.common[math.random(1, #sbo_api.loottables.sky_loot.common)]
				elseif math.random(1, 10) ~= 1 then
					item = sbo_api.loottables.sky_loot.rare[math.random(1, #sbo_api.loottables.sky_loot.rare)]
				else
					item = sbo_api.loottables.sky_loot.god[math.random(1, #sbo_api.loottables.sky_loot.god)]
				end
				item = ItemStack(item[1] .. " " .. math.random(1, item[2]))
				inv:set_stack("main", i, item)
			end
		end
	end,
})
sbo_api.boxnumber = 0

sbo_api.get_lootbox_on_punch = function(loottable, node)
	return function(pos)
		minetest.set_node(pos, { name = node })
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		sbo_api.boxnumber = sbo_api.boxnumber + 1
		local pr = math.random(1, 1000000000)
		for i = 1, 32 do
			if math.random(1, 100) > 68 then
				local item = nil
				if math.random(1, 100) >= 10 then
					item = sbo_api.loottables[loottable].common[math.random(1, #sbo_api.loottables[loottable].common)]
				elseif math.random(1, 10) ~= 1 then
					item = sbo_api.loottables[loottable].rare[math.random(1, #sbo_api.loottables[loottable].rare)]
				else
					item = sbo_api.loottables[loottable].god[math.random(1, #sbo_api.loottables[loottable].god)]
				end
				item = ItemStack(item[1] .. " " .. math.random(1, item[2]))
				inv:set_stack("main", i, item)
			end
		end
	end
end
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Structures",
    text =
        [[Core Structure Api, Adds the floating sky lootbox]],
})

--=========================--
--planet gen--
core.register_on_generated(function(minp, maxp, blockseed)
    local planets = sbz_api.planets.area:get_areas_in_area(minp, maxp, true, true, true)

    if next(planets) ~= nil then -- Translates to: If the amount of planets that the player is inside of isn't zero
            local cx = math.random(minp.x, maxp.x)
            local cy = math.random(minp.y, maxp.y)
			local cz = math.random(minp.z, maxp.z)

			--core.chat_send_all(
			--	"X:" .. cx .. ", Y:" .. minp.y .. ", Z:" .. cz
			--)
			local struct = math.random(1, 12)
			if struct == 1 then
				for y = maxp.y, minp.y, -1 do
					--minetest.set_node({ x = cx, y = y, z = cz }, { name = "sbz_resources:emittrium_glass" })
					local pos = { x = cx, y = y, z = cz }
					local posa = { x = cx, y = y+1, z = cz }
					
					local node = core.get_node(pos)
					local nodea = core.get_node(posa)
				
					if node.name ~= "air" and nodea.name == "air"  then --SURFACE
						if debugr then
							minetest.set_node(posa, { name = "sbz_resources:emittrium_glass" })
							core.chat_send_all("Surface Structure: X:" .. cx .. ", Y:" .. y+1 .. ", Z:" .. cz)
						end
						struct = sbo_api.structures[math.random(1, #sbo_api.structures)]
						for a = 1, struct.offset.x do
							for b = 1, struct.offset.y do
								for c = 1, struct.offset.z do
									if struct.map[a][b][c] then
										minetest.set_node({ x = cx + a, y = y + b, z = cz + c }, { name = struct.map[a][b][c] })
									end
								end
							end
						end
					end
				end
			elseif struct == 2 then
				local pos = { x = cx, y = cy, z = cz }
				local node = core.get_node(pos)
				if node.name ~= "air" then
					if debugr then
						minetest.set_node(pos, { name = "sbz_resources:emittrium_glass" })
						core.chat_send_all("Ground Structure: X:" .. cx .. ", Y:" .. cy .. ", Z:" .. cz)
					end
					struct = sbo_api.structures[math.random(1, #sbo_api.structures)]
					if math.random(1, 5) == 1 then
						struct = {
							offset = {
								x = 7,
								y = 7,
								z = 7,
							},
							map = {}
						}
						local x,y,z
						for x = 1,7 do
							struct.map[x]={}
							for y = 1,7 do
								struct.map[x][y]={}
								for z = 1, 7 do
									struct.map[x][y][z] = "air"
								end
							end
						end

						for a = 1,7 do
							for b = 1,7 do
								struct.map[a][b][1] = "sbz_decor:factory_floor_tiling"
								struct.map[a][b][7] = "sbz_decor:factory_floor_tiling"
								struct.map[a][1][b] = "sbz_decor:factory_floor_tiling"
								struct.map[a][7][b] = "sbz_decor:factory_floor_tiling"
								struct.map[1][b][a] = "sbz_decor:factory_floor_tiling"
								struct.map[7][b][a] = "sbz_decor:factory_floor_tiling"
							end
						end
						struct.map[4][2][4] = "sbo_structures:unopened_sky_loot"
						core.log("warning", "Dungeon")
						--core.chat_send_all("Dungeon")
					end
					for a = 1, struct.offset.x do
						for b = 1, struct.offset.y do
							for c = 1, struct.offset.z do
								if struct.map[a][b][c] then
									minetest.set_node({ x = cx + a, y = cy + b, z = cz + c }, { name = struct.map[a][b][c] })
								end
							end
						end
					end
				end
			elseif struct == 3 then
				
				local _, planet = next(planets)
                local data = assert(core.deserialize(planet.data), 'Something went horribly wrong')
                local type = data[1]
                local type_def = sbz_api.planets.types[type]
                if debugr then
					core.chat_send_all("Creox attempt: X:" .. cx .. ", Y:" .. cy .. ", Z:" .. cz)
					core.chat_send_all("Planet type: " .. type_def.name)
				end
                if type_def.name == "Colorium Planet" then
					for y = maxp.y, minp.y, -1 do
						--minetest.set_node({ x = cx, y = y, z = cz }, { name = "sbz_resources:emittrium_glass" })
						local pos = { x = cx, y = y, z = cz }
						local posa = { x = cx, y = y+1, z = cz }
					
						local node = core.get_node(pos)
						local nodea = core.get_node(posa)
				
						if node.name ~= "air" and nodea.name == "air"  then --SURFACE
							if debugr then
								minetest.set_node(pos, { name = "sbz_resources:emittrium_glass" })
								core.chat_send_all("Creox: X:" .. cx .. ", Y:" .. cy .. ", Z:" .. cz)
							end
							core.add_entity(posa, "sbo_creox:mob")
						end
					end
				end
			end
		
    else
		----
    end
end)
