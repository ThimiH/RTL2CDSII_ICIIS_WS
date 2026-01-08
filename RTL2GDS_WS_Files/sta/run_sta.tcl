# 1. Read the Standard Cell Library
# IMPORTANT: Update path to match student's environment
read_liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib

# 2. Read the Synthesized Netlist (Generated in Chapter 3)
read_verilog ../synth/design6_netlist.v

# 3. Link the Design
# Must match the top module name in Verilog
link_design design6_seq

# 4. Read Constraints
read_sdc design6.sdc

# 5. Report Checks

puts "\n--- SETUP CHECK (Max Delay) ---"
# Checks if signal arrives fast enough (Frequency check)
report_checks -path_delay max -format full

puts "\n--- HOLD CHECK (Min Delay) ---"
# Checks if signal stays stable long enough (Race condition check)
report_checks -path_delay min -format full

# 6. Exit
exit