local default_dirt_sounds = {}
if core.get_modpath("sbz_audio") then
	default_dirt_sounds = sbz_audio.dirt()
else
	default_dirt_sounds = sbz_api.sounds.dirt()
end

minetest.register_node("sbo_dirt_planter:dirt", unifieddyes.def {
    description = "Dirt Planter",
    tiles = {
        "dirt_planter.png",
        "reinforced_matter.png",
        "reinforced_matter.png",
    },
    paramtype2 = "color",
    groups = {
        matter = 2,
        crumbly = 1,
        moss_growable = 1,
        soil = 2,
        --oddly_breakable_by_hand = 1,
        charged = 1,
    },
    paramtype = "light", -- if you leave this out, fertilizer wont work
    sounds = default_dirt_sounds,
})
minetest.register_craft({
    output = "sbo_dirt_planter:dirt",
    recipe = {
        { "sbz_bio:fertilizer",         "sbz_resources:matter_plate", "sbz_bio:fertilizer" },
        { "sbz_resources:matter_plate", "sbz_bio:dirt",               "sbz_resources:matter_plate" },
        { "",                           "sbz_resources:matter_plate", "" }
    }
})
sbo_api.quests.in_inven["sbo_dirt_planter:dirt"] = "Dirt Planter"
sbo_api.quests.register_to("Questline: Organics",{
    type = "quest",
    title = "Dirt Planter",
    text =
        [[Dirt Planters is a type of soil that is 2x as effective as dirt thak is blast resistive ]],
    requires = { "Dirt", }
})
