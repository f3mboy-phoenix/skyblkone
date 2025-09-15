--
local function get_nearby_player(pos)
    for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 200)) do
        if obj:is_player() then return obj end
    end
end


local function meteorite_explode(pos, type)
    --breaking nodes
    for _ = 1, 100 do
        local raycast = minetest.raycast(pos, pos + vector.random_direction() * 8, false)
        local wear = 0
        for pointed in raycast do
            if pointed.type == "node" then
                local nodename = minetest.get_node(pointed.under).name
                wear = wear + (1 / minetest.get_item_group(nodename, "explody"))
                --the explody group hence signifies roughly how many such nodes in a straight line it can break before stopping
                --although this is very random
                if wear > 1 or minetest.is_protected(pointed.under, ".meteorite") then break end
                minetest.set_node(pointed.under, { name = minetest.registered_nodes[nodename]._exploded or "air" })
            end
        end
    end
    --placing nodes
    local protected = minetest.is_protected(pos, ".meteorite")
    if not protected then
        minetest.set_node(pos,
            { name = type == "antimatter_blob" and "sbz_meteorites:antineutronium" or "sbz_meteorites:neutronium" })
    end
    local node_types = {
        stone = { "sbo_asteroid:stoney_matter"},
    }
    if not protected then
        for _ = 1, 16 do
            local new_pos = pos + vector.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
            if minetest.get_node(new_pos).name == "air" then
                minetest.set_node(new_pos, {
                    name = math.random() < 0.2 and node_types[type][2] or
                        node_types[type][1]
                })
            end
        end
    end
    --knockback
    for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 16)) do
        if obj:is_player() then
            local dir = obj:get_pos() - pos
            obj:add_velocity((vector.normalize(dir) + vector.new(0, 0.5, 0)) * 0.5 * (16 - vector.length(dir)))
        end
    end
    --particle effects
    minetest.add_particlespawner({
        time = 0.1,
        amount = 2000 / (protected and 5 or 1),
        pos = pos,
        radius = 1,
        drag = 0.2,
        glow = 14,
        exptime = { min = 2, max = 5 },
        size = { min = 3, max = 6 },
        texture = "meteorite_trail_" .. type .. ".png",
        animation = { type = "vertical_frames", aspect_width = 4, aspect_height = 4, length = -1 },
        attract = {
            kind = "point",
            origin = pos,
            strength = { min = -4, max = 0 }
        }
    })
    local forward = vector.new(1, 0, 0)
    local up = vector.new(0, 1, 0)

    for _ = 1, 500 / (protected and 5 or 1) do
        local dir = vector.rotate_around_axis(forward, up, math.random() * 2 * math.pi)
        local expiry = math.random() * 3 + 2
        minetest.add_particle({
            pos = pos + dir,
            velocity = dir * (5 + math.random()),
            drag = vector.new(0.2, 0.2, 0.2),
            glow = 14,
            expirationtime = expiry,
            size = math.random() * 3 + 3,
            texture = "meteorite_trail_" .. type .. ".png^[colorize:#aaaaaa:alpha",
            animation = { type = "vertical_frames", aspect_width = 4, aspect_height = 4, length = expiry },
        })
    end
end

sbz_api.asteroid={explode=meteorite_explode}
minetest.register_entity("sbo_asteroid:asteroid", {
    initial_properties = {
        visual = "cube",
        visual_size = { x = 2, y = 2 },
        automatic_rotate = 0.2,
        glow = 14,
        physical = false, --so they enter unloaded chunks properly
        typename="meteorite",
        apiname="asteroid",
    },
    on_activate = function(self, staticdata, dtime)
        if dtime and dtime > 600 then
            self.object:remove()
            return
        end
        self.typename="meteorite"
        self.apiname="asteroid"
        self.object:set_rotation(vector.new(math.random() * 2, math.random(), math.random() * 2) * math.pi)
        if staticdata and staticdata ~= "" then --not new, just unpack staticdata
            self.type = staticdata
        else                                    --new entity, initialise stuff
            local types = { "stone" }
            self.type = types[math.random(#types)]
            local offset = vector.new(math.random(-48, 48), math.random(-48, 48), math.random(-48, 48))
            local pos = self.object:get_pos()
            local target = get_nearby_player(pos)
            if not target then
                self.object:remove()
                return
            end
            self.object:set_velocity(1.5 * vector.normalize(target:get_pos() - pos + offset))
        end
        local texture = self.type .. ".png^meteorite.png"
        self.object:set_properties({ textures = { texture, texture, texture, texture, texture, texture } })
        self.object:set_armor_groups({ immortal = 1 })
        self.sound = minetest.sound_play({ name = "rocket-loop-99748", gain = 0.15, fade = 0.1 }, { loop = true })
        self.waypoint = nil
        self.time_since = 100
    end,
    on_deactivate = function(self)
        if not self.type then return end
        if self.sound then
            minetest.sound_fade(self.sound, 0.1, 0)
        end
        if self.waypoint then sbz_api.remove_waypoint(self.waypoint) end
    end,
    get_staticdata = function(self)
        return self.type
    end,
    on_step = function(self, dtime)
        if not self.type then return end
        local pos = self.object:get_pos()
        local diag = vector.new(1, 1, 1)
        for x = -1, 1 do
            for y = -1, 1 do
                for z = -1, 1 do
                    local node = minetest.get_node(pos + vector.new(x, y, z)).name
                    if node ~= "ignore" and node ~= "air" then --colliding with something, should explode
                        self.object:remove()
                        meteorite_explode(pos, self.type)
                        minetest.sound_play({ name = "distant-explosion-47562", gain = 0.4 })
                        return
                    end
                end
            end
        end
        --the stopping moving bug seems to be it hitting unloaded chunks
        minetest.add_particlespawner({
            time = dtime,
            amount = 1,
            pos = { min = pos - diag, max = pos + diag },
            vel = { min = -0.5 * diag, max = 0.5 * diag },
            drag = 0.2,
            glow = 14,
            exptime = { min = 10, max = 20 },
            size = { min = 2, max = 4 },
            texture = "meteorite_trail_" .. self.type .. ".png",
            animation = { type = "vertical_frames", aspect_width = 4, aspect_height = 4, length = -1 }
        })
        self.time_since = (self.time_since or 0) + dtime
        if self.waypoint and self.time_since >= 2 then
            sbz_api.remove_waypoint(self.waypoint)
            self.waypoint = nil
        end
        sbz_api.move_waypoint(self.waypoint, pos)
    end,
    show_waypoint = function(self)
        if not self.waypoint then
            self.waypoint = sbz_api.set_waypoint(self.object:get_pos(), {
                name = "",
                dist = 10,
                image = "visualiser_trail.png^[verticalframe:3:0"
            })
        end
        self.time_since = 0
    end
})

minetest.register_node("sbo_asteroid:stoney_matter", {
    description = "Asteroidic Stone",
    tiles = { "stone.png^meteoric_overlay.png" },
    paramtype = "light",
    light_source = 10,
    groups = { matter = 1, cracky = 3 },
    drop = {
        max_items = 9,
        items = {
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } },
            { rarity = 2, items = { "sbz_resources:pebble" } }
        }
    },
    sounds = sbz_api.sounds.matter(),
})

local function spawn_meteorite(pos)
    local players = minetest.get_connected_players()
    if #players == 0 then return end
    local player = players[math.random(#players)]
    if not pos then
        local player_pos = player:get_pos()
        local attempts = 0
        repeat
            pos = player_pos + vector.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
            attempts = attempts + 1
        until attempts >= 64 or vector.length(pos) > 80 and vector.length(pos) < 100 and minetest.get_node(pos).name ~= "ignore"
    end
    return minetest.add_entity(pos, "sbo_asteroid:asteroid")
end

local storage = minetest.get_mod_storage()
local time_since = storage:get_float("time_since_last_spawn")

local function meteorite_globalstep(dtime)
    time_since = time_since + dtime
    if time_since > 120 then
        time_since = 0
        if math.random() < 0.25 then spawn_meteorite() end
        --        for _, obj in ipairs(minetest.object_refs) do
        --            if obj and obj:get_luaentity() and obj:get_luaentity().name == "sbz_meteorites:gravitational_attractor_entity" and math.random() < 0.2 then
        --                spawns = spawns + obj:get_luaentity().type
        --            end
        --        end
        -- the above is a horrible idea that should never had entered production
    end
    storage:set_float("time_since_last_spawn", time_since)
end

minetest.register_globalstep(meteorite_globalstep)

minetest.register_abm({
    nodenames = {"sbo_asteroid:stoney_matter"},
    interval = 60,
    chance = 1,
    action = function(pos, node)
        local meta = minetest.get_meta(pos)
        local placed_at = meta:get_int("placed_at")
        if placed_at == 0 then
            meta:set_int("placed_at", os.time())
        elseif os.time() - placed_at >= 3600 then
            minetest.remove_node(pos)
        end
    end,
})
