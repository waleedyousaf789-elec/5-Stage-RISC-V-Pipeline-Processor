`timescale 1ns / 1ps
module EX_MEM_Stage(input logic clk,
                    input logic rst,
                    input logic [31:0] jal_target_in_ex_mem,
                    input logic [31:0] result_in_ex_mem,
                    input logic [31:0] rd_data_2_in_ex_mem,
                    input logic zero_in_ex_mem,
                    input logic less_than_in_ex_mem,
                    input logic mem_read_in_ex_mem,
                    input logic mem_write_in_ex_mem,
                    input logic mem_to_reg_in_ex_mem,
                    input logic reg_write_in_ex_mem,
                    input logic branch_in_ex_mem,
                    input logic jump_in_ex_mem,
                    input logic U_type_in_ex_mem,
                    input  logic [4:0] rd_in_ex_mem,
                    input logic [6:0] op_in_ex_mem,
                    input logic [2:0] func3_in_ex_mem,
                    input logic  [31:0] imm_in_ex_mem,
                    input logic flush_ex_mem,
                    
                    output logic [31:0] jal_target_out_ex_mem,
                    output logic [31:0] result_out_ex_mem,
                    output logic [31:0] rd_data_2_out_ex_mem,
                    output logic mem_read_out_ex_mem,
                    output logic mem_write_out_ex_mem,
                    output logic mem_to_reg_out_ex_mem,
                    output logic reg_write_out_ex_mem,
                    output logic less_than_out_ex_mem,
                    output logic zero_out_ex_mem,
                    output logic branch_out_ex_mem,
                    output logic jump_out_ex_mem,
                    output logic U_type_out_ex_mem,
                    output logic [4:0] rd_out_ex_mem,
                    output logic [6:0] op_out_ex_mem,
                    output logic [2:0] func3_out_ex_mem,
                    output logic [31:0] imm_out_ex_mem
    );
 always_ff @(posedge clk or posedge rst) begin
 if(rst || flush_ex_mem) begin
 jal_target_out_ex_mem<=0;
 result_out_ex_mem<=0;
 rd_data_2_out_ex_mem<=0;
 mem_read_out_ex_mem<=0;
 mem_write_out_ex_mem<=0;
 mem_to_reg_out_ex_mem<=0;
 reg_write_out_ex_mem<=0;
 less_than_out_ex_mem<=0;
 zero_out_ex_mem<=0;
 branch_out_ex_mem<=0;
 jump_out_ex_mem<=0;
 U_type_out_ex_mem<=0;
 rd_out_ex_mem<=0;
 op_out_ex_mem<=0;
 func3_out_ex_mem<=0;
 imm_out_ex_mem<=0;
 end
 else begin
 jal_target_out_ex_mem<=jal_target_in_ex_mem;
 result_out_ex_mem<=result_in_ex_mem;
 rd_data_2_out_ex_mem<=rd_data_2_in_ex_mem;
 mem_read_out_ex_mem<=mem_read_in_ex_mem;
 mem_write_out_ex_mem<=mem_write_in_ex_mem;
 mem_to_reg_out_ex_mem<=mem_to_reg_in_ex_mem;
 reg_write_out_ex_mem<=reg_write_in_ex_mem;
 less_than_out_ex_mem<=less_than_in_ex_mem;
 zero_out_ex_mem<=zero_in_ex_mem;
 branch_out_ex_mem<=branch_in_ex_mem;
 jump_out_ex_mem<=jump_in_ex_mem;
 U_type_out_ex_mem<=U_type_in_ex_mem;
 rd_out_ex_mem<=rd_in_ex_mem;
 op_out_ex_mem<=op_in_ex_mem;
 func3_out_ex_mem<=func3_in_ex_mem;
 imm_out_ex_mem<=imm_in_ex_mem;
 end   
 end
endmodule
