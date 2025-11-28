`timescale 1ns / 1ps
module Instruction_Memory 
(
    input  logic [31:0] program_counter,
    output logic [31:0] instruction
);
    // Memory of 32 words (each 32-bit)
    logic [31:0] mem [0:72];
    // Load instructions from hex file
    initial begin
        $readmemh("Instructions_mem.mem", mem);
    end
    assign instruction = mem[program_counter[31:2]];  // divided by 4 to achieve pc+4
endmodule
