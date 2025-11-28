module branch_comparison (
    input  logic        jump,
    input  logic        branch,
    input  logic        zero,
    input  logic        less_than,
    input  logic [2:0]  func3,
    input  logic [6:0]  op_ex,
    input  logic [31:0] jal_target,
    input  logic [31:0] jalr_target,
    input  logic [31:0] pc_next,
    input  logic        U_type,
    input  logic [6:0]  op_wb,
    input  logic [31:0] imm_wb,
    input  logic [31:0] alu_result_wb,
    input  logic        mem_to_reg,
    input  logic [31:0] mem_data,

    output logic [31:0] next_pc,
    output logic [31:0] write_back_data,
    output logic branch_taken
);

    // Next PC logic
    always_comb begin
    branch_taken=0;
        if (jump) begin
            case (op_ex)
                7'd111: next_pc = jal_target;
                7'd103: next_pc = jalr_target;
                default: next_pc = pc_next;
            endcase
        end
        else if (branch) begin
            case (func3)
                3'b000: begin
                        next_pc = zero ? jal_target : pc_next;
                        branch_taken=zero;
                        end
                3'b001: begin
                        next_pc = ~zero ? jal_target : pc_next;
                        branch_taken=~zero;
                        end
                3'b100: begin
                        next_pc = less_than ? jal_target : pc_next;
                        branch_taken=less_than;
                        end
                3'b101: begin
                        next_pc = (~less_than || zero) ? jal_target : pc_next;
                        branch_taken=(~less_than || zero);
                        end
                3'b110: begin 
                        next_pc = less_than ? jal_target : pc_next;
                        branch_taken=less_than;
                        end
                3'b111: begin 
                        next_pc = (~less_than || zero) ? jal_target : pc_next;
                        branch_taken=(~less_than || zero) ;
                        end
                default:next_pc = pc_next;
            endcase
        end
        else next_pc = pc_next;
    end

    // Write-back Mux
    always_comb begin
        if (U_type) begin
            case (op_wb)
                7'd55: write_back_data = imm_wb;
                7'd23: write_back_data = jal_target;
                default: write_back_data = alu_result_wb;
            endcase
        end else begin
            write_back_data = jump ? pc_next :
                              mem_to_reg ? mem_data :
                              alu_result_wb;
        end
    end

endmodule
