-- this doesn't use any code from techage

local jetpack_durability_s = 60 * 5           -- jetpack durability, in seconds
local jetpack_velocity = vector.new(0, 15, 0) -- multiplied by dtime
local jetpack_full_charge = 20000             -- 20kcj power needed for a jetpack
local jetpack_durability_save_during_sneak_flight = 2
local default_number_of_particles = 20
local jetpack_boost = 3

local jetpack_users = {}
local jetpack_charge_per_1_wear = (jetpack_full_charge / 65535)


local function edit_stack_image(user, stack)
    if stack:get_name() == "sbo_jetpacks:jetpack" then
        if jetpack_users[user] then
            stack:get_meta():set_string("inventory_image", "ejetpack_on.png")
        else
            stack:get_meta():set_string("inventory_image", "ejetpack_off.png")
        end
    end
end

minetest.register_tool("sbo_jetpacks:jetpack", {
    description = "Jetpack",
    info_extra = "Idea originated from techage",
    inventory_image = "ejetpack_off.png",
    stack_max = 1,
    tool_capabilities = {}, -- No specific tool capabilities, as it's not meant for digging
    wear_color = {
        blend = "constant",
        color_stops = {
            [0] = "lime"
        }
    },
    groups = { disable_repair = 1, power_tool = 1 },
    wear_represents = "power",
    on_use = function(itemstack, user, pointed_thing)
        -- Check if user is valid
        if not user or user.is_fake_player then
            return itemstack
        end
        local wear = itemstack:get_wear()
        local username = user:get_player_name()
        if wear < 65535 then
            if jetpack_users[username] then
                jetpack_users[username] = nil
            else
                jetpack_users[username] = user:get_wield_index()
            end
        else
            minetest.chat_send_player(user:get_player_name(), "Jetpack ran out of charge")
        end
        edit_stack_image(username, itemstack)
        return itemstack
    end,
    on_place = sbz_api.on_place_recharge(jetpack_charge_per_1_wear, function(stack, player, pointed)
        edit_stack_image(player:get_player_name(), stack)
    end),
})



local speed = player_monoids.speed
minetest.register_globalstep(function(dtime)
    for player in pairs(jetpack_users) do
        local real_player = minetest.get_player_by_name(player)
        if real_player and real_player:is_valid() then
            local slot = jetpack_users[player]
            local jetpack_item = real_player:get_inventory():get_stack("main", slot)
            if jetpack_item:get_name() ~= "sbo_jetpacks:jetpack" then
                jetpack_users[player] = nil
            end
            if jetpack_item:get_wear() >= 65535 then
                jetpack_users[player] = nil
            end

            local controls = real_player:get_player_control()

            local num_particles = 0
            if (controls.sneak or controls.aux1) and controls.jump and jetpack_users[player] then
                speed:add_change(real_player, jetpack_boost, "sbo_jetpacks:jetpack_boost")
                real_player:add_velocity((jetpack_velocity / 2) * dtime)
                jetpack_item:set_wear(math.min(65535,
                    jetpack_item:get_wear() +
                    65535 *
                    ((jetpack_durability_s * (1 / jetpack_durability_save_during_sneak_flight)) ^ -1)
                    * dtime)) -- this works, do not question it
                num_particles = default_number_of_particles / 5
            elseif controls.jump and jetpack_users[player] then
                speed:add_change(real_player, jetpack_boost, "sbo_jetpacks:jetpack_boost")
                real_player:add_velocity(jetpack_velocity * dtime)
                jetpack_item:set_wear(math.min(65535,
                    jetpack_item:get_wear() + ((65535 * (jetpack_durability_s ^ -1))) * dtime)) -- this works, do not question it
                num_particles = default_number_of_particles
            else
                speed:del_change(real_player, "sbo_jetpacks:jetpack_boost")
            end
            edit_stack_image(player, jetpack_item)
            real_player:get_inventory():set_stack("main", slot, jetpack_item)
            if num_particles ~= 0 then
                -- make a effect
                local vel = real_player:get_velocity()
                vel = vector.subtract(vector.zero(), vel)
				local setter = minetest.add_particlespawner
				if minetest.set_particlespawner then
					setter = minetest.set_particlespawner
				end
                setter({
                    amount = num_particles,
                    time = dtime,
                    texture = "star.png",
                    texpool = {
                        "star.png^[colorize:red",
                        "star.png^[colorize:orange",
                        "star.png^[colorize:yellow",
                    },
                    exptime = { min = 1, max = 2 },
                    vel = { min = vector.new(-2, -2, -2), max = vector.new(2, 2, 2) },
                    acc = { min = vel, max = vel * 5 },
                    radius = { min = 0.1, max = 0.3, bias = 1 },
                    glow = 14,
                    pos = real_player:get_pos()
                })
            end
        else
            jetpack_users[player] = nil
        end
    end
    for k, v in ipairs(minetest.get_connected_players()) do
        if not jetpack_users[v:get_player_name()] then
            speed:del_change(v, "sbo_jetpacks:jetpack_boost")
        end
    end
end)


minetest.register_craft {
    output = "sbo_jetpacks:jetpack",
    recipe = {
        { "sbo_extrosim_circuit:extrosim_circuit", "sbz_power:battery",         "sbo_extrosim_circuit:extrosim_circuit" },
        { "sbz_resources:angels_wing",       "sbz_meteorites:neutronium", "sbz_resources:angels_wing" },
        { "sbo_extrosim_circuit:extrosim_circuit", "",                          "sbo_extrosim_circuit:extrosim_circuit" }
    }
}

