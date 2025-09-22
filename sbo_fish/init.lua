local storage = minetest.get_mod_storage()
sbz_api.fish={}
sbz_api.fish.storage=storage
local __fish= tonumber(storage:get_string("fishes")) or 0
print(fishes)
minetest.register_craftitem("sbo_fish:fish", {
    description = "Voidfish",
    on_use=hbhunger.item_eat(1.5),
    inventory_image = "fish.png", -- replace or draw your own
})
hbhunger.register_food("sbo_fish:fish", 1.5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_life:essence",
    recipe = { "sbo_fish:fish" }
})

function sbz_api.get_fishes() return __fish end
minetest.register_entity("sbo_fish:mob", {
    initial_properties = {
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
        visual = "mesh",
        mesh = "mob.b3d",
        paramtype = "light",
        visual_size = {x = 2, y = 2, z = 2},
        textures = {"mob.png"},
        hp_max = 3,
    },

    -- State
    timer = 0,
    direction = {x = 0, y = 0, z = 0},
on_activate = function (self)
    __fish = __fish + 1
end,
on_remove = function ()
    __fish = __fish - 1
end,

on_step = function(self, dtime)
    self.timer = self.timer + dtime

    local pos = self.object:get_pos()
    local players = minetest.get_connected_players()
    local target = nil

    for _, player in ipairs(players) do
        local ppos = player:get_pos()
        local dist = vector.distance(pos, ppos)

        -- only care if close enough
        if dist < 15 then
            local wield = player:get_wielded_item():get_name()
            if wield == "sbz_resources:core_dust" then
                target = ppos
                break
            end
        end
    end

    if target then
        -- Move toward the player
        local dir = vector.direction(pos, target)
        local speed = 2
        self.object:set_velocity(vector.multiply(dir, speed))
    else
        -- No lure: wander randomly every 3s
        if self.timer > 3 then
            self.direction = {
                x = math.random(-2, 2),
                y = math.random(-1, 1),
                z = math.random(-2, 2),
            }
            self.timer = 0
        end
        self.object:set_velocity(self.direction)
    end

	local vel= self.object:get_velocity()

	if vel.x~=0 or vel.z~=0 then
		local yaw = math.atan2(vel.z,vel.x)
		self.object:set_yaw(-yaw + math.pi/2)
	end
    -- Optional: still play sound sometimes
    if math.random() < 0.01 then
        minetest.sound_play("sbo_fish_voidfish", {
            object = self.object,
            max_hear_distance = 200,
            gain = 1.0,
        })
    end
end,

    on_punch = function(self, hitter)
        local hp = self.object:get_hp() - 1
        if hp <= 0 then
            minetest.add_item(self.object:get_pos(), "sbo_fish:fish")
            self.object:remove()
        else
            self.object:set_hp(hp)
        end
    end,
})

-- Spawning system: spawn fish in the air randomly
minetest.register_abm({
    label = "Spawn Flying Fish",
    nodenames = {"air"},
    interval = 1000, -- every 1000 seconds
    chance = 30000,   -- 1 in 30000 chance
    action = function(pos)
        -- only spawn above y=0 to avoid void
        if pos.y > 0 and __fish < 100 then
            minetest.add_entity(pos, "sbo_fish:mob")
        end
    end,
})

sbz_api.register_stateful_machine('sbo_fish:fish_summoner', {
    --disallow_pipeworks = true,
    description = "Fish Summoner",
    drawtype = "mesh",
    paramtype = "light",
    mesh = "meteorite_radar.obj",
    tiles = { "fish_summoner.png" },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.25, 0.5 }
    },
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.25, 0.5 }
    },
    groups = { matter = 1 },
    power_needed = 200,
    action_interval = 0,

    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size('input', 1)
        meta:set_string(
            'formspec',
            [[
formspec_version[7]
size[8.2,9]
style_type[list;spacing=.2;size=.8]
list[context;output;3.5,0.5;4,4;]
list[context;input;1,2;1,1;]
list[current_player;main;0.2,5;8,4;]
listring[current_player;main]listring[context;input]listring[current_player;main]listring[context;output]listring[current_player;main]
]]
        )
    end,
    info_power_consume = 200,
    autostate = true,
    action = function(pos, node, meta, supply, demand)
        local inv = meta:get_inventory()
        local itemname = inv:get_stack('input', 1):get_name()
        local input = inv:get_stack('input', 1)
		print(itemname,input:get_count())
        if input:get_count() < 0 or itemname ~= "sbo_life:essence" then
			print("inactive")
            meta:set_string('infotext', 'Inactive')
            return 0
        end

        if demand + 200 > supply then
            meta:set_string('infotext', 'Not enough power')
            return 200, false
        end

        meta:set_string('infotext', 'Summoning...')

        input:set_count(input:get_count() - 1)
        inv:set_stack('input', 1, input)

		if math.random() < 0.1 then
			for i = 1, math.random(1,5) do
				local offset = {
					x= math.random(-2,2),
					y= math.random(0,4),
					z= math.random(-2,2),
				}
				local spawn = vector.add(pos,offset);
				minetest.add_entity(spawn,"sbo_fish:mob")
			end
		end

        return 200
    end,
    input_inv = 'input',
}, {
    tiles = { "fish_summoners.png" },
    light_source = 3,
})

minetest.register_craft {
    output = 'sbo_fish:fish_summoner',
    recipe = {
        { 'sbo_chromatic_metal:cuticr_ingot', 'sbo_life:essence', 'sbo_chromatic_metal:cuticr_ingot' },
        { 'sbz_resources:matter_blob', 'sbo_rein_cable:power_pipe', 'sbz_resources:matter_blob' },
        { 'sbo_life:essence', 'sbo_control_board:control_board', 'sbo_life:essence' },
    },
}

minetest.register_on_shutdown(function()
	storage:set_string("fishes",tostring(__fish))
end)
