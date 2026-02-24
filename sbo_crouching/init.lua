core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local controls = player:get_player_control()

        if controls.sneak then
            player:set_properties({
                eye_height = 1.35,
                visual_size = {x = 1, y = 0.85},
                collisionbox = { -0.3, 0.0, -0.3, 0.3, 1.4, 0.3 }
            })
            player:set_bone_position("Body", {x = 0, y = 6.3, z = 0}, {x = -10, y = 180, z = 0})
            player:set_bone_position("Head", {x = 0, y = 6.3, z = 0}, {x = 15, y = 0, z = 0})
        else
            player:set_properties({
                eye_height = 1.7,
                visual_size = {x = 1, y = 1.05},
                collisionbox = { -0.3, 0.0, -0.3, 0.3, 1.2, 0.3 }
            })
            player:set_bone_position("Body", {x = 0, y = 6.3, z = 0}, {x = 0, y = 180, z = 0})
            player:set_bone_position("Head", {x = 0, y = 6.3, z = 0}, {x = 0, y = 0, z = 0})
        end
    end
end)
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Crouching",
    text = [[Adds Crouching lol]],
})
