quests[#quests+1]={ type = "text", title = "Questline: Colorium", text = "Colorium Based Questline" }
sbo_api.quests.on_craft["sbz_bio:colorium_planks"] = "Getting Wood"
sbo_api.quests.register_to("Questline: Colorium",{
    type = "quest",
    title = "Getting Wood",
    text =
        [[Punch a tree until a block of wood pops out.]],
    requires = { "Dirt", }
})
