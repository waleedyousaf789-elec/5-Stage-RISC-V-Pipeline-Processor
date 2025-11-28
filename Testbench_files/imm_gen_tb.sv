`timescale 1ns / 1ps
module imm_gen_tb;
    logic [31:0] instruction;
    logic [6:0]  opcode;
    logic [31:0] imm_out;

    imm_gen uut (
        .instruction(instruction),
        .opcode(opcode),
        .imm_out(imm_out)
    );
    initial begin
        opcode=7'd35;
        instruction = 32'h0f200700; 
        #10;
        opcode=7'd1;
        instruction = 32'hff200000; // MSB of imm = 1 (negative imm)
        #10;
        $finish;
    end
endmodule
