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
