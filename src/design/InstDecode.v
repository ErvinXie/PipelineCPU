

module InstDecode(
    input clk,
    input rst,
    input[31:0] inst,
    input[31:0] pc,

    input[0:0] WB_we,
    input[4:0] WB_wa,
    input[31:0] WB_wd,

    input[1:0] cregwd_ex,

    input we_ex,
    input[4:0] wa_ex,
    input[31:0] wd_ex,   
    input we_me,
    input[4:0] wa_me,
    input[31:0] wd_me,   
    input we_wb,
    input[4:0] wa_wb,
    input[31:0] wd_wb,

    output pause,

    output[31:0] newPC_o,

    output[3:0] cb_o,

    output[0:0] cregwa_o,
 
    output[1:0] cregwd_o,

    output[0:0] regwe_o,
 
    output[1:0] aluin1_o,

    output[0:0] aluin2_o,

    output[3:0] alusel_o,

    output[2:0] memlen_o,
 
    output[0:0] memwe_o,

    output[31:0] imm_ext_o,

    output[31:0] sa_ext_o,
 
    output[31:0] rd1_o,
 
    output[31:0] rd2_o,

    output[4:0] rt_o,
  
    output[4:0] rd_o

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

    assign imm_ext = {16'hffff & {16{imm[15]}},imm};
    assign imm_ext_o = imm_ext;
    assign sa_ext = {27'h0000000 & {27{sa[4]}},sa};

    wire[25:0] instr_index;
    assign instr_index = inst[25:0];


    wire[3:0] cb;


    wire[3:0] alusel;
    wire[0:0] dmemwe;
    wire[2:0] memlen;
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
        aluin1_o,
        aluin2_o,
        alusel,
        dmemwe,
        memlen,
        regwa,
        regwd,
        regwe
    );

 
    wire[31:0] rd1,rd2;
    wire ra_we;
    wire[31:0] br_ra_w;

    RegFile u_regfile(
        clk,
        rst,
        WB_we,
        rs,
        rt,
        WB_wa,
        rd1,
        rd2,
        WB_wd,

        cregwd_ex,

        pause,

        we_ex,
        wa_ex,
        wd_ex,

        we_me,
        wa_me,
        wd_me,

        we_wb,
        wa_wb,
        wd_wb,

        ra_we,
        br_ra_w

    );

    wire[31:0] newPC;
    Br u_br(
        pc,
        instr_index,
        offset,
        rd1,
        rd2,
        cb,
        newPC,
        ra_we,
        br_ra_w
    );



    assign newPC_o = newPC;
    assign cb_o = cb;
    assign regwe_o = regwe;
    assign cregwa_o = regwa;
    assign cregwd_o = regwd;
    assign alusel_o = alusel;
    assign memlen_o = memlen;
    assign memwe_o = dmemwe;
    assign sa_ext_o = sa_ext;
    assign rd1_o = rd1;
    assign rd2_o = rd2;
    assign rt_o = rt;
    assign rd_o = rd;


endmodule