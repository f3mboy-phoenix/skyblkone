-- Function to create the formspec
local function get_wiki_formspec(selected_quest_index, player_name, quests_to_show, search_text)
    local player_ref = core.get_player_by_name(player_name)
    sbz_api.ui.set_player(player_ref)
    if not player_ref then return '' end

    local selected_quest = quests_to_show[selected_quest_index]
    search_text = search_text or ''
    local quest_list = {}

    local ins = function(element)
        table.insert(quest_list, element)
    end

    local default_indent = '1'
    if search_text ~= '' then default_indent = '0' end

    local pal = sbz_api.ui.get_theme().palette or sbz_api.default_palette

    for _, quest in ipairs(quests_to_show) do
        if quest.info == true then -- info text
            ins(pal.bright_blue)
            ins(default_indent)
            ins '*'
            ins(quest.title)
        elseif quest.warning == true then -- info text
            ins(pal.bright_red)
            ins '0'
            ins '⚠️'
            ins(quest.title)
        elseif quest.type == 'text' then
            ins(pal.bright_aqua)
            ins '0'
            ins '≡'
            ins(quest.title)
        end
    end
    ---@diagnostic disable-next-line: cast-local-type
    quest_list = table.concat(quest_list, ',')

    local table_style = sbz_api.get_font_style(sbz_api.ui.get_player_and_theme_and_config())
    if table_style ~= '' then table_style = ('style_type[table%s]'):format(table_style) end

    local formspec = ([[
        formspec_version[7]
        size[17.25,12.8]
        padding[0.01,0.01]
        %s
        tablecolumns[color;tree,width=0.5;text;text]
        %s
        %s
        table[0.2,0.7;5.6,11.3;quest_list;%s;%s]
        field_close_on_enter[search;false]
        %s
        image_button[5.25,12;0.5,0.5;ui_search_icon.png;dummybutton;]
        image_button[5.75,12;0.5,0.5;ui_reset_icon.png;search_reset;]

		button[5.25,0.35;0.3,0.3;font_add;+]
		button[5.55,0.35;0.3,0.3;font_sub;-]
		tooltip[font_add;Makes font larger]
		tooltip[font_sub;Makes font smaller]
]]):format(
        sbz_api.ui.hypertext(0.3, 0.25, 5.6, 0.5, '', 'Wiki Entries'),
        sbz_api.ui.box_shadow(0.2, 0.7, 5.6, 11.3, 2),
        table_style,
        quest_list,
        selected_quest_index,
        sbz_api.ui.field(0.2, 12, 5.25, 0.5, 'search', '', search_text)
    )
    formspec = formspec .. sbz_api.ui.box(5.85, 0.2, 11.2, 11.8)

    local font_size = player_ref:get_meta():get_int 'font_size'
    if font_size == 0 then font_size = 16 end -- the default font size according to some undocumented C++ luanti code
    -- thanks luanti

    --- so, this is something like hypertext[blabla;%s]
    --- where the %s gets filled in later, so dont worry about it
    local hypertext = ([[
    %s
    %s
    label[7.35,12.25;%s]
    ]]):format(
        sbz_api.ui.big_hypertext(6, 0.3, 100, 100, '', '%s'),
        sbz_api.ui.hypertext(
            6.1,
            1.3,
            10.8,
            10.3,
            '',
            ('<global size=%s><tag name=dash color=%s>%%s'):format(font_size, pal.bright_orange)
        ),
        '%s'
    )

    if selected_quest then
        if selected_quest.type == 'text' then
            formspec = formspec
                .. hypertext:format(
                    ('<style color=%s>'):format(pal.bright_aqua or '#9ab7fc') .. selected_quest.title .. '</style>',
                    (
                        minetest.formspec_escape(selected_quest.text)
                    ),
                    ''
                )
        end
    end

    -- play page sound lol
    minetest.sound_play('questbook', {
        to_player = player_name,
        gain = 1,
    })
    sbz_api.ui.del_player()
    return formspec
end

-- Handle form submissions
minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname == 'wiki:main' then
        local name = player:get_player_name()
        local meta = player:get_meta()
        local force_query = false
        if fields.search_reset then
            fields.search = ''
            force_query = true
        end

        if fields.font_add or fields.font_sub then
            local font_size = player:get_meta():get_int 'font_size'
            if font_size == 0 then font_size = 16 end

            if fields.font_add then
                font_size = font_size + 1
            else
                font_size = font_size - 1
            end
            font_size = sbz_api.clamp(font_size, 6, 24)
            player:get_meta():set_int('font_size', font_size)
        end

        if fields.quest_list or fields.search or force_query or (fields.font_add or fields.font_sub) then
            local event = minetest.explode_table_event(fields.quest_list)

            local selected_quest_index
            if event.row and event.row ~= 0 or (fields.search and fields.search ~= '') then
                selected_quest_index = event.row or 0
            else
                selected_quest_index = meta:get_int 'selected_quest_index'
            end
            meta:set_int('selected_quest_index', selected_quest_index)

            local filtered_quests = {}
            if fields.search and fields.search ~= '' then
                if fields.search == 'reachable' then -- When re-working this, don't forget to update the questbook, it's in the introduction questline, last infopage
                    for k, v in pairs(sbo_api.quests) do
                        if
                            is_quest_available(name, v.title)
                            and v.type == 'quest'
                            and is_achievement_unlocked(name, v.title) == false
                        then
                            filtered_quests[#filtered_quests + 1] = v
                        end
                    end
                else
                    local real_search = fields.search:lower()
                    local quests_with_holes = table.copy(sbo_api.quests)
                    for k, v in pairs(quests_with_holes) do
                        local title = v.title:lower()
                        if not title:find(real_search, 1, true) then quests_with_holes[k] = nil end
                    end
                    for i = 1, #sbo_api.quests do
                        if quests_with_holes[i] then filtered_quests[#filtered_quests + 1] = quests_with_holes[i] end
                    end
                end
            else
                filtered_quests = table.copy(sbo_api.quests)
            end
            core.show_formspec(
                name,
                'wiki:main',
                get_wiki_formspec(selected_quest_index, player:get_player_name(), filtered_quests, fields.search)
            )
        end
    end
end)

minetest.register_craftitem('sbo_core:wiki', {
    description = 'Wiki',
    inventory_image = 'wiki.png',
    stack_max = 1,
    on_use = function(itemstack, player, pointed_thing)
        local selected_quest_index = 1
        local meta = player:get_meta()
        if meta then selected_quest_index = meta:get_int 'selected_quest_index' end
        if selected_quest_index == 0 then selected_quest_index = 1 end

        minetest.show_formspec(
            player:get_player_name(),
            'wiki:main',
            get_wiki_formspec(selected_quest_index, player:get_player_name(), sbo_api.quests)
        )
    end,
})
