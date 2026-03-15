
local S = core.get_translator("sbo_animals")

-- Chicken by JK Murray and Sirrobzeroone

mobs:register_mob("sbo_animals:chicken", {
	stepheight = 0.6,
	type = "animal",
	passive = true,
	hp_min = 5,
	hp_max = 10,
	armor = 100,
	collisionbox = {-0.3, -0.75, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	mesh = "mobs_chicken.b3d",
	textures = {
		{"mobs_chicken.png"}, -- white
		{"mobs_chicken_brown.png"},
		{"mobs_chicken_black.png"}
	},
	child_texture = {{"mobs_chick.png"}},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_chicken",
		replace = "default_dig_crumbly"
	},
	walk_velocity = 1,
	run_velocity = 3,
	runaway = true,
	runaway_from = {"player", "sbo_animals:pumba"},
	drops = {
		{name = "sbo_animals:chicken_raw", chance = 1, min = 1, max = 1},
		{name = "sbo_animals:chicken_feather", chance = 1, min = 0, max = 2}
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -4,
	fear_height = 5,
	animation = {
		speed_normal = 15,
		stand_start = 1, stand_end = 30, stand_speed = 28,
		stand1_start = 31, stand1_end = 70, stand1_speed = 32,
		walk_start = 71, walk_end = 90, walk_speed = 24,
		run_start = 91, run_end = 110, run_speed = 24
	},
	follow = {
		"sbz_bio:stemfruit",
	},
	view_range = 5,
	stay_near = {{"sbz_bio:stemfruit"}, 7},

	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 30, 50, 80, false, nil) then return end
	end,

	do_custom = function(self, dtime)

		self.egg_timer = (self.egg_timer or 0) + dtime
		if self.egg_timer < 10 then return end
		self.egg_timer = 0

		if self.child then return end

		local pos = self.object:get_pos() ; if not pos then return end

		if math.random(100) == 1 then

			core.add_item(pos, "sbo_animals:egg")

			core.sound_play("default_dig_matter",
					{pos = pos, gain = 1.0, max_hear_distance = 5}, true)

		elseif math.random(100) < 3 then
			core.add_item(pos, "sbo_animals:chicken_feather")
		end
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	local spawn_on = {"sbz_bio:dirt_with_grass"}

	mobs:spawn({
		name = "sbo_animals:chicken",
		nodes = spawn_on,
		neighbors = {"sbz_bio:dirt_with_grass"},
		min_light = 0,
		interval = 60,
		chance = 8000,
		--min_height = 5,
		--max_height = 200,
		--day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("sbo_animals:chicken", S("Chicken"), "mobs_chicken_inv.png", 0)

-- compatibility with older mobs mod

mobs:alias_mob("sbo_mobs:chicken", "sbo_animals:chicken")

-- egg entity

mobs:register_arrow("sbo_animals:egg_entity", {
	visual = "sprite",
	visual_size = {x = .5, y = .5},
	textures = {"mobs_chicken_egg.png"},
	velocity = 6,

	hit_player = function(self, player)

		player:punch(core.get_player_by_name(self.playername) or self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1}
		}, nil)
	end,

	hit_mob = function(self, player)

		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1}
		}, nil)
	end,

	hit_node = function(self, pos, node)

		if math.random(10) > 1 then return end

		pos.y = pos.y + 1

		local nod = core.get_node_or_nil(pos)

		if not nod or not core.registered_nodes[nod.name]
		or core.registered_nodes[nod.name].walkable == true then
			return
		end

		mobs:add_mob(pos, {
			name = "sbo_animals:chicken",
			child = true,
			owner = self.playername,
--			nametag = "Chicky",
			ignore_count = true -- ignores mob count per map area
		})
	end
})

-- egg throwing function

local egg_GRAVITY = 9
local egg_VELOCITY = 19

local mobs_shoot_egg = function (item, player, pointed_thing)

	local playerpos = player:get_pos()

	core.sound_play("default_dig_matter", 
			{pos = playerpos, gain = 1.0, max_hear_distance = 5}, true)

	local obj = core.add_entity({
		x = playerpos.x,
		y = playerpos.y +1.5,
		z = playerpos.z
	}, "sbo_animals:egg_entity")

	local ent = obj:get_luaentity()
	local dir = player:get_look_dir()

	ent.velocity = egg_VELOCITY -- needed for api internal timing
	ent.switch = 1 -- needed so that egg doesn't despawn straight away
	ent._is_arrow = true -- tell advanced mob protection this is an arrow

	obj:set_velocity({
			x = dir.x * egg_VELOCITY, y = dir.y * egg_VELOCITY, z = dir.z * egg_VELOCITY})

	obj:set_acceleration({
			x = dir.x * -3, y = -egg_GRAVITY, z = dir.z * -3})

	-- pass player name to egg for chick ownership
	local ent2 = obj:get_luaentity()

	ent2.playername = player:get_player_name()

	item:take_item()

	return item
end

-- egg

core.register_node("sbo_animals:egg", {
	description = S("Chicken Egg"),
	tiles = {"mobs_chicken_egg.png"},
	inventory_image  = "mobs_chicken_egg.png",
	visual_scale = 0.7,
	drawtype = "plantlike",
	wield_image = "mobs_chicken_egg.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {food_egg = 1, snappy = 2, dig_immediate = 3},
	sounds = mobs.node_sound_defaults(),

	after_place_node = function(pos, placer, itemstack)
		core.set_node(pos, {name = "sbo_animals:egg", param2 = 1})
	end,

	on_use = mobs_shoot_egg
})

-- fried egg and recipe

core.register_craftitem("sbo_animals:chicken_egg_fried", {
	description = S("Fried Egg") .. minetest.colorize("#777", "\nRestores 2 hunger"),
	inventory_image = "mobs_chicken_egg_fried.png",
	on_use = hbhunger.item_eat(2),
	groups = {food_egg_fried = 1}
})

mobs.add_eatable("sbo_animals:chicken_egg_fried", 2)
hbhunger.register_food("sbo_animals:chicken_egg_fried", 2)
unified_inventory.add_category_item('food', "sbo_animals:chicken_egg_fried")

core.register_craft({
	type  =  "cooking",
	recipe  = "sbo_animals:egg",
	output = "sbo_animals:chicken_egg_fried"
})

-- raw chicken

core.register_craftitem("sbo_animals:chicken_raw", {
	description = S("Raw Chicken") .. minetest.colorize("#777", "\nRestores 2 hunger"),
	inventory_image = "mobs_chicken_raw.png",
	on_use = hbhunger.item_eat(2),
	groups = {food_meat_raw = 1, food_chicken_raw = 1}
})

mobs.add_eatable("sbo_animals:chicken_raw", 2)
hbhunger.register_food("sbo_animals:chicken_raw", 2)
unified_inventory.add_category_item('food', "sbo_animals:chicken_raw")

-- cooked chicken and recipe

core.register_craftitem("sbo_animals:chicken_cooked", {
	description = S("Cooked Chicken") .. minetest.colorize("#777", "\nRestores 6 hunger"),
	inventory_image = "mobs_chicken_cooked.png",
	on_use = hbhunger.item_eat(6),
	groups = {food_meat = 1, food_chicken = 1}
})

mobs.add_eatable("sbo_animals:chicken_cooked", 6)
hbhunger.register_food("sbo_animals:chicken_cooked", 2)
unified_inventory.add_category_item('food', "sbo_animals:chicken_cooked")

core.register_craft({
	type  =  "cooking",
	recipe  = "sbo_animals:chicken_raw",
	output = "sbo_animals:chicken_cooked"
})

-- feather and fuel

core.register_craftitem("sbo_animals:chicken_feather", {
	description = S("Feather"),
	inventory_image = "mobs_chicken_feather.png",
	groups = {flammable = 2, feather = 1}
})
