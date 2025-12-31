module dq
(
    input  logic unsigned [3:0] d,
    input  logic clk, rst,
    output logic [3:0] q
);

always_ff @(posedge clk or posedge rst) begin

    if(rst) begin
        q <= 0;
    end
    else begin
        q <= d;
    end
end

endmodule