`timescale 1ns / 1ps
module Control(
    input  logic [6:0] opcode,       // instruction opcode field
    output logic       reg_write,    // enable register file write
    output logic       is_imm,       // ALU source select
    output logic       mem_read,
    output logic       mem_write,
    output logic       mem_to_reg,
    output logic [2:0] alu_op,        // ALU operation control
    output logic jump,
    output logic branch,
    output logic U_type
);
    always_comb begin
        case (opcode)
            7'd51: begin // R-type
            reg_write = 1;
            is_imm    = 0;   // will use register operand
            alu_op    = 3'd0;   ///R
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;
            branch=0;
            U_type=0;
            end
            7'd19: begin 
            reg_write = 1;
            is_imm    = 1;   // use immediate I type
            alu_op    = 3'd1;
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;
            branch=0;
            U_type=0;
            end
            7'd3:begin
            reg_write = 1;
            is_imm    = 1;
            alu_op    = 3'd2; //L_type
            mem_read=1;
            mem_write=0;
            mem_to_reg=1;
            jump=0;
            branch=0;
            U_type=0;
            end
            7'd35:begin
            reg_write = 0;
            is_imm    = 1;
            alu_op    = 3'd3; //S_type
            mem_read=0;
            mem_write=1;
            mem_to_reg=0;
            jump=0;
            branch=0;
            U_type=0;
            end
            7'd111:begin
            reg_write = 1;    //jal
            is_imm    = 1;
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=1;        //jump=1;
            branch=0;
            U_type=0;
            end     
            7'd103:begin     //jalr
            reg_write = 1;
            is_imm    = 1;
            alu_op    = 3'd1;    //as it follows I_type
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=1;        //jump=1;
            branch=0;
            U_type=0;
            end
            7'd99:begin     //branch
            reg_write = 0;
            is_imm    = 0;
            alu_op    = 3'd4;    
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;        
            branch=1;
            U_type=0;
            end
            7'd55:begin     //lui
            reg_write = 1;
            is_imm    = 0;    
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;        
            branch=0;
            U_type=1;
            end
            7'd23:begin     //auipc
            reg_write = 1;
            is_imm    = 0;    
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;        
            branch=0;
            U_type=1;
            end
            default:begin
            reg_write = 0;
            is_imm    = 0;
            alu_op    = 3'd0;    
            mem_read=0;
            mem_write=0;
            mem_to_reg=0;
            jump=0;   
            branch=0;
            U_type=0;     
            end     
        endcase
    end
endmodule
