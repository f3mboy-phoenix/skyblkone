-- storinator/init.lua
-- A portable storinator for carrying large amount of items (= Shulker Boxes)
--[[
    MIT License

    Copyright (c) 2022, 2024  1F616EMO

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
]]

local S = minetest.get_translator("sbo_portible")
local F = minetest.formspec_escape
local FS = function(...) return F(S(...)) end

local formspec = "size[8,10]" ..
    "list[context;main;0,1.3;8,4;]" ..
    "list[current_player;main;0,5.85;8,1;]" ..
    "list[current_player;main;0,7.08;8,3;8]" ..
    "listring[context;main]" ..
    "listring[current_player;main]" 

-- Deny these items to reduce itemstring size
local prohibited_items = {
    -- Matryoshka doll
    ["sbo_portible:storinator"] = true,
    -- Digtron crates
    ["digtron:loaded_crate"] = true,
    ["digtron:loaded_locked_crate"] = true,
}

local scan_for_tube_objects = minetest.get_modpath("pipeworks") and function() end
local occupied_translated_match = "\n" .. string.char(0x1b) .. "(T@storinator)Occupied: " .. string.char(0x1b) .. "F"

local function count_occupied_slots(inv, listname)
    local list = inv:get_list(listname)
    local count = 0
    for _, item in ipairs(list) do
        if not item:is_empty() then
            count = count + 1
        end
    end
    return count
end

local function get_node_description(meta, fallback)
    local description = meta:get_string("storinator_description")
    if description == "" then
        local old_description = meta:get_string("infotext")
        if not string.find(old_description, occupied_translated_match, 1, true) then
            description = old_description
            meta:set_string("storinator_description", description)
        end
    end
    return description == "" and fallback or description
end

local function update_node_meta(meta, inv)
    meta:set_string("formspec", formspec)

    local description = get_node_description(meta, S("Portable Storinator"))

    inv = inv or meta:get_inventory()
    local occupied_slots = count_occupied_slots(inv, "main")
    meta:set_string("infotext", description .. "\n" ..
        S("Occupied: @1/@2", occupied_slots, inv:get_size("main")))
end

local function get_stack_description(meta)
    local description = meta:get_string("storinator_description")
    if description == "" then
        local old_description = meta:get_string("description")
        if not string.find(old_description, occupied_translated_match, 1, true) then
            description = old_description
        end
    end
    return description
end

local node_def = {
    description = S("Portable Storinator"),
    tiles = {
        "portstorinator_side.png",
        "portstorinator_side.png",
        "portstorinator_side.png",
        "portstorinator_side.png",
        "portstorinator_side.png",
        "portstorinator_empty.png",
    },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()

        inv:set_size("main", 32)
        meta:set_string("formspec", formspec)
        meta:set_string("formspec", formspec)
        meta:set_string("infotext", S("Portable Storinator") .. "\n" ..
            S("Occupied: @1/@2", 0, 32))
    end,
    on_place = function(itemstack, placer, pointed_thing)
        local stack = itemstack:peek_item(1)
        local pos
        itemstack, pos = minetest.item_place(itemstack, placer, pointed_thing)

        if not pos then return itemstack end
        local stack_meta = stack:get_meta()
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()

        local inv_table = minetest.deserialize(stack_meta:get_string("inv"))
        if inv_table then
            inv:set_list("main", inv_table)
        end
        local description = get_stack_description(stack_meta)
        meta:set_string("storinator_description", description)
        update_node_meta(meta, inv)

        return itemstack
    end,
    on_rightclick = function(pos, _, _, itemstack)
        local meta = minetest.get_meta(pos)
        update_node_meta(meta)
        return itemstack
    end,
    on_receive_fields = function(pos, _, fields, sender)
        if fields["teacher"] and teacher_enabled and sender:is_player() then
            teacher.simple_show(sender, "sbo_portible:storinator_basic")
            return
        end
        local name = sender:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return
        end
        local meta = minetest.get_meta(pos)
        local description = fields["infotext"] or ""
        if not fields["btn"] then return end
        meta:set_string("storinator_description", description)
        update_node_meta(meta)
    end,
    groups = {
        choppy = 2,
        oddly_breakable_by_hand = 2,
        flammable = 2,
        tubedevice = 1,
        tubedevice_receiver = 1,
        not_in_creative_inventory = 1,
    },
    on_dig = function(pos, _, digger)
        if not digger:is_player() then return false end
        local digger_inv = digger:get_inventory()
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()

        local name = digger:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return false
        end

        if inv:is_empty("main") then
            if not minetest.is_creative_enabled(name)
                or not digger_inv:contains_item("main", "sbo_portible:storinator_craftitem") then
                local stack = ItemStack("sbo_portible:storinator_craftitem")
                if not digger_inv:room_for_item("main", stack) then
                    return false
                end
                digger_inv:add_item("main", stack)
            end
            minetest.set_node(pos, { name = "air" })
            scan_for_tube_objects(pos)
            return true
        end

        local stack = ItemStack("sbo_portible:storinator")
        local stack_meta = stack:get_meta()
        if not digger_inv:room_for_item("main", stack) then
            return false
        end

        local inv_table_raw = inv:get_list("main")
        local inv_table = {}
        local inv_occupied = 0
        for x, y in ipairs(inv_table_raw) do
            inv_table[x] = y:to_string()
            if not y:is_empty() then
                inv_occupied = inv_occupied + 1
            end
        end
        inv_table = minetest.serialize(inv_table)

        do -- Check the serialized table to avoid accidents
            local inv_table_des = minetest.deserialize(inv_table)
            if not inv_table_des then
                -- If the table is too big, the serialize result might be nil.
                -- That was a bug found in advtrains and is now solved.
                -- I'm not gonna use such a complex way to serialize the inventory,
                -- so just reject to dig the node.
                return false
            end
        end

        stack_meta:set_string("inv", inv_table)
        stack_meta:set_string("storinator_description", get_node_description(meta))
        stack_meta:set_string("description", get_node_description(meta, S("Portable Storinator")) .. "\n" ..
            S("Occupied: @1/@2", inv_occupied, inv:get_size("main")))
        digger_inv:add_item("main", stack)
        minetest.set_node(pos, { name = "air" })
        scan_for_tube_objects(pos)
        return true
    end,
    allow_metadata_inventory_move = function(pos, _, _, _, _, count, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        end
        return count
    end,
    allow_metadata_inventory_put = function(pos, _, _, stack, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        end
        if prohibited_items[stack:get_name()] then return 0 end
        return stack:get_count()
    end,
    allow_metadata_inventory_take = function(pos, _, _, stack, player)
        local name = player:get_player_name()
        if minetest.is_protected(pos, name) then
            minetest.record_protection_violation(pos, name)
            return 0
        end
        return stack:get_count()
    end,
    on_metadata_inventory_move = function(pos)
        update_node_meta(minetest.get_meta(pos))
    end,
    on_metadata_inventory_put = function(pos)
        update_node_meta(minetest.get_meta(pos))
    end,
    on_metadata_inventory_take = function(pos)
        update_node_meta(minetest.get_meta(pos))
    end,
    stack_max = 1,
    on_blast = function() end,
    on_drop = function(itemstack) return itemstack end,

}

if minetest.get_modpath("pipeworks") then
    local old_on_construct = node_def.on_construct
    node_def.on_construct = function(pos)
        old_on_construct(pos)
    end
    node_def.tube = {
        insert_object = function(pos, _, stack)
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            local rtn = inv:add_item("main", stack)
            update_node_meta(meta, inv)
            return rtn
        end,
        can_insert = function(pos, _, stack)
            if prohibited_items[stack:get_name()] then return false end
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:room_for_item("main", stack)
        end,
        input_inventory = "main",
        connect_sides = { left = 1, right = 1, back = 1, bottom = 1, top = 1, front = 1 }
    }
    
end

minetest.register_node("sbo_portible:storinator", node_def)
minetest.register_node("sbo_portible:storinator_craftitem", { -- Empty Storinators: Skip on_place checks
    description = S("Portable Storinator"),
    tiles = node_def.tiles,
    on_construct = function(pos)
        local node = minetest.get_node(pos)
        node.name = "sbo_portible:storinator"
        minetest.swap_node(pos, node)
        node_def.on_construct(pos)
    end,
    node_placement_prediction = "sbo_portible:storinator",
})

minetest.register_craft({
    recipe = {
        { "", "sbo_colorium_plate:colorium_plate", "" },
        { "sbo_colorium_plate:colorium_plate", "sbz_resources:storinator", "sbo_colorium_plate:colorium_plate" },
        { "", "sbo_colorium_plate:colorium_plate", "" },
    },
    output = "sbo_portible:storinator_craftitem"
})

