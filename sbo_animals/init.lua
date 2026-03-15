
-- translation and mod path

local S = core.get_translator("sbo_animals")
local path = core.get_modpath(core.get_current_modname()) .. "/"

-- Check for custom mob spawn file

local input = io.open(path .. "spawn.lua", "r")

if input then
	mobs.custom_spawn_animal = true
	input:close()
	input = nil
end

-- helper function

local function ddoo(mob)

	if core.settings:get_bool("mobs_animal." .. mob) == false then
		print("[Mobs_Animal] " .. mob .. " disabled!")
		return
	end

	dofile(path .. mob .. ".lua")
end

-- Animals

ddoo("chicken") -- JKmurray
ddoo("cow") -- KrupnoPavel
ddoo("rat") -- PilzAdam
ddoo("sheep") -- PilzAdam
ddoo("warthog") -- KrupnoPavel
ddoo("bee") -- KrupnoPavel
ddoo("bunny") -- ExeterDad
ddoo("kitten") -- Jordach/BFD
ddoo("penguin") -- D00Med
ddoo("panda") -- AspireMint

-- Load custom spawning if found

if mobs.custom_spawn_animal then
	dofile(path .. "spawn.lua")
end

print ("[MOD] Mobs Redo Animals loaded")

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Animals",
    text =
        [[
        
# ANIMAL MOBS
### Bee
Tends to buzz around stemfruit and gives honey when killed, you can also right-click a bee to pick it up and place in inventory. 3x bee's in a row can craft a beehive.

---
### Bunny
Bunnies appear on Colorium Planets and can be tamed with 4 stemfruit. Can also be picked up and placed in inventory and gives 1 raw rabbit and 1 rabbit hide when killed.

---
### Chicken
Found in Colorium Planets and lays eggs on flat ground, Can be picked up and placed in inventory and gives 1-2 raw chicken when killed. Feed 8x stemfruit to breed.

---
### Cow
Wanders around on Colorium Planets eating grass and can be right-clicked with empty fluid cell to get milk. Cows will defend themselves when hit and can be right-clicked with 8x pyrograss to tame and breed.

---
### Kitten
Found on Colorium Planets these cute cats walk around and can be picked up and placed in inventory as pets or right-clicked with 4x live rats or voidfish and tamed.  They can sometimes leave you little gifts of a hairball, remember to check just incase it contains an item.

---
### Rat
Typically found around stone they can be picked up and cooked for eating.

---
### Sheep
Grass munchers that can be clipped using shears to give 1-3 Light Blocks when tamed. Feed sheep 8x pyrograss to regrow wool, tame and breed. Will drop 1-3 raw mutton when killed.

---
### Warthog
Warthogs unlike pigs defend themselves when hit and give 1-3 raw pork when killed, they can also be right-clicked with 8x warpshroom to tame or breed.

---
### Penguin
These little guys can be found in glacier biomes on top of snow and have the ability to swim if they fall into water.

---
### Panda
These monochrome cuties spawn on Colorium Planets and can be tamed with colorium leaves :)  Remember they have claws though.

]],
})
