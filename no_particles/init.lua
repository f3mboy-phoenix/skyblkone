minetest.set_particlespawner = minetest.add_particlespawner
minetest.add_particlespawner = function ()end
if sbz_api.quests then
	sbz_api.quests[#sbz_api.quests+1]={
		type = "text",
		warning=true,
		title = "Warning No Particles is Enabled",
		text = [[The mod no_particles is enabled...
It removes all particles except Extrosim and Resium Jetpack trails if sbo_jetpacks is enabled
]] }
end
