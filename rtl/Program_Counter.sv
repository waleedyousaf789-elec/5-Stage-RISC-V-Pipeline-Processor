`timescale 1ns / 1ps
module Program_Counter 
(
    input logic rst,
    input logic clk,
    input logic pc_write,
    input logic [31:0] next_pc,  
    output logic [31:0] pc       
); 
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        pc <= 0;
    else if (pc_write)
        pc <= next_pc;  // Only update when pc_write is 1 and else will retain when pc_write is 0
    // else: do nothing, retain current value
end
endmodule
