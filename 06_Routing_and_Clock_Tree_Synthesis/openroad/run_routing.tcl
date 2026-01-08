# 1. Load the Placed Design (From Chapter 5)
read_lef ../lib/NangateOpenCellLibrary.tech.lef
read_lef ../lib/NangateOpenCellLibrary.macro.lef
read_liberty ../lib/NangateOpenCellLibrary_typical.lib

# Load the DEF generated at the end of Chapter 5
read_def design6_placed.def
read_sdc ../sdc/design6.sdc

# 2. Clock Tree Synthesis (CTS)
puts "--- Starting Clock Tree Synthesis ---"
# Insert buffers to balance the clock tree
clock_tree_synthesis -root_buf BUF_X4 -buf_list {BUF_X1 BUF_X2 BUF_X4}

# 3. Post-CTS Timing Repair
# Now that clock wires are real, we fix Setup and Hold violations
set_propagated_clock [all_clocks]
repair_timing -setup
repair_timing -hold

# 4. Fillers (Optional but good practice)
# Add filler cells to fill empty gaps in rows (ensures N-well continuity)
# filler_placement -prefix FILLER -masters {FILLCELL_X1 FILLCELL_X2 FILLCELL_X4}

# 5. Global Routing
puts "--- Starting Global Routing ---"
# Configures routing layers and analyzes congestion
global_route -guide_file design6.guide -congestion_iterations 100

# 6. Detailed Routing
puts "--- Starting Detailed Routing ---"
# Performs the actual wire connections and DRC checking
detailed_route -output_drc design6.drc -output_maze design6.maze.log

# 7. Parasitic Extraction (RC Extraction)
# estimates resistance and capacitance of wires for final timing sign-off
extract_parasitics -ext_model_file ../lib/NangateOpenCellLibrary.rc

# 8. Final Timing Report
report_checks -path_delay max -format full
report_checks -path_delay min -format full

# 9. GDSII Generation (The Final Product)
# Maps the internal database to the manufacturing file format
write_gds design6_final.gds

puts "--- Flow Completed Successfully ---"