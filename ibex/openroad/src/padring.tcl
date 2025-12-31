# Copyright (c) 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#


make_io_sites -horizontal_site sg13g2_ioSite \
    -vertical_site sg13g2_ioSite \
    -corner_site sg13g2_ioSite \
    -offset 0 \
    -rotation_horizontal R0 \
    -rotation_vertical R0 \
    -rotation_corner R0

set padD    180; # pad depth (edge to core)
set padW     80; # pad width (beachfront)

set chipH  1960; # left/right (height)
set chipW  1960; # top/bottom (width)

#Edge: LEFT (top to bottom)
# Clock, Reset, Control signals, Instruction memory interface
set numPads 16
set offset 20
set pitch [expr {floor( ($chipH - 2*$padD -2*$offset - $padW)/($numPads-1) )}]
puts "IO_WEST_pitch: $pitch "
set start [expr $chipH - $padD - $offset - $padW]
place_pad -row IO_WEST -location [expr $start -  0*$pitch] -master "sg13g2_IOPadIOVss"   "pad_vssio0"
place_pad -row IO_WEST -location [expr $start -  1*$pitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio0"
place_pad -row IO_WEST -location [expr $start -  2*$pitch] -master "sg13g2_IOPadIn"      "pad_clk_inst"
place_pad -row IO_WEST -location [expr $start -  3*$pitch] -master "sg13g2_IOPadIn"      "pad_rst_ni_inst"
place_pad -row IO_WEST -location [expr $start -  4*$pitch] -master "sg13g2_IOPadIn"      "pad_scan_rst_ni_inst"
place_pad -row IO_WEST -location [expr $start -  5*$pitch] -master "sg13g2_IOPadIn"      "pad_test_en_i_inst"
place_pad -row IO_WEST -location [expr $start -  6*$pitch] -master "sg13g2_IOPadIn"      "pad_debug_req_i_inst"
place_pad -row IO_WEST -location [expr $start -  7*$pitch] -master "sg13g2_IOPadIn"      "pad_fetch_enable_i_0_inst"
place_pad -row IO_WEST -location [expr $start -  8*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_req_o_inst"
place_pad -row IO_WEST -location [expr $start -  9*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_gnt_i_inst"
place_pad -row IO_WEST -location [expr $start - 10*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rvalid_i_inst"
place_pad -row IO_WEST -location [expr $start - 11*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_err_i_inst"
place_pad -row IO_WEST -location [expr $start - 12*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_core_sleep_o_inst"
place_pad -row IO_WEST -location [expr $start - 13*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_alert_minor_o_inst"
place_pad -row IO_WEST -location [expr $start - 14*$pitch] -master "sg13g2_IOPadVss"     "pad_vss0"
place_pad -row IO_WEST -location [expr $start - 15*$pitch] -master "sg13g2_IOPadVdd"     "pad_vdd0"


#Edge: BOTTOM (left to right)
# Instruction address and data bus (low bits)
set numPads 16
set offset 20
set pitch [expr {floor( ($chipW - 2*$padD -2*$offset - $padW)/($numPads-1) )}]
puts "IO_SOUTH_pitch: $pitch "
set start [expr $padD + $offset]
place_pad -row IO_SOUTH -location [expr $start +  0*$pitch] -master "sg13g2_IOPadIOVss"   "pad_vssio1"
place_pad -row IO_SOUTH -location [expr $start +  1*$pitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio1"
place_pad -row IO_SOUTH -location [expr $start +  2*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_0_inst"
place_pad -row IO_SOUTH -location [expr $start +  3*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_1_inst"
place_pad -row IO_SOUTH -location [expr $start +  4*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_2_inst"
place_pad -row IO_SOUTH -location [expr $start +  5*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_3_inst"
place_pad -row IO_SOUTH -location [expr $start +  6*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_4_inst"
place_pad -row IO_SOUTH -location [expr $start +  7*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_instr_addr_o_5_inst"
place_pad -row IO_SOUTH -location [expr $start +  8*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_0_inst"
place_pad -row IO_SOUTH -location [expr $start +  9*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_1_inst"
place_pad -row IO_SOUTH -location [expr $start + 10*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_2_inst"
place_pad -row IO_SOUTH -location [expr $start + 11*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_3_inst"
place_pad -row IO_SOUTH -location [expr $start + 12*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_4_inst"
place_pad -row IO_SOUTH -location [expr $start + 13*$pitch] -master "sg13g2_IOPadIn"      "pad_instr_rdata_i_5_inst"
place_pad -row IO_SOUTH -location [expr $start + 14*$pitch] -master "sg13g2_IOPadVss"     "pad_vss1"
place_pad -row IO_SOUTH -location [expr $start + 15*$pitch] -master "sg13g2_IOPadVdd"     "pad_vdd1"


#Edge: RIGHT (bottom to top)
# Data memory interface control + low address bits
set numPads 16
set offset 20
set pitch [expr {floor( ($chipH - 2*$padD -2*$offset - $padW)/($numPads-1) )}]
puts "IO_EAST_pitch: $pitch "
set start [expr $padD + $offset]
place_pad -row IO_EAST -location [expr $start +  0*$pitch] -master "sg13g2_IOPadIOVss"   "pad_vssio2"
place_pad -row IO_EAST -location [expr $start +  1*$pitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio2"
place_pad -row IO_EAST -location [expr $start +  2*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_req_o_inst"
place_pad -row IO_EAST -location [expr $start +  3*$pitch] -master "sg13g2_IOPadIn"      "pad_data_gnt_i_inst"
place_pad -row IO_EAST -location [expr $start +  4*$pitch] -master "sg13g2_IOPadIn"      "pad_data_rvalid_i_inst"
place_pad -row IO_EAST -location [expr $start +  5*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_we_o_inst"
place_pad -row IO_EAST -location [expr $start +  6*$pitch] -master "sg13g2_IOPadIn"      "pad_data_err_i_inst"
place_pad -row IO_EAST -location [expr $start +  7*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_0_inst"
place_pad -row IO_EAST -location [expr $start +  8*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_1_inst"
place_pad -row IO_EAST -location [expr $start +  9*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_2_inst"
place_pad -row IO_EAST -location [expr $start + 10*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_3_inst"
place_pad -row IO_EAST -location [expr $start + 11*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_4_inst"
place_pad -row IO_EAST -location [expr $start + 12*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_5_inst"
place_pad -row IO_EAST -location [expr $start + 13*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_addr_o_6_inst"
place_pad -row IO_EAST -location [expr $start + 14*$pitch] -master "sg13g2_IOPadVss"     "pad_vss2"
place_pad -row IO_EAST -location [expr $start + 15*$pitch] -master "sg13g2_IOPadVdd"     "pad_vdd2"


#Edge: TOP (right to left)
# Data read/write data (low bits) + interrupts
set numPads 16
set offset 20
set pitch [expr {floor( ($chipW - 2*$padD -2*$offset - $padW)/($numPads-1) )}]
puts "IO_NORTH_pitch: $pitch "
set start [expr $chipW - $padD - $padW -$offset]
place_pad -row IO_NORTH -location [expr $start -  0*$pitch] -master "sg13g2_IOPadIOVss"   "pad_vssio3"
place_pad -row IO_NORTH -location [expr $start -  1*$pitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio3"
place_pad -row IO_NORTH -location [expr $start -  2*$pitch] -master "sg13g2_IOPadIn"      "pad_data_rdata_i_0_inst"
place_pad -row IO_NORTH -location [expr $start -  3*$pitch] -master "sg13g2_IOPadIn"      "pad_data_rdata_i_1_inst"
place_pad -row IO_NORTH -location [expr $start -  4*$pitch] -master "sg13g2_IOPadIn"      "pad_data_rdata_i_2_inst"
place_pad -row IO_NORTH -location [expr $start -  5*$pitch] -master "sg13g2_IOPadIn"      "pad_data_rdata_i_3_inst"
place_pad -row IO_NORTH -location [expr $start -  6*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_wdata_o_0_inst"
place_pad -row IO_NORTH -location [expr $start -  7*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_wdata_o_1_inst"
place_pad -row IO_NORTH -location [expr $start -  8*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_wdata_o_2_inst"
place_pad -row IO_NORTH -location [expr $start -  9*$pitch] -master "sg13g2_IOPadOut4mA"  "pad_data_wdata_o_3_inst"
place_pad -row IO_NORTH -location [expr $start - 10*$pitch] -master "sg13g2_IOPadIn"      "pad_irq_software_i_inst"
place_pad -row IO_NORTH -location [expr $start - 11*$pitch] -master "sg13g2_IOPadIn"      "pad_irq_timer_i_inst"
place_pad -row IO_NORTH -location [expr $start - 12*$pitch] -master "sg13g2_IOPadIn"      "pad_irq_external_i_inst"
place_pad -row IO_NORTH -location [expr $start - 13*$pitch] -master "sg13g2_IOPadIn"      "pad_irq_nm_i_inst"
place_pad -row IO_NORTH -location [expr $start - 14*$pitch] -master "sg13g2_IOPadVss"     "pad_vss3"
place_pad -row IO_NORTH -location [expr $start - 15*$pitch] -master "sg13g2_IOPadVdd"     "pad_vdd3"

place_corners $iocorner

place_io_fill -row IO_NORTH {*}$iofill
place_io_fill -row IO_SOUTH {*}$iofill
place_io_fill -row IO_WEST  {*}$iofill
place_io_fill -row IO_EAST  {*}$iofill

# Connect built-in rings
connect_by_abutment

# Bondpad as separate cell placed in OpenROAD:
# place the bonding pad relative to the IO cell
place_bondpad -bond bondpad_70x70 -offset {5.0 -70.0} pad_*

# remove rows created by via make_io_sites as they are no longer needed
remove_io_rows

puts "Floorplan completed for ibex core"
