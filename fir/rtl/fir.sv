module fir
(
    input logic unsigned [3:0] in,
    input logic clk, rst,
    output logic [31:0] out
);

wire logic [3:0]  q1, q2, q3, q4, q5; 
wire logic [31:0] o1, o2, o3, o4, o5;

dq i1 (.d(in), .q(q1), .clk(clk), .rst(rst));

dq i2 (.d(q1), .q(q2), .clk(clk), .rst(rst));

dq i3 (.d(q2), .q(q3), .clk(clk), .rst(rst));

dq i4 (.d(q3), .q(q4), .clk(clk), .rst(rst));

dq i5 (.d(q4), .q(q5), .clk(clk), .rst(rst));
    
mul #(.M(1))  m1 (.i(q1), .o(o1));

mul #(.M(4))  m2 (.i(q2), .o(o2)); 

mul #(.M(16)) m3 (.i(q3), .o(o3));

mul #(.M(4))  m4 ( .i(q4), .o(o4));

mul #(.M(1))  m5 ( .i(q5), .o(o5));  

adder a1 ( .in1(o1), .in2(o2), .in3(o3), .in4(o4), .in5(o5), .out(out));

endmodule