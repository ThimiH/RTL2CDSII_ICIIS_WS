# Power Distribution Network Configuration

# 1. Define Global Connections
set_voltage_domain -name CORE -power {VDD} -ground {VSS}

# 2. Define Standard Cell Grid
# Uses Metal1 for rails (horizontal)
define_pdn_grid -name stdcell_grid -starts_with POWER -voltage_domains {CORE} -pins {stdcell}

add_pdn_stripe -grid stdcell_grid -layer {met1} -width {0.17} -pitch {2.4} -offset {0} -followpins

# 3. Define Macro Grid (Power Rings/Straps)
# Uses Metal4 (vertical) and Metal5 (horizontal) for power mesh
add_pdn_stripe -grid stdcell_grid -layer {met4} -width {0.48} -pitch {50.0} -offset {2.0} -extend_to_core_ring
add_pdn_stripe -grid stdcell_grid -layer {met5} -width {0.48} -pitch {50.0} -offset {2.0} -extend_to_core_ring

# 4. Connect Layers
add_pdn_connect -grid stdcell_grid -layers {met1 met4}
add_pdn_connect -grid stdcell_grid -layers {met4 met5}