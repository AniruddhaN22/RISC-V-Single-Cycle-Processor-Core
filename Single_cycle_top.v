`include "pc.v"
`include "instruction_memory.v"
`include "register_file.v"
`include "sign_extend.v"
`include "ALU.v"
`include "control_unit_top.v"
`include "data_mem.v"
`include "pc_adder.v"
`include "mux.v"

module single_cycle_top(clk,rst);

    input clk,rst;

    wire [31:0] pc_top, rd_instr, rd1_top, imm_ext_top, alu_result, ReadData, pcplus4, rd2_top, srcb, Result;
    wire RegWrite_top,ALUSrc,MemWrite_top,ResultSrc_top;
    wire [1:0] immsrc_top;
    wire [2:0] alu_control_top;

    
    pc_module prog(
        .clk(clk),
        .rst(rst),
        .pc_out(pc_top),
        .pc_next(pcplus4)
    );

    pc_ad pa(
        .a(pc_top),
        .b(32'd4),
        .c(pcplus4));

    instr_mem im(
        .A(pc_top),
        .rst(rst),
        .RD(rd_instr)
    );

    reg_file rf(
        .A1(rd_instr[19:15]),
        .A2(rd_instr[24:20]),
        .A3(rd_instr[11:7]),
        .WD3(ReadData),
        .WE3(RegWrite_top),
        .clk(clk),
        .rst(rst),
        .RD1(rd1_top),
        .RD2(rd2_top)
    );

    sign_ext se(
        .in(rd_instr),
        .immsrc(immsrc_top[0]),
        .imm_ext(imm_ext_top)
    );
    mux Mux_Register_to_ALU(
                            .a(rd2_top),
                            .b(imm_ext_top),
                            .s(ALUSrc),
                            .c(srcb)
    alu al(
        .A(rd1_top), 
        .B(srcb), 
        .ALUControl(alu_control_top), 
        .Result(alu_result), 
        .Zero(), 
        .Negative(), 
        .OverFlow(), 
        .Carry());

    Control_Unit_Top cut(
        .Op(rd_instr[6:0]),
        .RegWrite(RegWrite_top),
        .ImmSrc(immsrc_top),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite_top),
        .ResultSrc(ResultSrc_top),
        .Branch(),
        .funct3(rd_instr[14:12]),
        .funct7(rd_instr[6:0]),
        .ALUControl(alu_control_top));

    data_memory dm(
        .A(alu_result),
        .WD(rd2_top),
        .rst(rst),
        .clk(clk),
        .WE(MemWrite),
        .RD(ReadData));

    mux Mux_DataMemory_to_Register(
                            .a(alu_result),
                            .b(ReadData),
                            .s(ResultSrc_top),
                            .c(Result)
endmodule