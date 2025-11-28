`timescale 1ns/1ps
module tb_Control;

    // Inputs
    logic [6:0] opcode;

    // Outputs
    logic reg_write, is_imm, mem_read, mem_write, mem_to_reg;
    logic [2:0] alu_op;
    logic jump, branch, U_type;

    // Instantiate DUT
    Control dut (
        .opcode(opcode),
        .reg_write(reg_write),
        .is_imm(is_imm),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),
        .jump(jump),
        .branch(branch),
        .U_type(U_type)
    );

    // Apply test vectors
    initial begin
        opcode = 7'd51;   #5;  // R-type
        opcode = 7'd19;   #5;  // I-type
        opcode = 7'd3;    #5;  // Load
        opcode = 7'd35;   #5;  // Store
        opcode = 7'd111;  #5;  // JAL
        opcode = 7'd103;  #5;  // JALR
        opcode = 7'd99;   #5;  // Branch
        opcode = 7'd55;   #5;  // LUI
        opcode = 7'd23;   #5;  // AUIPC
        opcode = 7'd0;    #5;  // Default
        $finish;
    end

endmodule
