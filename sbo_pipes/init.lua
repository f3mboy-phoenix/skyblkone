local pipes=pipeworks.tubenodes
for i = 1, #pipes do
	local priority=minetest.registered_nodes[pipes[i]].tube.priority
	minetest.override_item(pipes[i],{on_construct=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: ".. priority)
		end,
		on_step=function(pos)
			local meta=minetest.get_meta(pos)
			meta:set_string("infotext","Priority: ".. priority)
		end
	})
end
minetest.register_chatcommand("scan_tubes", {
    params = "",
    description = "Scan area and add priority infotext to tube nodes",
    privs = {server = true}, -- restrict to server/admin

    func = function(name, param)
        -- Define area to scan
        local p1 = {x=-150, y=0, z=-150}
        local p2 = {x=150, y=50, z=150}

        local total = 0
        local updated = 0

        -- Loop through all tubenodes
        for _, nodename in ipairs(pipeworks.tubenodes) do
            local positions = minetest.find_nodes_in_area(p1, p2, {nodename})
            for _, pos in ipairs(positions) do
                total = total + 1
                local meta = minetest.get_meta(pos)

                -- Look up node definition
                local def = minetest.registered_nodes[nodename]
                if def and def.tube and def.tube.priority then
                    meta:set_string("infotext", "Priority: " .. def.tube.priority)
                    updated = updated + 1
                end
            end
        end

        return true, string.format("Scanned %d nodes, updated %d with priority infotext.", total, updated)
    end,
})


minetest.register_chatcommand("scan_autocrafters", {
    params = "",
    description = "Scan area and fix missing proccessor slot when updating from R39 to R40",
    privs = {server = true}, -- restrict to server/admin

    func = function(name, param)
        -- Define area to scan
        local p1 = {x=-150, y=0, z=-150}
        local p2 = {x=150, y=50, z=150}

        local total = 0
        local updated = 0

        -- Loop through all tubenodes
            local positions = minetest.find_nodes_in_area(p1, p2, {"pipeworks:autocrafter"})
            for _, pos in ipairs(positions) do
                total = total + 1
                local meta = minetest.get_meta(pos)
                meta:set_string('formspec', meta:get_string("formspec").. 'list[context;processor;4,2.7;1,1;]')
				local inv = meta:get_inventory()
                inv:set_size('src', 9)
				inv:set_size('recipe', 3 * 3)
				inv:set_size('dst', 4 * 3)
				inv:set_size('output', 1)
				inv:set_size('processor', 1)
                updated = updated + 1
            end


        return true, string.format("Scanned %d nodes, updated %d with priority infotext.", total, updated)
    end,
})

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Pipes",
    text =
        [[Adds visible Priority int info text. 
/scan_tubes: Scan area and add priority infotext to tube nodes
/scan_autocrafters: Scan area and fix missing proccessor slot when updating from R39 to R40]],
})
