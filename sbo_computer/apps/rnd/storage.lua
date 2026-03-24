--[[
Research N' Duplication
Copyright (C) 2020 Noodlemire

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
--]]

--file-specific global storage
rnd.storage = {}

--Grab rnd's mod-private storage
local store = minetest.get_mod_storage()

--A set function that automatically takes any kind of storable value
function rnd.storage.put(key, val)
	local t = type(val)

	if t == "string" then
		store:set_string(key, val)
	elseif t == "number" then
		store:set_float(key, val)
	elseif val == true then
		store:set_int(key, 1)
	elseif not val then
		--Setting a value to "" will delete it.
		store:set_string(key, "")
	else
		minetest.log("error", "Attempt to put val of type "..t.." into key "..key)
	end
end

--Normally, get_string returns "" when there's no value. I find nil easier to check.
function rnd.storage.getStr(key)
	if not store:contains(key) then return nil end

	return store:get_string(key)
end

--Normally, get_float returns 0 when there's no value. I find nil easier to check.
--Also, "Num" is easier to remember, because the type() for numeral values in Lua is "number", rather than "float"
function rnd.storage.getNum(key)
	if not store:contains(key) then return nil end

	return store:get_float(key)
end

--Essentially only exists because it's memorable, alongside the rest of the "getType" functions
function rnd.storage.getBool(key)
	return store:contains(key)
end

--A value that isn't given at all counts as "not val" in the if statements of put(), which is why this works.
function rnd.storage.del(key)
	rnd.storage.put(key)
end
