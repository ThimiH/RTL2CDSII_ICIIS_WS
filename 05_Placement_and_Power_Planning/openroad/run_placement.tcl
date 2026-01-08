# 1. Read Technology and Libraries
# LEF files define the physical layers and cell dimensions
read_lef ../lib/NangateOpenCellLibrary.tech.lef
read_lef ../lib/NangateOpenCellLibrary.macro.lef
read_liberty ../lib/NangateOpenCellLibrary_typical.lib

# 2. Read the Design
# Read the netlist generated in Chapter 3
read_verilog ../synth/design6_netlist.v
link_design design6_seq

# 3. Read Constraints
read_sdc ../sdc/design6.sdc

# 4. Floorplanning
# Initialize floorplan: utilization 30%, aspect ratio 1.0, core margins 5um
# (Relaxed density for easier placement in a workshop)
initialize_floorplan -utilization 30 -aspect_ratio 1.0 -core_space 5.0 -site FreePDK45_38x28_10R_NP_162NW_34O

# 5. Place IO Pins
# Places input/output pins on the boundary randomly or optimally
place_pins -random

# 6. Tap Cell Insertion
# Inserts well taps to prevent latch-up
tapcell -distance 120 -tapcell_master TAP_X1

# 7. Power Distribution Network (PDN)
# Generates the VDD/VSS grid based on the config file
pdngen pdn_config.pdn

# 8. Global Placement
# Rough placement of cells (routability driven)
global_placement -density 0.4

# 9. Detailed Placement
# Legalizes the placement (snaps to grid, removes overlaps)
detailed_placement

# 10. Final Reports and Export
report_checks -path_delay max -format full
write_def design6_placed.def