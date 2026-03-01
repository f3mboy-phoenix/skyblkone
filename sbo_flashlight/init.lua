local modpath = minetest.get_modpath("sbo_flashlight")

--from itemextensions
itemextensions = {}

itemextensions._playerdata = {}
function itemextensions.pi(player)
	if not core.is_player(player) then return nil end
	local pi = itemextensions._playerdata[player]
	if not pi then pi = {}; itemextensions._playerdata[player] = pi end
	return pi
end

dofile(modpath .. "/scripts/equipment.lua")
dofile(modpath .. "/scripts/move_item.lua")
dofile(modpath .. "/scripts/wieldevents.lua")


--from aom_util
aom_util = {}
aom_util.player = {}

dofile(modpath .. "/scripts" .. "/tools_and_hand_range.lua")
dofile(modpath .. "/scripts" .. "/on_change_wielditem.lua")
dofile(modpath .. "/scripts" .. "/try_rightclick.lua")
dofile(modpath .. "/nodes" .. "/air_lights.lua")

--from backrooms_test
dofile(modpath .. "/flashlight.lua")

--sbz integration
minetest.register_craft({
    output = "sbo_flashlight:flashlight",
    recipe = {
        { "sbo_ultra_pipes:mlp_tube_1", "sbz_resources:matter_plate", "" },
        { "sbz_resources:matter_plate", "sbo_light_blk:light_block", "sbz_resources:matter_plate" },
        { "", "sbz_resources:matter_plate", "" }
    }
})
sbo_api.quests.on_craft["sbo_flashlight:flashlight"] = "Flashlight"
sbo_api.quests.register_to("Questline: Chemistry",{
    type = "quest",
    title = "Flashlight",
    text = [[The flashlight from backroom test.]],
    requires = { "Block of Light??" }
})
