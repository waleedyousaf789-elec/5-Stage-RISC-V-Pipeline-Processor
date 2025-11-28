`timescale 1ns / 1ps
module Register_File_tb;
    logic clk;
    logic RegWEn;
    logic [4:0] rs1_add, rs2_add, rd_add;
    logic [31:0] dataW;
    logic [31:0] rs1, rs2;
    // Instantiate the Register File
    Register_File rf (
        .clk(clk),
        .RegWEn(RegWEn),
        .rs1_add(rs1_add),
        .rs2_add(rs2_add),
        .rd_add(rd_add),
        .dataW(dataW),
        .rs1(rs1),
        .rs2(rs2)
    );
    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        // Initialize inputs
        RegWEn = 0;
        rs1_add =5'd1;
        rs2_add = 0;
        rd_add = 0;
        dataW = 0;
        #10
        rs1_add =5'd1;
        rs2_add = 5'd2;
        #10;
        RegWEn = 1;
        rd_add = 3;
        dataW = 32'h12345678;
        #10;
        rs1_add =5'd3;
        #10;
        $finish;
    end

endmodule
