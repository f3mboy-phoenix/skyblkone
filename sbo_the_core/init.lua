

sbz_api.recipe.register_craft {
    output = 'sbz_resources:the_core',
    items = { 'sbo_atomic:nitrogen 35', 'sbo_atomic:fluorine 47', "sbo_atomic:phosphorus 56", "sbo_atomic:sulfur 24" },
    type = 'atomic',
}
sbo_api.quests.register_to("SBO: Other infos",{
    type = "text",
    info = true,
    title = "The Core",
    text = [[Create a Core Block with the Atomic Reconstructor]],
})
