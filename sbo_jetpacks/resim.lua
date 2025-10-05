sbz_api.jetpack={}

local storage = minetest.get_mod_storage()
sbz_api.jetpack.color=minetest.deserialize(storage:get_string("color")) or {}
local color=sbz_api.jetpack.color

local color_list = {
	"white", "red","orange","yellow","lime","green","cyan","blue","purple",
	"gold", "tomato","magenta","teal","grey","black","brown","pink"
}

local function sheet(c)
	return "star.png^[colorize:"..color_list[c]
end


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
    if stack:get_name() == "sbo_jetpacks:rjetpack" then
        if jetpack_users[user] then
            stack:get_meta():set_string("inventory_image", "rjetpack_on.png")
        else
            stack:get_meta():set_string("inventory_image", "rjetpack_off.png")
        end
    end
end

minetest.register_tool("sbo_jetpacks:rjetpack", {
    description = "Jetpack",
    info_extra = "Idea originated from techage",
    inventory_image = "rjetpack_off.png",
    stack_max = 1,
    tool_capabilities = {}, -- No specific tool capabilities, as it's not meant for digging
    wear_color = {
        blend = "constant",
        color_stops = {
            [0] = "lime"
        }
    },
    groups = { disable_repair = 1, power_tool = 1, resium = 1 },
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
  on_secondary_use = function(stack, player)
    local size = vector.new(8, 1, 0)
	local button_size = 0.8
	local button_spacing = 0.9

	local fs = {
		([[
formspec_version[7]
size[%s,%s]
	]]):format((size.x * button_spacing) + 1.2, 1.2 + (size.y * button_spacing)), -- 1.5 spacing for the rest
	}

	local head = #fs + 1

	local idx = 0

	for y = 0, size.y do
		for x = 0, size.x do
			idx = idx + 1
			if y == size.y and x >= (size.x - size.z) then
				break
			end
			fs[head] = string.format("image_button[%s,%s;%s,%s;%s;%s;]",
				(x * button_spacing) + 0.2, (y * button_spacing) + 0.2,
				button_size, button_size,
				minetest.formspec_escape(sheet(idx)), idx)
			head = head + 1
		end
	end
		minetest.show_formspec(player:get_player_name(),"sbo:jetpacks:color",table.concat(fs))
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
            if jetpack_item:get_name() ~= "sbo_jetpacks:rjetpack" then
                jetpack_users[player] = nil
            end
            if jetpack_item:get_wear() >= 65535 then
                jetpack_users[player] = nil
            end

            local controls = real_player:get_player_control()

            local num_particles = 0
            if (controls.sneak or controls.aux1) and controls.jump and jetpack_users[player] then
                speed:add_change(real_player, jetpack_boost, "sbo_jetpacks:rjetpack_boost")
                real_player:add_velocity((jetpack_velocity / 2) * dtime)
                jetpack_item:set_wear(math.min(65535,
                    jetpack_item:get_wear() +
                    65535 *
                    ((jetpack_durability_s * (1 / jetpack_durability_save_during_sneak_flight)) ^ -1)
                    * dtime)) -- this works, do not question it
                num_particles = default_number_of_particles / 5
            elseif controls.jump and jetpack_users[player] then
                speed:add_change(real_player, jetpack_boost, "sbo_jetpacks:rjetpack_boost")
                real_player:add_velocity(jetpack_velocity * dtime)
                jetpack_item:set_wear(math.min(65535,
                    jetpack_item:get_wear() + ((65535 * (jetpack_durability_s ^ -1))) * dtime)) -- this works, do not question it
                num_particles = default_number_of_particles
            else
                speed:del_change(real_player, "sbo_jetpacks:rjetpack_boost")
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
                        "star.png^[colorize:"..color[player],
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
            speed:del_change(v, "sbo_jetpacks:rjetpack_boost")
        end
    end
end)


minetest.register_craft {
    output = "sbo_jetpacks:rjetpack",
    recipe = {
        { "sbo_resium:circuit", "sbz_power:battery",         "sbo_resium:circuit" },
        { "sbz_resources:angels_wing",       "sbz_meteorites:neutronium", "sbz_resources:angels_wing" },
        { "sbo_resium:circuit", "",                          "sbo_resium:circuit" }
    }
}

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not color[name] then
		color[name]="#FFFFFF"
	end
end)

minetest.register_on_leaveplayer(function()
	storage:set_string("color", minetest.serialize(color))
end)

minetest.register_on_player_receive_fields(function(player, name, form)
	if name ~="sbo:jetpacks:color" then return end
	local fields=form
	local name= player:get_player_name()
	if form.ok then
		colors[name]=form.color_picker.hex
	end
	if fields.quit then return end
	--sbz_api.displayDialogLine(name, ""..tostring(fields) )
	if not next(fields) then return end

	local idx = tonumber(({ next(fields) })[1])
	if idx == nil then return end

	color[name]=color_list[idx]
end)
