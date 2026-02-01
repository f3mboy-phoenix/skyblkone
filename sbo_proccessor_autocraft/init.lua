local list = {
	"sbz_resources:simple_crafting_processor",
	"sbz_resources:quick_crafting_processor",
	"sbz_resources:fast_crafting_processor",
	"sbz_resources:accelerated_silicon_crafting_processor",
	"sbz_resources:nuclear_crafting_processor",
}
for _, name in ipairs(list) do
	core.override_item(name, {
		stack_max = 16,
	})
end
