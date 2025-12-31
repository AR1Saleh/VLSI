module adder
(
    input logic [31:0] in1, in2, in3, in4, in5,
    output logic [31:0] out 
);

always_comb begin
    out = in1 + in2 + in3 + in4 + in5;
end

endmodule