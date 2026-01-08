# 1. Define the Clock
# Period: 10ns (100 MHz), applied to port 'clk'
create_clock -name clk -period 10 [get_ports clk]

# 2. Input Delays
# Assume inputs arrive 2ns after the previous clock edge (External delay)
set_input_delay -clock clk 2 [get_ports {A B C D start rst_n}]

# 3. Output Delays
# Assume outputs must be stable 2ns before the next clock edge (External setup req)
set_output_delay -clock clk 2 [get_ports {F valid}]