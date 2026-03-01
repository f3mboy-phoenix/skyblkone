--[[
Research N' Duplication
Copyright (C) 2020 Noodlemire

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--]]

--file-specific global storage
rnd.research = {}

--Every researchable item has a specific amount needed to be researched in order to unlock duplication.
--This table stores the research requirement of each, indexed by item name.
rnd.research.goals = {}
rnd.research.pos = {x=0,y=0,z=0}
--Tracks research progress of each item of each player
rnd.research.progs = {}

-- Translation support
local S = minetest.get_translator("sbo_laptop_rnd_app")
local F = minetest.formspec_escape

--This variable is needed to prevent buggy behavior when players grab an item from the sfinv research tab,
--switch to a different tab, and place the item somewhere.
--Without it, the game erroneously displays the /research menu in this scenario.
local normal_research_menu_active = {}



--In research.txt, research requirements of entire groups can be defined.
--In case an item fits into numberous groups, the smallest research requirement takes precedent over larger research requirements.
--Note that if a multi-group item is named specifically in research.txt or fits into group:rnd_goal,
--that research requirement is used no matter how many group requirements are defined.
--The point of returning rnd.research.goals[item] is to confirm that anything was found at all for an if statement.
local function find_research_groups(item, research_specs)
	for k, v in pairs(research_specs) do
		if (not rnd.research.goals[item] or v < rnd.research.goals[item]) and k:sub(1, 6) == "group:" and minetest.get_item_group(item, k:sub(7)) > 0 then
			rnd.research.goals[item] = v
		end
	end

	return rnd.research.goals[item]
end

--Once all mods have been loaded, no more items can be registered, so this is when research requirements are calculated.
minetest.register_on_mods_loaded(function()
	--Open research.txt in read-only mode
	local research_txt = io.open(rnd.mp.."research.txt", "r")

	--A list of each line in research.txt, indexed by item or group name and storing the associated research requirement of each
	local research_specs = {}

	--For each line in research.txt...
	for line in research_txt:lines() do
		--If the line isn't blank and isn't a comment as marked by a # at the start...
		if line:len() > 0 and line:sub(1, 1) ~= '#' then
			--Separate each line by the space in between the item/group name and research requirement number
			local line_parts = string.split(line, ' ')
			research_specs[line_parts[1]] = tonumber(line_parts[2])
		end
	end

	--For each registered item...
	for item, def in pairs(minetest.registered_items) do
		--Skip over items marked as "not_in_creative_inventory" or "rnd_disabled", they aren't allowed to be researched.
		if minetest.get_item_group(item, "not_in_creative_inventory") == 0 and minetest.get_item_group(item, "rnd_disabled") == 0 then
			--If an item is named specifically in research.txt, that given requirement gets top priority.
			if research_specs[item] then
				rnd.research.goals[item] = research_specs[item]
			--If a mod creator gives their item the "rnd_goal" group, it has priority over group-wide goals defined in research.txt.
			elseif minetest.get_item_group(item, "rnd_goal") ~= 0 then
				rnd.research.goals[item] = minetest.get_item_group(item, "rnd_goal")
			--See the function above this one.
			elseif find_research_groups(item, research_specs) then
				--Nothing happens here because everything already happened in the function. This is only here so the default doesn't apply.
			else
				--By default, a full stack of items is needed to unlock duplication.
				rnd.research.goals[item] = def.stack_max * 256
			end
		end
	end

	--Once finished, the file can be closed.
	io.close()
end)

--Whenever a player joins, progress data is either loaded from memory or created.
minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()

	--Short for "base", this is used to sort between saved research progress amounts.
	local b = pname.."_"

	--Checks if data has been created yet.
	local hasData = rnd.storage.getBool(b.."hasData")

	--Create a new research progress table for the newly joined player.
	rnd.research.progs[pname] = {}

	if hasData then
		--If this is a returning player, fill the new table with saved data.
		--Do this by checking the name of every researchable item, and seeing if data for "<player name>_<item name>" exists.
		for item, _ in pairs(minetest.registered_items) do
			if minetest.get_item_group(item, "not_in_creative_inventory") == 0 and minetest.get_item_group(item, "rnd_disabled") == 0 then
				local itemdata = rnd.storage.getNum(b..item)

				if itemdata then
					rnd.research.progs[pname][item] = itemdata
				end
			end
		end
	else
		rnd.storage.put(b.."hasData", true)

		--Create a research inventory for that player.
		player:get_inventory():set_size("research", 8)

		--For sorting purposes, creation of the duplication inventory is moved to duplication.lua.
		rnd.duplication.init(player)
	end
end)

--When a player leaves, their progress data doesn't need to be loaded in progs[] anymore, since it's in mod storage.
minetest.register_on_leaveplayer(function(player)
	rnd.research.progs[player:get_player_name()] = nil
end)



--Use this to check if a player's research of any particular item is complete.
function rnd.research.complete(pname, iname)
	--If the given item can't be researched, automatically say no.
	if not rnd.research.progs[pname] or not rnd.research.progs[pname][iname] or not rnd.research.goals[iname] then
		return false
	end

	--Otherwise, research is complete has long as progress has reached or exceeded the goal.
	--(Excess is normally prevented, but if a file is modified and a goal becomes lowered, it can still happen.)
	return rnd.research.progs[pname][iname] >= rnd.research.goals[iname]
end

--This function is used to determine how much progress to add, based on the returned number.
function rnd.research.progress(pname, iname, num)
	--If the item can't be researched, always return 0.
	if not rnd.research.progs[pname] or not rnd.research.goals[iname] or rnd.research.complete(pname, iname) then
		return 0
	end

	--Give whichever is smaller: the provided amount of items to use, or the amount needed to complete research.
	return math.min(num, rnd.research.goals[iname] - (rnd.research.progs[pname][iname] or 0))
end



--This function creates the research menu.
function rnd.research.research_formspec(app, mtos)
	--Get the player's inventory to look through later.
	local player = minetest.get_player_by_name(mtos.sysram.current_player)
	local inv = player:get_inventory()
	local pname = mtos.sysram.current_player
	core.log("warning", tostring(mtos)..","..tostring(mtos.meta))
	rnd.research[pname] = {}
	rnd.research[pname].mtos = mtos

	--Stored information to displayer later in the menu.
	--"X" is the default goal to show that an item can't be researched.
	local item = {name = "", count = 0, goal = "X"}

	--For each item currently in the research inventory, search for its name.
	--Only one kind of item is allowed in the research inventory at a time, so when one is found, the loop can be exited immediately.
	for i = 1, inv:get_size("research") do
		local stack = inv:get_stack("research", i)

		if not stack:is_empty() then
			item.name = stack:get_name()
			break
		end
	end

	--If a name was found, get information about current progress and its goal.
	if item.name ~= "" then
		item.count = rnd.research.progs[player:get_player_name()][item.name] or item.count
		item.goal = rnd.research.goals[item.name] or item.goal
	end

	--The progress label's text is stored here because it is used more than once.
	local progString = "("..item.count.."/"..item.goal..")"

	--Show a different inventory layout based on if the unified_inventory is open or not
	local base_inv = rnd.base_inv_formspec
	local btn_height = 4.05


	--With all of the above information, the formspec can be formed here.
	--Note that every time information changes, the menu is reformed.
	return base_inv..
		"label["..tostring(4 - 0.05 * item.name:len())..",0.75;"..item.name.."]"..
		"label["..tostring(3.9 - 0.05 * progString:len())..",1;"..progString.."]"..
		"button[3,1.5;2,1;research;"..F(S("Research")).."]"..
		"list[current_player;research;0,2.5;8,1;]"..
		"listring[]"
end

--This function forces the research menu to only accept once item at a time.
--The extra slots are only here to make it possible to research several stacks at a time, for items with high requirements.
minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
	--Putting items directly into the research menu from nowhere isn't normally possible, so just block it.
	if action == "put" and inventory_info.listname == "research" then
		return 0
	--If the player tries to move an item from an inventory to the research inventory...
	elseif action == "move" and inventory_info.to_list == "research" then
		--This overly long set of functions and variables is only to get the name of the item being moved.
		local iname = inventory:get_stack(inventory_info.from_list, inventory_info.from_index):get_name()

		--For each item in the research menu...
		for i = 1, inventory:get_size(inventory_info.to_list) do
			local otherItem = inventory:get_stack(inventory_info.to_list, i)

			--Only keep going if the current slot is where the item is being moved, if the current slot is empty,
			--or the item that is in this slot has the same name as the item being moved to the research inventory.
			--Otherwise, prevent the movement.
			if i ~= inventory_info.to_index and not otherItem:is_empty() and iname ~= otherItem:get_name() then
				return 0
			end
		end

		--If we got this far, we can let the itemstack into the research inventory.
	end
end)

--Whenever something is successfully moved to the research menu, reform it to adjust the research progress labels.
minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
	if action == "move" and (inventory_info.to_list == "research" or inventory_info.from_list == "research") then
		local pname = player:get_player_name()
		if rnd.research[pname] and rnd.research[pname].mtos then
			rnd.research[pname].mtos:set_app("research")
		end
	end
end)

--The functionality between the research menu's Research button.
--This function is defined like this because it is used in two different places, one for sfinv and one that is used for /research.
function rnd.research.on_player_receive_fields_research(app, mtos, sender, fields)
    if mtos.sysram.current_player ~= mtos.sysram.last_player then
		mtos:set_app() -- wrong player. Back to launcher
		return
	end
	local player = minetest.get_player_by_name(mtos.sysram.current_player)
	local pname = player:get_player_name()

	rnd.research[pname] = {}
	rnd.research[pname].mtos = mtos
	if fields["research"] then
		--Get the player's inventory to look through later.
		local inv = player:get_inventory()

		--Information stored about the item, for later research
		local item = {name = "", count = 0}
		
		--Look through each slot in the research inventory, to fill out the item table.
		for i = 1, inv:get_size("research") do
			local stack = inv:get_stack("research", i)
			if not stack:is_empty() then
				item.count = item.count + stack:get_count()
				item.name = stack:get_name()
			end
		end

		--If items were found...
		if item.name ~= "" then
			--Calculate the amount of progress to add.
			local progress = rnd.research.progress(pname, item.name, item.count)

			--Add the progress to the progs table and immediately save it in mod storage.
			rnd.research.progs[pname][item.name] = (rnd.research.progs[pname][item.name] or 0) + progress
			rnd.storage.put(pname.."_"..item.name, rnd.research.progs[pname][item.name])

			--Reform the research inventory, using a method to preserve sfinv tabs if they exist.
			--Its placement here, before the research inventory is cleared, is important.
			--This makes the research label "lag", so if all of the items are removed by research,
			--The player will still see the total research progress for that item, rather than the usual (0/X)
			--However, unified_inventory is too aggressive for this trick to work. Sorry.


			--For each research inventory slot...
			--Note that from here on out, the progress variable is only used to determine how many items need to be removed.
			for i = 1, inv:get_size("research") do
				local stack = inv:get_stack("research", i)
				
				--If the stack is larger than the amount of progress made, deplete that amount from the stack and leave everything else be.
				if stack:get_count() > progress then
					stack:set_count(stack:get_count() - progress)
					inv:set_stack("research", i, stack)
					break
				else
					--Otherwise, decrase progress for future reference in this loop and erase the stack
					progress = progress - stack:get_count()
					inv:set_stack("research", i, {})

					--If progress is 0, because the remaining progress equalled this stack's size, this loop can be exited.
					if progress == 0 then
						break
					end
				end
			end
		end
		mtos:set_app("research")
	end

	if normal_research_menu_active[pname] and fields["quit"] then
		--If the player just exited the /research menu, remember that it is no longer open.
		normal_research_menu_active[pname] = false
	end
end

