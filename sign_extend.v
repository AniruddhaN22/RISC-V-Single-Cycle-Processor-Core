module sign_ext(in,imm_ext,immsrc);

    input immsrc;
    input [31:0] in;
    output [31:0] imm_ext;

    assign imm_ext = (immsrc == 1'b1) ? ({{20{in[31]}},in[31:25],in[11:7]}) : 
                                        {{20{1'b1}},in[31:20]};

endmodule