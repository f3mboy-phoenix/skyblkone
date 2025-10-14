minetest.register_chatcommand("wiki", {
    description = "Gives you a wiki if you don't have one.",
    privs = {},
    func = function(name, param)
        local inv = minetest.get_player_by_name(name):get_inventory()
        if inv then
            if inv:contains_item("main", "sbo_core:wiki") then
                sbz_api.displayDialogLine(name, "You already have a Wiki.")
            else
                if inv:room_for_item("main", "sbo_core:wiki") then
                    inv:add_item("main", "sbo_core:wiki")
                    sbz_api.displayDialogLine(name, "You have been given a Wiki.")
                else
                    sbz_api.displayDialogLine(name, "Your inventory is full.")
                end
            end
        end
    end,
})
