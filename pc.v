module pc_module(pc_next,pc_out,clk,rst);
    input clk,rst;
    input [31:0] pc_next;
    output reg [31:0] pc_out;

    always @(posedge clk)
    begin
      if (~rst)
        begin
        pc_out <= {32{1'b0}};
        end
    else
        begin
        pc_out <= pc_next;
        end
    end
endmodule
    
