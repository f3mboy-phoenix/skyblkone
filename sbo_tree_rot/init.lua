minetest.register_abm({
    nodenames = {"sbz_bio:colorium_tree", "sbz_bio:colorium_leaves"},
    interval = 5,
    chance = 1,
    action = function(pos, node)
        minetest.remove_node(pos)
    end,
})
if sbz_api.quests then
	sbz_api.quests[#sbz_api.quests+1]={
		type = "text",
		warning = true,
		title = "Warning Tree Rot is Enabled",
		text = [[The mod sbo_tree_rot is enabled...
Use this mod to get rid of tree trunks and leaves.
They don't drop items, they are just destroyed.
Basicaly a rarely used helper mod for when you make a big tree and dont want to chop it all yourself...😃
]] }
end
minetest.register_on_joinplayer(function(player)
	sbz_api.displayDialogLine(player:get_player_name(), minetest.colorize("#F00", "Warning Tree Rot is Enabled\nMore info in questbook"))
end)
