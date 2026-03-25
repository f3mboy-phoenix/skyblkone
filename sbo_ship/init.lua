local struct = {
	offset = {
		x = 11,
		y = 4,
		z = 3,
	},
	map = {}
}
local x,y,z
for x = 1,11 do
	struct.map[x]={}
	for y = 1,4 do
		struct.map[x][y]={}
		for z = 1, 3 do
			--struct.map[x][y][z] = "air"
		end
	end
end

for x = 3, 10 do
	for z= 1, 3 do
		struct.map[x][1][z]="sbz_resources:matter_blob"
	end
end
for x = 4, 10 do
	for y = 2, 3 do
		struct.map[x][y][1]="sbz_resources:matter_blob"
		struct.map[x][y][3]="sbz_resources:matter_blob"
	end
end
for x = 4, 10 do
	struct.map[x][4][2]="sbz_resources:reinforced_matter"
end
struct.map[10][2][2]="sbz_resources:matter_blob"
struct.map[10][3][2]="sbz_resources:matter_blob"
struct.map[11][1][1]="sbz_resources:compressed_core_dust"
struct.map[11][1][3]="sbz_resources:compressed_core_dust"
struct.map[11][3][1]="sbz_resources:compressed_core_dust"
struct.map[11][3][3]="sbz_resources:compressed_core_dust"
struct.map[6][3][1]="sbz_resources:emittrium_glass"
struct.map[6][3][3]="sbz_resources:emittrium_glass"
struct.map[9][3][1]="sbz_resources:emittrium_glass"
struct.map[9][3][3]="sbz_resources:emittrium_glass"
struct.map[4][2][2]="sbo_nexus:storage"
struct.map[3][2][3]="sbz_resources:matter_blob"
struct.map[3][2][1]="sbz_resources:matter_blob"
struct.map[3][2][2]="sbz_meteorites:neutronium"
struct.map[3][3][2]="sbz_resources:reinforced_antimatter"
struct.map[2][2][2]="sbz_resources:matter_blob"
struct.map[2][1][2]="sbz_resources:matter_blob"
struct.map[1][1][2]="sbz_resources:reinforced_matter"
sbo_api.register_structure(struct)

sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "Ship",
    text =
        [[Adds a ship structure floating in the void]],
})
