# Backend constraints for ibex_wrap - Chip-level wrapper with I/O pads
# Target: 25 MHz (40 ns period)

############
## Global ##
############
# Source instance definitions (if needed for pad placement)
# source src/instances.tcl

#############################
## Driving Cells and Loads ##
#############################
# Your existing pad driving/load settings are appropriate for the chip I/O.
set_load [expr 2 * 5.0 + 5.0] [all_outputs]
set_driving_cell [all_inputs] -lib_cell sg13g2_IOPadOut16mA -pin pad

##################
## Input Clocks ##
##################
puts "Clocks..."
set TCK_SYS 40
# The chip's primary clock input is 'clk', not 'clk_i'
create_clock -name clk_sys -period $TCK_SYS [get_ports clk]

##################################
## Clock Groups & Uncertainties ##
##################################
set_clock_uncertainty 0.1 [all_clocks]
set_clock_transition  0.2 [all_clocks]

#############
## Inputs  ##
#############
puts "Input/Outputs..."

# ---- Asynchronous Reset Signals - treat as false paths ----
# Chip pins: 'rst_n', 'scan_rst_n'
set_false_path -from [get_ports {rst_n scan_rst_n}]

# ---- Other Control Inputs ----
# Apply reasonable input delays for control signals
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports {test_en debug_req}]
set_input_delay -clock clk_sys -min 0.0 [get_ports {test_en debug_req}]

set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports fetch_enable_0]
set_input_delay -clock clk_sys -min 0.0 [get_ports fetch_enable_0]

# ---- Memory Handshake Inputs ----
set bus_input_ports {
    instr_gnt instr_rvalid instr_err
    data_gnt data_rvalid data_err
}
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports $bus_input_ports]
set_input_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports $bus_input_ports]

# ---- Instruction Read Data Bus (6 bits) ----
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports instr_rdata_*]
set_input_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports instr_rdata_*]

# ---- Data Read Bus (4 bits) ----
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports data_rdata_*]
set_input_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports data_rdata_*]

# ---- Interrupt Inputs ----
set_input_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports {irq_software irq_timer irq_external irq_nm}]
set_input_delay -clock clk_sys -min 0.0 [get_ports {irq_software irq_timer irq_external irq_nm}]

#############
## Outputs ##
#############

# ---- Memory Request Outputs ----
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports {instr_req data_req data_we}]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports {instr_req data_req data_we}]

# ---- Instruction Address Bus (6 bits) ----
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports instr_addr_*]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports instr_addr_*]

# ---- Data Address Bus (7 bits) ----
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports data_addr_*]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports data_addr_*]

# ---- Data Write Bus (4 bits) ----
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports data_wdata_*]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports data_wdata_*]

# ---- Status Outputs ----
set_output_delay -clock clk_sys -max [expr $TCK_SYS * 0.30] [get_ports {core_sleep alert_minor}]
set_output_delay -clock clk_sys -min [expr $TCK_SYS * 0.10] [get_ports {core_sleep alert_minor}]

#####################################
## INTERNAL TIMING EXCEPTIONS      ##
#####################################
puts "Defining internal timing exceptions..."

# ---- Multi-Cycle Paths for Multiplier/Divider ----
# UNCOMMENT and MODIFY based on your Ibex configuration
# Example for a 3-cycle multiplier:
# set_multicycle_path 3 -setup -from [get_cells *u_ibex_top/u_multdiv*] -to [get_cells *u_ibex_top/u_multdiv*]
# set_multicycle_path 2 -hold  -from [get_cells *u_ibex_top/u_multdiv*] -to [get_cells *u_ibex_top/u_multdiv*]

# ---- Generated Clocks (if any) ----
# If core_sleep gates a clock externally, define it here
# create_generated_clock -name clk_core_gated -source [get_ports clk] -divide_by 1 [get_pins path/to/clock_gating_cell/CP]

###########################
## Design Rules          ##
###########################
set_max_transition 1.0 [current_design]
set_max_fanout 20 [current_design]
set_max_capacitance 0.5 [current_design]

puts "Constraints loaded for ibex_wrap design"
