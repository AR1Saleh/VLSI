# Copyright 2023 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Power planning for bare ibex_top (no SRAMs)

utl::report "Power Grid"

source scripts/floorplan_util.tcl

##########################################################################
# Reset
##########################################################################

if {[info exists power_grid_defined]} {
    pdngen -ripup
    pdngen -reset
} else {
    set power_grid_defined 1
}

# === Variant Configuration ===
if { ![info exists variant_name] } { set variant_name "default" }
if { ![info exists stripe_width] } { set stripe_width 6 }
if { ![info exists stripe_pitch] } { set stripe_pitch 204 }
if { ![info exists add_ring] } { set add_ring 1 }
if { ![info exists add_vertical] } { set add_vertical 1 }
if { ![info exists core_ring_width] } { set core_ring_width 10 }

##########################################################################
##  Power settings
##########################################################################
# Core Power Ring
set PowRingSpace  35
set pgcrSpacing 6
set pgcrWidth $core_ring_width
set pgcrOffset [expr ($PowRingSpace - $pgcrSpacing - 2 * $pgcrWidth) / 2]

# TopMetal2 Core Power Grid
set tpg2Width    $stripe_width
set tpg2Pitch    $stripe_pitch
set tpg2Spacing  60
set tpg2Offset   97

##########################################################################
##  Define Core Power Grid
##########################################################################

# First, define the voltage domain
set_voltage_domain -name {CORE} -power {VDD} -ground {VSS}

# Then define the core grid
define_pdn_grid -name {core_grid} -voltage_domains {CORE}

##########################################################################
##  Core Power Distribution
##########################################################################

# Add power ring around core
if { $add_ring } {
    add_pdn_ring -grid {core_grid} \
        -layer        {TopMetal1 TopMetal2} \
        -widths       "$pgcrWidth $pgcrWidth" \
        -spacings     "$pgcrSpacing $pgcrSpacing" \
        -pad_offsets  "6 6" \
        -add_connect \
        -connect_to_pads \
        -connect_to_pad_layers TopMetal2
}

# M1 Standard cell power rails (horizontal tracks following cell rows)
add_pdn_stripe -grid {core_grid} -layer {Metal1} -width {0.44} -offset {0} \
               -followpins -extend_to_core_ring

# TopMetal2 vertical power stripes
if { $add_vertical } {
    add_pdn_stripe -grid {core_grid} -layer {TopMetal2} -width $tpg2Width \
                   -pitch $tpg2Pitch -spacing $tpg2Spacing -offset $tpg2Offset \
                   -extend_to_core_ring -snap_to_grid -number_of_straps 7
}

##########################################################################
##  Power Grid Connections (vias between layers)
##########################################################################

# Connect TopMetal2 vertical stripes to lower metal layers
add_pdn_connect -grid {core_grid} -layers {TopMetal2 Metal1}
add_pdn_connect -grid {core_grid} -layers {TopMetal2 Metal2}
add_pdn_connect -grid {core_grid} -layers {TopMetal2 Metal4}

# Connect power ring to standard cell rails
add_pdn_connect -grid {core_grid} -layers {TopMetal1 Metal1}
add_pdn_connect -grid {core_grid} -layers {TopMetal1 Metal2}

##########################################################################
##  Generate PDN
##########################################################################
pdngen -failed_via_report ${report_dir}/${log_id_str}_${proj_name}_pdngen.rpt

utl::report "Power grid generation completed for bare ibex_top"
