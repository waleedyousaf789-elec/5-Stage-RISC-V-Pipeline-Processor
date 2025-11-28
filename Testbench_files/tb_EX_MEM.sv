`timescale 1ns / 1ps

module tb_EX_MEM_Stage;

  // Inputs
  logic clk, rst;
  logic [31:0] jal_target_in_ex_mem, result_in_ex_mem, rd_data_2_in_ex_mem;
  logic zero_in_ex_mem, less_than_in_ex_mem;
  logic mem_read_in_ex_mem, mem_write_in_ex_mem, mem_to_reg_in_ex_mem, reg_write_in_ex_mem;
  logic branch_in_ex_mem, jump_in_ex_mem, U_type_in_ex_mem;
  logic [4:0] rd_in_ex_mem;
  logic [6:0] op_in_ex_mem;
  logic [2:0] func3_in_ex_mem;

  // Outputs
  logic [31:0] jal_target_out_ex_mem, result_out_ex_mem, rd_data_2_out_ex_mem;
  logic zero_out_ex_mem, less_than_out_ex_mem;
  logic mem_read_out_ex_mem, mem_write_out_ex_mem, mem_to_reg_out_ex_mem, reg_write_out_ex_mem;
  logic branch_out_ex_mem, jump_out_ex_mem, U_type_out_ex_mem;
  logic [4:0] rd_out_ex_mem;
  logic [6:0] op_out_ex_mem;
  logic [2:0] func3_out_ex_mem;

  // DUT instantiation
  EX_MEM_Stage dut (
    .clk(clk), .rst(rst),
    .jal_target_in_ex_mem(jal_target_in_ex_mem),
    .result_in_ex_mem(result_in_ex_mem),
    .rd_data_2_in_ex_mem(rd_data_2_in_ex_mem),
    .zero_in_ex_mem(zero_in_ex_mem),
    .less_than_in_ex_mem(less_than_in_ex_mem),
    .mem_read_in_ex_mem(mem_read_in_ex_mem),
    .mem_write_in_ex_mem(mem_write_in_ex_mem),
    .mem_to_reg_in_ex_mem(mem_to_reg_in_ex_mem),
    .reg_write_in_ex_mem(reg_write_in_ex_mem),
    .branch_in_ex_mem(branch_in_ex_mem),
    .jump_in_ex_mem(jump_in_ex_mem),
    .U_type_in_ex_mem(U_type_in_ex_mem),
    .rd_in_ex_mem(rd_in_ex_mem),
    .op_in_ex_mem(op_in_ex_mem),
    .func3_in_ex_mem(func3_in_ex_mem),

    .jal_target_out_ex_mem(jal_target_out_ex_mem),
    .result_out_ex_mem(result_out_ex_mem),
    .rd_data_2_out_ex_mem(rd_data_2_out_ex_mem),
    .zero_out_ex_mem(zero_out_ex_mem),
    .less_than_out_ex_mem(less_than_out_ex_mem),
    .mem_read_out_ex_mem(mem_read_out_ex_mem),
    .mem_write_out_ex_mem(mem_write_out_ex_mem),
    .mem_to_reg_out_ex_mem(mem_to_reg_out_ex_mem),
    .reg_write_out_ex_mem(reg_write_out_ex_mem),
    .branch_out_ex_mem(branch_out_ex_mem),
    .jump_out_ex_mem(jump_out_ex_mem),
    .U_type_out_ex_mem(U_type_out_ex_mem),
    .rd_out_ex_mem(rd_out_ex_mem),
    .op_out_ex_mem(op_out_ex_mem),
    .func3_out_ex_mem(func3_out_ex_mem)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk; // 10ns period

  initial begin
    rst = 1;
    jal_target_in_ex_mem = 0;
    result_in_ex_mem = 0;
    rd_data_2_in_ex_mem = 0;
    zero_in_ex_mem = 0;
    less_than_in_ex_mem = 0;
    mem_read_in_ex_mem = 0;
    mem_write_in_ex_mem = 0;
    mem_to_reg_in_ex_mem = 0;
    reg_write_in_ex_mem = 0;
    branch_in_ex_mem = 0;
    jump_in_ex_mem = 0;
    U_type_in_ex_mem = 0;
    rd_in_ex_mem = 0;
    op_in_ex_mem = 0;
    func3_in_ex_mem = 0;
    #10;
    jal_target_in_ex_mem = 32'h0000_0200;
    result_in_ex_mem = 32'hDEAD_BEEF;
    rd_data_2_in_ex_mem = 32'h8765_4321;
    zero_in_ex_mem = 0;
    less_than_in_ex_mem = 1;
    mem_read_in_ex_mem = 0;
    mem_write_in_ex_mem = 1;
    mem_to_reg_in_ex_mem = 0;
    reg_write_in_ex_mem = 0;
    branch_in_ex_mem = 1;
    jump_in_ex_mem = 0;
    U_type_in_ex_mem = 1;
    rd_in_ex_mem = 5'd5;
    op_in_ex_mem = 7'h13;
    func3_in_ex_mem = 3'b100;
    #10;
    $finish;
  end

endmodule
