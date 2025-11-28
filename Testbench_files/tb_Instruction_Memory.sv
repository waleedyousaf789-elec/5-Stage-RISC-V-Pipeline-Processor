`timescale 1ns / 1ps
module Instruction_Memory_tb;
    logic [31:0] program_counter;
    logic [31:0] instruction;
    Instruction_Memory uut (
        .program_counter(program_counter),
        .instruction(instruction)
    );
    initial begin
        program_counter = 0;      #10;
        program_counter = 4;      #10;
        program_counter = 8;      #10;
        program_counter = 12;     #10;
        program_counter = 16;     #10;
        program_counter = 20;     #10;
        #10;
        $finish;
    end

endmodule
