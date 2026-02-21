unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:simple_circuit 4",
    items = {
        "sbz_resources:core_dust",
        "sbz_resources:matter_blob",
    },
    width = 2,
    height = 1
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:retaining_circuit 2",
    items = {
        "sbz_resources:core_dust",
        "sbz_resources:simple_circuit",
        "sbz_resources:antimatter_dust",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:emittrium_circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:matter_plate",
        "sbz_resources:raw_emittrium",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:phlogiston_circuit 8",
    items = {
        "sbz_resources:emittrium_circuit 4",
        "sbz_resources:phlogiston 1",
        "sbz_resources:antimatter_blob",
        "sbz_resources:matter_blob",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbz_resources:prediction_circuit 4",
    items = {
        "sbz_resources:emittrium_circuit 2",
        "sbz_chem:titanium_alloy_ingot",
        "sbz_resources:raw_emittrium 2",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_extrosim_circuit:extrosim_circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:antimatter_plate",
        "sbo_extrosim:raw_extrosim",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})
unified_inventory.register_craft({
    type = "ele_fab",
    output = "sbo_resium:circuit 4",
    items = {
        "sbz_resources:retaining_circuit",
        "sbz_resources:antimatter_plate",
        "sbo_resium:crystal",
        "sbz_resources:charged_particle",
    },
    width = 2,
    height = 2
})

