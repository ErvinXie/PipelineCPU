module FI_ID(
    input clk,
    input rst,
    input pause,
    input[32:0] pc_i,
    output[32:0] pc_o,
    input[32:0] inst_i,
    output[32:0] inst_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[32:0] pc;
    reg[32:0] inst;

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
    input[1:0] regwe_i,
    output[1:0] regwe_o,
    input[4:0] alusel_i,
    output[4:0] alusel_o,
    input[2:0] memlen_i,
    output[2:0] memlen_o,
    input[1:0] memwe_i,
    output[1:0] memwe_o,
    input[32:0] imm_ext_i,
    output[32:0] imm_ext_o,
    input[32:0] sa_ext_i,
    output[32:0] sa_ext_o,
    input[32:0] rd1_i,
    output[32:0] rd1_o,
    input[32:0] rd2_i,
    output[32:0] rd2_o,
    input[5:0] rt_i,
    output[5:0] rt_o,
    input[5:0] rd_i,
    output[5:0] rd_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[1:0] regwe;
    reg[4:0] alusel;
    reg[2:0] memlen;
    reg[1:0] memwe;
    reg[32:0] imm_ext;
    reg[32:0] sa_ext;
    reg[32:0] rd1;
    reg[32:0] rd2;
    reg[5:0] rt;
    reg[5:0] rd;

    always@(posedge clk)begin
        if(pause==0)begin
            regwe <= regwe_i;
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
    assign regwe_o = regwe & oe;
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
    input[1:0] regwe_i,
    output[1:0] regwe_o,
    input[2:0] memlen_i,
    output[2:0] memlen_o,
    input[1:0] memwe_i,
    output[1:0] memwe_o,
    input[32:0] rd2_i,
    output[32:0] rd2_o,
    input[5:0] rt_i,
    output[5:0] rt_o,
    input[5:0] rd_i,
    output[5:0] rd_o,
    input[32:0] aluout_i,
    output[32:0] aluout_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[1:0] regwe;
    reg[2:0] memlen;
    reg[1:0] memwe;
    reg[32:0] rd2;
    reg[5:0] rt;
    reg[5:0] rd;
    reg[32:0] aluout;

    always@(posedge clk)begin
        if(pause==0)begin
            regwe <= regwe_i;
            memlen <= memlen_i;
            memwe <= memwe_i;
            rd2 <= rd2_i;
            rt <= rt_i;
            rd <= rd_i;
            aluout <= aluout_i;
        end
    end
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
    input[1:0] regwe_i,
    output[1:0] regwe_o,
    input[5:0] rt_i,
    output[5:0] rt_o,
    input[5:0] rd_i,
    output[5:0] rd_o,
    input[32:0] aluout_i,
    output[32:0] aluout_o,
    input[32:0] memrd_i,
    output[32:0] memrd_o
);

    wire[31:0] oe;
    assign oe = ~{32{pause}};
    reg[1:0] regwe;
    reg[5:0] rt;
    reg[5:0] rd;
    reg[32:0] aluout;
    reg[32:0] memrd;

    always@(posedge clk)begin
        if(pause==0)begin
            regwe <= regwe_i;
            rt <= rt_i;
            rd <= rd_i;
            aluout <= aluout_i;
            memrd <= memrd_i;
        end
    end
    assign regwe_o = regwe & oe;
    assign rt_o = rt & oe;
    assign rd_o = rd & oe;
    assign aluout_o = aluout & oe;
    assign memrd_o = memrd & oe;

endmodule

