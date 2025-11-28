`timescale 1ns / 1ps
module imm_gen (
    input  logic [31:0] instruction,
    input  logic [6:0]  opcode,
    output logic [31:0] imm_out
);
    always_comb begin
        if (opcode == 7'd35) 
            // S-type 
            imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
         else if(opcode==7'd111) 
         //jal
         imm_out = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
         else if(opcode==7'd99) 
         //branches
         imm_out = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
         else if(opcode==7'd55 || opcode==7'd23 )
         //U_Type
         imm_out = {instruction[31:12], {12{1'b0}}};
         else
            // I-type 
            imm_out = {{20{instruction[31]}}, instruction[31:20]};
        
    end
endmodule
