`timescale 1ns / 1ps
module Register_File        // 32-bit registers (0..31)
(
    input  logic        clk,
    input  logic        RegWEn,          // Write enable
    input  logic [4:0]  rs1_add,         // Selector for rs1
    input  logic [4:0]  rs2_add,         // Selector for rs2
    input  logic [4:0]  rd_add,          // Selector for write register
    input  logic [31:0] dataW,           // Data to be written
    output logic [31:0]  rs1,             // Data out from rs1
    output logic [31:0]  rs2              // Data out from rs2
);
    // Register file: 32 registers of 32 bits
    logic [31:0] mem [0:31];
    // Write on rising edge if enabled and not register 0
   always_ff @(negedge clk) begin
        if (RegWEn) begin
            if (rd_add == 0) 
                mem[0] <=0;       // Hardwired 0
            else 
                mem[rd_add] <= dataW;
        end
    end
    // Asynchronous read
    assign rs1 = mem[rs1_add];
    assign rs2 = mem[rs2_add];
    // Initialize (optional)
    initial begin
        $readmemb("rom_image_bin.mem", mem);
    end
endmodule
