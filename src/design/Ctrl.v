`include "Marco.v"
module Ctrl(
input clk,
input rst,
input[5:0] opcode,
input[5:0] func,
output[2:0] cb,
output[1:0] alu1,
output[0:0] alu2,
output[3:0] alusel,
output[0:0] dmemwe,
output[1:0] memlen,
output[0:0] regwa,
output[1:0] regwd,
output[0:0] regwe);


    wire[5:0] inst_type;
    assign inst_type = 
        (opcode==6'b001000)?`addi_inst:
        (opcode==6'b001001)?`addiu_inst:
        (opcode==6'b011100)?`mul_inst:
        (opcode==6'b001100)?`andi_inst:
        (opcode==6'b001101)?`ori_inst:
        (opcode==6'b001110)?`xori_inst:
        (opcode==6'b001010)?`slti_inst:
        (opcode==6'b001011)?`sltiu_inst:
        (opcode==6'b010011)?`lw_inst:
        (opcode==6'b101011)?`sw_inst:
        (opcode==6'b100000)?`lb_inst:
        (opcode==6'b101000)?`sb_inst:
        (opcode==6'b100001)?`lh_inst:
        (opcode==6'b101001)?`sh_inst:
        (opcode==6'b001111)?`lui_inst:
        (opcode==6'b000010)?`j_inst:
        (opcode==6'b000100)?`beq_inst:
        (opcode==6'b000101)?`bne_inst:
        (opcode==6'b000110)?`blez_inst:
        (opcode==6'b000111)?`bgtz_inst:
        (opcode==6'b000000)?(
            (func==6'b100000)?`add_inst:
            (func==6'b100001)?`addu_inst:
            (func==6'b100010)?`sub_inst:
            (func==6'b100011)?`subu_inst:
            (func==6'b011000)?`mult_inst:
            (func==6'b011001)?`multu_inst:
            (func==6'b011010)?`div_inst:
            (func==6'b011011)?`divu_inst:
            (func==6'b100100)?`and_inst:
            (func==6'b100101)?`or_inst:
            (func==6'b100110)?`xor_inst:
            (func==6'b100111)?`nor_inst:
            (func==6'b101010)?`slt_inst:
            (func==6'b101011)?`sltu_inst:
            (func==6'b000000)?`sll_inst:
            (func==6'b000010)?`srl_inst:
            (func==6'b000011)?`sra_inst:
            (func==6'b000100)?`sllv_inst:
            (func==6'b000110)?`srlv_inst:
            (func==6'b010000)?`mfhi_inst:
            (func==6'b010010)?`mflo_inst:
            `reserved
        ):`reserved;

endmodule