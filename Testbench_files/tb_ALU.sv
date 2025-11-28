`timescale 1ns / 1ps
module tb_ALU;
    // DUT signals
    logic signed [31:0] operand_a;
    logic signed [31:0] operand_b;
    logic signed [3:0]  alu_control;
    logic signed [31:0] result;
    logic        zero;
    logic        overflow;
    logic        carry;
    // Instantiate the ALU
    ALU dut (
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero),
        .overflow(overflow),
        .carry(carry)
    );
    initial begin
        // Test ADD
        operand_a   = 32'd2;
        operand_b   = 32'd2;
        alu_control = 4'b0000;
        #10;
        // Test SUB 
        operand_a   = 32'd9;
        operand_b   = 32'd8;
        alu_control = 4'b0001;
        #10;
        // Test SLL
        operand_a   = 32'd1;
        operand_b   = 32'd3;   // shift amount = 3
        alu_control = 4'b0010;
        #10;
        // Test SRA
        operand_a   = 32'hF0000200;
        operand_b   = 32'd4;
        alu_control = 4'b0111;
        #10;
        $finish;

    end

endmodule
