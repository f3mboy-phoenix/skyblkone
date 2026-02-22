local debugr = debugr or function() end
--api
tinkers = {}
tinkers.materials = {}
tinkers.tools = {}
tinkers.tempmaterials = {}
tinkers.parts = {}
tinkers.marked_players = {}
tinkers.item_to_material = {}
function tinkers.register_material(type, def)
	tinkers.materials[type] = def
	for i in pairs(def.valid_items) do
		tinkers.item_to_material[i]=type
	end
end
function tinkers.register_tool(itemname, def)
	tinkers.tools[itemname] = def
	minetest.register_tool(itemname, {
		description = "Creative"..def.filler,
		inventory_image = def.img,
		stack_max=1,
		tool_capabilities = {
			full_punch_interval = 0.1,
			damage_groups = { matter = 1, antimatter = 1 },
			max_drop_level = 1,
			groupcaps = {
				matter = {
					times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
					uses = 500 * 3 * 3 * 3,
					leveldiff = 2,
					maxlevel = 2
				},
				antimatter = {
					times = { [1] = 1.0 / 2, [2] = 0.25 / 2, [3] = 0.05 / 2 },
					uses = 500 * 3 * 3 * 3,
					leveldiff = 2,
					maxlevel = 2
				},
			},
		},
	})
end
function tinkers.register_tempmaterial(type, def)
	tinkers.tempmaterials[type] = def
end

function tinkers.create_part_texture(part, mat)
	local itemname
	for i,v in pairs(tinkers.parts) do
		if v.type == part then
			itemname=i
			part = v
			break
		end
	end
	local mat = tinkers.materials[mat]
	
	local img = tinkers.parts[itemname].img
	if mat[type] and mat[type].img then
		img = mat[type].img
	end
	if mat.color then 
		img = img.."^[multiply:"..mat.color
	end
	return img
end
function tinkers.create_tool_texture(parts, mats, fullparts)
	local partimgs = {}
	local partlist = fullparts
	for i,v in pairs(parts) do
		local b = 0
		for x, z in pairs(partlist) do
			if parts[i] == partlist[x] then
				b = x
			end
		end
		minetest.log(b..table.concat(mats,","))
		minetest.log(v..","..tinkers.parts[v].img)
		minetest.log(tostring(mats[b] or {}))
		
		if tinkers.parts[v].img then
			partimgs[i]="("..tinkers.parts[v].img.."^[multiply:"..((tinkers.materials[mats[b] or {}] or {}).color or "#FFFFFF")..")"
		end
	end
	
	local img = partimgs[1]

	for i = 1, #partimgs do
		img = img.."^"
		img = img..partimgs[i]
	end
	return img
end
function tinkers.create_template_texture(mat, part)
	local mat = tinkers.tempmaterials[mat]
	for i,v in pairs(tinkers.parts) do
		if v.type == part then
			part = tinkers.parts[i]
			break
		end
	end
	return "(pattern.png^[multiply:"..mat.color..")^("..part.img.."^[colorize:black^[opacity:155)"
end


function tinkers.scan_player(name)
	local player = minetest.get_player_by_name(name)
    local inv = player:get_inventory()

    for i = 1, inv:get_size("main") do
        local stack = inv:get_stack("main", i)
        local name = stack:get_name()

        if tinkers.parts[name] then
            local meta = stack:get_meta()
            local type = meta:get_string("type")
			local img = meta:get_string("inventory")
            if type and tinkers.materials[type] then
                local mat = tinkers.materials[type]
                local part = tinkers.parts[name]

                -- Build a new stack with updated description
				local stack = tinkers.init_part(part.type, type)
                -- Replace in inventory
                inv:set_stack("main", i, stack)
            end
        end
        if tinkers.tools[name] then
            local meta = stack:get_meta()
            local type = meta:get_string("mats")
			local img = meta:get_string("inventory")
            if type and tinkers.materials[type] then
                local mat = type:split(",")
                local part = tinkers.tool[name]

                -- Build a new stack with updated description
				local stack = tinkers.init_tool(name, mats)
                -- Replace in inventory
                inv:set_stack("main", i, stack)
            end
        end
        if name == "tinkering:template" then
            local meta = stack:get_meta()
            local type = meta:get_string("type")
            local creates = meta:get_string("creates")
            if type and tinkers.materials[type] then
                local mat = tinkers.materials[type]
                local part = tinkers.parts[creates]

                -- Build a new stack with updated description
				local stack = tinkers.init_template(type, part.type)
				
                -- Replace in inventory
                inv:set_stack("main", i, stack)
            end
        end
    end
end

function tinkers.register_part(itemname, def)
	minetest.register_craftitem(itemname, {
		description = "Creative"..def.filler,
		inventory_image = def.img,
		stack_max=1
	})
	tinkers.parts[itemname] = def
end

function tinkers.init_part(type, material)
	local item, itemname
	for i,v in pairs(tinkers.parts) do
		if v.type == type then
			itemname = i
			item = ItemStack(i)
			break
		end
	end
	if not item then
		return false, "IT"
	end
	if tinkers.materials[material] then
		local meta = item:get_meta()
		local mat = tinkers.materials[material]
		
		--inv img
		img = tinkers.create_part_texture(type,material)
		meta:set_string("inventory_image", img)
		meta:set_string("wield_image", img)
		meta:set_string("type", material)
		--Description
		meta:set_string("description", mat.common_name..tinkers.parts[itemname].filler)
	end
	return item
end
function tinkers.init_tool(toolname, materials)
	local item
	item = ItemStack(toolname)
	debugr("hello")
	for i, v in pairs(materials) do
		debugr(v)
	end
	local tool = tinkers.tools[toolname]
	local meta = item:get_meta()
	img = tinkers.create_tool_texture(tool.img_parts,materials,tool.parts)
	debugr(img)
	meta:set_string("inventory_image", img)
	meta:set_string("wield_image", img)
	local lastmat = tinkers.materials[materials[#materials]]
	debugr(lastmat)
	meta:set_string("mats", table.concat(materials,","))
	debugr(lastmat.common_name..tool.filler)
	meta:set_string("description", lastmat.common_name..tool.filler)
	return item
end
function tinkers.init_template(type, part)
	local item, creates
	item = ItemStack("sbo_tinkers:template")
	for i,v in pairs(tinkers.parts) do
		if v.type == part then
			creates = i
			break
		end
	end
	if tinkers.tempmaterials[type] then
		local meta = item:get_meta()
		local mat = tinkers.tempmaterials[type]
		local part= tinkers.parts[creates]
		
		--inv img
		img = tinkers.create_template_texture(type, part)
		local img = "(pattern.png^[multiply:"..mat.color..")^("..part.img.."^[colorize:black^[opacity:155)"
		
		meta:set_string("inventory_image", img)
		meta:set_string("wield_image", img)
		meta:set_string("type", type)
		meta:set_string("creates", creates)
		
		--Description
		meta:set_string("description", mat.common_name..part.filler.." Template")
	end
	return item
end



-- materials
tinkers.register_material("wood", {
	valid_items = {
		["sbo_wood:stick"] = 1,
		["sbz_bio:colorium_planks"] = 2,
		["sbz_bio:colorium_tree_core"] = 4,
		["sbz_bio:colorium_tree"] = 4,
	},
	contrib = 300,
	common_name = "Wood",
	color = "#8B6914"
})
tinkers.register_material("extrosim", {
	valid_items = {
		["sbo_extrosim:raw_extrosim"] = 1,
	},
	contrib = 100,
	common_name = "Extrosim",
	color = "#FF9A26"
})
tinkers.register_material("diamond", {
	valid_items = {
		["sbo_diamond:diamond"] = 1,
	},
	contrib = 5,
	common_name = "Diamond",
	color = "#00FFFF"
})
tinkers.register_material("shock", {
	valid_items = {
		["sbz_resources:shock_crystal"] = 1,
	},
	contrib = 75,
	common_name = "Shock Crystal",
	color = "#FFE600"
})
tinkers.register_material("resium", {
	valid_items = {
		["sbo_resium:crystal"] = 1,
	},
	contrib = 50,
	common_name = "Resium",
	color = "#31FF00"
})
tinkers.register_material("instantinium", {
	valid_items = {
		["sbz_instatube:instantinium"] = 1,
	},
	contrib = 50,
	common_name = "Instantinium",
	color = "#00FFFF"
})
tinkers.register_material("charged", {
	valid_items = {
		["sbz_resources:charged_particle"] = 1,
	},
	contrib = 500,
	common_name = "Charged",
	color = "#8800FF"
})
tinkers.register_material("antimatter", {
	valid_items = {
		["sbz_resources:antimatter_dust"] = 1,
	},
	contrib = 500,
	common_name = "Antimatter",
	color = "#FFFFFF"
})
tinkers.register_material("core", {
	valid_items = {
		["sbz_resources:core_dust"] = 1,
	},
	contrib = 500,
	common_name = "Core Dust",
	color = "#713700"
})
tinkers.register_material("matter", {
	valid_items = {
		["sbz_resources:matter_dust"] = 1,
	},
	common_name = "Matter",
	contrib = 500,
	color = "#1E1A38"
})
tinkers.register_material("phlogiston", {
	valid_items = {
		["sbz_resources:phlogiston"] = 1,
	},
	contrib = 25,
	common_name = "Phlogiston",
	color = "#CE6200"
})
tinkers.register_material("emittrium", {
	valid_items = {
		["sbz_resources:raw_emittrium"] = 1,
	},
	contrib = 200,
	common_name = "Emittrium",
	color = "#0090F7"
})
tinkers.register_material("strange", {
	valid_items = {
		["sbz_resources:strange_dust"] = 1,
	},
	contrib = 300,
	common_name = "Strange Dust",
	color = "#00A10D"
})
tinkers.register_material("colorium", {
	valid_items = {
		["unifieddyes:colorium"] = 1,
	},
	contrib = 350,
	common_name = "Colorium",
	color = "#FFFFFF"
})
tinkers.register_material("luanium", {
	valid_items = {
		["sbz_resources:luanium"] = 1,
	},
	contrib = 25,
	common_name = "Luanium",
	color = "#1F00FF"
})



tinkers.register_tempmaterial("stone", {
	valid_items = {},
	common_name = "Stone",
	color = "#696969" -- lmfaoooo that was not intentional color picker
})


-- parts
tinkers.register_part("sbo_tinkers:binding", {
	type = "binding",
	filler = " Binding",
	img = "binding.png",--
	contrib = 0.2,
	requires = 1
})
tinkers.register_part("sbo_tinkers:pick_head", {
	type = "pickaxe",
	filler = " Pickaxe Head",
	contrib = 3,
	img = "pick.png",--
	requires = 2
})
tinkers.register_part("sbo_tinkers:axe_head", {
	type = "axe",
	filler = " Axe Head",
	img = "axe.png",--
	contrib = 3,
	requires = 2
})
tinkers.register_part("sbo_tinkers:shovel_head", {
	type = "shovel",
	filler = " Shovel Head",
	img = "shovel.png",
	contrib = 3,
	requires = 2
})
tinkers.register_part("sbo_tinkers:shard", {
	type = "shard",
	filler = " Shard",
	img = "shard.png",
	no_pat = true,
})
tinkers.register_part("sbo_tinkers:sword_blade", {
	type = "sword",
	filler = " Sword Blade",
	img = "sword.png",--
	contrib = 3,
	requires = 2
})
tinkers.register_part("sbo_tinkers:pan_head", {
	type = "pan",
	filler = " Pan",
	img = "pan.png",--
	contrib = 3,
	requires = 3
})
tinkers.register_part("sbo_tinkers:board", {
	type = "board",
	filler = " Board",
	img = "board.png",--
	contrib = 3,
	requires = 4
})
tinkers.register_part("sbo_tinkers:knife_blade", {
	type = "knife",
	filler = " Knife Blade",
	img = "knife.png",--
	contrib = 3,
	requires = 1
})
tinkers.register_part("sbo_tinkers:rod", {
	type = "rod",
	filler = " Tool Rod",
	contrib = 1,
	img = "rod.png",--
	requires = 1
})
tinkers.register_part("sbo_tinkers:hammer_head", {
	type = "hammer",
	filler = " Hammer Head",
	img = "hammer.png",--
	contrib = 5,
	requires = 8
})
tinkers.register_part("sbo_tinkers:guard", {
	type = "guard",
	filler = " Tool Guard",
	contrib = 0.2,
	img = "guard.png",
	requires = 1
})
tinkers.register_part("sbo_tinkers:nugget", {
	type = "nugget",
	filler = " Nugget",
	img = "nugget.png",
		contrib = 0.1,
	no_pat = true,
})
tinkers.register_part("sbo_tinkers:plate", {
	type = "plate",
	filler = " Plate",
	img = "plate.png",--
	
	contrib = 0.1,
	requires = 8
})
--tools
tinkers.register_tool("sbo_tinkers:sword", {
	type = "sword",
	filler = " Sword",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:guard", "sbo_tinkers:sword_blade"}, {}, {"sbo_tinkers:rod", "sbo_tinkers:guard", "sbo_tinkers:sword_blade"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:guard", "sbo_tinkers:sword_blade"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:guard", "sbo_tinkers:sword_blade"},
	fs=	"list[context;main;1,3;1,1;3]".."image[2.3,1.3;1.4,0.4;ui_crafting_arrow.png]".."list[context;main;4,1;1,1;0]"
})
tinkers.register_tool("sbo_tinkers:hammer", {
	type = "hammer",
	filler = " Hammer",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:hammer_head"}, {},{"sbo_tinkers:rod", "sbo_tinkers:plate", "sbo_tinkers:plate", "sbo_tinkers:hammer_head"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:hammer_head"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:plate", "sbo_tinkers:plate", "sbo_tinkers:hammer_head"},
})
tinkers.register_tool("sbo_tinkers:knife", {
	type = "knife",
	filler = " Knife",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:knife_blade"}, {},{"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:knife_blade"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:knife_blade"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:knife_blade"},
})
tinkers.register_tool("sbo_tinkers:pan", {
	type = "pan",
	filler = " Pan",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:pan_head"}, {},{"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:pan_head"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:pan_head"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:pan_head"},
})
tinkers.register_tool("sbo_tinkers:shovel", {
	type = "shovel",
	filler = " Shovel",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:shovel_head"}, {},{"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:shovel_head"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:shovel_head"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:shovel_head"},
})
tinkers.register_tool("sbo_tinkers:axe", {
	type = "axe",
	filler = " Axe",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:axe_head"}, {},{"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:axe_head"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:axe_head"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:axe_head"},
})
tinkers.register_tool("sbo_tinkers:pickaxe", {
	type = "pickaxe",
	filler = " Axe",
	img = tinkers.create_tool_texture({"sbo_tinkers:rod", "sbo_tinkers:pick_head"}, {},{"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:pick_head"}),
	img_parts = {"sbo_tinkers:rod", "sbo_tinkers:pick_head"},
	parts = {"sbo_tinkers:rod", "sbo_tinkers:binding", "sbo_tinkers:pick_head"},
})

--nodes
minetest.register_node("sbo_tinkers:template_station", {
	description = "Template Station",
	drawtype = "normal",
    tiles = {
        'template_station_top.png',
        'compressed_core_dust.png',
        'compressed_core_dust.png',
    },
	groups = {
		matter = 1,
		oddly_breakable_by_hand=1
		--not_in_creative_inventory = 1,
	},
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local fs = tinkers.construct_formspec("sbo_tinkers:template_station", node, puncher, pos)
		meta:set_string("formspec", fs)
		meta:set_string("mode", "binding")
		local inv = meta:get_inventory()
		inv:set_size("main", 2)
	end,
	on_receive_fields = function(pos, _, fields, sender)
		--minetest.chat_send_player("singleplayer","pressed")
		if debugr then
			for i,v in pairs(fields) do
				debugr(i)
			end
		end
		for i,v in pairs(tinkers.parts) do
			if fields[v.type] then
				debugr(i)
				local meta = minetest.get_meta(pos)
				meta:set_string("mode", v.type)
				local inv = meta:get_inventory()
				
				if inv:get_stack("main", 1):get_name() == "sbo_tinkers:blank_template" or inv:get_stack("main", 1):get_name() == "sbo_tinkers:template" then
					inv:set_stack("main", 2, tinkers.init_template("stone", meta:get_string("mode")))
				end
			end
		end
	end,
	allow_metadata_inventory_put = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(stack:get_name())
		if listitem == "main" and (index == 2) then
			return 0
		end
		if listitem == "main" and (stack:get_name() ~= "sbo_tinkers:blank_template" and stack:get_name() ~= "sbo_tinkers:template") and index == 1 then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(_,_,_,stack) 
		debugr("triggered")
		debugr(stack:get_count())
		return stack:get_count()
	end,
	allow_metadata_inventory_move = function() return 0 end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_stack("main", 2, tinkers.init_template("stone", meta:get_string("mode")))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		debugr("triggered")
		debugr(listname)
		debugr(index)
		debugr(stack:get_name())
		debugr(stack:get_count())
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if index == 2 then
			local stack = inv:get_stack('main', 1)
			stack:take_item(1)
			inv:set_stack('main', 1, stack)
			if inv:get_stack("main",1):get_count() ~= 0 then
				inv:set_stack("main", 2, tinkers.init_template("stone", meta:get_string("mode")))
			end
		elseif index == 1 then
			inv:set_stack("main", 2, "")
		end
	    debugr(stack:get_count())

	end,
})
minetest.register_craft({
    output = "sbo_tinkers:template_station",
    recipe = {
        { "sbo_tinkers:blank_template",},
        { "sbo_resources:compressed_core_dust", },
    }
})

minetest.register_node("sbo_tinkers:tool_assembler", {
	description = "Tool Assembler",
	drawtype = "normal",
    tiles = {
        'tool_assembler_top.png',
        'simple_charged_field.png',
        'simple_charged_field.png',
    },
	groups = {
		matter = 1,
		oddly_breakable_by_hand=1
		--not_in_creative_inventory = 1,
	},
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local fs = tinkers.construct_formspec("sbo_tinkers:tool_assembler", meta, puncher, pos)
		meta:set_string("formspec", fs)
		meta:set_string("mode", "sbo_tinkers:sword")
		local inv = meta:get_inventory()
		inv:set_size("main", 5)
	end,
	on_receive_fields = function(pos, _, fields, sender)
		--minetest.chat_send_player("singleplayer","pressed")
		if debugr then
			for i,v in pairs(fields) do
				debugr(i)
			end
		end
		for i,v in pairs(tinkers.tools) do
			if fields[v.type] then
				debugr("i:"..i)
				debugr("v.type:"..v.type)
				local meta = minetest.get_meta(pos)
				meta:set_string("mode", i)
				local inv = meta:get_inventory()
				local partl = tinkers.tools[i].parts
				
				for x = 1, #partl do
					local stack = inv:get_stack('main', x+1)
					if stack:get_name() ~= tinkers.tools[i].parts[x] then
						return
					end
				end	
				--inv:set_stack("main", 2, tinkers.init_tool(meta:get_string("mode"), mats))
			end
		end
	end,
	allow_metadata_inventory_put = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(stack:get_name())
		if listitem == "main" and (index == 0) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		if listitem == "main" and stack:get_name() ~= tinkers.tools[meta:get_string("mode")].parts[index-1] then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(_,_,_,stack) 
		debugr("triggered")
		debugr(stack:get_count())
		return stack:get_count()
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local partl = tinkers.tools[meta:get_string("mode")].parts
		local mats = {}
		for i = 1, #partl do
			mats[i] = inv:get_stack('main', i+1):get_meta():get_string("type")
			debugr(mats[i])
		end
		for i = 1, #partl do
			if inv:get_stack('main', i+1):get_name() ~= tinkers.tools[meta:get_string("mode")].parts[i] then
				return 
			end
		end
		inv:set_stack("main", 1, tinkers.init_tool(meta:get_string("mode"), mats))
	end,
	allow_metadata_inventory_move = function() return 0 end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		debugr("triggered")
		debugr(listname)
		debugr(index)
		debugr(stack:get_name())
		--debugr(stack:get_count())
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local partl = tinkers.tools[meta:get_string("mode")].parts
		local mats = {}
		for i = 1, #partl do
			mats[i] = inv:get_stack('main', i+1):get_meta():get_string("type")
		end
		for i = 1, #partl do
			if inv:get_stack('main', i+1):get_name() ~= tinkers.tools[meta:get_string("mode")].parts[i] then
				return 
			end
		end
		if index == 1 then --tool
			debugr('tool')
			for i = 2, 5 do
				local stack = inv:get_stack('main', i)
				stack:take_item(1)
				inv:set_stack('main', i, stack)
			end
		elseif index ~= 1 then --parts
			debugr('part')
			inv:set_stack("main", 1, "")
		end
	    debugr(stack:get_count())
	end,
})
minetest.register_craft({
    output = "sbo_tinkers:tool_assembler",
    recipe = {
        { "sbo_tinkers:blank_template",},
        { "sbz_power:charged_field", },
    }
})

minetest.register_node("sbo_tinkers:part_builder", {
	description = "Part Maker",
	drawtype = "normal",
    tiles = {
        'part_builder_top.png',
        'stone.png',
        'stone.png',
    },
	groups = {
		matter = 1,
		oddly_breakable_by_hand=1
		--not_in_creative_inventory = 1,
	},
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local fs = tinkers.construct_formspec("sbo_tinkers:part_builder", node, puncher, pos)
		meta:set_string("formspec", fs)
		local inv = meta:get_inventory()
		inv:set_size("main", 4)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if formname ~= "sbo_tinkers:part_builder" then return end
		
	end,
	allow_metadata_inventory_move = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(stack:get_name())
		if listitem == "main" and (index == 3 or index == 4) then
			return 0
		end
		if listitem == "main" and stack:get_name() ~= "sbo_tinkers:template" and index == 1 then
			return 0
		end
		if listitem == "main" and index == 2 and not tinkers.item_to_material[stack:get_name()] then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_put = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(stack:get_name())
		if listitem == "main" and (index == 3 or index == 4) then
			return 0
		end
		if listitem == "main" and stack:get_name() ~= "sbo_tinkers:template" and index == 1 then
			return 0
		end
		if listitem == "main" and index == 2 and not tinkers.item_to_material[stack:get_name()] then
			return 0
		end
		return stack:get_count()
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:get_stack("main", 1):get_name() == "sbo_tinkers:template" and tinkers.item_to_material[inv:get_stack("main", 2):get_name()] then
			local template = inv:get_stack("main", 1)
			local res = inv:get_stack("main", 2)
			local creates = template:get_meta():get_string("creates")
			local type = tinkers.parts[creates].type
			local mat = tinkers.item_to_material[inv:get_stack("main", 2):get_name()]

			local actual = tinkers.materials[mat].valid_items[res:get_name()] * res:get_count()
			debugr(actual)
			debugr(tinkers.parts[creates].requires)
			if actual >= tinkers.parts[creates].requires then 
				inv:set_stack("main", 3, tinkers.init_part(type, mat))
			end
		end
	end,
	allow_metadata_inventory_move = function() return 0 end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		debugr("triggered")
		debugr(listname)
		debugr(index)
		debugr(stack:get_name())
		debugr(stack:get_count())
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if index == 3 then
			local stack = inv:get_stack('main', 2)
			local template = inv:get_stack("main", 1)
			local mat = tinkers.item_to_material[inv:get_stack("main", 2):get_name()]
			local creates = template:get_meta():get_string("creates")
			local type = tinkers.parts[creates].type
			local part_amount = tinkers.parts[template:get_meta():get_string("creates")].requires
			local multiplier = tinkers.materials[mat].valid_items[stack:get_name()]
			stack:take_item(part_amount / multiplier )
			inv:set_stack('main', 2, stack)
			if inv:get_stack("main",2):get_count() >= part_amount / multiplier then
				inv:set_stack("main", 3, tinkers.init_part(type,mat))
			end
		elseif index == 1 or index == 2 then
			inv:set_stack("main", 3, "")
		end
	    debugr(stack:get_count())

	end,
})
minetest.register_craft({
    output = "sbo_tinkers:part_builder",
    recipe = {
        { "sbo_tinkers:blank_template",},
        { "sbz_resources:stone", },
    }
})
minetest.register_node("sbo_tinkers:reforger", {
	description = "reforger",
	drawtype = "normal",
    tiles = {
        'reforger_top.png',
        'emittrium_block.png',
        'emittrium_block.png',
    },
	groups = {
		matter = 1,
		oddly_breakable_by_hand=1
		--not_in_creative_inventory = 1,
	},
	sunlight_propagates = true,
	paramtype = "light",
	walkable = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local fs = tinkers.construct_formspec("sbo_tinkers:reforger", node, puncher, pos)
		meta:set_string("formspec", fs)
		local inv = meta:get_inventory()
		inv:set_size("main", 4)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if formname ~= "sbo_tinkers:reforger" then return end
		
	end,
	allow_metadata_inventory_move = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(stack:get_name())
		if listitem == "main" and (index == 3 or index == 4) then
			return 0
		end
		if listitem == "main" and tinkers.tools[stack:get_name()] and index == 1 then
			return 0
		end
		if listitem == "main" and index == 2 and not tinkers.item_to_material[stack:get_name()] then
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_put = function(pos, listitem, index, stack, player)
		debugr("triggered")
		debugr(listitem)
		debugr(index)
		debugr(tinkers.tools[stack:get_name()] )
		if listitem == "main" and (index == 3 or index == 4) then
			return 0
		end
		if listitem == "main" and not tinkers.tools[stack:get_name()] and index == 1 then
			return 0
		end
		if listitem == "main" and not tinkers.parts[stack:get_name()] and index == 2 then
			return 0
		end
		return stack:get_count()
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if tinkers.tools[inv:get_stack("main", 1):get_name()] and tinkers.parts[inv:get_stack("main", 2):get_name()] then
			local tool = inv:get_stack("main", 1)
			local part = inv:get_stack("main", 2)
			local mats = tool:get_meta():get_string("mats"):split(",")
			local reforge = false
			for i = 1, 4 do
				if tinkers.tools[tool:get_name()].parts[i] == part:get_name() then
					mats[i] = part:get_meta():get_string("type")
					reforge = true
				end 
			end
			if reforge then
				inv:set_stack("main", 3, tinkers.init_tool(tool:get_name(), mats))
			end
		end
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		debugr("triggered")
		debugr(listname)
		debugr(index)
		debugr(stack:get_name())
		debugr(stack:get_count())
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if index == 3 then
			 inv:set_stack("main", 1, "")
			 inv:set_stack("main", 2, "")
		elseif index == 1 or index == 2 then
			inv:set_stack("main", 3, "")
		end
	    debugr(stack:get_count())

	end,
})
minetest.register_craft({
    output = "sbo_tinkers:reforger",
    recipe = {
        { "sbo_tinkers:blank_template",},
        {     'sbz_resources:emittrium_block',, },
    }
})
--patterns
minetest.register_craftitem("sbo_tinkers:blank_template", {
	description = "Blank Template",
	inventory_image = "pattern.png^[multiply:#6F6F6F",
	stack_max=64
})
minetest.register_craft({1
    output = "sbo_tinkers:blank_template 4",
    recipe = {
        { "sbz_resources:pebble", "sbz_resources:stone", },
        { "sbz_resources:stone",  "sbz_resources:pebble", },
    }
})
minetest.register_craftitem("sbo_tinkers:template", {
	description = "Creative Template",
	inventory_image = "pattern.png",
	stack_max=1
})
--commands
minetest.register_chatcommand("givepart", {
	description = "Test: give part",
	privs = {give = true},
	func = function(name, param) 
		local params = param:split(" ")
		local type = params[1]
		local material = params[2]
		local player = minetest.get_player_by_name(name)
		if not player then return false, "PNF" end
		local item = tinkers.init_part(type, material)
		if item then
			player:get_inventory():add_item("main", item)
		end
	end
})
minetest.register_chatcommand("givetemplate", {
	description = "Test: give template",
	privs = {give = true},
	func = function(name, param) 
		local params = param:split(" ")
		local type = params[1]
		local material = params[2]
		local player = minetest.get_player_by_name(name)
		if not player then return false, "PNF" end
		local item = tinkers.init_template(type, material)
		if item then
			player:get_inventory():add_item("main", item)
		end
	end
})
--formspec control
function tinkers.construct_formspec(fs, node, puncher, pos)
	local contents = ""
	if fs == "sbo_tinkers:template_station" then
	    contents = contents.. "formspec_version[5]size[20,9]"
		contents = contents.. "label[0.5,0.5;Template Station]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(1, 1, 1, 1)
		contents = contents.. "list[context;main;1,1;1,1;0]"
		contents = contents.. "image[2.3,1.3;1.4,0.4;ui_crafting_arrow.png]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(4, 1, 1, 1)
		contents = contents.. "list[context;main;4,1;1,1;1]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(0.5, 3.5, 9, 4)
		contents = contents.. "list[current_player;main;0.5,3.5;9,4;]"
		
		local x, y = 0, 0
		for i,v in pairs(tinkers.parts) do
			if not v.no_pat then
				contents = contents .. "image_button["..10.5+x..","..0.5+y..";1,1;"..tinkers.create_template_texture("stone", v.type)..";"..v.type..";]"
				x = x + 1
				if x == 9 then
					x = 0
					y = y + 1
				end
			end
		end
	elseif fs == "sbo_tinkers:tool_assembler" then
	    contents = contents.. "formspec_version[5]size[20,9]"
		contents = contents.. "label[0.5,0.5;Tool Assembler]"
		
		contents = contents.. "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;1,1;2,2;1]"
		contents = contents.. "image[3.3,1.3;1.4,1.4;ui_crafting_arrow.png]"
		contents = contents.. "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;5,1.5;1,1;0]"
		contents = contents.. "list[current_player;main;0.5,3.5;9,4;]"
		local x, y = 0, 0
		for i,v in pairs(tinkers.tools) do
			if not v.no_pat then
				contents = contents .. "image_button["..10.5+x..","..0.5+y..";1,1;"..tinkers.create_tool_texture(v.img_parts, {}, v.parts)..";"..v.type..";]"
				x = x + 1
				if x == 9 then
					x = 0
					y = y + 1
				end
			end
		end

	elseif fs == "sbo_tinkers:part_builder" then
		contents = contents.. "formspec_version[5]size[12,9]"
		contents = contents.. "label[0.5,0.5;Part Maker]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(1, 1, 1, 2)
		contents = contents.. "list[context;main;1,1;1,2;0]"
		contents = contents.. "image[2.3,1.3;1.4,1.4;ui_crafting_arrow.png]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(4, 1.5, 1, 1)
		contents = contents.. "list[context;main;4,1.5;1,1;2]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(0.5, 3.5, 9, 4)
		contents = contents.. "list[current_player;main;0.5,3.5;9,4;]"
	elseif fs == "sbo_tinkers:reforger" then
		contents = contents.. "formspec_version[5]size[12,9]"
		contents = contents.. "label[0.5,0.5;Reforger]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(1, 1, 1, 2)
		contents = contents.. "list[context;main;1,1;1,2;0]"
		contents = contents.. "image[2.3,1.3;1.4,1.4;ui_crafting_arrow.png]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(4, 1.5, 1, 1)
		contents = contents.. "list[context;main;4,1.5;1,1;2]"
		--contents = contents.. mcl_formspec.get_itemslot_bg_v4(0.5, 3.5, 9, 4)
		contents = contents.. "list[current_player;main;0.5,3.5;9,4;]"
	end
	return contents
end

--on_join
minetest.register_on_joinplayer(function(player)
    table.insert(tinkers.marked_players, player:get_player_name())
end)
minetest.register_globalstep(function()
	for i=#tinkers.marked_players, 1, -1 do
		tinkers.scan_player(tinkers.marked_players[i])
		table.remove(tinkers.marked_players, i)
	end
end)
minetest.register_on_dignode(function(pos, oldnode, digger)
	debugr("hello????")
	if not digger then return end
	local stack = digger:get_wielded_item()
	tinkers.after_tool_dig(stack, digger, oldnode)
end)

tinkers.after_tool_dig = function(stack, user, node)
	debugr(stack:get_wear())
	debugr("hello?")
	
	local meta = stack:get_meta()
	local mats = meta:get_string("mats"):split(",")
	local extra = 0
			
	for i, v in ipairs(mats) do
		extra = extra + tinkers.parts[tinkers.tools[stack:get_name()].parts[i]].contrib * tinkers.materials[v].contrib
	end
	debugr(extra)
	stack:add_wear(extra)
	user:set_wielded_item(stack)
	debugr(stack:get_wear())
	return stack
end
--PNF Player Not Found
--IT Invalid Type
