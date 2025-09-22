local S = sbo_upgrades.translator

sbo_upgrades.register_pack("sbo_upgrades:health", "health", {
	description = S("Health Boost"),
	strength = 10,
	image = "heart.png"
})

local mc = "sbo_resium:crystal"
local gb = "sbo_extrosim_glass:extrosim_glass"
local ci = "sbo_modded_elem:sodium_ingot"
minetest.register_craft({
	output = "sbo_upgrades:health",
	recipe = {
		{ci, mc, ci},
		{mc, gb, mc},
		{ci, mc, ci}
	}
})

-- Take something else from the player. BLOOD AND AIR
minetest.register_on_craft(function(itemstack, player)
	local name = itemstack:get_name()
	if name == "sbo_upgrades:health" then
		player:set_hp(player:get_hp() - 5)
	end
end)
---------------------------------------------------------------
sbo_upgrades.register_pack("sbo_upgrades:hunger", "hunger", {
	description = S("Hunger Boost"),
	strength = 10,
	image = "hbhunger_icon.png"
})

local mc = "sbo_extrosim:raw_extrosim"
local gb = "sbo_resium_glass:resium_glass"
local ci = "sbo_modded_elem:platinum_ingot"
minetest.register_craft({
	output = "sbo_upgrades:hunger",
	recipe = {
		{ci, mc, ci},
		{mc, gb, mc},
		{ci, mc, ci}
	}
})
---------------------------------------------------------------
sbo_upgrades.register_pack("sbo_upgrades:speed", "speed", {
	description = S("Speed Boost"),
	strength = 2,
	image = "sprint_stamina_icon.png"
})

local mc = "sbo_life:essence"
local gb = "sbz_resources:antimatter_blob"
local ci = "sbo_chromium:chromium_ingot"
minetest.register_craft({
	output = "sbo_upgrades:speed",
	recipe = {
		{ci, mc, ci},
		{mc, gb, mc},
		{ci, mc, ci}
	}
})
---------------------------------------------------------------
sbo_upgrades.register_pack("sbo_upgrades:jump", "jump", {
	description = S("Jump Boost"),
	strength = 1,
	image = "jump.png"
})

local mc = "sbo_photon:photon"
local gb = "sbo_chromium:chromium_ingot"
local ci = "sbo_modded_elem:brass_powder"
minetest.register_craft({
	output = "sbo_upgrades:jump",
	recipe = {
		{ci, mc, ci},
		{mc, gb, mc},
		{ci, mc, ci}
	}
})
---------------------------------------------------------------
sbo_upgrades.register_pack("sbo_upgrades:gravity", "gravity", {
	description = S("Gravity Boost"),
	strength = 1.3,
	image = "gravity.png"
})

local mc = "sbz_meteorites:neutronium"
local gb = "sbo_resium_glass:resium_glass"
local ci = "sbo_modded_elem:platinum_ingot"
minetest.register_craft({
	output = "sbo_upgrades:gravity",
	recipe = {
		{ci, mc, ci},
		{mc, gb, mc},
		{ci, mc, ci}
	}
})


