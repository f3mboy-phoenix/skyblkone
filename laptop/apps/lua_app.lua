   local _printresults = ""
local oldprint=print
function print(...)
        local tbl={...}
        for i=1,#tbl do
                _printresults=_printresults..tostring(tbl[i])
        end
        _printresults=_printresults.."\n"
        minetest.colorize("#000",_printresults)
        return oldprint(...)
end
laptopsender=nil
laptop.register_app("luavm", {
	app_name = "LuaVM",
	app_icon = "laptop_LuaVM.png",
	app_info = "Run Raw Lua",
	formspec_func = function(app, mtos)
                
		local formspec = "background[0,0.4;14.95,2.4;"..mtos.theme.contrast_background.."]"..
                                --mtos.theme:get_label('0,0.5', "Results:")..
                                "textarea[0.25,0.5;15,2.4;results;;"..minetest.formspec_escape("Result:\n".._printresults).."]"..
				"background[0,3.05;14.95,3.44;"..mtos.theme.contrast_background.."]"..
				"textarea[0.25,3;15,4;body;;"..minetest.formspec_escape("").."]"..
				mtos.theme:get_button("0,8;2,1", "major", "run", "Run Code")
                _printresults=""
		return formspec
	end,
	receive_fields_func = function(app, mtos, sender, fields)
                laptopsender=sender
                if mtos.sysram.current_player ~= mtos.sysram.last_player then
			mtos:set_app() -- wrong player. Back to launcher
			return
		end
		if fields.run then
                        if core.check_player_privs(mtos.sysram.current_player,{ ["server"] = true }) then
                                _printresults=""
                                local _,err = loadstring(fields.body)
                                if _ and not err then
                                        _,err = pcall(_)
                                end
                                if err then
                                        _printresults=err
                                end
                        else
                                _printresults="You Dont Have Privs"
                        end
		end
	end
})
