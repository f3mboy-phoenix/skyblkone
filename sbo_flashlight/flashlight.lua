local mod_name = minetest.get_current_modname()
local mod_path = minetest.get_modpath(mod_name)
local S = minetest.get_translator(mod_name)

local pl = {}

local FULLWEAR = 65536
local recharge_items = {
    ["sbo_flashlight:flashlight"] = {time=-10},
    ["sbo_flashlight:flashlight_on"] = {time=60},
}
local function wear_item_by_time(itemstack, total_time, dtime)
    local wear = itemstack:get_wear()
    local to_add = (FULLWEAR / total_time) * dtime
    wear = wear + to_add
    itemstack:set_wear(math.max(math.min(FULLWEAR-1, wear), 0)) -- don't destroy the item
    return itemstack
end
local function start_recharge(player)
    pl[player] = {recharging=true}
end
local function recharge(player, dtime)
    local inv = player:get_inventory()
    if not inv then return end
    local charged = false
    for i=1, inv:get_size("main") do
        local stack = inv:get_stack("main", i)
        if recharge_items[stack:get_name()] and recharge_items[stack:get_name()].time
        and recharge_items[stack:get_name()].time < 0 then
            stack = wear_item_by_time(stack, recharge_items[stack:get_name()].time, dtime)
            if stack:get_name() == "sbo_flashlight:flashlight_on" and player:get_wield_index() ~= i then
                stack:set_name("sbo_flashlight:flashlight")
            end
            inv:set_stack("main", i, stack)
            charged = true
        end
    end
    return charged
end

minetest.register_globalstep(function(dtime)
    for player, def in pairs(pl) do
        if not recharge(player, dtime) then
            pl[player] = nil
        end
    end
end)

local function use_flashlight(itemstack, user, pointed_thing)
    local ret = aom_util.try_rightclick(itemstack, user, pointed_thing)
    if ret then return ret end
    itemstack:set_name(minetest.registered_items[itemstack:get_name()]._alternate)
    if itemstack:get_name() == "sbo_flashlight:flashlight" then
        start_recharge(user)
    end
    return itemstack
end

minetest.register_tool("sbo_flashlight:flashlight", {
    description = S("Flashlight"),
    _tt_long_desc = S(""),
    _tt_how_to_use = S(""),
    _tt_uses = "Infinite",
    inventory_image = "br_flashlight_off.png",
    wield_image = "[combine:32x64:0,22=br_flashlight_off.png",
	wield_scale = {x=3.0,y=5.0,z=2.0},
    _wield3d_offset = {x=0, y=5.0, z=1},
    _wield3d_rotation = {x=-90, y=-45, z=-90},
    tool_capabilities = {
		damage_groups = { fleshy = 1 },
    },
    groups = { flashlight = 1, upgrade_curio =1, },
    on_secondary_use = use_flashlight,
    on_place = use_flashlight,
    _alternate = "sbo_flashlight:flashlight_on",
})
minetest.register_tool("sbo_flashlight:flashlight_on", {
    description = S("Flashlight"),
    _tt_long_desc = S(""),
    _tt_how_to_use = S(""),
    _tt_uses = "Infinite",
    inventory_image = "br_flashlight.png",
    wield_image = "[combine:32x64:0,22=br_flashlight.png",
	wield_scale = {x=3.0,y=5.0,z=2.0},
    _wield3d_offset = {x=0, y=5.0, z=1},
    _wield3d_rotation = {x=-90, y=-45, z=-90},
    tool_capabilities = {
		damage_groups = { fleshy = 1 },
    },
    groups = { flashlight = 1, },
    on_secondary_use = use_flashlight,
    on_place = use_flashlight,
    _alternate = "sbo_flashlight:flashlight",
})

aom_util.register_on_wield({
    name = "sbo_flashlight:flashlight_on",
    on_change_to_item = function(player)
        -- br_player_model.set_anim(player, {tag="flashlight_point", actions={"aim"}})
    end,
    on_change_from_item = function(player, fromstack)
        fromstack:set_name(minetest.registered_items[fromstack:get_name()]._alternate)
        start_recharge(player)
        -- br_player_model.unset_anim(player, "flashlight_point")
        return fromstack
    end,
    on_step = function(player, dtime)
        local wield = player:get_wielded_item()
        if wield:get_wear() > FULLWEAR - 2 then
            wield:set_name(minetest.registered_items[wield:get_name()]._alternate)
            player:set_wielded_item(wield)
            return
        end
        player:set_wielded_item(wear_item_by_time(wield, recharge_items[wield:get_name()].time, dtime))
        local pos = player:get_pos()
        local ct = player_info and player_info.get(player)
        local eye_pos = vector.add(pos, (ct and ct.eye_offset) or vector.new(0, 1.75, 0))
        local dir = player:get_look_dir()
        -- add light nodes in this dir
        local maxdist = 30
        for i=0, 15 do
            local v = vector.add(eye_pos, vector.multiply(dir, i))
            local node = minetest.get_node(v)
            if minetest.get_item_group(node.name, "full_solid") > 0 then
                break
            end
            maxdist = i
        end
        local skipdist = math.max(maxdist / 5, 1)
        for i=0, math.ceil(maxdist/skipdist) do
            local p = vector.add(vector.multiply(dir, i * skipdist), eye_pos)
            local flashnode = minetest.get_node(p)
            if flashnode.name == "air" then
                minetest.set_node(p, {name="sbo_flashlight:light_node_14"})
                minetest.get_node_timer(p):set(1, 0.7)
            elseif flashnode.name == "sbo_flashlight:light_node_9" then
                minetest.get_node_timer(p):set(1, 0.7)
            end
        end
    end,
})

minetest.register_on_joinplayer(function(player, last_login)
    start_recharge(player)
end)

