geodes_lib = {}

local function set_geode_node(pos, node)
    local original_node = core.get_node(pos)
    if original_node.name ~= "air" then
        core.set_node(pos, node)
    end
end

local function generate_geode(pos, radius, inner, inner_alt, inner_alt_chance, shell)
    local total_radius = radius+1+#(shell)
    --generate shell
    for _, layer in ipairs(shell) do
        for x = -total_radius, total_radius do
            for y = -total_radius, total_radius do
                for z = -total_radius, total_radius do
                    if vector.distance(vector.new(x, y, z), vector.new()) < total_radius then
                        set_geode_node(pos + vector.new(x, y, z), {name = layer})
                    end
                end
            end
        end
        total_radius = total_radius-1
    end
    --generate core
    for x = -total_radius, total_radius do
        for y = -total_radius, total_radius do
            for z = -total_radius, total_radius do
                if vector.distance(vector.new(x, y, z), vector.new()) < total_radius then
                    if math.random(1, inner_alt_chance) == 1 then
                        set_geode_node(pos + vector.new(x, y, z), {name = inner_alt})
                    else
                        set_geode_node(pos + vector.new(x, y, z), {name = inner})
                    end
                end
            end
        end
    end
    total_radius = total_radius-1
    --generate cavity
    for x = -total_radius, total_radius do
        for y = -total_radius, total_radius do
            for z = -total_radius, total_radius do
                if vector.distance(vector.new(x, y, z), vector.new()) < total_radius then
                    core.set_node(pos + vector.new(x, y, z), {name = "air"})
                end
            end
        end
    end
end

function geodes_lib:register_geode(data)
    local wherein = data.wherein or "mapgen_stone"
    local y_min = data.y_min
    local y_max = data.y_max
    local scarcity = data.scarcity
    local inner = data.inner
    local inner_alt = data.inner_alt
    local inner_alt_chance = data.inner_alt_chance
    local shell = data.shell or {}
    local radius_min = data.radius_min
    local radius_max = data.radius_max
    local generation_chance = data.generation_chance or 100
    local id = data.id or ""
    
    local ore = core.registered_nodes[inner]
    
    core.register_node(inner.."_technical_mapgen", {
        description = ore.description .. " Geode",
        tiles = ore.tiles,
    	groups = {not_in_creative_inventory = 1}
    })
    
    core.register_ore({
        ore_type = "scatter",
        ore = inner.."_technical_mapgen"..id,
        wherein = wherein,
        clust_scarcity = scarcity*scarcity*scarcity,
        clust_num_ores = 1,
        clust_size = 1,
        y_min = y_min,
        y_max = y_max,
    })
    core.register_lbm({
        label = "Generate geodes",
        name = inner.."_geode_generation",
        nodenames = inner.."_technical_mapgen"..id,
        run_at_every_load = true,
        action = function(pos, node)
            -- Check if the action should be taken
            if math.random(1, 100) <= generation_chance then
                generate_geode(pos, math.random(radius_min,radius_max), inner, inner_alt, inner_alt_chance, shell)
            else
                -- Revert the node back to wherein state
                core.set_node(pos, {name = wherein})
            end
        end,
    })
end

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Geodes Lib",
    text =
        [[A library for creating geodes]],
})
