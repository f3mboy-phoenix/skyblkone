-- Advanced Pebble Extractor Node
unified_inventory.register_category('extractors', {
	symbol = "sbo_adv_metal_ext:aluminum_extractor",
	label = "Metal Extractors"
})
core.register_craftitem("sbo_adv_metal_ext:n64_processor", {
    description = "Creox Fabrication Processor",
    inventory_image = "creox_processor.png",
    stack_max = 16
})

minetest.register_craft({
    type = "shapeless",
    output = "sbo_adv_metal_ext:n64_processor",
    recipe = { "sbz_resources:mosfet", "sbz_resources:nuclear_crafting_processor", "sbo_nexus:creox_fab_cube" }
})

local processor_stats_map = {
    ["sbz_resources:simple_crafting_processor"] = { crafts = 1, power = 10 },
    ["sbz_resources:quick_crafting_processor"] = { crafts = 2, power = 25 },
    ["sbz_resources:fast_crafting_processor"] = { crafts = 4, power = 50 },
    ["sbz_resources:accelerated_silicon_crafting_processor"] = { crafts = 8, power = 100 },
    ["sbz_resources:nuclear_crafting_processor"] = { crafts = 16, power = 175 },
	["sbo_adv_metal_ext:n64_processor"] = {crafts = 64 }
}
for def, _ in pairs(core.registered_items) do

local powder = def
if powder:sub(powder:len()-6,powder:len()) == "_powder" and powder~="unifieddyes:colorium_powder" and powder~="sbz_chem:sodium_powder" and powder~="sbz_chem:calcium_powder" and powder~="sbz_chem:magnesium_powder" and powder~="sbz_chem:mercury_powder" and powder~="sbz_chem:platinum_powder" and powder~="sbz_chem:zinc_powder" and powder~="sbz_chem:brass_powder" and powder~="sbz_chem:bronze_powder" and powder~="sbo_modded_elem:brass_powder" and powder~="sbo_cuti:cuti_powder" and powder~="sbo_chromatic_metal:cuticr_powder" and powder~="sbz_chem:invar_powder" and powder~="sbo_modded_elem:white_gold_powder" and powder~="sbz_chem:titanium_alloy_powder" then
print(powder)
-- powder = "modname:element_powder"
local element = powder:split(":")[2]:split("_")[1]
local modname = powder:split(":")[1]
local block = modname..":"..element .."_block"
sbz_api.register_machine("sbo_adv_metal_ext:".. element .."_extractor", {
    description =
    "Advanced ".._.description.." Extractor",
    tiles = { "sbo_adv_metal_ext.png^".._.inventory_image },
    groups = { matter = 1, sbz_machine = 1, pipe_connects = 1 },
    sunlight_propagates = true,
    walkable = true,
    on_rightclick = function(pos, node, player, pointed_thing)
        local player_name = player:get_player_name()
        minetest.show_formspec(player_name, "sbz_power:sbo_adv_metal_ext_"..element,
            "formspec_version[7]" ..
            "size[8.2,9]" ..
            "style_type[list;spacing=.2;size=.8]" ..
            "list[nodemeta:" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ";main;2.5,2;3,1;]" ..
            "list[current_player;main;0.2,5;8,4;]" .. 
            "list[nodemeta:" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ';proc;3.5,3.5;1,1;]' ..
            "listring[]")

		local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()		
		inv:set_size("proc", 1)
        minetest.sound_play("machine_open", {
            to_player = player_name,
            gain = 1.0,
            pos = pos,
        })
    end,
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main", 3)
		inv:set_size("proc", 1)
        minetest.sound_play("machine_build", {
            to_player = player_name or "singleplayer",
            gain = 1.0,
            pos = pos,
        })
    end,
    action = function(pos, node, meta)
        local inv = meta:get_inventory()
        local itemstack = ItemStack(powder)
        local processor_stack = inv:get_stack("proc", 1)

        if processor_stack:is_empty() then
            meta:set_string('infotext', 'No processor.')
            return 0
        end

        local item_name = processor_stack:get_name()
        if not processor_stats_map[item_name] then
			meta:set_string('infotext', 'Invalid processor.')
            return 0
        end
        itemstack:set_count(processor_stats_map[item_name].crafts or 0)


        if inv:room_for_item("main", itemstack) then
            inv:add_item("main", itemstack)

            minetest.add_particlespawner({
                amount = 10,
                time = 1,
                minpos = { x = pos.x - 0.5, y = pos.y - 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 0.5, z = pos.z + 0.5 },
                minvel = { x = -2, y = -2, z = -2 },
                maxvel = { x = 2, y = 2, z = 2 },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                minexptime = 5,
                maxexptime = 10,
                minsize = 0.5,
                maxsize = 1.0,
                collisiondetection = false,
                vertical = false,
                texture = "powder.png",
                glow = 10
            })
        end
    end,
    power_needed = 50,
    action_interval = 1,
    output_inv = "main",
})

minetest.register_craft({
    output = "sbo_adv_metal_ext:".. element .."_extractor",
    recipe = {
        { block, block,         block },
        { block, "sbz_power:simple_matter_extractor", block },
        { block, "sbo_resium:circuit",                block }
    }
})
unified_inventory.add_category_item('extractors', "sbo_adv_metal_ext:".. element .."_extractor")

end
end
