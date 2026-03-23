
local S = core.get_translator("sbo_animals")

-- Rat by KPavel and PilzAdam (B3D model by sirrobzeroone)

mobs:register_mob("sbo_animals:rat", {
	stepheight = 0.6,
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 100,
	collisionbox = {-0.2, -1, -0.2, 0.2, -0.8, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.b3d",
	textures = {
		{"mobs_rat.png"},
		{"mobs_rat2.png"},
		{"mobs_rat3.png"}
	},
	makes_footstep_sound = false,
	sounds = {random = "mobs_rat"},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,

	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 50, 90, 0, true, "sbo_animals:rat")
	end,
--[[
	do_custom = function(self, dtime)

		self.rat_timer = (self.rat_timer or 0) + dtime

		if self.rat_timer < 1 then return end -- every 1 second

		self.rat_timer = 0

		local pos = self.object:get_pos()

		print("rat pos", pos.x, pos.y, pos.z, dtime)

		return false -- return but skip doing rest of API
	end,
]]
--[[
	on_blast = function(obj, damage)
		print ("--- damage is", damage)
		print ("---    mob is", obj.object:get_luaentity().name)
		-- return's do_damage, do_knockback and drops
		return false, true, {"default:mese"}
	end,
]]
})

-- example on_spawn function

local function rat_spawn(self, pos)
	self = self:get_luaentity()
	print (self.name, pos.x, pos.y, pos.z)
	self.hp_max = 100
	self.health = 100
end

-- where to spawn

if not mobs.custom_spawn_animal then

	mobs:spawn({
		name = "sbo_animals:rat",
		nodes = {"sbz_resources:stone", "sbz_planets:dwarf_stone"},
		min_light = 0,
		max_light = 9,
		interval = 60,
		chance = 8000,
		--max_height = 0,
	--	on_spawn = rat_spawn,
	})
end

-- spawn egg

mobs:register_egg("sbo_animals:rat", S("Plesoic"), "mobs_rat_inv.png")

-- compatibility with older mobs mod

mobs:alias_mob("sbo_mobs:rat", "sbo_animals:rat")

-- cooked rat, yummy!

core.register_craftitem("sbo_animals:rat_cooked", {
	description = S("Cooked Plesoic") .. minetest.colorize("#777", "\nRestores 3 hunger"),
	inventory_image = "mobs_cooked_rat.png",
	on_use = hbhunger.item_eat(3),
	groups = {food_rat = 1}
})

mobs.add_eatable("sbo_animals:rat_cooked", 3)
hbhunger.register_food("sbo_animals:rat_cooked", 3)
unified_inventory.add_category_item('food', "sbo_animals:rat_cooked")

core.register_craft({
	type = "cooking",
	output = "sbo_animals:rat_cooked",
	recipe = "sbo_animals:rat",
	cooktime = 5
})
