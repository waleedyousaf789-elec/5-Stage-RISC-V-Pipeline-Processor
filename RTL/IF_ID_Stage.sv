`timescale 1ns / 1ps
module IF_ID_Stage
(
     input logic clk,
     input logic rst,
     input logic retain,
     input logic flush_if_id,
     input logic [31:0]  instruction_in_if_id,
     input logic [31:0]  pc_plus_4_in_if_id,
     output logic [31:0] instruction_out_if_id,
     output logic [31:0] pc_plus_4_out_if_id
 );
 always_ff @(posedge clk or posedge rst)
 begin
 if(rst || flush_if_id) begin
 instruction_out_if_id<=0;
 pc_plus_4_out_if_id<=0;
 end
 else if(!retain) begin
 instruction_out_if_id<=instruction_in_if_id;
 pc_plus_4_out_if_id<=pc_plus_4_in_if_id;
 end
 else begin
 instruction_out_if_id<=instruction_out_if_id;
 pc_plus_4_out_if_id<=pc_plus_4_out_if_id;
 end
 end
endmodule
