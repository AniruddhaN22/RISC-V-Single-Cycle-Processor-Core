module pc_ad(a,b,c);

    input [31:0] a,b;
    output [31:0] c;

    assign c = a + b;
endmodule