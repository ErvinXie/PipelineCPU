`include "Marco.v"
module Ctrl(
input clk,
input rst,
input[5:0] opcode,
input[5:0] func,
input[4:0] rt,
output[3:0] cb,
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
        (opcode==6'b001100)?`andi_inst:
        (opcode==6'b001101)?`ori_inst:
        (opcode==6'b001110)?`xori_inst:
        (opcode==6'b001010)?`slti_inst:
        (opcode==6'b001011)?`sltiu_inst:
        (opcode==6'b010011)?`lw_inst:
        (opcode==6'b101011)?`sw_inst:
        (opcode==6'b100100)?`lbu_inst:
        (opcode==6'b100000)?`lb_inst:
        (opcode==6'b101000)?`sb_inst:
        (opcode==6'b100001)?`lh_inst:
        (opcode==6'b101001)?`sh_inst:
        (opcode==6'b001111)?`lui_inst:
        (opcode==6'b000010)?`j_inst:
        (opcode==6'b000011)?`jal_inst:
        (opcode==6'b000100)?`beq_inst:
        (opcode==6'b000101)?`bne_inst:
        (opcode==6'b000110)?`blez_inst:
        (opcode==6'b000111)?`bgtz_inst:
        (opcode==6'b000001)?(
            (rt==5'b00000)?`bltz_inst:
            (rt==5'b00001)?`bgez_inst:
            `reserved):
        (opcode==6'b000000)?(
            (func==6'b100000)?`add_inst:
            (func==6'b100001)?`addu_inst:
            (func==6'b100010)?`sub_inst:
            (func==6'b100011)?`subu_inst:
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
            (func==6'b001000)?`jr_inst:
            `reserved
        ):`reserved;

        assign cb = 
        (inst_type==`add_inst)?`none:
        (inst_type==`addu_inst)?`none:
        (inst_type==`addi_inst)?`none:
        (inst_type==`addiu_inst)?`none:
        (inst_type==`sub_inst)?`none:
        (inst_type==`subu_inst)?`none:
        (inst_type==`and_inst)?`none:
        (inst_type==`andi_inst)?`none:
        (inst_type==`or_inst)?`none:
        (inst_type==`ori_inst)?`none:
        (inst_type==`xor_inst)?`none:
        (inst_type==`xori_inst)?`none:
        (inst_type==`nor_inst)?`none:
        (inst_type==`slt_inst)?`none:
        (inst_type==`slti_inst)?`none:
        (inst_type==`sltu_inst)?`none:
        (inst_type==`sltiu_inst)?`none:
        (inst_type==`sll_inst)?`none:
        (inst_type==`srl_inst)?`none:
        (inst_type==`sra_inst)?`none:
        (inst_type==`sllv_inst)?`none:
        (inst_type==`srlv_inst)?`none:
        (inst_type==`lw_inst)?`none:
        (inst_type==`sw_inst)?`none:
        (inst_type==`lbu_inst)?`none:
        (inst_type==`lb_inst)?`none:
        (inst_type==`sb_inst)?`none:
        (inst_type==`lh_inst)?`none:
        (inst_type==`sh_inst)?`none:
        (inst_type==`lui_inst)?`none:
        (inst_type==`mfhi_inst)?`none:
        (inst_type==`mflo_inst)?`none:
        (inst_type==`j_inst)?`j_br:
        (inst_type==`jal_inst)?`jal_br:
        (inst_type==`jr_inst)?`jr_br:
        (inst_type==`beq_inst)?`beq_br:
        (inst_type==`bne_inst)?`bne_br:
        (inst_type==`blez_inst)?`blez_br:
        (inst_type==`bgtz_inst)?`bgtz_br:
        (inst_type==`bltz_inst)?`bltz_br:
        (inst_type==`bgez_inst)?`bgez_br:
        0;

        assign alu1 = 
        (inst_type==`add_inst)?`rd1:
        (inst_type==`addu_inst)?`rd1:
        (inst_type==`addi_inst)?`rd1:
        (inst_type==`addiu_inst)?`rd1:
        (inst_type==`sub_inst)?`rd1:
        (inst_type==`subu_inst)?`rd1:
        (inst_type==`and_inst)?`rd1:
        (inst_type==`andi_inst)?`rd1:
        (inst_type==`or_inst)?`rd1:
        (inst_type==`ori_inst)?`rd1:
        (inst_type==`xor_inst)?`rd1:
        (inst_type==`xori_inst)?`rd1:
        (inst_type==`nor_inst)?`rd1:
        (inst_type==`slt_inst)?`rd1:
        (inst_type==`slti_inst)?`rd1:
        (inst_type==`sltu_inst)?`rd1:
        (inst_type==`sltiu_inst)?`rd1:
        (inst_type==`sll_inst)?`sa:
        (inst_type==`srl_inst)?`sa:
        (inst_type==`sra_inst)?`sa:
        (inst_type==`sllv_inst)?`rd1:
        (inst_type==`srlv_inst)?`rd1:
        (inst_type==`lw_inst)?`rd1:
        (inst_type==`sw_inst)?`rd1:
        (inst_type==`lbu_inst)?`rd1:
        (inst_type==`lb_inst)?`rd1:
        (inst_type==`sb_inst)?`rd1:
        (inst_type==`lh_inst)?`rd1:
        (inst_type==`sh_inst)?`rd1:
        (inst_type==`lui_inst)?`const16:
        (inst_type==`mfhi_inst)?`x:
        (inst_type==`mflo_inst)?`x:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign alu2 = 
        (inst_type==`add_inst)?`rd2:
        (inst_type==`addu_inst)?`rd2:
        (inst_type==`addi_inst)?`imm:
        (inst_type==`addiu_inst)?`imm:
        (inst_type==`sub_inst)?`rd2:
        (inst_type==`subu_inst)?`rd2:
        (inst_type==`and_inst)?`rd2:
        (inst_type==`andi_inst)?`imm:
        (inst_type==`or_inst)?`rd2:
        (inst_type==`ori_inst)?`imm:
        (inst_type==`xor_inst)?`rd2:
        (inst_type==`xori_inst)?`imm:
        (inst_type==`nor_inst)?`rd2:
        (inst_type==`slt_inst)?`rd2:
        (inst_type==`slti_inst)?`imm:
        (inst_type==`sltu_inst)?`rd2:
        (inst_type==`sltiu_inst)?`imm:
        (inst_type==`sll_inst)?`rd2:
        (inst_type==`srl_inst)?`rd2:
        (inst_type==`sra_inst)?`rd2:
        (inst_type==`sllv_inst)?`rd2:
        (inst_type==`srlv_inst)?`rd2:
        (inst_type==`lw_inst)?`imm:
        (inst_type==`sw_inst)?`imm:
        (inst_type==`lbu_inst)?`imm:
        (inst_type==`lb_inst)?`imm:
        (inst_type==`sb_inst)?`imm:
        (inst_type==`lh_inst)?`imm:
        (inst_type==`sh_inst)?`imm:
        (inst_type==`lui_inst)?`imm:
        (inst_type==`mfhi_inst)?`x:
        (inst_type==`mflo_inst)?`x:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign alusel = 
        (inst_type==`add_inst)?`add_op:
        (inst_type==`addu_inst)?`add_op:
        (inst_type==`addi_inst)?`add_op:
        (inst_type==`addiu_inst)?`add_op:
        (inst_type==`sub_inst)?`sub_op:
        (inst_type==`subu_inst)?`sub_op:
        (inst_type==`and_inst)?`and_op:
        (inst_type==`andi_inst)?`and_op:
        (inst_type==`or_inst)?`or_op:
        (inst_type==`ori_inst)?`or_op:
        (inst_type==`xor_inst)?`xor_op:
        (inst_type==`xori_inst)?`xor_op:
        (inst_type==`nor_inst)?`nor_op:
        (inst_type==`slt_inst)?`lt_op:
        (inst_type==`slti_inst)?`lt_op:
        (inst_type==`sltu_inst)?`ltu_op:
        (inst_type==`sltiu_inst)?`ltu_op:
        (inst_type==`sll_inst)?`sl_op:
        (inst_type==`srl_inst)?`srl_op:
        (inst_type==`sra_inst)?`sra_op:
        (inst_type==`sllv_inst)?`sl_op:
        (inst_type==`srlv_inst)?`srl_op:
        (inst_type==`lw_inst)?`add_op:
        (inst_type==`sw_inst)?`add_op:
        (inst_type==`lbu_inst)?`add_op:
        (inst_type==`lb_inst)?`add_op:
        (inst_type==`sb_inst)?`add_op:
        (inst_type==`lh_inst)?`add_op:
        (inst_type==`sh_inst)?`add_op:
        (inst_type==`lui_inst)?`sl_op:
        (inst_type==`mfhi_inst)?`x:
        (inst_type==`mflo_inst)?`x:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign dmemwe = 
        (inst_type==`add_inst)?`off:
        (inst_type==`addu_inst)?`off:
        (inst_type==`addi_inst)?`off:
        (inst_type==`addiu_inst)?`off:
        (inst_type==`sub_inst)?`off:
        (inst_type==`subu_inst)?`off:
        (inst_type==`and_inst)?`off:
        (inst_type==`andi_inst)?`off:
        (inst_type==`or_inst)?`off:
        (inst_type==`ori_inst)?`off:
        (inst_type==`xor_inst)?`off:
        (inst_type==`xori_inst)?`off:
        (inst_type==`nor_inst)?`off:
        (inst_type==`slt_inst)?`off:
        (inst_type==`slti_inst)?`off:
        (inst_type==`sltu_inst)?`off:
        (inst_type==`sltiu_inst)?`off:
        (inst_type==`sll_inst)?`off:
        (inst_type==`srl_inst)?`off:
        (inst_type==`sra_inst)?`off:
        (inst_type==`sllv_inst)?`off:
        (inst_type==`srlv_inst)?`off:
        (inst_type==`lw_inst)?`off:
        (inst_type==`sw_inst)?`on:
        (inst_type==`lbu_inst)?`off:
        (inst_type==`lb_inst)?`off:
        (inst_type==`sb_inst)?`on:
        (inst_type==`lh_inst)?`off:
        (inst_type==`sh_inst)?`on:
        (inst_type==`lui_inst)?`off:
        (inst_type==`mfhi_inst)?`off:
        (inst_type==`mflo_inst)?`off:
        (inst_type==`j_inst)?`off:
        (inst_type==`jal_inst)?`off:
        (inst_type==`jr_inst)?`off:
        (inst_type==`beq_inst)?`off:
        (inst_type==`bne_inst)?`off:
        (inst_type==`blez_inst)?`off:
        (inst_type==`bgtz_inst)?`off:
        (inst_type==`bltz_inst)?`off:
        (inst_type==`bgez_inst)?`off:
        0;

        assign memlen = 
        (inst_type==`add_inst)?`x:
        (inst_type==`addu_inst)?`x:
        (inst_type==`addi_inst)?`x:
        (inst_type==`addiu_inst)?`x:
        (inst_type==`sub_inst)?`x:
        (inst_type==`subu_inst)?`x:
        (inst_type==`and_inst)?`x:
        (inst_type==`andi_inst)?`x:
        (inst_type==`or_inst)?`x:
        (inst_type==`ori_inst)?`x:
        (inst_type==`xor_inst)?`x:
        (inst_type==`xori_inst)?`x:
        (inst_type==`nor_inst)?`x:
        (inst_type==`slt_inst)?`x:
        (inst_type==`slti_inst)?`x:
        (inst_type==`sltu_inst)?`x:
        (inst_type==`sltiu_inst)?`x:
        (inst_type==`sll_inst)?`x:
        (inst_type==`srl_inst)?`x:
        (inst_type==`sra_inst)?`x:
        (inst_type==`sllv_inst)?`x:
        (inst_type==`srlv_inst)?`x:
        (inst_type==`lw_inst)?`word:
        (inst_type==`sw_inst)?`word:
        (inst_type==`lbu_inst)?`byte:
        (inst_type==`lb_inst)?`byte:
        (inst_type==`sb_inst)?`byte:
        (inst_type==`lh_inst)?`half:
        (inst_type==`sh_inst)?`half:
        (inst_type==`lui_inst)?`x:
        (inst_type==`mfhi_inst)?`x:
        (inst_type==`mflo_inst)?`x:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign regwa = 
        (inst_type==`add_inst)?`rd:
        (inst_type==`addu_inst)?`rd:
        (inst_type==`addi_inst)?`rt:
        (inst_type==`addiu_inst)?`rt:
        (inst_type==`sub_inst)?`rd:
        (inst_type==`subu_inst)?`rd:
        (inst_type==`and_inst)?`rd:
        (inst_type==`andi_inst)?`rt:
        (inst_type==`or_inst)?`rd:
        (inst_type==`ori_inst)?`rt:
        (inst_type==`xor_inst)?`rd:
        (inst_type==`xori_inst)?`rt:
        (inst_type==`nor_inst)?`rd:
        (inst_type==`slt_inst)?`rd:
        (inst_type==`slti_inst)?`rt:
        (inst_type==`sltu_inst)?`rd:
        (inst_type==`sltiu_inst)?`rt:
        (inst_type==`sll_inst)?`rd:
        (inst_type==`srl_inst)?`rd:
        (inst_type==`sra_inst)?`rd:
        (inst_type==`sllv_inst)?`rd:
        (inst_type==`srlv_inst)?`rd:
        (inst_type==`lw_inst)?`rt:
        (inst_type==`sw_inst)?`x:
        (inst_type==`lbu_inst)?`rt:
        (inst_type==`lb_inst)?`rt:
        (inst_type==`sb_inst)?`x:
        (inst_type==`lh_inst)?`rt:
        (inst_type==`sh_inst)?`x:
        (inst_type==`lui_inst)?`rt:
        (inst_type==`mfhi_inst)?`rd:
        (inst_type==`mflo_inst)?`rd:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign regwd = 
        (inst_type==`add_inst)?`alu:
        (inst_type==`addu_inst)?`alu:
        (inst_type==`addi_inst)?`alu:
        (inst_type==`addiu_inst)?`alu:
        (inst_type==`sub_inst)?`alu:
        (inst_type==`subu_inst)?`alu:
        (inst_type==`and_inst)?`alu:
        (inst_type==`andi_inst)?`alu:
        (inst_type==`or_inst)?`alu:
        (inst_type==`ori_inst)?`alu:
        (inst_type==`xor_inst)?`alu:
        (inst_type==`xori_inst)?`alu:
        (inst_type==`nor_inst)?`alu:
        (inst_type==`slt_inst)?`alu:
        (inst_type==`slti_inst)?`alu:
        (inst_type==`sltu_inst)?`alu:
        (inst_type==`sltiu_inst)?`alu:
        (inst_type==`sll_inst)?`alu:
        (inst_type==`srl_inst)?`alu:
        (inst_type==`sra_inst)?`alu:
        (inst_type==`sllv_inst)?`alu:
        (inst_type==`srlv_inst)?`alu:
        (inst_type==`lw_inst)?`memrd:
        (inst_type==`sw_inst)?`x:
        (inst_type==`lbu_inst)?`memrd:
        (inst_type==`lb_inst)?`memrd:
        (inst_type==`sb_inst)?`x:
        (inst_type==`lh_inst)?`memrd:
        (inst_type==`sh_inst)?`x:
        (inst_type==`lui_inst)?`alu:
        (inst_type==`mfhi_inst)?`hi:
        (inst_type==`mflo_inst)?`lo:
        (inst_type==`j_inst)?`x:
        (inst_type==`jal_inst)?`x:
        (inst_type==`jr_inst)?`x:
        (inst_type==`beq_inst)?`x:
        (inst_type==`bne_inst)?`x:
        (inst_type==`blez_inst)?`x:
        (inst_type==`bgtz_inst)?`x:
        (inst_type==`bltz_inst)?`x:
        (inst_type==`bgez_inst)?`x:
        0;

        assign regwe = 
        (inst_type==`add_inst)?`on:
        (inst_type==`addu_inst)?`on:
        (inst_type==`addi_inst)?`on:
        (inst_type==`addiu_inst)?`on:
        (inst_type==`sub_inst)?`on:
        (inst_type==`subu_inst)?`on:
        (inst_type==`and_inst)?`on:
        (inst_type==`andi_inst)?`on:
        (inst_type==`or_inst)?`on:
        (inst_type==`ori_inst)?`on:
        (inst_type==`xor_inst)?`on:
        (inst_type==`xori_inst)?`on:
        (inst_type==`nor_inst)?`on:
        (inst_type==`slt_inst)?`on:
        (inst_type==`slti_inst)?`on:
        (inst_type==`sltu_inst)?`on:
        (inst_type==`sltiu_inst)?`on:
        (inst_type==`sll_inst)?`on:
        (inst_type==`srl_inst)?`on:
        (inst_type==`sra_inst)?`on:
        (inst_type==`sllv_inst)?`on:
        (inst_type==`srlv_inst)?`on:
        (inst_type==`lw_inst)?`on:
        (inst_type==`sw_inst)?`off:
        (inst_type==`lbu_inst)?`on:
        (inst_type==`lb_inst)?`on:
        (inst_type==`sb_inst)?`off:
        (inst_type==`lh_inst)?`on:
        (inst_type==`sh_inst)?`off:
        (inst_type==`lui_inst)?`on:
        (inst_type==`mfhi_inst)?`on:
        (inst_type==`mflo_inst)?`on:
        (inst_type==`j_inst)?`off:
        (inst_type==`jal_inst)?`on:
        (inst_type==`jr_inst)?`off:
        (inst_type==`beq_inst)?`off:
        (inst_type==`bne_inst)?`off:
        (inst_type==`blez_inst)?`off:
        (inst_type==`bgtz_inst)?`off:
        (inst_type==`bltz_inst)?`off:
        (inst_type==`bgez_inst)?`off:
        0;

endmodule