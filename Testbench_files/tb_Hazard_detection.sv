`timescale 1ns / 1ps
module tb_Hazard_detection;
    // Inputs
    logic [4:0] rs1_id_ex, rs2_id_ex, rd_ex_mem, rd_mem_wb;
    logic reg_write_ex_mem, reg_write_mem_wb, mem_read_id_ex;
    logic [4:0] rd_id_ex, rs1_if_id, rs2_if_id;
    logic branch_ex_mem, jump_ex_mem, branch_taken;

    // Outputs
    logic [1:0] forward_A, forward_B;
    logic pc_write, retain_if_id, flush_if_id, flush_id_ex, flush_ex_mem;

    // DUT
    Hazard_detection dut(
        .rs1_id_ex(rs1_id_ex), .rs2_id_ex(rs2_id_ex),
        .rd_ex_mem(rd_ex_mem), .rd_mem_wb(rd_mem_wb),
        .reg_write_ex_mem(reg_write_ex_mem), .reg_write_mem_wb(reg_write_mem_wb),
        .mem_read_id_ex(mem_read_id_ex), .rd_id_ex(rd_id_ex),
        .rs1_if_id(rs1_if_id), .rs2_if_id(rs2_if_id),
        .branch_ex_mem(branch_ex_mem), .jump_ex_mem(jump_ex_mem),
        .branch_taken(branch_taken),
        .forward_A(forward_A), .forward_B(forward_B),
        .pc_write(pc_write), .retain_if_id(retain_if_id),
        .flush_if_id(flush_if_id), .flush_id_ex(flush_id_ex), .flush_ex_mem(flush_ex_mem)
    );

    initial begin
        // Case 1: Forwarding from EX/MEM
        rs1_id_ex=5; rd_ex_mem=5; reg_write_ex_mem=1;
        rs2_id_ex=0; rd_mem_wb=0; reg_write_mem_wb=0;
        mem_read_id_ex=0; rd_id_ex=0; rs1_if_id=0; rs2_if_id=0;
        branch_ex_mem=0; jump_ex_mem=0; branch_taken=0;
        #10;

        // Case 2: Forwarding from MEM/WB
        rs1_id_ex=3; rd_mem_wb=3; reg_write_mem_wb=1;
        rd_ex_mem=0; reg_write_ex_mem=0;
        #10;

        // Case 3: Stall due to load-use hazard
        mem_read_id_ex=1; rd_id_ex=6; rs1_if_id=6; rs2_if_id=0;
        #10;

        // Case 4: Flush on branch taken
        mem_read_id_ex=0; branch_taken=1;
        #10;

        // Case 5: Flush on jump
        branch_taken=0; jump_ex_mem=1;
        #10;

        $finish;
    end
endmodule
