module mul
#(parameter M = 1)
(
    input  logic [3:0] i,
    output logic [31:0] o
);

always_comb begin
    o = i * M;
end

endmodule