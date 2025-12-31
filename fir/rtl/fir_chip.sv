module fir_chip
(
    input logic clk, rst,
    input logic unsigned [3:0] in,
    output logic [31:0] out
);

logic chip_clk;
logic chip_rst;

logic [3:0] chip_in;
logic [31:0] chip_out;



sg13g2_IOPadIn pad_clk (.pad(clk), .p2c(chip_clk));
sg13g2_IOPadIn pad_rst (.pad(rst), .p2c(chip_rst));

sg13g2_IOPadIn pad_in0 (.pad(in[0]), .p2c(chip_in[0]));
sg13g2_IOPadIn pad_in1 (.pad(in[1]), .p2c(chip_in[1]));
sg13g2_IOPadIn pad_in2 (.pad(in[2]), .p2c(chip_in[2]));
sg13g2_IOPadIn pad_in3 (.pad(in[3]), .p2c(chip_in[3]));

sg13g2_IOPadOut16mA pad_out0 (.pad(out[0]), .c2p(chip_out[0]));
sg13g2_IOPadOut16mA pad_out1 (.pad(out[1]), .c2p(chip_out[1]));
sg13g2_IOPadOut16mA pad_out2 (.pad(out[2]), .c2p(chip_out[2]));
sg13g2_IOPadOut16mA pad_out3 (.pad(out[3]), .c2p(chip_out[3]));
sg13g2_IOPadOut16mA pad_out4 (.pad(out[4]), .c2p(chip_out[4]));
sg13g2_IOPadOut16mA pad_out5 (.pad(out[5]), .c2p(chip_out[5]));
sg13g2_IOPadOut16mA pad_out6 (.pad(out[6]), .c2p(chip_out[6]));
sg13g2_IOPadOut16mA pad_out7 (.pad(out[7]), .c2p(chip_out[7]));
sg13g2_IOPadOut16mA pad_out8 (.pad(out[8]), .c2p(chip_out[8]));
sg13g2_IOPadOut16mA pad_out9 (.pad(out[9]), .c2p(chip_out[9]));
sg13g2_IOPadOut16mA pad_out10 (.pad(out[10]), .c2p(chip_out[10]));
sg13g2_IOPadOut16mA pad_out11 (.pad(out[11]), .c2p(chip_out[11]));
sg13g2_IOPadOut16mA pad_out12 (.pad(out[12]), .c2p(chip_out[12]));
sg13g2_IOPadOut16mA pad_out13 (.pad(out[13]), .c2p(chip_out[13]));
sg13g2_IOPadOut16mA pad_out14 (.pad(out[14]), .c2p(chip_out[14]));
sg13g2_IOPadOut16mA pad_out15 (.pad(out[15]), .c2p(chip_out[15]));
sg13g2_IOPadOut16mA pad_out16 (.pad(out[16]), .c2p(chip_out[16]));
sg13g2_IOPadOut16mA pad_out17 (.pad(out[17]), .c2p(chip_out[17]));
sg13g2_IOPadOut16mA pad_out18 (.pad(out[18]), .c2p(chip_out[18]));
sg13g2_IOPadOut16mA pad_out19 (.pad(out[19]), .c2p(chip_out[19]));
sg13g2_IOPadOut16mA pad_out20 (.pad(out[20]), .c2p(chip_out[20]));
sg13g2_IOPadOut16mA pad_out21 (.pad(out[21]), .c2p(chip_out[21]));
sg13g2_IOPadOut16mA pad_out22 (.pad(out[22]), .c2p(chip_out[22]));
sg13g2_IOPadOut16mA pad_out23 (.pad(out[23]), .c2p(chip_out[23]));
sg13g2_IOPadOut16mA pad_out24 (.pad(out[24]), .c2p(chip_out[24]));
sg13g2_IOPadOut16mA pad_out25 (.pad(out[25]), .c2p(chip_out[25]));
sg13g2_IOPadOut16mA pad_out26 (.pad(out[26]), .c2p(chip_out[26]));
sg13g2_IOPadOut16mA pad_out27 (.pad(out[27]), .c2p(chip_out[27]));
sg13g2_IOPadOut16mA pad_out28 (.pad(out[28]), .c2p(chip_out[28]));
sg13g2_IOPadOut16mA pad_out29 (.pad(out[29]), .c2p(chip_out[29]));
sg13g2_IOPadOut16mA pad_out30 (.pad(out[30]), .c2p(chip_out[30]));
sg13g2_IOPadOut16mA pad_out31 (.pad(out[31]), .c2p(chip_out[31]));

(* keep = "true" *)sg13g2_IOPadVdd pad_vdd0();
(* keep = "true" *)sg13g2_IOPadVdd pad_vdd1();

(* keep = "true" *)sg13g2_IOPadVss pad_vss0();
(* keep = "true" *)sg13g2_IOPadVss pad_vss1();

(* keep = "true" *)sg13g2_IOPadIOVdd pad_vddio0();
(* keep = "true" *)sg13g2_IOPadIOVdd pad_vddio1();

(* keep = "true" *)sg13g2_IOPadIOVss pad_vssio0();
(* keep = "true" *)sg13g2_IOPadIOVss pad_vssio1();

fir i_fir (

.clk(chip_clk), 
.rst(chip_rst),
.in (chip_in),
.out(chip_out)

);

endmodule
