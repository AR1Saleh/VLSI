make_io_sites -horizontal_site sg13g2_ioSite \
    -vertical_site sg13g2_ioSite \
    -corner_site sg13g2_ioSite \
    -offset 0 \
    -rotation_horizontal R0 \
    -rotation_vertical R0 \
    -rotation_corner R0

# Define chip and pad dimensions
set padD    180; # Pad depth (from edge to core)
set padW     80; # Pad width
set chipH  1760; # Chip height
set chipW  1760; # Chip width

# --- LEFT SIDE (12 pads: 2 power + 2 inputs + 8 outputs) ---
set numLeftPads 12
set leftOffset 20
set leftPitch [expr {floor( ($chipH - 2*$padD - 2*$leftOffset - $padW) / ($numLeftPads-1) )}]
set leftStart [expr $chipH - $padD - $leftOffset - $padW]

puts "IO_LEFT pitch: $leftPitch µm"

place_pad -row IO_WEST -location [expr $leftStart -  0*$leftPitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio0"
place_pad -row IO_WEST -location [expr $leftStart -  1*$leftPitch] -master "sg13g2_IOPadIOVss"   "pad_vssio0"
place_pad -row IO_WEST -location [expr $leftStart -  2*$leftPitch] -master "sg13g2_IOPadIn"      "pad_clk"
place_pad -row IO_WEST -location [expr $leftStart -  3*$leftPitch] -master "sg13g2_IOPadIn"      "pad_rst"
place_pad -row IO_WEST -location [expr $leftStart -  4*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out0"
place_pad -row IO_WEST -location [expr $leftStart -  5*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out1"
place_pad -row IO_WEST -location [expr $leftStart -  6*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out2"
place_pad -row IO_WEST -location [expr $leftStart -  7*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out3"
place_pad -row IO_WEST -location [expr $leftStart -  8*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out4"
place_pad -row IO_WEST -location [expr $leftStart -  9*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out5"
place_pad -row IO_WEST -location [expr $leftStart - 10*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out6"
place_pad -row IO_WEST -location [expr $leftStart - 11*$leftPitch] -master "sg13g2_IOPadOut16mA" "pad_out7"

# --- BOTTOM SIDE (12 pads: 2 power + 4 inputs + 6 outputs) ---
set numBottomPads 12
set bottomOffset 20
set bottomPitch [expr {floor( ($chipW - 2*$padD - 2*$bottomOffset - $padW) / ($numBottomPads-1) )}]
set bottomStart [expr $padD + $bottomOffset]

puts "IO_BOTTOM pitch: $bottomPitch µm"

place_pad -row IO_SOUTH -location [expr $bottomStart +  0*$bottomPitch] -master "sg13g2_IOPadVdd"     "pad_vdd0"
place_pad -row IO_SOUTH -location [expr $bottomStart +  1*$bottomPitch] -master "sg13g2_IOPadVss"     "pad_vss0"
place_pad -row IO_SOUTH -location [expr $bottomStart +  2*$bottomPitch] -master "sg13g2_IOPadIn"      "pad_in0"
place_pad -row IO_SOUTH -location [expr $bottomStart +  3*$bottomPitch] -master "sg13g2_IOPadIn"      "pad_in1"
place_pad -row IO_SOUTH -location [expr $bottomStart +  4*$bottomPitch] -master "sg13g2_IOPadIn"      "pad_in2"
place_pad -row IO_SOUTH -location [expr $bottomStart +  5*$bottomPitch] -master "sg13g2_IOPadIn"      "pad_in3"
place_pad -row IO_SOUTH -location [expr $bottomStart +  6*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out8"
place_pad -row IO_SOUTH -location [expr $bottomStart +  7*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out9"
place_pad -row IO_SOUTH -location [expr $bottomStart +  8*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out10"
place_pad -row IO_SOUTH -location [expr $bottomStart +  9*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out11"
place_pad -row IO_SOUTH -location [expr $bottomStart + 10*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out12"
place_pad -row IO_SOUTH -location [expr $bottomStart + 11*$bottomPitch] -master "sg13g2_IOPadOut16mA" "pad_out13"

# --- RIGHT SIDE (11 pads: 2 power + 9 outputs) ---
set numRightPads 11
set rightOffset 20
set rightPitch [expr {floor( ($chipH - 2*$padD - 2*$rightOffset - $padW) / ($numRightPads-1) )}]
set rightStart [expr $padD + $rightOffset]

puts "IO_RIGHT pitch: $rightPitch µm"

place_pad -row IO_EAST -location [expr $rightStart +  0*$rightPitch] -master "sg13g2_IOPadVdd"     "pad_vdd1"
place_pad -row IO_EAST -location [expr $rightStart +  1*$rightPitch] -master "sg13g2_IOPadVss"     "pad_vss1"
place_pad -row IO_EAST -location [expr $rightStart +  2*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out14"
place_pad -row IO_EAST -location [expr $rightStart +  3*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out15"
place_pad -row IO_EAST -location [expr $rightStart +  4*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out16"
place_pad -row IO_EAST -location [expr $rightStart +  5*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out17"
place_pad -row IO_EAST -location [expr $rightStart +  6*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out18"
place_pad -row IO_EAST -location [expr $rightStart +  7*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out19"
place_pad -row IO_EAST -location [expr $rightStart +  8*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out20"
place_pad -row IO_EAST -location [expr $rightStart +  9*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out21"
place_pad -row IO_EAST -location [expr $rightStart + 10*$rightPitch] -master "sg13g2_IOPadOut16mA" "pad_out22"

# --- TOP SIDE (11 pads: 2 power + 9 outputs) ---
set numTopPads 11
set topOffset 20
set topPitch [expr {floor( ($chipW - 2*$padD - 2*$topOffset - $padW) / ($numTopPads-1) )}]
set topStart [expr $chipW - $padD - $padW - $topOffset]

puts "IO_TOP pitch: $topPitch µm"

place_pad -row IO_NORTH -location [expr $topStart -  0*$topPitch] -master "sg13g2_IOPadIOVdd"   "pad_vddio1"
place_pad -row IO_NORTH -location [expr $topStart -  1*$topPitch] -master "sg13g2_IOPadIOVss"   "pad_vssio1"
place_pad -row IO_NORTH -location [expr $topStart -  2*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out23"
place_pad -row IO_NORTH -location [expr $topStart -  3*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out24"
place_pad -row IO_NORTH -location [expr $topStart -  4*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out25"
place_pad -row IO_NORTH -location [expr $topStart -  5*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out26"
place_pad -row IO_NORTH -location [expr $topStart -  6*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out27"
place_pad -row IO_NORTH -location [expr $topStart -  7*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out28"
place_pad -row IO_NORTH -location [expr $topStart -  8*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out29"
place_pad -row IO_NORTH -location [expr $topStart -  9*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out30"
place_pad -row IO_NORTH -location [expr $topStart - 10*$topPitch] -master "sg13g2_IOPadOut16mA" "pad_out31"


# --- Finalize the floorplan ---
# Note: Ensure $iocorner and $iofill are defined in your environment
place_corners $iocorner
place_io_fill -row IO_NORTH {*}$iofill
place_io_fill -row IO_SOUTH {*}$iofill
place_io_fill -row IO_WEST  {*}$iofill
place_io_fill -row IO_EAST  {*}$iofill
connect_by_abutment

# Bondpad as separate cell placed in OpenROAD:
# place the bonding pad relative to the IO cell
place_bondpad -bond bondpad_70x70 -offset {5.0 -70.0} pad_*

remove_io_rows

