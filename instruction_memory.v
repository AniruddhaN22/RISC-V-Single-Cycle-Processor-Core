module instr_mem(A,rst,RD);

    input [31:0] A;
    input rst;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

    assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A[31:2]];

    initial begin

    //mem[0] = 32'hFFC4A303;
    mem[0] = 32'h0064A423;
    end
    endmodule