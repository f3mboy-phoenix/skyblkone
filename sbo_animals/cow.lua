
local S = core.get_translator("sbo_animals")

-- should cows eat grass blocks and mess up the environment?

local eat_gb = core.settings:get_bool("mobs_animal.eat_grass_block")
local replace_what = { {"group:grass", "air", 0} }

if eat_gb then
	table.insert(replace_what, {"sbz_bio:dirt_with_grass", "sbz_bio:dirt", -1})
end

-- Cow by sirrobzeroone

mobs:register_mob("sbo_animals:cow", {
	type = "animal",
	passive = false,
	attack_type = "dogfight",
	attack_npcs = false,
	reach = 2,
	damage = 4, attack_chance = 98,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.2, 0.4},
	visual = "mesh",
	mesh = "mobs_cow.b3d",
	textures = {
		{"mobs_cow.png"},
		{"mobs_cow2.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_cow",
		replace = "default_dig_crumbly"
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	jump_height = 6,
	pushable = true,
	drops = {
		{name = "sbo_mobs:meat_raw", chance = 1, min = 1, max = 3},
		{name = "sbo_mobs:leather", chance = 1, min = 0, max = 2}
	},
	water_damage = 0.01,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		stand_start = 0, stand_end = 30, stand_speed = 20,
		stand1_start = 35, stand1_end = 75, stand1_speed = 20,
		walk_start = 85, walk_end = 114, walk_speed = 20,
		run_start = 120, run_end = 140, run_speed = 30,
		punch_start = 145, punch_end = 160, punch_speed = 20,
		die_start = 165, die_end = 185, die_speed = 25, die_loop = false
	},
	follow = {
		"sbz_bio:pyrograss",
	},
	view_range = 8,
	replace_rate = 10,
	replace_what = replace_what,
	fear_height = 2,

	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 8, true, true) then

			-- if fed 7x wheat or grass then cow can be milked again
			if self.food and self.food > 6 then self.gotten = false end

			return
		end

		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 60, false, nil) then return end

		local tool = clicker:get_wielded_item()
		local name = clicker:get_player_name()
		local item = tool:get_name()

		-- milk cow with empty bucket
		if item == "sbz_chem:empty_fluid_cell" then

			if self.child == true then return end

			if self.gotten == true then

				core.chat_send_player(name, S("Cow already milked!"))

				return
			end

			local inv = clicker:get_inventory()

			tool:take_item()
			clicker:set_wielded_item(tool)

			-- which bucket are we using
			local ret_item = "sbo_animals:bucket_milk"
			
			if inv:room_for_item("main", {name = ret_item}) then
				clicker:get_inventory():add_item("main", ret_item)
			else
				local pos = self.object:get_pos()

				pos.y = pos.y + 0.5

				core.add_item(pos, {name = ret_item})
			end

			self.gotten = true -- milked

			return
		end
	end,

	on_replace = function(self, pos, oldnode, newnode)

		self.food = (self.food or 0) + 1

		if self.food >= 8 then -- replace 8x grass and can be milked again
			self.food = 0
			self.gotten = false
		end
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "sbo_animals:cow",
		nodes = {"sbz_bio:dirt_with_grass"},
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

mobs:register_egg("sbo_animals:cow", S("Astrozenni"), "mobs_cow_inv.png")

-- old mobs mod compatibility

mobs:alias_mob("sbo_mobs:cow", "sbo_animals:cow")

-- bucket of milk

core.register_craftitem("sbo_animals:bucket_milk", {
	description = S("Milk Fluid Cell") .. minetest.colorize("#777", "\nRestores 8 hunger"),
	inventory_image = "mobs_bucket_milk.png",
	stack_max = 1,
	on_use = hbhunger.item_eat(8, "sbz_chem:empty_fluid_cell"),
	groups = {food_milk = 1, drink = 1}
})

mobs.add_eatable("sbo_animals:bucket_milk", 8, 3)
hbhunger.register_food("sbo_animals:bucket_milk", 8)
unified_inventory.add_category_item('food', "sbo_animals:bucket_milk")

-- butter and recipe

core.register_craftitem("sbo_animals:butter", {
	description = S("Butter") .. minetest.colorize("#777", "\nRestores 1 hunger"),
	inventory_image = "mobs_butter.png",
	on_use = hbhunger.item_eat(1),
	groups = {food_butter = 1}
})

mobs.add_eatable("sbo_animals:butter", 1)
hbhunger.register_food("sbo_animals:butter", 1)
unified_inventory.add_category_item('food', "sbo_animals:butter")

local salt_item = "sbo_modded_elem:sodium_powder" -- some saplings are high in sodium

core.register_craft({
	output = "sbo_animals:butter",
	recipe = {{"sbo_animals:bucket_milk", salt_item}},
	replacements = {{"sbo_animals:bucket_milk", "sbz_chem:empty_fluid_cell"}}
})

-- cheese wedge and recipe

core.register_craftitem("sbo_animals:cheese", {
	description = S("Cheese") .. minetest.colorize("#777", "\nRestores 4 hunger"),
	inventory_image = "mobs_cheese.png",
	on_use = hbhunger.item_eat(4),
	groups = {food_cheese = 1}
})

mobs.add_eatable("sbo_animals:cheese", 4)
hbhunger.register_food("sbo_animals:cheese", 4)
unified_inventory.add_category_item('food', "sbo_animals:cheese")

core.register_craft({
	type = "cooking",
	output = "sbo_animals:cheese",
	recipe = "sbo_animals:bucket_milk",
	cooktime = 5,
	replacements = {{"sbo_animals:bucket_milk", "sbz_chem:empty_fluid_cell"}}
})

-- cheese block and recipe

core.register_node("sbo_animals:cheeseblock", {
	description = S("Cheese Block"),
	tiles = {"mobs_cheeseblock.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 3},
	sounds = mobs.node_sound_dirt_defaults()
})

core.register_craft({
	output = "sbo_animals:cheeseblock",
	recipe = {
		{"group:food_cheese", "group:food_cheese", "group:food_cheese"},
		{"group:food_cheese", "group:food_cheese", "group:food_cheese"},
		{"group:food_cheese", "group:food_cheese", "group:food_cheese"}
	}
})

core.register_craft({
	output = "group:food_cheese 9",
	recipe = {{"sbo_animals:cheeseblock"}}
})
