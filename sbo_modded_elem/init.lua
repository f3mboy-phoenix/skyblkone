sbz_api.register_modded_element = function(name, color, description, def, modname)
    def = def or {}
    local disabled, part_of_crusher_drops, radioactive = def.disabled, def.part_of_crusher_drops, def.radioactive
    if disabled == nil then disabled = false end
    local disabled_group = disabled and 1 or nil
    core.register_craftitem(modname .. name .. "_powder", {
        groups = { chem_element = 1, powder = 1, not_in_creative_inventory = disabled_group, chem_disabled = disabled_group, radioactive = radioactive },
        description = string.format(description, "Powder"),
        inventory_image = "powder.png^[colorize:" .. color .. ":150"
    })
    core.register_craftitem(modname .. name .. "_ingot", {
        groups = { chem_element = 1, ingot = 1, not_in_creative_inventory = disabled_group, chem_disabled = disabled_group, radioactive = radioactive },
        description = string.format(description, "Ingot"),
        inventory_image = "ingot.png^[multiply:" .. color --[[.. ":150"]],

    })
    local rad_resistance = def.radiation_resistance or 0

    core.register_node(modname .. name .. "_block", unifieddyes.def {
        groups = {
            chem_element = 1,
            chem_block = 1,
            not_in_creative_inventory = disabled_group,
            chem_disabled = disabled_group,
            matter = 1,
            level = 2,
            explody = 100,
            radioactive = radioactive,
            radiation_resistance = rad_resistance,
        },
        description = string.format(description, "Block"),
        drawtype = "glasslike_framed",
        tiles = { "block_frame.png^[colorize:" .. color .. ":200", "block_inner.png^[colorize:" .. color .. ":200" },
        sounds = sbz_api.sounds.metal()
    })


    -- fluid
    if def.fluid then
        core.register_node((modname.."%s_fluid_source"):format(name), {
            description = description:format("Fluid Source"),
            drawtype = "liquid",
            tiles = {
                { name = ("flowing_chemical_source.png^[multiply:%s"):format(color), backface_culling = false, },
                { name = ("flowing_chemical_source.png^[multiply:%s"):format(color), backface_culling = true, }
            },
            inventory_image = minetest.inventorycube(("flowing_chemical_source.png^[multiply:%s"):format(color)),
            --       use_texture_alpha = "blend",
            groups = {
                liquid = 3,
                habitat_conducts = 1,
                transparent = 1,
                liquid_capturable = 1,
                water = 0,
                not_in_creative_inventory = disabled_group,
                chem_disabled = disabled_group,
                chem_fluid = 1,
                chem_fluid_source = 1,
                chem_element = 1,
                radioactive = (radioactive or 0) * 2,
                hot = 50,
                radiation_resistance = rad_resistance * 16,
            },
            post_effect_color = color .. "7F",
            paramtype = "light",
            walkable = false,
            pointable = false,
            buildable_to = true,
            liquidtype = "source",
            liquid_alternative_source = (modname.."%s_fluid_source"):format(name),
            liquid_alternative_flowing = (modname.."%s_fluid_flowing"):format(name),
            drop = "",
            liquid_viscosity = 7,
            liquid_renewable = false,
            sbz_node_damage = {
                matter = 5, -- 5hp/second
            },
            light_source = 14,
            liquid_range = 2,
            chem_block_form = modname .. name .. "_block"
        })

        local animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 8,
        }

        minetest.register_node((modname.."%s_fluid_flowing"):format(name), {
            description = description:format("Fluid Flowing"),
            drawtype = "flowingliquid",
            tiles = { { name = ("flowing_chemical_source.png^[multiply:%s"):format(color), } },
            special_tiles = {
                {
                    name = ("flowing_chemical.png^[multiply:%s"):format(color),
                    backface_culling = false,
                    animation = animation,
                },
                {
                    name = ("flowing_chemical.png^[multiply:%s"):format(color),
                    backface_culling = true,
                    animation = animation,
                }
            },
            --          use_texture_alpha = "blend",
            groups = {
                liquid = 3,
                habitat_conducts = 1,
                transparent = 1,
                not_in_creative_inventory = 1,
                water = 0,
                hot = 10,
                chem_disabled = disabled_group,
                chem_fluid = 1,
                chem_fluid_source = 0,
                radioactive = radioactive,
                radiation_resistance = rad_resistance,
            },
            post_effect_color = color .. "7F",
            paramtype = "light",
            paramtype2 = "flowingliquid",
            walkable = false,
            pointable = false,
            buildable_to = true,
            liquidtype = "flowing",
            liquid_alternative_source = (modname.."%s_fluid_source"):format(name),
            liquid_alternative_flowing = (modname.."%s_fluid_flowing"):format(name),
            drop = "",
            liquid_viscosity = 7,
            sbz_node_damage = {
                matter = 3, -- 3hp/second
            },
            liquid_renewable = false,
            light_source = 14,
            liquid_range = 2,
            chem_block_form = "sbz_chem:" .. name .. "_block",

        })

        sbz_api.register_fluid_cell((modname.."%s_fluid_cell"):format(name), {
            description = description:format("Fluid Cell"),
            groups = {
                chem_disabled = disabled_group,
                chem_fluid_cell = 1,
                chem_fluid_source = 0,
                not_in_creative_inventory = disabled_group,
            }
        }, (modname.."%s_fluid_source"):format(name), color)
    end
    if not disabled then
        stairs.register(modname .. name .. "_block", {
            tiles = {
                "block_full.png^[colorize:" .. color .. ":200",
                "block_full.png^[colorize:" .. color .. ":200",
                "block_full.png^[colorize:" .. color .. ":200",
                "block_full.png^[colorize:" .. color .. ":200",
                "block_full.png^[colorize:" .. color .. ":200",
                "block_full.png^[colorize:" .. color .. ":200",
            },
            tex = {
                stair_front = "block_stair_front.png^[colorize:" .. color .. ":200",
                stair_side = "block_stair_side.png^[colorize:" .. color .. ":200",
                stair_cross = "block_stair_cross.png^[colorize:" .. color .. ":200",
            }
        })
        minetest.register_craft({
            type = "cooking",
            output = modname .. name .. "_ingot",
            recipe = modname .. name .. "_powder",
        })
        unified_inventory.register_craft {
            type = "crushing",
            output = modname .. name .. "_powder",
            items = { modname .. name .. "_ingot" }
        }

        unified_inventory.register_craft {
            type = "compressing",
            output = modname.. name .. "_block",
            items = { modname .. name .. "_powder 9" }
        }
        unified_inventory.register_craft {
            type = "compressing",
            output = modname .. name .. "_block",
            items = { modname .. name .. "_ingot 9" }
        }

        unified_inventory.register_craft {
            type = "crushing",
            output = modname .. name .. "_powder 9",
            items = { modname .. name .. "_block" }
        }

        if part_of_crusher_drops == nil or part_of_crusher_drops == true then
            sbz_api.crusher_drops[#sbz_api.crusher_drops + 1] = modname .. name .. "_powder"
            sbz_api.crusher_drops_enhanced[#sbz_api.crusher_drops_enhanced + 1] = modname .. name .. "_powder"
            unified_inventory.register_craft {
                output = modname .. name .. "_powder",
                type = "crushing",
                items = {
                    "sbz_resources:pebble"
                }
            }
            unified_inventory.register_craft {
                output = modname .. name .. "_powder",
                type = "crushing",
                items = {
                    "sbz_chem:enhanced_pebble"
                }
            }
        elseif def.part_of_enhanced_drops == true then
            sbz_api.crusher_drops_enhanced[#sbz_api.crusher_drops_enhanced + 1] = modname .. name .. "_powder"
            unified_inventory.register_craft {
                output = modname .. name .. "_powder",
                type = "crushing",
                items = {
                    "sbz_resources:pebble"
                }
            }
        end
    else
        sbz_api.unused_chem[#sbz_api.unused_chem + 1] = modname .. name
    end
end

minetest.after(0, function()
    for k, v in pairs(sbz_api.unused_chem) do
        local powder = v .. "_powder"
        local ingot = v .. "_ingot"
        if unified_inventory.get_recipe_list(powder) then
            minetest.log(
                "This chemical: " ..
                powder ..
                " is disabled, and shouldn't have any use.. right... but it has!!! \n details: " ..
                dump(unified_inventory.get_recipe_list(powder)))
        end
        if unified_inventory.get_recipe_list(ingot) then
            minetest.log(
                "This chemical: " ..
                ingot ..
                " is disabled, and shouldn't have any use.. right... but it has!!! \n details: " ..
                dump(unified_inventory.get_recipe_list(ingot)))
        end
    end
end)


-- disabled tech
sbz_api.register_modded_element("zinc", "#7F7F7F", "Zinc %s (Zn)", { disabled = false}, "sbo_modded_elem:")
sbz_api.register_modded_element("platinum", "#E5E4E2", "Platinum %s (Pt)", { disabled = false }, "sbo_modded_elem:")
sbz_api.register_modded_element("mercury", "#B5B5B5", "Mercury %s (Hg)", { disabled = false }, "sbo_modded_elem:")
sbz_api.register_modded_element("magnesium", "#DADADA", "Magnesium %s (Mg)", { disabled = false }, "sbo_modded_elem:")
sbz_api.register_modded_element("calcium", "#F5F5DC", "Calcium %s (Ca)", { disabled = false }, "sbo_modded_elem:")
sbz_api.register_modded_element("sodium", "#F4F4F4", "Sodium %s (Na)", { disabled = false }, "sbo_modded_elem:")

-- disabled alloys
sbz_api.register_modded_element("white_gold", "#E5E4E2", "White Gold %s (AuNi)",
    { disabled = false, part_of_crusher_drops = false }, "sbo_modded_elem:")
sbz_api.register_modded_element("brass", "#B5A642", "Brass %s (CuZn)", { disabled = false, part_of_crusher_drops = false }, "sbo_modded_elem:")

