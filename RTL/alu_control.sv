`timescale 1ns / 1ps
module ALU_Control
(   input  logic       [2:0] alu_op,        // 0 = R-type, 1 = I-type
    input  logic [2:0] funct3,       
    input  logic       funct7_bit5,   
    output logic [3:0] alu_control
);
    always_comb begin
        alu_control = 4'b0000;  // default
        case(alu_op)
            3'd0: begin // R-type
                case(funct3)
                    3'b000: alu_control = funct7_bit5 ? 4'b0001 : 4'b0000; // SUB : ADD
                    3'b001: alu_control = 4'b0010; // SLL
                    3'b010: alu_control = 4'b0011; // SLT
                    3'b011: alu_control = 4'b0100; // SLTU
                    3'b100: alu_control = 4'b0101; // XOR
                    3'b101: alu_control = funct7_bit5 ? 4'b0111 : 4'b0110; // SRA : SRL
                    3'b110: alu_control = 4'b1000; // OR
                    3'b111: alu_control = 4'b1001; // AND
                    default: alu_control = 4'b0000;
                endcase
            end
            3'd1: begin // I-type 
                case(funct3)
                    3'b000: alu_control = 4'b0000; // ADDI
                    3'b001: alu_control = 4'b0010; // SLLI
                    3'b010: alu_control = 4'b0011; // SLTI
                    3'b011: alu_control = 4'b0100; // SLTIU
                    3'b100: alu_control = 4'b0101; // XORI
                    3'b101: alu_control = funct7_bit5 ? 4'b0111 : 4'b0110; // SRAI : SRLI
                    3'b110: alu_control = 4'b1000; // ORI
                    3'b111: alu_control = 4'b1001; // ANDI
                    default: alu_control = 4'b0000;
                endcase
            end
          3'd2:alu_control = 4'b0000; // Load: rs1 + offset (address calculation)
          3'd3:alu_control = 4'b0000; // Store: rs1 + offset (address calculation)
          3'd4:begin
              if (funct3 == 3'b000 || funct3 == 3'b001 || funct3 == 3'b100 || funct3 == 3'b101) 
              alu_control = 4'b0001; // SUB operation for signed branches
              else 
              alu_control = 4'b1010; // SUB operation for unsigned branches
              end
    endcase
    end
endmodule
