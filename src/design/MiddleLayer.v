module FI_ID(
    input clk,
    input rst,
    input pause,
    input[31:0] pc_i,
    output[31:0] pc_o,
    input[31:0] inst_i,
    output[31:0] inst_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[31:0] pc;
    reg[31:0] inst;

    always@(posedge clk)begin
        if(pause==0)begin
            pc <= pc_i;
            inst <= inst_i;
        end
    end
    assign pc_o = pc & oe;
    assign inst_o = inst & oe;

endmodule

module ID_EX(
    input clk,
    input rst,
    input pause,
    input[0:0] cregwa_i,
    output[0:0] cregwa_o,
    input[1:0] cregwd_i,
    output[1:0] cregwd_o,
    input[0:0] regwe_i,
    output[0:0] regwe_o,
    input[1:0] aluin1_i,
    output[1:0] aluin1_o,
    input[0:0] aluin2_i,
    output[0:0] aluin2_o,
    input[3:0] alusel_i,
    output[3:0] alusel_o,
    input[1:0] memlen_i,
    output[1:0] memlen_o,
    input[0:0] memwe_i,
    output[0:0] memwe_o,
    input[31:0] imm_ext_i,
    output[31:0] imm_ext_o,
    input[31:0] sa_ext_i,
    output[31:0] sa_ext_o,
    input[31:0] rd1_i,
    output[31:0] rd1_o,
    input[31:0] rd2_i,
    output[31:0] rd2_o,
    input[4:0] rt_i,
    output[4:0] rt_o,
    input[4:0] rd_i,
    output[4:0] rd_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[0:0] cregwa;
    reg[1:0] cregwd;
    reg[0:0] regwe;
    reg[1:0] aluin1;
    reg[0:0] aluin2;
    reg[3:0] alusel;
    reg[1:0] memlen;
    reg[0:0] memwe;
    reg[31:0] imm_ext;
    reg[31:0] sa_ext;
    reg[31:0] rd1;
    reg[31:0] rd2;
    reg[4:0] rt;
    reg[4:0] rd;

    always@(posedge clk)begin
        if(pause==0)begin
            cregwa <= cregwa_i;
            cregwd <= cregwd_i;
            regwe <= regwe_i;
            aluin1 <= aluin1_i;
            aluin2 <= aluin2_i;
            alusel <= alusel_i;
            memlen <= memlen_i;
            memwe <= memwe_i;
            imm_ext <= imm_ext_i;
            sa_ext <= sa_ext_i;
            rd1 <= rd1_i;
            rd2 <= rd2_i;
            rt <= rt_i;
            rd <= rd_i;
        end
    end
    assign cregwa_o = cregwa & oe;
    assign cregwd_o = cregwd & oe;
    assign regwe_o = regwe & oe;
    assign aluin1_o = aluin1 & oe;
    assign aluin2_o = aluin2 & oe;
    assign alusel_o = alusel & oe;
    assign memlen_o = memlen & oe;
    assign memwe_o = memwe & oe;
    assign imm_ext_o = imm_ext & oe;
    assign sa_ext_o = sa_ext & oe;
    assign rd1_o = rd1 & oe;
    assign rd2_o = rd2 & oe;
    assign rt_o = rt & oe;
    assign rd_o = rd & oe;

endmodule

module EX_MEM(
    input clk,
    input rst,
    input pause,
    input[0:0] cregwa_i,
    output[0:0] cregwa_o,
    input[1:0] cregwd_i,
    output[1:0] cregwd_o,
    input[0:0] regwe_i,
    output[0:0] regwe_o,
    input[1:0] memlen_i,
    output[1:0] memlen_o,
    input[0:0] memwe_i,
    output[0:0] memwe_o,
    input[31:0] rd2_i,
    output[31:0] rd2_o,
    input[4:0] rt_i,
    output[4:0] rt_o,
    input[4:0] rd_i,
    output[4:0] rd_o,
    input[31:0] aluout_i,
    output[31:0] aluout_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[0:0] cregwa;
    reg[1:0] cregwd;
    reg[0:0] regwe;
    reg[1:0] memlen;
    reg[0:0] memwe;
    reg[31:0] rd2;
    reg[4:0] rt;
    reg[4:0] rd;
    reg[31:0] aluout;

    always@(posedge clk)begin
        if(pause==0)begin
            cregwa <= cregwa_i;
            cregwd <= cregwd_i;
            regwe <= regwe_i;
            memlen <= memlen_i;
            memwe <= memwe_i;
            rd2 <= rd2_i;
            rt <= rt_i;
            rd <= rd_i;
            aluout <= aluout_i;
        end
    end
    assign cregwa_o = cregwa & oe;
    assign cregwd_o = cregwd & oe;
    assign regwe_o = regwe & oe;
    assign memlen_o = memlen & oe;
    assign memwe_o = memwe & oe;
    assign rd2_o = rd2 & oe;
    assign rt_o = rt & oe;
    assign rd_o = rd & oe;
    assign aluout_o = aluout & oe;

endmodule

module MEM_WB(
    input clk,
    input rst,
    input pause,
    input[0:0] cregwa_i,
    output[0:0] cregwa_o,
    input[1:0] cregwd_i,
    output[1:0] cregwd_o,
    input[0:0] regwe_i,
    output[0:0] regwe_o,
    input[4:0] rt_i,
    output[4:0] rt_o,
    input[4:0] rd_i,
    output[4:0] rd_o,
    input[31:0] aluout_i,
    output[31:0] aluout_o,
    input[31:0] memrd_i,
    output[31:0] memrd_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[0:0] cregwa;
    reg[1:0] cregwd;
    reg[0:0] regwe;
    reg[4:0] rt;
    reg[4:0] rd;
    reg[31:0] aluout;
    reg[31:0] memrd;

    always@(posedge clk)begin
        if(pause==0)begin
            cregwa <= cregwa_i;
            cregwd <= cregwd_i;
            regwe <= regwe_i;
            rt <= rt_i;
            rd <= rd_i;
            aluout <= aluout_i;
            memrd <= memrd_i;
        end
    end
    assign cregwa_o = cregwa & oe;
    assign cregwd_o = cregwd & oe;
    assign regwe_o = regwe & oe;
    assign rt_o = rt & oe;
    assign rd_o = rd & oe;
    assign aluout_o = aluout & oe;
    assign memrd_o = memrd & oe;

endmodule
