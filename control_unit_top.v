`include "ALU_decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

    main_decode md(
                .op(Op),
                .regwrite(RegWrite),
                .immsrc(ImmSrc),
                .memwrite(MemWrite),
                .resultsrc(ResultSrc),
                .branch(Branch),
                .alusrc(ALUSrc),
                .aluop(ALUOp)
    );

    ALU_Decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule