sbo_api = {}
sbo_api.quests = {}
sbo_api.quests.on_craft = {}
sbo_api.quests.on_dig = {}
sbo_api.quests.in_inven = {}

core.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if sbo_api.quests.on_craft[itemstack:get_name()] then
		unlock_achievement(player:get_player_name(), sbo_api.quests.on_craft[itemstack:get_name()])
	end
end)

minetest.register_on_player_inventory_action(function(player, action, inv, inv_info)
    local itemstack
    if action == 'move' then
        itemstack = inv:get_stack(inv_info.to_list, inv_info.to_index)
    else
        itemstack = inv_info.stack
    end
    local player_name = player:get_player_name()
    local itemname = itemstack:get_name()
    if sbo_api.quests.in_inven[itemname] then
        unlock_achievement(player_name, sbo_api.quests.in_inven[itemname])
    end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
    if digger ~= nil and digger:is_valid() then
        local player_name = digger:get_player_name()
        local itemname = oldnode.name
        if sbo_api.quests.on_dig[itemname] then
            unlock_achievement(player_name, sbo_api.quests.on_dig[itemname])
        end
    end
end)

function sbo_api.quests.register_to(line,quest)
    local found=false
    for i=1,#quests do
        if quests[i].type=="text" then
            if found then
                table.insert(quests,i,quest)
                return true
            elseif quests[i].title==line then
                found=true
            end
        end
    end
    if found then
        sbz_api.register_quest(quest)
        return true
    end
    return false
end
sbz_api.register_quest({ type = "text", title = "SBO: Other infos", text = "Some mods may not make quests so info is put here for their uses.\nThey will use their modname as the title. " })
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Core",
    text =
        [[SBO Api and quest core]],
})
