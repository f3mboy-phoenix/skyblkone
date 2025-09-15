minetest.register_abm({
    nodenames = {"sbz_bio:colorium_tree", "sbz_bio:colorium_leaves"},
    interval = 5,
    chance = 1,
    action = function(pos, node)
        minetest.remove_node(pos)
    end,
})
