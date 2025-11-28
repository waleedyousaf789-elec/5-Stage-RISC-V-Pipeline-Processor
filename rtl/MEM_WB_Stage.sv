`timescale 1ns / 1ps
module MEM_WB_Stage(input logic clk,
                    input logic rst,
                    input logic [31:0] result_in_mem_wb,
                    input logic [31:0] read_data_in_mem_wb,
                    input logic mem_to_reg_in_mem_wb,
                    input  logic [4:0] rd_in_mem_wb,
                    input logic reg_write_in_mem_wb,
                    input logic [31:0] imm_in_mem_wb,
                    input logic [6:0] op_in_mem_wb,
                    input logic U_type_in_mem_wb,
                    
                    output logic [31:0] result_out_mem_wb,
                    output logic [31:0] read_data_out_mem_wb,
                    output logic mem_to_reg_out_mem_wb,
                    output logic [4:0] rd_out_mem_wb,
                    output logic reg_write_out_mem_wb,
                    output logic [31:0] imm_out_mem_wb,
                    output logic [31:0] op_out_mem_wb,
                    output logic U_type_out_mem_wb
    );
always_ff @(posedge clk or posedge rst) begin
if(rst) begin
result_out_mem_wb<=0;
read_data_out_mem_wb<=0;
mem_to_reg_out_mem_wb<=0;
rd_out_mem_wb<=0;
reg_write_out_mem_wb<=0;
imm_out_mem_wb<=0;
op_out_mem_wb<=0;
U_type_out_mem_wb<=0;
end
else begin
result_out_mem_wb<=result_in_mem_wb;
read_data_out_mem_wb<=read_data_in_mem_wb;
mem_to_reg_out_mem_wb<=mem_to_reg_in_mem_wb;
rd_out_mem_wb<=rd_in_mem_wb;
reg_write_out_mem_wb<=reg_write_in_mem_wb;
imm_out_mem_wb<=imm_in_mem_wb;
op_out_mem_wb<=op_in_mem_wb;
U_type_out_mem_wb<=U_type_in_mem_wb;
end
end    
endmodule
