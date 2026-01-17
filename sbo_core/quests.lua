local quests = {}

function sbo_api.register_wiki_page(def)
    def.info = true
    def.type = "text"
    quests[#quests + 1] = def
end

sbo_api.quests = quests
function sbo_api.register_wiki_page_to(line, quest)
    local found = false
    for i = 1, #quests do
        if quests[i].type == "text" then
            if found then
                table.insert(quests, i, quest)
                return true
            elseif quests[i].title == line then
                found = true
            end
        end
    end
    if found then
        sbo_api.register_wiki_page(quest)
        return true
    end
    return false
end

sbo_api.quests[#sbo_api.quests + 1] = {
    type = "text",
    title = "Wiki:",
    text = "Mods will add information here."
}
sbo_api.register_wiki_page_to("Wiki:", {
    title = "Quests+",
    text =
    [[This mod is a slight redo of the questbook was needed to be done so that I could make my own quests. It changes nothing visualy in the questbook.

Also this mod was repurposed to be the required mod for all other Skyblock: One mods. This was chosen because it replaces a core game mod with a slightly modified version.
Kinda like a tiny rom-hack. Where this one is the one that all other require.]]
})
