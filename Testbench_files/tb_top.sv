`timescale 1ns/1ps

module tb_top;

    // Testbench signals
    logic clk;
    logic rst;

    // DUT outputs
    logic [31:0] operand_a;
    logic [31:0] operand_b;
    logic [31:0] result;
    logic [31:0] dataR;

    // Instantiate DUT
    top dut (
        .clk(clk),
        .rst(rst),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .result(result),
        .dataR(dataR)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        rst = 1;
        #10;
        rst = 0;
        #300;
        $finish;
    end
endmodule
