# Copyright 2024 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Authors:
# - Philippe Sauter <phsauter@iis.ee.ethz.ch>

# Instance paths for bare ibex_top (no SoC wrapper)
# Used for constraints and macro placement

############################################
# Core Instance Paths
############################################

# Top level is just ibex_top, no wrapper hierarchy
set IBEX ""

# Check if there are any SRAM macros in the design
set srams [get_cells -quiet *RM_IHP* -filter "is_hierarchical==true"]
set macros [list]

if {[llength $srams] > 0} {
    puts "Found [llength $srams] SRAM macros"
    foreach inst $srams {
        lappend macros $inst
        puts "  SRAM: $inst"
    }
} else {
    puts "No SRAM macros found in design"
}

############################################
# CDC Paths (if they exist)
############################################

# Since bare ibex_top has no JTAG wrapper, these paths don't exist
# Leaving them undefined - constraints will skip them if they don't exist
# set JTAG_ASYNC_REQ [get_nets -quiet $JTAG/i_dmi_cdc.i_cdc_req/*async_*]
# set JTAG_ASYNC_RSP [get_nets -quiet $JTAG/i_dmi_cdc.i_cdc_resp/*async_*]

puts "Instance paths loaded for bare ibex_top design"
