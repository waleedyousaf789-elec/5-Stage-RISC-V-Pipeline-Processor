`timescale 1ns / 1ps
module tb_ID_EX_Stage();

    // Inputs
    logic clk;
    logic rst;
    logic [31:0] imm_in;
    logic [31:0] rd_1_in;
    logic [31:0] rd_2_in;
    logic [31:0] pc_in;
    logic reg_write_in;
    logic is_imm_in;
    logic mem_read_in;
    logic mem_write_in;
    logic mem_to_reg_in;
    logic [2:0] alu_op_in;
    logic jump_in;
    logic branch_in;
    logic U_type_in;
    logic [2:0] funct3_in;
    logic funct7b5_in;
    logic [4:0] rd_in;
    logic [6:0] op_in;

    // Outputs
    logic [31:0] imm_out;
    logic [31:0] rd_1_out;
    logic [31:0] rd_2_out;
    logic [2:0] alu_op_out;
    logic [31:0] pc_out;
    logic jump_out;
    logic branch_out;
    logic U_type_out;
    logic reg_write_out;
    logic is_imm_out;
    logic mem_read_out;
    logic mem_write_out;
    logic mem_to_reg_out;
    logic [2:0] funct3_out;
    logic funct7b5_out;
    logic [4:0] rd_out;
    logic [6:0] op_out;


    ID_EX_Stage uut (
        .clk(clk),
        .rst(rst),
        .imm_in_id_ex(imm_in),
        .rd_1_in_id_ex(rd_1_in),
        .rd_2_in_id_ex(rd_2_in),
        .pc_in_id_ex(pc_in),
        .reg_write_in_id_ex(reg_write_in),
        .is_imm_in_id_ex(is_imm_in),
        .mem_read_in_id_ex(mem_read_in),
        .mem_write_in_id_ex(mem_write_in),
        .mem_to_reg_in_id_ex(mem_to_reg_in),
        .alu_op_in_id_ex(alu_op_in),
        .jump_in_id_ex(jump_in),
        .branch_in_id_ex(branch_in),
        .U_type_in_id_ex(U_type_in),
        .funct3_in(funct3_in),
        .funct7b5_in(funct7b5_in),
        .rd_in_id_ex(rd_in),
        .op_in_id_ex(op_in),

        .imm_out_id_ex(imm_out),
        .rd_1_out_id_ex(rd_1_out),
        .rd_2_out_id_ex(rd_2_out),
        .alu_op_out_id_ex(alu_op_out),
        .pc_out_id_ex(pc_out),
        .jump_out_id_ex(jump_out),
        .branch_out_id_ex(branch_out),
        .U_type_out_id_ex(U_type_out),
        .reg_write_out_id_ex(reg_write_out),
        .is_imm_out_id_ex(is_imm_out),
        .mem_read_out_id_ex(mem_read_out),
        .mem_write_out_id_ex(mem_write_out),
        .mem_to_reg_out_id_ex(mem_to_reg_out),
        .funct3_out(funct3_out),
        .funct7b5_out(funct7b5_out),
        .rd_out_id_ex(rd_out),
        .op_out_id_ex(op_out)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    initial begin
        // Initialize inputs
        rst = 1;
        imm_in = 0;
        rd_1_in = 0;
        rd_2_in = 0;
        pc_in = 0;
        reg_write_in = 0;
        is_imm_in = 0;
        mem_read_in = 0;
        mem_write_in = 0;
        mem_to_reg_in = 0;
        alu_op_in = 0;
        jump_in = 0;
        branch_in = 0;
        U_type_in = 0;
        funct3_in = 0;
        funct7b5_in = 0;
        rd_in = 0;
        op_in = 0;


        #12;
        rst = 0;
        #10;
        imm_in = 32'hA5A5A5A5;
        rd_1_in = 32'h11111111;
        rd_2_in = 32'h22222222;
        pc_in = 32'h33333333;
        reg_write_in = 1;
        is_imm_in = 1;
        mem_read_in = 0;
        mem_write_in = 1;
        mem_to_reg_in = 0;
        alu_op_in = 3'b101;
        jump_in = 0;
        branch_in = 1;
        U_type_in = 0;
        funct3_in = 3'b010;
        funct7b5_in = 1;
        rd_in = 5'b10101;
        op_in = 7'b1101100;
   
        #10;

        imm_in = 32'hFFFF0000;
        rd_1_in = 32'h44444444;
        rd_2_in = 32'h55555555;
        pc_in = 32'h66666666;
        reg_write_in = 0;
        is_imm_in = 0;
        mem_read_in = 1;
        mem_write_in = 0;
        mem_to_reg_in = 1;
        alu_op_in = 3'b011;
        jump_in = 1;
        branch_in = 0;
        U_type_in = 1;
        funct3_in = 3'b111;
        funct7b5_in = 0;
        rd_in = 5'b01010;
        op_in = 7'b1010101;
        #10;
        $stop;
    end

endmodule
