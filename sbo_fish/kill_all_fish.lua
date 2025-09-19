for _, obj in ipairs(minetest.get_objects_inside_radius({x=0,y=0,z=0},100000)) do
 local ent=obj:get_luaentity()
 if ent and ent.name== "sbo_fish:mob" then
  obj:remove()
 end
end
