`timescale 1ns / 1ps
module tb_Data_Memory;
    logic clk;
    logic mem_read, mem_write;
    logic [6:0] opcode;
    logic [2:0] func3;
    logic [31:0] addr, dataW;
    logic [31:0] dataR;
    Data_Memory dut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .opcode(opcode),
        .func3(func3),
        .addr(addr),
        .dataW(dataW),
        .dataR(dataR)
    );

    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        // Init
        mem_read  = 0;
        mem_write = 0;
        opcode    = 0;
        func3     = 0;
        addr      = 0;
        dataW     = 0;
        #10;
        mem_read = 1;
        opcode   = 7'd3;    
        func3    = 3'b000;  
        addr     = 32'd0; // LB 0 from that memory location
        #10;
        mem_read = 1;
        opcode   = 7'd3;    
        func3    = 3'b000;  
        addr     = 32'd1; // LB 1 from that memory location
        #10;
        mem_read = 1;
        opcode   = 7'd3;    
        func3    = 3'b000;  
        addr     = 32'd2; // LB 2 from that memory location
        #10;
        mem_read = 1;
        opcode   = 7'd3;    
        func3    = 3'b000;  
        addr     = 32'd3; // LB 3 from that memory location
        #10;
        mem_read = 1;
        opcode   = 7'd3;    
        func3    = 3'b000;  
        addr     = 32'd4; // LB 3 from that memory location
        #10;
        $finish;
    end
endmodule
