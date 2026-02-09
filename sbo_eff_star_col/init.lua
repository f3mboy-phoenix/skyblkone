-- Starlight Collector
sbz_api.register_generator('sbo_eff_star_col:gen', {
    description = 'Effective Starlight Collector',
    drawtype = 'nodebox',
    tiles = {
        'starlight_collector.png',
        'matter_blob.png',
        'matter_blob.png',
        'matter_blob.png',
        'matter_blob.png',
        'matter_blob.png',
    },
    groups = { matter = 1, pipe_connects = 1, network_always_found = 1 },
    sunlight_propagates = true,
    walkable = true,
    node_box = {
        type = 'fixed',
        fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
    },
    paramtype = 'light',
    use_texture_alpha = 'clip',
    action_interval = 1,
    action = function(pos, node, meta)
        return 30
    end,
    info_extra = "Bio-Elecrticaly Powered"
})

minetest.register_craft {
    output = 'sbo_eff_star_col:gen',
    recipe = {
        { 'sbo_life:essence', 'sbz_resources:luanium', 'sbo_life:essence' },
        { 'sbz_resources:phlogiston', 'sbz_power:starlight_collector', 'sbz_resources:phlogiston' },
        { 'sbz_resources:shock_crystal', 'sbz_planets:snowball', 'sbz_resources:shock_crystal' },
    },
}
if not sbz_api.server_optimizations then
    minetest.register_abm {
        label = 'Starlight Collector Particles',
        nodenames = { 'sbz_power:starlight_collector' },
        interval = 1,
        chance = 0.5,
        action = function(pos, node, active_object_count, active_object_count_wider)
            minetest.add_particlespawner {
                amount = 2,
                time = 1,
                minpos = { x = pos.x - 0.5, y = pos.y + 0.5, z = pos.z - 0.5 },
                maxpos = { x = pos.x + 0.5, y = pos.y + 1, z = pos.z + 0.5 },
                minvel = { x = 0, y = -2, z = 0 },
                maxvel = { x = 0, y = -1, z = 0 },
                minacc = { x = 0, y = 0, z = 0 },
                maxacc = { x = 0, y = 0, z = 0 },
                minexptime = 1,
                maxexptime = 1,
                minsize = 0.5,
                maxsize = 1.0,
                collisiondetection = true,
                vertical = false,
                texture = 'star.png',
                glow = 10,
            }
        end,
    }
end
sbo_api.quests.on_craft["sbo_eff_star_col:gen"] = "Effective Starlight Collector"
sbo_api.quests.register_to("Questline: Organics",{
    type = "quest",
    title = "Effective Starlight Collector",
    text =
        [[An Effective Starlight Collector Creates 30 power per second. It is Bio-Electricaly powered.]],
    requires = { "Starlight Collectors", }
})
