
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
### Trexare
Tends to buzz around stemfruit and gives honey when killed, you can also right-click a Trexare to pick it up and place in inventory. 3x Trexare's in a row can craft a Trexare Cluster.

---
### Hexenith
Hexeniths appear on Colorium Planets and can be tamed with 4 stemfruit. Can also be picked up and placed in inventory and gives 1 raw Hexenith and 1 Hexenith hide when killed.

---
### Floxite
Found in Colorium Planets and lays eggs on flat ground, Can be picked up and placed in inventory and gives 1-2 raw Floxite when killed. Feed 8x stemfruit to breed.

---
### Astrozenni
Wanders around on Colorium Planets eating grass and can be right-clicked with empty fluid cell to get milk. Astrozenni will defend themselves when hit and can be right-clicked with 8x pyrograss to tame and breed.

---
### Athrosoto
Found on Colorium Planets these cute Athrosoto walk around and can be picked up and placed in inventory as pets or right-clicked with 4x live rats or voidfish and tamed.  They can sometimes leave you little gifts of a hairball, remember to check just incase it contains an item.

---
### Plesoic
Typically found around stone they can be picked up and cooked for eating.

---
### Unopian
Grass munchers that can be clipped using shears to give 1-3 Light Blocks when tamed. Feed sheep 8x pyrograss to regrow Light Blocks, tame and breed. Will drop 1-3 raw Unopian when killed.

---
### Jogbin
Jogbin unlike pigs defend themselves when hit and give 1-3 raw Jogbin when killed, they can also be right-clicked with 8x warpshroom to tame or breed.

---
### Vexinite
These little guys can be found in glacier biomes on top of snow and have the ability to swim if they fall into water.

---
### Fleablo
These monochrome cuties spawn on Colorium Planets and can be tamed with colorium leaves :)  Remember they have claws though.

]],
})
