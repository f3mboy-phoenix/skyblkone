
sbz_api.recipe.register_craft {
    output = 'sbz_chem:water_fluid_cell',
    items = { 'sbo_atomic:hydrogen 2', 'sbo_atomic:oxygen', "sbz_chem:empty_fluid_cell" },
    type = 'atomic',
}
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "H2O",
    text = [[Create a Water Fluid Cell with the Atomic Reconstructor]],
})
