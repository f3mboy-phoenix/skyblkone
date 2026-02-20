local function detonate(obj, owner, power)
    sbz_api.explode(obj:get_pos(), power, 0.9, true, owner or "", 2.5, nil, true)
    obj:remove()
end

local speed = 30
local speed_vec = vector.new(speed, speed, speed)

core.register_entity("sbo_explosives:thermite_stick_entity", {
    initial_properties = {
        visual = "sprite",
        visual_size = { x = 1, y = 1, z = 1 },
        pointable = false,
        collide_with_objects = true,
        physical = true,
        textures = { "thermite_inv.png" },
        glow = 14,
        static_save = false,
    },
    on_activate = function(self, staticdata, dtime_s)
        staticdata = core.deserialize(staticdata)
        self.object:set_armor_groups { matter = 100, antimatter = 100 }
        self.owner = staticdata.owner
        self.direction = staticdata.direction
        self.object:set_acceleration(vector.new(0, -sbz_api.gravity, 0))
        self.object:set_velocity(vector.multiply(vector.add(speed_vec, staticdata.vel), self.direction))
    end,
    on_punch = function(self)
        -- use to defend yourself i guess idk lmfao good luck!
        detonate(self.object, self.owner, 15)
    end,
    on_death = function(self, killer)
        detonate(self.object, self.owner, 15)
    end,
    on_step = function(self, dtime, moveresult)
        if moveresult.collides then
            detonate(self.object, self.owner, 15)
        end
    end
})

core.register_craftitem("sbo_explosives:thermite_stick", {
    description = "Thermite Explosive Stick",
    wield_scale = { x = 1, y = 1, z = 2.5 },
    wield_image = "thermite_wield.png",
    inventory_image = "thermite_inv.png",
    on_use = function(stack, placer, pointed)
        local look_dir = placer:get_look_dir()
        local name = placer:get_player_name()
        core.add_entity(
            vector.add(sbz_api.get_pos_with_eye_height(placer), vector.multiply(look_dir, 0.05)),
            "sbo_explosives:thermite_stick_entity",
            core.serialize { owner = name, direction = look_dir, vel = placer:get_velocity() })
        stack:set_count(stack:get_count() - 1)
        return stack
    end
})

sbz_api.recipe.register_craft {
    type = "compressing",
    output = "sbo_explosives:thermite_stick",
    items = { "sbo_atomic:phosphorus 100" }
}
-----
core.register_entity("sbo_explosives:nuclear_stick_entity", {
    initial_properties = {
        visual = "sprite",
        visual_size = { x = 1, y = 1, z = 1 },
        pointable = false,
        collide_with_objects = true,
        physical = true,
        textures = { "nuclear_inv.png" },
        glow = 14,
        static_save = false,
    },
    on_activate = function(self, staticdata, dtime_s)
        staticdata = core.deserialize(staticdata)
        self.object:set_armor_groups { matter = 100, antimatter = 100 }
        self.owner = staticdata.owner
        self.direction = staticdata.direction
        self.object:set_acceleration(vector.new(0, -sbz_api.gravity, 0))
        self.object:set_velocity(vector.multiply(vector.add(speed_vec, staticdata.vel), self.direction))
    end,
    on_punch = function(self)
        -- use to defend yourself i guess idk lmfao good luck! Extra Good Luck!!!
        detonate(self.object, self.owner, 40)
    end,
    on_death = function(self, killer)
        detonate(self.object, self.owner,40)
    end,
    on_step = function(self, dtime, moveresult)
        if moveresult.collides then
            detonate(self.object, self.owner,40)
        end
    end
})

core.register_craftitem("sbo_explosives:nuclear_stick", {
    description = "Nuclear Explosive Stick",
    wield_scale = { x = 1, y = 1, z = 2.5 },
    wield_image = "nuclear_wield.png",
    inventory_image = "nuclear_inv.png",
    on_use = function(stack, placer, pointed)
        local look_dir = placer:get_look_dir()
        local name = placer:get_player_name()
        core.add_entity(
            vector.add(sbz_api.get_pos_with_eye_height(placer), vector.multiply(look_dir, 0.05)),
            "sbo_explosives:nuclear_stick_entity",
            core.serialize { owner = name, direction = look_dir, vel = placer:get_velocity() })
        stack:set_count(stack:get_count() - 1)
        return stack
    end
})

sbz_api.recipe.register_craft {
    type = "compressing",
    output = "sbo_explosives:nuclear_stick",
    items = { "sbz_chem:plutonium_block 100" }
}
