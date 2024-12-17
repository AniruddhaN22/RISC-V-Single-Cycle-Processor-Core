module data_memory(A,WD,rst,clk,WE,RD);
    input clk,WE,rst;
    input [31:0] A, WD;
    output [31:0] RD;

    reg [31:0] memory [1023:0];

    assign RD = (~rst) ? 32'd0 : memory[A] ;

    always @(posedge clk) begin
    if (WE) begin
        memory[A] <= WD;
    end
    end

    initial begin
        memory[28] = 32'h00000020;
    end
endmodule