local laser_range = 300

local max_wear = 50
local power_per_1_use = 50

minetest.register_tool("sbo_laser:laser_weapon", {
    description = "Laser",
    info_extra = "Do you want to get all the meteorites you see, without bridging to them? This is the perfect weapon",
    inventory_image = "laser_pointer.png",
    groups = { disable_repair = 1, power_tool = 1 },
    wear_represents = "power",
    on_use = function(stack, player, original_pointed)
        if stack:get_wear() < (65535) then
            stack:set_wear(math.min(65535, stack:get_wear() + (65535 / max_wear)))

            local eyepos = sbz_api.get_pos_with_eye_height(player)
            local lookdir = player:get_look_dir()
            local endpos = vector.add(eyepos, vector.multiply(lookdir, laser_range))
            local ray = minetest.raycast(vector.add(eyepos, vector.multiply(lookdir, 2)), endpos, true, false)

            repeat
                local pointed = ray:next()
                if pointed and pointed.type == "object" then
                    local ref = pointed.ref
                    local luaentity = ref:get_luaentity()
                    if luaentity and luaentity.name == "sbz_meteorites:meteorite" then
                        minetest.after(0.1, function()
                            if ref and ref:is_valid() then
                                sbz_api.meteorite_explode(ref:get_pos(), luaentity.type)
                            end
                        end)
                    end
                    if luaentity and luaentity.typename == "meteorite" then
                        minetest.after(0.1, function()
                            if ref and ref:is_valid() then
                                sbz_api[luaentity.apiname].explode(ref:get_pos(), luaentity.type)
                            end
                        end)
                    end
                    
                    if ref:is_player() then
                        minetest.after(0.1, function()
                            if ref and ref:is_player() and player and player:is_player() then
                                local damage = 3
                                sbz_api.punch(ref, player, 200, {
                                    full_punch_interval = 0,
                                    damage_groups = { light = damage },
                                }, lookdir)
                            end
                        end)
                    end
                end
            until not pointed

            core.add_particlespawner {
                pos     = eyepos + lookdir * 2,
                texture = "star.png^[colorize:red",
                time    = 0.8,
                size    = 3,
                amount  = 5000,
                exptime = 10,
                attract = {
                    kind = "point",
                    origin = endpos,
                    strength = 0.8,
                    die_on_contact = true,
                },
                glow    = 14,
            }
        end


        return stack
    end,
    on_place = sbz_api.on_place_recharge((max_wear / 65535) * power_per_1_use),
    powertool_charge = sbz_api.powertool_charge((max_wear / 65535) * power_per_1_use),
    charge_per_use = power_per_1_use,
    power_per_1_use = power_per_1_use,
    wield_scale = { x = 1, y = 1, z = 2.5 },
    wield_image = "laser_wield.png",
    wear_color = { color_stops = { [0] = "lime" } },
})

minetest.register_craft {
    output = "sbo_laser:laser_weapon",
    recipe = {
        { "sbz_resources:emittrium_circuit" },
        { "sbz_power:advanced_battery" },
        { "sbz_resources:reinforced_matter" }
    }
}
sbz_api.achievment_table["sbz_laser:laser_weapon"] = "Laser"

minetest.register_craft({
    output = "sbz_chem:engraver",
    recipe = {
        { "sbz_resources:reinforced_matter", "sbo_laser:laser_weapon", "sbz_resources:reinforced_matter" },
        { "sbz_resources:emittrium_circuit", "sbz_resources:storinator",   "sbz_resources:emittrium_circuit" },
        { "sbz_meteorites:neutronium",       "sbz_meteorites:neutronium",  "sbz_meteorites:neutronium" },
    }
})
