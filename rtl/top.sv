`timescale 1ns / 1ps
module top(
    input  logic        clk,
    input  logic        rst,
    output logic [31:0] operand_a,
    output logic [31:0] operand_b,
    output logic [31:0] result,
    output logic [31:0] dataR
);

    // Internal signals
    logic [31:0] pc_plus_4, prgm_counter, next_pc, jal_target, jalr_target;
    logic overflow, carry, zero, less_than;
    logic jump, branch, U_type;
    logic reg_write, is_imm, mem_read, mem_write, mem_to_reg;
    logic [2:0] alu_op;
    logic [31:0] instruction, rs1, rs2, imm_out, write_back_data;
    logic [3:0] alu_control;
    logic retain,flush_if_id;
    // IF/ID stage
    logic [31:0] instruction_out_if_id, pc_out_if_id;
    IF_ID_Stage u_if_id (
        .clk(clk), .rst(rst),
        .retain(retain),
        .flush_if_id(flush_if_id),
        .instruction_in_if_id(instruction),
        .pc_plus_4_in_if_id(prgm_counter),
        
        .instruction_out_if_id(instruction_out_if_id),
        .pc_plus_4_out_if_id(pc_out_if_id)
    );

    // ID/EX stage
    logic [31:0] imm_out_id_ex, rs1_id_ex, rs2_id_ex, pc_id_ex;
    logic reg_write_id_ex, is_imm_id_ex, mem_read_id_ex, mem_write_id_ex, mem_to_reg_id_ex;
    logic jump_id_ex, branch_id_ex, U_type_id_ex,flush_id_ex;
    logic [2:0] alu_op_id_ex;
    logic [2:0] funct3_id_ex;
    logic funct7b5_id_ex;
    logic [4:0] rd_out_id_ex,rs1_out_id_ex,rs2_out_id_ex;
    logic [6:0] op_out_id_ex;

    ID_EX_Stage u_id_ex (
        .clk(clk), .rst(rst),
        .imm_in_id_ex(imm_out),
        .rd_1_in_id_ex(rs1),
        .rd_2_in_id_ex(rs2),
        .pc_in_id_ex(pc_out_if_id),
        .reg_write_in_id_ex(reg_write),
        .is_imm_in_id_ex(is_imm),
        .mem_read_in_id_ex(mem_read),
        .mem_write_in_id_ex(mem_write),
        .mem_to_reg_in_id_ex(mem_to_reg),
        .alu_op_in_id_ex(alu_op),
        .jump_in_id_ex(jump),
        .branch_in_id_ex(branch),
        .U_type_in_id_ex(U_type),
        .funct3_in(instruction_out_if_id[14:12]),
        .funct7b5_in(instruction_out_if_id[30]),
        .rd_in_id_ex(instruction_out_if_id[11:7]),
        .op_in_id_ex(instruction_out_if_id[6:0]),
        .rs1_in_id_ex(instruction_out_if_id[19:15]),
        .rs2_in_id_ex(instruction_out_if_id[24:20]),
        .flush_id_ex(flush_id_ex),
        
        .imm_out_id_ex(imm_out_id_ex),
        .rd_1_out_id_ex(rs1_id_ex),
        .rd_2_out_id_ex(rs2_id_ex),
        .alu_op_out_id_ex(alu_op_id_ex),
        .pc_out_id_ex(pc_id_ex),
        .jump_out_id_ex(jump_id_ex),
        .branch_out_id_ex(branch_id_ex),
        .U_type_out_id_ex(U_type_id_ex),
        .reg_write_out_id_ex(reg_write_id_ex),
        .is_imm_out_id_ex(is_imm_id_ex),
        .mem_read_out_id_ex(mem_read_id_ex),
        .mem_write_out_id_ex(mem_write_id_ex),
        .mem_to_reg_out_id_ex(mem_to_reg_id_ex),
        .funct3_out(funct3_id_ex),
        .funct7b5_out(funct7b5_id_ex),
        .rd_out_id_ex(rd_out_id_ex),
        .op_out_id_ex(op_out_id_ex),
        .rs1_out_id_ex(rs1_out_id_ex),
        .rs2_out_id_ex(rs2_out_id_ex)
    );

    // EX/MEM stage
    logic [31:0] result_ex_mem, rd_data_2_ex_mem, jal_target_ex_mem,imm_out_ex_mem;
    logic mem_read_ex_mem, mem_write_ex_mem, mem_to_reg_ex_mem, reg_write_out_ex_mem;
    logic less_than_ex_mem, zero_ex_mem, branch_ex_mem, jump_ex_mem, U_type_ex_mem,flush_ex_mem;
    logic [4:0] rd_out_ex_mem;
    logic [6:0] op_out_ex_mem;
    logic [2:0] func3_out_ex_mem;

    EX_MEM_Stage u_ex_mem (
        .clk(clk), .rst(rst),
        .jal_target_in_ex_mem(jal_target),
        .result_in_ex_mem(result),
        .rd_data_2_in_ex_mem(rs2_id_ex),
        .zero_in_ex_mem(zero),
        .less_than_in_ex_mem(less_than),
        .mem_read_in_ex_mem(mem_read_id_ex),
        .mem_write_in_ex_mem(mem_write_id_ex),
        .mem_to_reg_in_ex_mem(mem_to_reg_id_ex),
        .reg_write_in_ex_mem(reg_write_id_ex),
        .branch_in_ex_mem(branch_id_ex),
        .jump_in_ex_mem(jump_id_ex),
        .U_type_in_ex_mem(U_type_id_ex),
        .rd_in_ex_mem(rd_out_id_ex),
        .op_in_ex_mem(op_out_id_ex),
        .func3_in_ex_mem(funct3_id_ex),
        .imm_in_ex_mem(imm_out_id_ex),
        .flush_ex_mem(flush_ex_mem),
        
        .jal_target_out_ex_mem(jal_target_ex_mem),
        .result_out_ex_mem(result_ex_mem),
        .rd_data_2_out_ex_mem(rd_data_2_ex_mem),
        .mem_read_out_ex_mem(mem_read_ex_mem),
        .mem_write_out_ex_mem(mem_write_ex_mem),
        .mem_to_reg_out_ex_mem(mem_to_reg_ex_mem),
        .reg_write_out_ex_mem(reg_write_out_ex_mem),
        .less_than_out_ex_mem(less_than_ex_mem),
        .zero_out_ex_mem(zero_ex_mem),
        .branch_out_ex_mem(branch_ex_mem),
        .jump_out_ex_mem(jump_ex_mem),
        .U_type_out_ex_mem(U_type_ex_mem),
        .rd_out_ex_mem(rd_out_ex_mem),
        .op_out_ex_mem(op_out_ex_mem),
        .func3_out_ex_mem(func3_out_ex_mem),
        .imm_out_ex_mem(imm_out_ex_mem)
    );

    // MEM/WB stage
    logic [31:0] result_mem_wb, read_data_mem_wb,imm_out_mem_wb,op_out_mem_wb;
    logic mem_to_reg_mem_wb, reg_write_mem_wb,reg_write_out_mem_wb,U_type_out_mem_wb;
    logic [4:0] rd_out_mem_wb;
    logic pc_write;
  MEM_WB_Stage u_mem_wb 
  (
    .clk(clk),
    .rst(rst),
    .result_in_mem_wb(result_ex_mem),
    .read_data_in_mem_wb(dataR),
    .mem_to_reg_in_mem_wb(mem_to_reg_ex_mem),
    .rd_in_mem_wb(rd_out_ex_mem),
    .reg_write_in_mem_wb(reg_write_out_ex_mem),
    .imm_in_mem_wb(imm_out_ex_mem),
    .op_in_mem_wb(op_out_ex_mem),
    .U_type_in_mem_wb(U_type_ex_mem),
    
    .result_out_mem_wb(result_mem_wb),
    .read_data_out_mem_wb(read_data_mem_wb),
    .mem_to_reg_out_mem_wb(mem_to_reg_mem_wb),
    .rd_out_mem_wb(rd_out_mem_wb),
    .reg_write_out_mem_wb(reg_write_out_mem_wb),
    .imm_out_mem_wb(imm_out_mem_wb),
    .op_out_mem_wb(op_out_mem_wb),
    .U_type_out_mem_wb(U_type_out_mem_wb)
);

    // Program Counter
    Program_Counter pc1 (
        .rst(rst), .clk(clk),
        .pc_write(pc_write),
        .next_pc(next_pc), .pc(prgm_counter)
    );

    // Instruction Memory
    Instruction_Memory I_1 (
        .program_counter(prgm_counter),
        .instruction(instruction)
    );

    // Control Unit
    Control c1 (
        .opcode(instruction_out_if_id[6:0]),
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

    // ALU Control
    ALU_Control alu_ctrl (
        .alu_op(alu_op_id_ex),
        .funct3(funct3_id_ex),
        .funct7_bit5(funct7b5_id_ex),
        .alu_control(alu_control)
    );

    // Register File
    Register_File rf (
        .clk(clk),
        .RegWEn(reg_write_out_mem_wb),
        .rs1_add(instruction_out_if_id[19:15]),
        .rs2_add(instruction_out_if_id[24:20]),
        .rd_add(rd_out_mem_wb),
        .dataW(write_back_data),
        .rs1(rs1),
        .rs2(rs2)
    );

    // Immediate Generator
    imm_gen imm1 (
        .instruction(instruction_out_if_id),
        .opcode(instruction_out_if_id[6:0]),
        .imm_out(imm_out)
    );

    // ALU
    ALU alu (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .overflow(overflow),
        .carry(carry),
        .less_than(less_than)
    );

    // Data Memory
    Data_Memory dmem (
        .clk(clk),
        .mem_read(mem_read_ex_mem),
        .mem_write(mem_write_ex_mem),
        .opcode(op_out_ex_mem),  
        .func3(func3_out_ex_mem),
        .addr(result_ex_mem),
        .dataW(rd_data_2_ex_mem),
        .dataR(dataR)
    );

logic branch_taken;
branch_comparison u_branch_comparison   //Branch ,JUMP,U_Type Handling
(
    .jump(jump_ex_mem),
    .branch(branch_ex_mem),
    .zero(zero_ex_mem),
    .less_than(less_than_ex_mem),
    .func3(func3_out_ex_mem),
    .op_ex(op_out_ex_mem),
    .jal_target(jal_target_ex_mem),
    .jalr_target(jalr_target),
    .pc_next(pc_plus_4),
    .U_type(U_type_out_mem_wb),
    .op_wb(op_out_mem_wb),
    .imm_wb(imm_out_mem_wb),
    .alu_result_wb(result_mem_wb),
    .mem_to_reg(mem_to_reg_mem_wb),
    .mem_data(read_data_mem_wb),

    .next_pc(next_pc),
    .write_back_data(write_back_data),
    .branch_taken(branch_taken)
);
    // Datapath connections
    logic [31:0] operand_a_temp,operand_b_temp;
    assign operand_a_temp = rs1_id_ex;
    assign operand_b_temp = rs2_id_ex;
    assign pc_plus_4 = prgm_counter + 4;
    assign jal_target   = pc_id_ex + imm_out_id_ex;
    assign jalr_target  = result_ex_mem & ~32'h1;
    
    logic [1:0] forward_A,forward_B;
    
    always_comb begin
    case(forward_A)
    0:operand_a=operand_a_temp;
    1:operand_a=write_back_data;  
    2:operand_a=result_ex_mem;
    default:operand_a=0;
    endcase
    if(is_imm_id_ex)
    operand_b=imm_out_id_ex;
    else begin
    case(forward_B)
    0:operand_b=operand_b_temp;
    1:operand_b=write_back_data;
    2:operand_b=result_ex_mem;
    default:operand_b=0;
    endcase
    end
    end
    
  Hazard_detection u222
(
   .rs1_id_ex(rs1_out_id_ex),
   .rs2_id_ex(rs2_out_id_ex),
   .rd_ex_mem(rd_out_ex_mem),
   .rd_mem_wb(rd_out_mem_wb),
   .reg_write_ex_mem(reg_write_out_ex_mem),
   .reg_write_mem_wb(reg_write_out_mem_wb),
   .mem_read_id_ex(mem_read_id_ex),
   .rd_id_ex(rd_out_id_ex),
   .rs1_if_id(instruction_out_if_id[19:15]),
   .rs2_if_id(instruction_out_if_id[24:20]),
   .branch_ex_mem(branch_ex_mem),
   .jump_ex_mem(jump_ex_mem),
   .branch_taken(branch_taken),
   
   .forward_A(forward_A),
   .forward_B(forward_B),
   .pc_write(pc_write),
   .retain_if_id(retain),
   .flush_if_id(flush_if_id),
   .flush_id_ex(flush_id_ex),
   .flush_ex_mem(flush_ex_mem)
);
    
endmodule