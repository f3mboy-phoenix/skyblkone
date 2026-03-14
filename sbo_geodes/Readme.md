# Geodes Library

Register a geode:
```lua
geodes_lib:register_geode({
    wherein = -- node in which geodes generate, set to mapgen_stone unless you need it to spawn in a specific place,
    y_min = -- minimum level at which geodes generate,
    y_max = -- maximum level at which geodes generate,
    scarcity = -- rarity of geodes, rarest at 80, lower values not recommended unless you use generation chance,
    inner = -- node comprising innermost part of geode, usually a crystal such as amethyst,
    inner_alt = -- replacement for node comprising innermost part of geode, usually a budding node which spawns plantlike drawtype crystal nodes on all sides,
    inner_alt_chance = -- chance of core_alt replacing core,
    shell = -- array of nodes comprising geode shell, from outermost to innermost,
    radius_min = -- minimum radius of geode cavity,
    radius_max = -- maximum radius of geode cavity,
    generation_chance = -- % chance a geode spawns given other conditions, lets geodes be even rarer,
    id = -- appended to the name of technical geode generator node. Required when generating multiple geodes with the same core, otherwise optional
})
```
Example:
```lua
geodes_lib:register_geode({
    wherein = "mapgen_stone",
    y_min = -31000,
    y_max = -10,
    scarcity = 80,
    inner = "modname:citrine",
    inner_alt = "modname:citrine_budding",
    inner_alt_chance = 100,
    shell = {"modname:limestone", "modname:calcite"},
    radius_min = 2,
    radius_max = 10,
    generation_chance = 50, -- set to around 10 if you are adding 20 or more geodes this way,
    id = "1",
})
```
