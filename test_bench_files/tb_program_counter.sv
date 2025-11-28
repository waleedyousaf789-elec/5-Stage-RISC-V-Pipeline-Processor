`timescale 1ns / 1ps
module tb_Program_Counter;
    logic clk;
    logic rst;
    logic [31:0] next_pc;
    logic [31:0] pc;
    logic pc_write;
    Program_Counter pc_inst (
        .clk(clk),
        .pc_write(pc_write),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        rst = 1;
        next_pc = 0;
        pc_write=1;
        #15;
        rst = 0;
        pc_write=1;
        #10 next_pc = 32'd4;
        #10 next_pc = 32'd8;
        pc_write=0;            //pc_write 0_will halt
        #20 next_pc = 32'd16;  // Simulate jump to 16
        #10 next_pc = 32'd20;
        pc_write=1;           //pc_write 1_will continue normal incrementation
        #10 next_pc = 32'd24;
        #10 $finish;
    end
endmodule
