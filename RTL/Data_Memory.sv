`timescale 1ns / 1ps
module Data_Memory(
    input  logic        clk,
    input  logic        mem_read, mem_write,
    input  logic [6:0]  opcode,        // Instruction opcode
    input  logic [2:0]  func3,         // Function3 field
    input  logic [31:0] addr,          // 32-bit memory address
    input  logic [31:0] dataW,         // Data to be written
    output logic [31:0] dataR          // Data read from memory
);
    logic [31:0] mem [0:63];
    logic [31:0] word_data;
    logic [7:0]  byte_data;
    logic [15:0] halfword_data;
    // Word-aligned access
    assign word_data = mem[addr[31:2]];
    always_comb begin 
    dataR = 32'b0;                    
    if (mem_read && opcode == 7'd3) begin          // LOAD
    case (func3)
    // LB: Load signed byte
    3'b000: begin
    case (addr[1:0])
    2'b00: byte_data = word_data[7:0];
    2'b01: byte_data = word_data[15:8];
    2'b10: byte_data = word_data[23:16];
    2'b11: byte_data = word_data[31:24];
    endcase
    dataR = {{24{byte_data[7]}}, byte_data};
    end
    // LBU: Load unsigned byte
    3'b100: begin
    case (addr[1:0])
    2'b00: byte_data = word_data[7:0];
    2'b01: byte_data = word_data[15:8];
    2'b10: byte_data = word_data[23:16];
    2'b11: byte_data = word_data[31:24];
    endcase
    dataR = {24'b0, byte_data};
    end
    // LH: Load signed halfword
    3'b001: begin
    if (addr[0] == 1'b0) begin
    case (addr[1])
    1'b0: halfword_data = word_data[15:0];
    1'b1: halfword_data = word_data[31:16];
    endcase
    dataR = {{16{halfword_data[15]}}, halfword_data};
    end 
    end
    // LHU: Load unsigned halfword
    3'b101: begin
    if (addr[0] == 1'b0) begin
    case (addr[1])
    1'b0: halfword_data = word_data[15:0];
    1'b1: halfword_data = word_data[31:16];
    endcase
    dataR = {16'b0, halfword_data};
    end 
    end
    // LW: Load full word
    3'b010: begin
    if (addr[1:0] == 2'b00)
    dataR = word_data;
    end
    default: dataR = 32'b0;
    endcase
    end
    end    
    
    always_ff @(posedge clk) begin
        if (mem_write && opcode == 7'd35) begin             // STORE 
        case (func3)
        // SB: Store byte
        3'b000: begin
        case (addr[1:0])
        2'b00: mem[addr[31:2]][7:0]   <= dataW[7:0];
        2'b01: mem[addr[31:2]][15:8]  <= dataW[7:0];
        2'b10: mem[addr[31:2]][23:16] <= dataW[7:0];
        2'b11: mem[addr[31:2]][31:24] <= dataW[7:0];
        endcase
        end
        // SH: Store halfword
        3'b001: begin
        if (addr[0] == 1'b0) begin
        case (addr[1])
        1'b0: mem[addr[31:2]][15:0]  <= dataW[15:0];
        1'b1: mem[addr[31:2]][31:16] <= dataW[15:0];
        endcase
        end 
        end
        // SW: Store full word
        3'b010: begin
        if (addr[1:0] == 2'b00)
        mem[addr[31:2]] <= dataW;
        end
        endcase
        end
    end
    initial begin
        $readmemb("data_mem.mem", mem);
    end
endmodule
