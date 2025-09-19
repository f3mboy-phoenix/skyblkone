
minetest.register_craftitem("sbo_cooking:energy_pellet", {
    description = "Energy Pellet",
    on_use=hbhunger.item_eat(.5),
    inventory_image = "pellet.png", -- replace or draw your own
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
    description = "Quantum Snack",
    on_use=hbhunger.item_eat(1),
    inventory_image = "snack.png", -- replace or draw your own
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
    description = "Fusion Meal",
    on_use=hbhunger.item_eat(1.5),
    inventory_image = "emeal.png", -- replace or draw your own
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
    description = "Dust Biscuits",
    on_use=hbhunger.item_eat(1.5),
    inventory_image = "biscuit.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:dust", 1.5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:dust",
    recipe = {
        'sbz_resources:matter_dust', 'sbz_resources:strange_dust 8'
    }
})

minetest.register_craftitem("sbo_cooking:photon", {
    description = "Photon Drop",
    on_use=hbhunger.item_eat(2),
    inventory_image = "photon.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:photon", 2)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:photon",
    recipe = {
        'sbz_resources:strange_dust', 'sbo_photon:photon 8'
    }
})

minetest.register_craftitem("sbo_cooking:resium", {
    description = "Resium Candy",
    on_use=hbhunger.item_eat(5),
    inventory_image = "resium.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:resium", 5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:resium",
    recipe = {
        'sbo_resium:crystal 3'
    }
})

minetest.register_craftitem("sbo_cooking:epaste", {
    description = "Extrosim Paste",
    on_use=hbhunger.item_eat(5),
    inventory_image = "paste.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:epaste", 5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:epaste",
    recipe = {
        'sbo_extrosim:raw_extrosim 5', 'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:eflakes", {
    description = "Emittrium Flakes",
    on_use=hbhunger.item_eat(5),
    inventory_image = "eflakes.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:eflakes", 5)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:flakes",
    recipe = {
        'sbz_resources:raw_extrosim 5', 'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:bites", {
    description = "Shock Bites",
    on_use=hbhunger.item_eat(8),
    inventory_image = "bites.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:bites", 8)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:bites",
    recipe = {
        'sbz_resources:shock_crystal 5', 'sbz_resources:strange_dust'
    }
})

minetest.register_craftitem("sbo_cooking:loaf", {
    description = "Color Loaf",
    on_use=hbhunger.item_eat(8),
    inventory_image = "loaf.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:loaf", 8)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:loaf",
    recipe = {
        'unifieddyes:colorium 7', 'sbz_resources:matter_dust'
    }
})

minetest.register_craftitem("sbo_cooking:broth", {
    description = "Phlogiston Broth",
    on_use=hbhunger.item_eat(12),
    inventory_image = "broth.png", -- replace or draw your own
})
hbhunger.register_food("sbo_cooking:broth", 12)
minetest.register_craft({
    type = "shapeless",
    output = "sbo_cooking:broth",
    recipe = {
        'sbz_resources:phlogiston 7', 'sbz_resources:matter_dust', "sbz_chem:water_fluid_cell"
    }
})

