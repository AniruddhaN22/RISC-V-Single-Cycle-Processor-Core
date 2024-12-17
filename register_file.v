module reg_file(A1,A2,A3,WD3,WE3,clk,rst,RD1,RD2);
    input clk,rst,WE3;
    input [4:0] A1,A2,A3;
    input [31:0] WD3;
    output [31:0] RD1,RD2;

    reg [31:0] register [31:0];

    assign RD1 = (~rst) ? 32'h00000000 : register[A1];
    assign RD2 = (~rst) ? 32'h00000000 : register[A2];

    always @(posedge clk) begin
    if (WE3) begin
    register[A3] <= WD3;
    end
    end

    initial begin
    register[9] = 32'h00000020;
    register[6] = 32'h00000040;
    end
endmodule
    
