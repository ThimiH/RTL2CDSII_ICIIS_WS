# 1. Read Technology and Libraries
# LEF files define the physical layers and cell dimensions
read_lef ../lib/sky130_v5_5.lef
read_lef ../lib/output.lef
read_liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# 2. Read the Design
# Read the netlist generated in Chapter 3
read_verilog ../synth/design6_netlist.v
link_design design6_seq

# 3. Read Constraints
read_sdc ../sta/design6.sdc

# 4. Floorplanning
# Initialize floorplan: utilization 30%, aspect ratio 1.0, core margins 5um
# (Relaxed density for easier placement in a workshop)
initialize_floorplan -utilization 30 -aspect_ratio 1.0 -core_space 5.0 -site unithd

# 5. Place IO Pins
# Places input/output pins on the boundary randomly or optimally
place_pins -random

# 6. Tap Cell Insertion
# Inserts well taps to prevent latch-up
tapcell -distance 20 -tapcell_master sky130_fd_sc_hd__tapvpwrvgnd_1 -endcap_master sky130_fd_sc_hd__decap_3

# 7. Power Distribution Network (PDN)
# Generates the VDD/VSS grid based on the config file
pdngen pdn_config.tcl

# 8. Global Placement
# Rough placement of cells (routability driven)
global_placement -density 0.4

# 9. Detailed Placement
# Legalizes the placement (snaps to grid, removes overlaps)
detailed_placement

# 10. Final Reports and Export
report_checks -path_delay max -format full
write_def design6_placed.def