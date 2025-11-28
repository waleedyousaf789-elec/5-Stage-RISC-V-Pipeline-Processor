`timescale 1ns / 1ps

module tb_IF_ID_Stage;

  logic clk, rst;
  logic [31:0] instruction_in_if_id, pc_plus_4_in_if_id;
  logic [31:0] instruction_out_if_id, pc_plus_4_out_if_id;

  // Instantiate DUT
  IF_ID_Stage dut (
    .clk(clk),
    .rst(rst),
    .instruction_in_if_id(instruction_in_if_id),
    .pc_plus_4_in_if_id(pc_plus_4_in_if_id),
    .instruction_out_if_id(instruction_out_if_id),
    .pc_plus_4_out_if_id(pc_plus_4_out_if_id)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;  // 10ns clock period

  initial begin
    rst = 1; instruction_in_if_id = 0; pc_plus_4_in_if_id = 0;
    #10;
    rst = 0;
    instruction_in_if_id = 32'h00000013; // addi x0,x0,0
    pc_plus_4_in_if_id   = 32'h00000004;
    #10;
    instruction_in_if_id = 32'h00400093; // addi x1,x0,4
    pc_plus_4_in_if_id   = 32'h00000008;
    #10;
    instruction_in_if_id = 32'h00208133; // add x2,x1,x2
    pc_plus_4_in_if_id   = 32'h0000000C;
    #10;
    $finish;
  end

endmodule
