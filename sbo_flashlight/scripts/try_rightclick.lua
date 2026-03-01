--from aom_util
function aom_util.get_eyepos(player)
    local eyepos = vector.add(player:get_pos(), vector.multiply(player:get_eye_offset(), 0.1))
    eyepos.y = eyepos.y + player:get_properties().eye_height
    return eyepos
end

-- checks if can rightclick node/entity etc, returns itemstack if it did find something, else nil
function aom_util.try_rightclick(itemstack, user, pointed_thing, dry)
    if not minetest.is_player(user) then return nil end
    local pos = aom_util.get_eyepos(user)

    local ctrl = user:get_player_control()
    if ctrl and ctrl.sneak then return nil end

    local range = aom_util.get_tool_range(itemstack)
    local ray = minetest.raycast(pos, vector.add(pos, vector.multiply(user:get_look_dir(), range)), true, false)
    for pt in ray do
        if pt.ref then
            local ent = pt.ref:get_luaentity()
            if ent and ent.on_rightclick then
                return itemstack
            end
            if (user ~= pt.ref) then
                return
            end
        elseif pt.type == "node" then
            local def = minetest.registered_nodes[minetest.get_node(pt.under).name]
            if def.on_rightclick then
                if not dry then
                    local node = minetest.get_node(pt.under)
                    itemstack = def.on_rightclick(pt.under, node, user, itemstack, pt) or itemstack
                end
                return itemstack
            end
            return
        end
    end
    return nil
end
