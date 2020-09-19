

module InstDecode(
    input clk,
    input rst,
    input[31:0] inst
);
    wire[4:0] sa,rs,rt,rd,base;
    assign sa = inst[10:6];
    assign rs = inst[25:21];
    assign base = inst [25:21];
    assign rd = inst[15:11];

    wire [5:0] opcode,func;
    assign opcode = inst[31:26];
    assign func = inst [5:0];

    wire[15:0] imm,offset;
    assign imm = inst[15:0];
    assign offset = imm;
    wire[31:0] imm_ext,sa_ext;

    assign imm_ext = {16'hffff & imm[15],imm};
    assign sa_ext = {27'hfffffff & sa[4],sa};

    wire[25:0] instr_index;
    assign instr_index = inst[25:0];




endmodule