# Backend constraints for fir_chip
# Target: 25 MHz (40 ns period)
# Ports: clk, rst, in[3:0], out[31:0]

############
## Global ##
############

#############################
## Driving Cells and Loads ##
#############################
# Model external drive/load for chip I/O pins
# Drive inputs as if coming from an I/O pad
set_driving_cell [all_inputs] -lib_cell sg13g2_IOPadOut16mA -pin pad
# Load outputs as if driving a modest external trace and load
set_load [expr 2 * 5.0 + 5.0] [all_outputs]

##################
## Input Clocks ##
##################
puts "Defining Clocks..."

set TCK_SYS 10 ;# 10 ns period = 100 MHz
create_clock -name clk_sys -period $TCK_SYS [get_ports clk]

##################################
## Clock Groups & Uncertainties ##
##################################
set_clock_uncertainty 0.1 [all_clocks]
set_clock_transition  0.2 [all_clocks]

#############
## Inputs  ##
#############
puts "Constraining Inputs/Outputs..."

# ---- Primary Asynchronous Reset ----
# Treat the active-high 'rst' as a false timing path
set_false_path -from [get_ports rst]

# ---- Data Input Bus (in[3:0]) ----
# Apply realistic input delays.
# Assumption: External signal is valid 30% into the cycle and stable for 10%.
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports in_*]
set_input_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports in_*]

#############
## Outputs ##
#############

# ---- Data Output Bus (out[31:0]) ----
# Apply realistic output delays.
# Assumption: External logic needs data 20% before the next clock edge.
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.20] [get_ports out_*]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.05] [get_ports out_*]

#####################################
## INTERNAL TIMING EXCEPTIONS      ##
#####################################
puts "Defining internal timing exceptions..."

# ---- Multi-Cycle Paths (if any) ----
# If your FIR filter logic has a known pipeline latency (e.g., 5 cycles),
# you must define it here to avoid false timing violations.
# Example for a 5-cycle path from input to output registers:
# set_multicycle_path 5 -setup -from [get_cells *input_reg*] -to [get_cells *output_reg*]
# set_multicycle_path 4 -hold  -from [get_cells *input_reg*] -to [get_cells *output_reg*]

###########################
## Design Rules          ##
###########################
# These limits help the tool prevent electrical violations during optimization[citation:1].
set_max_transition 1.0 [current_design] ;# Max slew rate (ns)
set_max_fanout 20 [current_design]      ;# Max fanout for a net
set_max_capacitance 0.5 [current_design] ;# Max load capacitance (pF)

puts "Constraints loaded for fir_chip design"
