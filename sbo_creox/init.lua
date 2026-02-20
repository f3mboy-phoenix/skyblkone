local modname = core.get_current_modname()
math.randomseed(os.time())

--------------------------------------------------
-- UTILITY: ground check
--------------------------------------------------
local function is_on_ground(self)
    local pos = self.object:get_pos()
    if not pos then return false end

    local below = vector.add(pos, {x = 0, y = -0.2, z = 0})
    local node = core.get_node_or_nil(below)
    if not node then return false end

    local def = core.registered_nodes[node.name]
    return def and def.walkable
end

--------------------------------------------------
-- SHARD ENTITY (thin rectangles)
--------------------------------------------------
core.register_entity(modname .. ":mob_part", {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "cube",
        textures = {
            "creox.png",
            "creox.png",
            "creox.png",
            "creox.png",
            "creox.png",
            "creox.png",
        },
        visual_size = {x = 0.2, y = 0.5},
        static_save = false,
        pointable = false,
    },

    on_activate = function(self)
        self.object:set_armor_groups({immortal = 1})
    end,
})

--------------------------------------------------
-- CENTRAL MOB (peaceful anomaly)
--------------------------------------------------
core.register_entity("sbo_creox:mob", {
    initial_properties = {
		hp_max=40,
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, -.3, -0.3, 0.3, 1.3, 0.3},
        visual = "sprite",
        textures = {"blank.png"}, -- invisible core
        visual_size = {x = 0, y = 0},
        static_save = true,
    },

    --------------------------------------------------
    -- ACTIVATE
    --------------------------------------------------
    on_activate = function(self)
        self.parts = {}
        self.time = 0

        -- gravity (CRITICAL)
        --self.object:set_acceleration({x = 0, y = -9.8, z = 0})

        -- wandering state
        self.wander_timer = math.random(2, 4)
        self.wander_target = nil

        --------------------------------------------------
        -- CREATE ORBITING SHARDS
        --------------------------------------------------
        local part_count = math.random(10, 20)
        local core_radius = 0.6

        for i = 1, part_count do
            local obj = core.add_entity(self.object:get_pos(), modname .. ":mob_part")
            if obj then
                local angle = (i / part_count) * math.pi * 2
                local radius = core_radius + math.random() * 0.5

                obj:set_properties({
                    visual_size = {
                        x = math.random() * 0.15 + 0.15,
                        y = math.random() * 0.8  + 0.4,
                    },
                })

                obj:set_attach(self.object)

                table.insert(self.parts, {
                    obj = obj,
                    base_angle = angle,
                    radius = radius,
                    height = math.random() * 0.6 + 5,
                    bob_offset = math.random() * math.pi * 2,
                })
            end
        end
    end,

    --------------------------------------------------
    -- STEP
    --------------------------------------------------
    on_step = function(self, dtime)
        self.time = self.time + dtime

        --------------------------------------------------
        -- SHARD ORBIT (calm + intentional)
        --------------------------------------------------
        local orbit_speed = 0.25
        local bob_speed   = 2
        local bob_amount  = 0.2

        for _, part in ipairs(self.parts or {}) do
            local obj = part.obj
            if obj then
                local angle = part.base_angle + self.time * orbit_speed

                local x = math.cos(angle) * part.radius
                local z = math.sin(angle) * part.radius
                local y = part.height
                    + math.sin(self.time * bob_speed + part.bob_offset) * bob_amount +.1

                obj:set_attach(
                    self.object,
                    "",
                    {x = x, y = y + 1.5, z = z},
                    {x = 0, y = angle * 57.2958 + 90, z = 0}
                )
            end
        end

        --------------------------------------------------
        -- IDLE WANDERING
        --------------------------------------------------
        self.wander_timer = self.wander_timer - dtime

        if self.wander_timer <= 0 then
            self.wander_timer = math.random(3, 6)

            local pos = self.object:get_pos()
            if pos then
                self.wander_target = {
                    x = pos.x + math.random(-4, 4),
                    y = pos.y,
                    z = pos.z + math.random(-4, 4),
                }
            end
        end

        if self.wander_target then
            local pos = self.object:get_pos()
            local dir = vector.direction(pos, self.wander_target)
            local dist = vector.distance(pos, self.wander_target)

            if dist < 0.4 then
                self.wander_target = nil
                self.object:set_velocity({
                    x = 0,
                    y = self.object:get_velocity().y,
                    z = 0,
                })
            else
                local speed = 0.4
                self.object:set_velocity({
                    x = dir.x * speed,
                    y = self.object:get_velocity().y,
                    z = dir.z * speed,
                })

                self.object:set_yaw(math.atan2(dir.z, dir.x) - math.pi / 2)
            end
        end
    end,
		on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
			if not self.parts then return end
			for _, part in ipairs(self.parts) do
				if part.obj then
					part.obj:set_properties({
						textures = {
							"resium.png",
							"resium.png",
							"resium.png",
							"resium.png",
							"resium.png",
							"resium.png",
						},
						glow = 10,
					})
				end
			end
				minetest.add_item(self.object:get_pos(), "sbz_resources:phlogiston")
			-- revert after short delay
			core.after(0.2, function()
				for _, part in ipairs(self.parts or {}) do
					if part.obj then
						part.obj:set_properties({
							textures = {
								"creox.png",
								"creox.png",
								"creox.png",
								"creox.png",
								"creox.png",
								"creox.png",
							},
							glow = 0,
						})
					end
				end
			end)
		end,
})

--------------------------------------------------
-- SPAWN ITEM (testing)
--------------------------------------------------
--[[core.register_craftitem(modname .. ":spawn_creox", {
    description = "Spawn Creox",
    inventory_image = "shock_crystal.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then
            return itemstack
        end
        core.add_entity(pointed_thing.above, modname .. ":mob")
        return itemstack
    end,
})
]]
