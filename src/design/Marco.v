`include "ASettings.v"

//Instructions 
`define reserved 0
`define add_inst 1
`define addu_inst 2
`define addi_inst 3
`define addiu_inst 4
`define sub_inst 5
`define subu_inst 6
`define and_inst 7
`define andi_inst 8
`define or_inst 9
`define ori_inst 10
`define xor_inst 11
`define xori_inst 12
`define nor_inst 13
`define slt_inst 14
`define slti_inst 15
`define sltu_inst 16
`define sltiu_inst 17
`define sll_inst 18
`define srl_inst 19
`define sra_inst 20
`define sllv_inst 21
`define srlv_inst 22
`define lw_inst 23
`define sw_inst 24
`define lb_inst 25
`define sb_inst 26
`define lh_inst 27
`define sh_inst 28
`define lui_inst 29
`define mfhi_inst 30
`define mflo_inst 31
`define j_inst 32
`define jal_inst 33
`define jr_inst 34
`define beq_inst 35
`define bne_inst 36
`define blez_inst 37
`define bgtz_inst 38
`define bltz_inst 39
`define bgez_inst 40

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
`define bltz_br 8
`define bgez_br 9

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
`define and_op 2
`define or_op 3
`define xor_op 4
`define nor_op 5
`define lt_op 6
`define ltu_op 7
`define sl_op 8
`define srl_op 9
`define sra_op 10

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
