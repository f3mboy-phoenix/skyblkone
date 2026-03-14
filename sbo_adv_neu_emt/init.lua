sbz_api.register_stateful_machine("sbo_adv_neu_emt:neutron_emitter", {
    description = "Advanced Neutron Emitter",
    info_extra = "Emits radiation, forces plants mutate.",
    info_power_consume = 10,
    autostate = true,
    tiles = { "adv_neutron_emitter_off.png" },
    action = function(pos, node, meta, supply, demand)
        if supply < demand + 10 then
            meta:set_string("infotext", "Not enough power")
            return 10, false
        else
            meta:set_string("infotext", "On")
            return 10, true
        end
    end,
    groups = {
        matter = 1,
    },
}, {
    light_source = 14,
    tiles = { { name = "adv_neutron_emitter_on.png", animation = { type = "vertical_frames" } } },
    groups = { matter = 1, radioactive = 1 }
})

core.register_craft {
    output = "sbo_adv_neu_emt:neutron_emitter_off",
    recipe = {
        { "sbo_extrosim_circuit:extrosim_circuit", "sbz_bio:pyrograss",           "sbo_extrosim_circuit:extrosim_circuit" },
        { "sbz_bio:pyrograss",                     "sbz_bio:neutron_emitter_off", "sbz_bio:pyrograss" },
        { "sbo_extrosim_circuit:extrosim_circuit", "sbz_bio:pyrograss",           "sbo_extrosim_circuit:extrosim_circuit" },
    }
}

sbo_api.quests.on_craft["sbo_adv_neu_emt:neutron_emitter_off"] = "Advanced Neutron Emitter"
sbo_api.quests.register_to("Questline: Organics",{
    type = "quest",
    title = "Advanced Neutron Emitter",
    text =
        [[Advanced Neutron Emitters radiation has a higher chance of mutation.]],
    requires = { "Neutron Emitter", }
})
