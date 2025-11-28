`timescale 1ns / 1ps

module MEM_WB_Stage_tb();
  logic clk, rst;
  logic [31:0] result_in_mem_wb, read_data_in_mem_wb;
  logic mem_to_reg_in_mem_wb;
  logic [4:0] rd_in_mem_wb;
  logic reg_write_in_mem_wb;
  logic [31:0] result_out_mem_wb, read_data_out_mem_wb;
  logic mem_to_reg_out_mem_wb;
  logic [4:0] rd_out_mem_wb;
  logic reg_write_out_mem_wb;
  // DUT instantiation
  MEM_WB_Stage dut(
    .clk(clk), .rst(rst),
    .result_in_mem_wb(result_in_mem_wb),
    .read_data_in_mem_wb(read_data_in_mem_wb),
    .mem_to_reg_in_mem_wb(mem_to_reg_in_mem_wb),
    .rd_in_mem_wb(rd_in_mem_wb),
    .reg_write_in_mem_wb(reg_write_in_mem_wb),
    .result_out_mem_wb(result_out_mem_wb),
    .read_data_out_mem_wb(read_data_out_mem_wb),
    .mem_to_reg_out_mem_wb(mem_to_reg_out_mem_wb),
    .rd_out_mem_wb(rd_out_mem_wb),
    .reg_write_out_mem_wb(reg_write_out_mem_wb)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0; rst = 1;
    result_in_mem_wb = 0; read_data_in_mem_wb = 0;
    mem_to_reg_in_mem_wb = 0; rd_in_mem_wb = 0; reg_write_in_mem_wb = 0;
    #10 rst = 0; // Release reset
    // Test case 1
    result_in_mem_wb = 32'hAAAA_BBBB;
    read_data_in_mem_wb = 32'h1111_2222;
    mem_to_reg_in_mem_wb = 1;
    rd_in_mem_wb = 5'd10;
    reg_write_in_mem_wb = 1;
    #10;
    $finish;
  end

endmodule
