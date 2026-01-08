# 1. Read the Verilog source
read_verilog ../rtl/design6_seq.v

# 2. Elaborate the design hierarchy
hierarchy -check -top design6_seq

# 3. Translate processes to netlists
proc

# 4. Map to internal cell library
techmap

# 5. Map Flip-Flops to the Standard Cell Library
# IMPORTANT: Update path to match student's environment
dfflibmap -liberty ../lib/NangateOpenCellLibrary_typical.lib

# 6. Map Logic to the Standard Cell Library
abc -liberty ../lib/NangateOpenCellLibrary_typical.lib

# 7. Remove unused cells and wires
clean

# 8. Write the generated Netlist
write_verilog -noattr design6_netlist.v