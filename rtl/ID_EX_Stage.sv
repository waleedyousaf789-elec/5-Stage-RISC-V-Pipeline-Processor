`timescale 1ns / 1ps
module ID_EX_Stage(
    input logic clk,
    input logic rst,
    input logic [31:0] imm_in_id_ex,
    input logic [31:0] rd_1_in_id_ex,
    input logic [31:0] rd_2_in_id_ex,
    input logic [31:0] pc_in_id_ex,
    input logic reg_write_in_id_ex,
    input logic is_imm_in_id_ex,
    input logic mem_read_in_id_ex,
    input logic mem_write_in_id_ex,
    input logic mem_to_reg_in_id_ex,
    input logic [2:0] alu_op_in_id_ex,
    input logic jump_in_id_ex,
    input logic branch_in_id_ex,
    input logic U_type_in_id_ex,
    input logic [2:0] funct3_in,
    input logic funct7b5_in,
    input  logic [4:0] rd_in_id_ex,
    input logic  [6:0] op_in_id_ex,
    input logic  [4:0] rs1_in_id_ex,
    input logic  [4:0] rs2_in_id_ex,
    input logic   flush_id_ex,
    
    output logic [31:0] imm_out_id_ex,
    output logic [31:0] rd_1_out_id_ex,
    output logic [31:0] rd_2_out_id_ex,
    output logic [2:0] alu_op_out_id_ex,
    output logic [31:0] pc_out_id_ex,
    output logic jump_out_id_ex,
    output logic branch_out_id_ex,
    output logic U_type_out_id_ex,
    output logic reg_write_out_id_ex,
    output logic is_imm_out_id_ex,
    output logic mem_read_out_id_ex,
    output logic mem_write_out_id_ex,
    output logic mem_to_reg_out_id_ex,
    output logic [2:0] funct3_out,
    output logic funct7b5_out,
    output logic [4:0] rd_out_id_ex,
    output logic [6:0] op_out_id_ex,
    output logic [4:0] rs1_out_id_ex,
    output logic [4:0] rs2_out_id_ex
    
);

always_ff @(posedge clk or posedge rst) begin
    if (rst || flush_id_ex) begin
        imm_out_id_ex <= 0;
        rd_1_out_id_ex <= 0;
        rd_2_out_id_ex <= 0;
        alu_op_out_id_ex <= 0;
        jump_out_id_ex <= 0;
        branch_out_id_ex <= 0;
        U_type_out_id_ex <= 0;
        pc_out_id_ex <= 0;
        reg_write_out_id_ex <= 0;
        is_imm_out_id_ex <= 0;
        mem_read_out_id_ex <= 0;
        mem_write_out_id_ex <= 0;
        mem_to_reg_out_id_ex <= 0;
        rd_out_id_ex<=0;
        op_out_id_ex<=0;
        funct3_out<=0;
        funct7b5_out<=0;
        rs1_out_id_ex<=0;
        rs2_out_id_ex<=0;
    end else begin
        imm_out_id_ex <= imm_in_id_ex;
        rd_1_out_id_ex <= rd_1_in_id_ex;
        rd_2_out_id_ex <= rd_2_in_id_ex;
        alu_op_out_id_ex <= alu_op_in_id_ex;
        jump_out_id_ex <= jump_in_id_ex;
        branch_out_id_ex <= branch_in_id_ex;
        U_type_out_id_ex <= U_type_in_id_ex;
        pc_out_id_ex <= pc_in_id_ex;
        reg_write_out_id_ex <= reg_write_in_id_ex;
        is_imm_out_id_ex <= is_imm_in_id_ex;
        mem_read_out_id_ex <= mem_read_in_id_ex;
        mem_write_out_id_ex <= mem_write_in_id_ex;
        mem_to_reg_out_id_ex <= mem_to_reg_in_id_ex;
        rd_out_id_ex<=rd_in_id_ex;
        op_out_id_ex<=op_in_id_ex;
        funct3_out<=funct3_in;
        funct7b5_out<=funct7b5_in;
        rs1_out_id_ex<=rs1_in_id_ex;
        rs2_out_id_ex<=rs2_in_id_ex;
    end
end

endmodule
