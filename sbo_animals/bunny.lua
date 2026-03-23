
local S = core.get_translator("sbo_animals")

-- Bunny by ExeterDad

mobs:register_mob("sbo_animals:bunny", {
	type = "animal",
	passive = true,
	reach = 1,
	stepheight = 0.6,
	hp_min = 1,
	hp_max = 4,
	armor = 100,
	collisionbox = {-0.268, -0.5, -0.268, 0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "mobs_bunny.b3d",
	drawtype = "front",
	textures = {
		{"mobs_bunny_grey.png"},
		{"mobs_bunny_brown.png"},
		{"mobs_bunny_white.png"}
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	runaway_from = {"sbo_animals:pumba", "player"},
	jump = true,
	jump_height = 6,
	drops = {
		{name = "sbo_animals:rabbit_raw", chance = 1, min = 1, max = 1},
		{name = "sbo_animals:rabbit_hide", chance = 1, min = 0, max = 1}
	},
	water_damage = 0.01,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 1, stand_end = 15,
		walk_start = 16, walk_end = 24,
		punch_start = 16, punch_end = 24
	},
	follow = {"sbz_bio:stemfruit",},
	view_range = 8,
	
	on_rightclick = function(self, clicker)

		-- feed or tame
		if mobs:feed_tame(self, clicker, 4, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 30, 50, 80, false, nil) then return end

		-- Monty Python tribute
		local item = clicker:get_wielded_item()
		local player_name = clicker:get_player_name()

		if self.owner == player_name
		and item:get_name() == "sbo_crystals:amethyst_shard" then

			-- take orb
			if not mobs.is_creative(clicker:get_player_name()) then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			-- set special bunny attributes
			local staticdata = core.serialize({
				type = "monster",
				attack_type = "dogfight",
				health = 20,
				damage = 5,
				run_velocity = 3,
				passive = false,
				runaway = false,
				runaway_from = {},
				runaway_timer = 0,
				tamed = false,
				base_texture = {"mobs_bunny_evil.png"}
			})

			-- add evil bunny
			local obj = core.add_entity(
					self.object:get_pos(), "sbo_animals:bunny", staticdata)

			obj:set_properties({textures = {"mobs_bunny_evil.png"}, hp_max = 20})

			-- remove old bunny
			if obj:get_luaentity() then mobs:remove(self, true) end
		end
	end,

	on_spawn = function(self)

		local pos = self.object:get_pos() ; pos.y = pos.y - 1

		-- white snowy bunny
		if core.find_node_near(pos, 1,
				{"sbz_planets:snow",}) then
			self.base_texture = {"mobs_bunny_white.png"}
			self.object:set_properties({textures = self.base_texture})

		-- brown desert bunny
		elseif core.find_node_near(pos, 1,
				{"sbz_resources:sand",}) then
			self.base_texture = {"mobs_bunny_brown.png"}
			self.object:set_properties({textures = self.base_texture})

		-- grey stone bunny
		elseif core.find_node_near(pos, 1,
				{"sbz_resources:stone", "sbz_resources:gravel"}) then
			self.base_texture = {"mobs_bunny_grey.png"}
			self.object:set_properties({textures = self.base_texture})
		end

		return true -- run only once, false/nil runs every activation
	end
})

-- where to spawn

if not mobs.custom_spawn_animal then

	local spawn_on = "sbz_bio:dirt_with_grass"

	mobs:spawn({
		name = "sbo_animals:bunny",
		nodes = {spawn_on},
		neighbors = {"group:grass"},
		min_light = 0,
		interval = 60,
		chance = 8000,
		--min_height = 5,
		--max_height = 200,
		--day_toggle = true
	})
end

-- spawn egg

mobs:register_egg("sbo_animals:bunny", S("Hexenith"), "mobs_bunny_inv.png", 0)

-- compatibility (only used for older mobs compatibility)

mobs:alias_mob("sbo_mobs:bunny", "sbo_animals:bunny")

-- raw rabbit

core.register_craftitem("sbo_animals:rabbit_raw", {
	description = S("Raw Hexenith") .. minetest.colorize("#777", "\nRestores 3 hunger"),
	inventory_image = "mobs_rabbit_raw.png",
	on_use = hbhunger.item_eat(3),
	groups = {food_meat_raw = 1, food_rabbit_raw = 1}
})

mobs.add_eatable("sbo_animals:rabbit_raw", 3)
hbhunger.register_food("sbo_animals:rabbit_raw", 3)
unified_inventory.add_category_item('food', "sbo_animals:rabbit_raw")

-- cooked rabbit

core.register_craftitem("sbo_animals:rabbit_cooked", {
	description = S("Cooked Hexenith") .. minetest.colorize("#777", "\nRestores 5 hunger"),
	inventory_image = "mobs_rabbit_cooked.png",
	on_use = hbhunger.item_eat(5),
	groups = {food_meat = 1, food_rabbit = 1}
})

mobs.add_eatable("sbo_animals:rabbit_cooked", 5)
hbhunger.register_food("sbo_animals:rabbit_cooked", 5)
unified_inventory.add_category_item('food', "sbo_animals:rabbit_cooked")

core.register_craft({
	type = "cooking",
	output = "sbo_animals:rabbit_cooked",
	recipe = "sbo_animals:rabbit_raw",
	cooktime = 5
})

-- rabbit hide and recipes

core.register_craftitem("sbo_animals:rabbit_hide", {
	description = S("Hexenith Hide"),
	inventory_image = "mobs_rabbit_hide.png",
	groups = {flammable = 2, pelt = 1}
})

core.register_craft({
	output = "sbo_mobs:leather",
	recipe = {
		{"sbo_animals:rabbit_hide", "sbo_animals:rabbit_hide"},
		{"sbo_animals:rabbit_hide", "sbo_animals:rabbit_hide"}
	}
})
