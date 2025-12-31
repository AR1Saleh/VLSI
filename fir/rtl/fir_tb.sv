module fir_tb();

logic clk, rst;
logic [3:0] in;
logic [31:0] out;

fir uut (.*);

always begin
    #5 clk = ~clk;
end

task reset();

    rst = 1;
    in  = 0;
    @(negedge clk);
    rst = 0;

endtask

`ifdef SDF_TEST

initial begin
    $sdf_annotate("",,,"sdf.log", "MAXIMUM");
end
`endif

initial begin
    clk = 0;
    reset();
    @(negedge clk)  in<= 4'd1;
    @(negedge clk)  in<= 4'd0;
    //repeat(5) @(negedge clk) ;
    //@(negedge clk)  in<= 4'hF;
    //repeat (5) @(negedge clk) ;
    @(negedge clk)  in<= 4'd4;
    @(negedge clk)  in<= 4'd16;
    @(negedge clk)  in<= 4'd4;
    @(negedge clk)  in<= 4'd1;
    @(negedge clk)  in<= 4'd0;
    @(negedge clk)  in<= 4'd8;
    @(negedge clk)  in<= 4'd9;
    @(negedge clk)  in<= 4'd10;
    @(negedge clk)  in<= 4'd11;
    @(negedge clk)  in<= 4'd12;
    @(negedge clk)  in<= 4'd13;
    @(negedge clk)  in<= 4'd14;
    @(negedge clk)  in<= 4'd15;
end

endmodule