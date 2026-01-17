minetest.set_particlespawner = minetest.add_particlespawner
minetest.add_particlespawner = function() end
if sbo_api.register_wiki_page then
	sbo_api.register_wiki_page({
		type = "text",
		warning = true,
		title = "Warning No Particles is Enabled",
		text = [[The mod no_particles is enabled...
It removes all particles except Extrosim and Resium Jetpack trails if sbo_jetpacks is enabled
]]
	})
end
