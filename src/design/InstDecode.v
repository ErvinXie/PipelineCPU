

module InstDecode(
    input clk,
    input rst,
    input[31:0] inst,

    output[1:0] regwe_o,
    output[4:0] alusel_o,
    output[2:0] memlen_o,
    output[1:0] memwe_o,
    output[32:0] imm_ext_o,
    output[32:0] sa_ext_o,
    output[32:0] rd1_o,
    output[32:0] rd2_o,
    output[5:0] rt_o,
    output[5:0] rd_o

);
    wire[4:0] sa,rs,rt,rd,base;
    assign sa = inst[10:6];
    assign rs = inst[25:21];
    assign base = inst [25:21];
    assign rt = inst[20:16];
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


    wire[2:0] cb;
    wire[1:0] alu1;
    wire[0:0] alu2;
    wire[3:0] alusel;
    wire[0:0] dmemwe;
    wire[1:0] memlen;
    wire[0:0] regwa;
    wire[1:0] regwd;
    wire[0:0] regwe;


    Ctrl u_ctrl(
        clk,
        rst,
        opcode,
        func,
        rt,
        cb,
        alu1,
        alu2,
        alusel,
        dmemwe,
        memlen,
        regwa,
        regwd,
        regwe
    );

    wire[4:0] regwa_mux_o;
    wire[31:0] rd1,rd2,wd,w_ra,r_ra;
    mux2#(5) regwa_mux(
        rd,
        rt,
        regwa,
        regwa_mux_o
    );

    wire[31:0] regwd_mux_o;
    mux4 regwd_mux(
        alu,
        memrd,
        hi,
        lo,
        regwd,
        regwd_mux_o
    );

    RegFile u_regfile(
        clk,
        rst,
        regwe,
        rs,
        rt,
        regwa_mux_o,
        rd1,
        rd2,
        regwd_mux_o,
        w_ra,
        r_ra
    );

    

    assign regwe_o = regwe;
    assign alusel_o = alusel;
    assign memlen_o = memlen;
    assign memwe_o = dmemwe;
    assign sa_ext_o = sa_ext;
    assign rd1_o = rd1;
    assign rd2_o = rd2;
    assign rt_o = rt;
    assign rd_o = rd;


endmodule