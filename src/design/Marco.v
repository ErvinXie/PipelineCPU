`include "ASettings.v"

//Instructions 
`define reserved 0
`define add_inst 1
`define addu_inst 2
`define addi_inst 3
`define addiu_inst 4
`define sub_inst 5
`define subu_inst 6
`define mul_inst 7
`define mult_inst 8
`define multu_inst 9
`define div_inst 10
`define divu_inst 11
`define and_inst 12
`define andi_inst 13
`define or_inst 14
`define ori_inst 15
`define xor_inst 16
`define xori_inst 17
`define nor_inst 18
`define slt_inst 19
`define slti_inst 20
`define sltu_inst 21
`define sltiu_inst 22
`define sll_inst 23
`define srl_inst 24
`define sra_inst 25
`define sllv_inst 26
`define srlv_inst 27
`define lw_inst 28
`define sw_inst 29
`define lb_inst 30
`define sb_inst 31
`define lh_inst 32
`define sh_inst 33
`define lui_inst 34
`define mfhi_inst 35
`define mflo_inst 36
`define j_inst 37
`define jal_inst 38
`define jr_inst 39
`define beq_inst 40
`define bne_inst 41
`define blez_inst 42
`define bgtz_inst 43

//general
`define off 0
`define on 1
`define x 0

//cb 
`define none 0
`define j_br 1
`define jal_br 2
`define jr_br 3
`define beq_br 4
`define bne_br 5
`define blez_br 6
`define bgtz_br 7

//alu1 
`define rd1 0
`define sa 1
`define const16 2

//alu2 
`define rd2 0
`define imm 1

//alusel 
`define add_op 0
`define sub_op 1
`define mul_op 2
`define mulu_op 3
`define div_op 4
`define divu_op 5
`define and_op 6
`define or_op 7
`define xor_op 8
`define nor_op 9
`define lt_op 10
`define ltu_op 11
`define sl_op 12
`define srl_op 13
`define sra_op 14

//dmemwe 
`define off 0
`define on 1

//memlen 
`define word 0
`define byte 1
`define half 2

//regwa 
`define rd 0
`define rt 1

//regwd 
`define alu 0
`define memrd 1
`define hi 2
`define lo 3

//regwe 
`define on 1
`define off 0
