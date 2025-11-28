`timescale 1ns / 1ps
module ALU
(   input  logic signed [31:0] operand_a,    
    input  logic signed  [31:0] operand_b,     
    input  logic signed  [3:0]  alu_control,   
    output logic signed  [31:0] result,
    output logic        zero,
    output logic        overflow,
    output logic        carry,
    output logic        less_than
);
    logic [32:0] temp_result;  
    logic [4:0] shamt;
    
    always_comb begin
        result   = 0;
        overflow = 0;
        carry    = 0;
        temp_result = 0;
        shamt = operand_b[4:0]; 
        less_than=0;
        case(alu_control)
            4'b0000: begin // ADD/ADDI
                temp_result = operand_a + operand_b;
                result = temp_result[31:0];
                carry = temp_result[32];
                if ((operand_a[31] == operand_b[31]) && (result[31] != operand_a[31]))
                    overflow = 1;
            end            
            4'b0001: begin // SUB
                result = operand_a - operand_b;
                zero = (result == 32'd0);
                less_than = result[31];
                if ((operand_a[31] != operand_b[31]) && (result[31] != operand_a[31]))
                    overflow = 1;
            end     
            4'b0010: begin // SLL/SLLI
                result = operand_a << shamt;
            end
            
            4'b0011: begin // SLT/SLTI
                result = (operand_a < operand_b) ? 32'd1 : 32'd0;
            end
            
            4'b0100: begin // SLTU/SLTIU
                result = ($unsigned(operand_a) < $unsigned(operand_b)) ? 32'd1 : 32'd0;
            end   
            4'b0101: begin // XOR/XORI
                result = operand_a ^ operand_b;
            end
            
            4'b0110: begin // SRL/SRLI
                result = operand_a >> shamt;
            end
            
            4'b0111: begin // SRA/SRAI
                result = operand_a >>> shamt;
            end
            
            4'b1000: begin // OR/ORI
                result = operand_a | operand_b;
            end
            
            4'b1001: begin // AND/ANDI
                result = operand_a & operand_b;
            end
            4'b1010: begin // SUB
              result = $unsigned(operand_a) - $unsigned(operand_b);
              zero = (result == 32'd0);
              less_than = ($unsigned(operand_a) < $unsigned(operand_b));
            end 
            default: result = 32'd0;
        endcase
    end
    // Zero flag
endmodule