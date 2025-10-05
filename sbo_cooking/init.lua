minetest.register_craftitem("sbo_cooking:energy_pellet", {
    description = "Energy Pellet"..minetest.colorize("#777", "\n\nRestores 5 hunger"),
    on_use=hbhunger.item_eat(5),
    inventory_image = "pellet.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:energy_pellet", .5)
minetest.register_craft({
    type = "shaped",
    output = "sbo_cooking:energy_pellet",
    recipe = {
        { 'sbz_resources:matter_blob', 'sbz_resources:matter_blob', 'sbz_resources:matter_blob' },
        { 'sbz_resources:matter_blob', 'sbz_resources:core_dust',   'sbz_resources:matter_blob' },
        { 'sbz_resources:matter_blob', 'sbz_resources:matter_blob', 'sbz_resources:matter_blob' },
    }
})

minetest.register_craftitem("sbo_cooking:snack", {
    description = "Quantum Snack"..minetest.colorize("#777", "\nRestores 1 hunger"),
    on_use=hbhunger.item_eat(1),
    inventory_image = "snack.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:snack", 1)
minetest.register_craft({
    --type = "shapeless",
    output = "sbo_cooking:snack",
        recipe = {
        { 'sbz_resources:matter_dust', 'sbz_resources:matter_dust',      'sbz_resources:matter_dust' },
        { 'sbz_resources:matter_dust', 'sbz_resources:charged_particle', 'sbz_resources:matter_dust' },
        { 'sbz_resources:matter_dust', 'sbz_resources:matter_dust',      'sbz_resources:matter_dust' },
    }
})

minetest.register_craftitem("sbo_cooking:emeal", {
    description = "Fusion Meal"..minetest.colorize("#777", "\nRestores 1.5 hunger"),
    on_use=hbhunger.item_eat(1.5),
    inventory_image = "emeal.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:emeal", 1.5)
minetest.register_craft({
    --type = "shapeless",
    output = "sbo_cooking:emeal",
        recipe = {
        { 'sbz_resources:core_dust', 'sbz_resources:matter_dust',        'sbz_resources:core_dust' },
        { 'sbz_resources:matter_dust', 'sbz_resources:charged_particle', 'sbz_resources:matter_dust' },
        { 'sbz_resources:matter_dust', 'sbz_resources:charged_particle', 'sbz_resources:matter_dust' },
    }
})

minetest.register_craftitem("sbo_cooking:dust", {
    description = "Dust Biscuits"..minetest.colorize("#777", "\nRestores 1.5 hunger"),
    on_use=hbhunger.item_eat(1.5),
    inventory_image = "biscuit.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:dust", 1.5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:dust",
    recipe = {
        'sbz_resources:matter_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
        'sbz_resources:strange_dust',
    }
})

minetest.register_craftitem("sbo_cooking:photon", {
    description = "Photon Drop"..minetest.colorize("#777", "\nRestores 2 hunger"),
    on_use=hbhunger.item_eat(2),
    inventory_image = "sphoton.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:photon", 2)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:photon",
    recipe = {
        'sbz_resources:strange_dust',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
        'sbo_photon:photon',
    }
})

minetest.register_craftitem("sbo_cooking:resium", {
    description = "Resium Candy"..minetest.colorize("#777", "\nRestores 18 hunger"),
    on_use=hbhunger.item_eat(18),
    inventory_image = "fresium.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:resium", 18)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:resium",
    recipe = {
        'sbo_resium:crystal',
        'sbo_resium:crystal',
        'sbo_resium:crystal',
    }
})

minetest.register_craftitem("sbo_cooking:epaste", {
    description = "Extrosim Paste"..minetest.colorize("#777", "\nRestores 10 hunger"),
    on_use=hbhunger.item_eat(10),
    inventory_image = "paste.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:epaste", 10)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:epaste",
    recipe = {
        'sbo_extrosim:raw_extrosim',
        'sbo_extrosim:raw_extrosim',
        'sbo_extrosim:raw_extrosim',
        'sbo_extrosim:raw_extrosim',
        'sbo_extrosim:raw_extrosim',
        'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:eflakes", {
    description = "Emittrium Flakes"..minetest.colorize("#777", "\nRestores 8 hunger"),
    on_use=hbhunger.item_eat(8),
    inventory_image = "eflakes.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:eflakes", 8)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:flakes",
    recipe = {
        'sbz_resources:raw_emittrium',
        'sbz_resources:raw_emittrium',
        'sbz_resources:raw_emittrium',
        'sbz_resources:raw_emittrium',
        'sbz_resources:raw_emittrium',
        'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:bites", {
    description = "Shock Bites"..minetest.colorize("#777", "\nRestores 8 hunger"),
    on_use=hbhunger.item_eat(8),
    inventory_image = "bites.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:bites", 8)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:bites",
    recipe = {
        'sbz_resources:shock_crystal',
        'sbz_resources:shock_crystal',
        'sbz_resources:shock_crystal',
        'sbz_resources:shock_crystal',
        'sbz_resources:shock_crystal',
        'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:loaf", {
    description = "Color Loaf"..minetest.colorize("#777", "\nRestores 8 hunger"),
    on_use=hbhunger.item_eat(8),
    inventory_image = "loaf.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:loaf", 8)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:loaf",
    recipe = {
        'unifieddyes:colorium',
        'unifieddyes:colorium',
        'unifieddyes:colorium',
        'unifieddyes:colorium',
        'unifieddyes:colorium',
        'sbz_resources:matter_dust'
    }
})

minetest.register_craftitem("sbo_cooking:broth", {
    description = "Phlogiston Broth"..minetest.colorize("#777", "\nRestores 12 hunger"),
    on_use=hbhunger.item_eat(12),
    inventory_image = "broth.png", -- replace or draw your own
    groups={ui_food=1},
})
hbhunger.register_food("sbo_cooking:broth", 12)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:broth",
    recipe = {
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:phlogiston',
        'sbz_resources:matter_dust',
        "sbz_chem:water_fluid_cell"
    }
})
sbz_api.quests[#sbz_api.quests+1]={ type = "text", title = "Questline: Food", text = "????" }

sbz_api.achievment_table["sbo_cooking:energy_pellet"] = "Energy Pellet"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Energy Pellet",
        text = [[You made a Energy Pellet, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:snack"] = "Quantum Snack"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Quantum Snack",
        text = [[You made a Quantum Snack, it is Edible]],
})

sbz_api.achievment_table["sbo_cooking:emeal"] = "Fusion Meal"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Fusion Meal",
        text = [[You made a Fusion Meal, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:dust"] = "Dust Biscuits"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Dust Biscuits",
        text = [[You made a Dust Biscuits, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:photon"] = "Photon Drop"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Photon Drop",
        text = [[You made a Photon Drop, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:resium"] = "Resium Candy"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Resium Candy",
        text = [[You made a Resium Candy, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:epaste"] = "Extrosim Paste"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Extrosim Paste",
        text = [[You made a Extrosim Paste, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:eflakes"] = "Emittrium Flakes"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Emittrium Flakes",
        text = [[You made a Emittrium Flakes, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:bites"] = "Shock Bites"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Shock Bites",
        text = [[You made a Shock Bites, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:loaf"] = "Color Loaf"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Color Loaf",
        text = [[You made a Color Loaf, it is Edible]],
})
sbz_api.achievment_table["sbo_cooking:broth"] = "Phlogiston Broth"
sbz_api.register_quest_to("Questline: Food",{
        type = "quest",
        title = "Extrosim Paste",
        text = [[You made a Extrosim Paste, it is Edible]],
})
unified_inventory.register_category('food', {
	symbol = "sbo_cooking:snack",
	label = "Food"
})
unified_inventory.add_category_item('food', "sbo_cooking:energy_pellet")
unified_inventory.add_category_item('food', "sbo_cooking:broth")
unified_inventory.add_category_item('food', "sbo_cooking:loaf")
unified_inventory.add_category_item('food', "sbo_cooking:bites")
unified_inventory.add_category_item('food', "sbo_cooking:eflakes")
unified_inventory.add_category_item('food', "sbo_cooking:epaste")
unified_inventory.add_category_item('food', "sbo_cooking:resium")
unified_inventory.add_category_item('food', "sbo_cooking:photon")
unified_inventory.add_category_item('food', "sbo_cooking:dust")
unified_inventory.add_category_item('food', "sbo_cooking:emeal")
unified_inventory.add_category_item('food', "sbo_cooking:snack")
