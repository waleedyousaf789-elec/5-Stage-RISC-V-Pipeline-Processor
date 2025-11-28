`timescale 1ns / 1ps
module Hazard_detection
(
   input logic [4:0] rs1_id_ex,
   input logic [4:0] rs2_id_ex,
   input logic [4:0] rd_ex_mem,
   input logic [4:0] rd_mem_wb,
   input logic reg_write_ex_mem,
   input logic reg_write_mem_wb,
   input logic mem_read_id_ex,
   input logic [4:0] rd_id_ex,
   input logic [4:0] rs1_if_id,
   input logic [4:0] rs2_if_id,
   input logic branch_ex_mem,
   input logic jump_ex_mem,
   input logic branch_taken,
   
   output logic [1:0] forward_A,
   output logic [1:0] forward_B,
   output logic pc_write,
   output logic retain_if_id,
   output logic flush_if_id,
   output logic flush_id_ex,
   output logic flush_ex_mem
);
//For Forwarding
always_comb begin
forward_A=0;
forward_B=0;

if((rd_ex_mem!=0) && (reg_write_ex_mem) && (rd_ex_mem==rs1_id_ex))     
forward_A=2;
else if((rd_mem_wb!=0) && (reg_write_mem_wb) && (rd_mem_wb==rs1_id_ex))
forward_A=1;

if((rd_ex_mem!=0) && (reg_write_ex_mem) && (rd_ex_mem==rs2_id_ex))     
forward_B=2;
else if((rd_mem_wb!=0) && (reg_write_mem_wb) && (rd_mem_wb==rs2_id_ex))
forward_B=1;
end

//For Stalling
always_comb begin
pc_write=1;
retain_if_id=0;
if ((mem_read_id_ex) && ((rd_id_ex == rs1_if_id) || (rd_id_ex == rs2_if_id))) begin
    pc_write = 0;
    retain_if_id = 1;
end
end

always_comb begin
flush_if_id=0;
flush_id_ex=0;
flush_ex_mem=0;
if (branch_taken || jump_ex_mem) begin
flush_if_id=1;
flush_id_ex=1;
flush_ex_mem=1;
end
end
endmodule
