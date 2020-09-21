`include "Marco.v"
module Execute(
    input clk,
    input rst,

    
    input[0:0] cregwa_i,
  
    input[1:0] cregwd_i,

    input[0:0] regwe_i,

    input[1:0] aluin1_i,

    input[0:0] aluin2_i,
    
    input[3:0] alusel_i,
   
    input[1:0] memlen_i,
 
    input[0:0] memwe_i,

    input[31:0] imm_ext_i,
  
    input[31:0] sa_ext_i,
    
    input[31:0] rd1_i,
   
    input[31:0] rd2_i,

    input[4:0] rt_i,

    input[4:0] rd_i,

    output[1:0] cwd_ex,
    output we_ex,
    
    output[4:0] wa_ex,
    output[31:0] wd_ex,


    output[0:0] cregwa_o,

    output[1:0] cregwd_o,
    
    output[0:0] regwe_o,
    
    output[1:0] memlen_o,
    
    output[0:0] memwe_o,
    
    output[31:0] rd2_o,
    
    output[4:0] rt_o,
    
    output[4:0] rd_o,
    
    output[31:0] aluout_o
);
    assign cregwa_o = cregwa_i;
    assign cregwd_o = cregwd_i;
    assign regwe_o = regwe_i;
    assign memlen_o = memlen_i;
    assign memwe_o = memwe_i;
    assign rd2_o = rd2_i;
    assign rt_o = rt_i;
    assign rd_o = rd_i;


    wire[31:0] op1,op2;
    mux4 aluin1(
        rd1_i,
        sa_ext_i,
        16,
        0,
        aluin1_i,
        op1
    );
    mux2 aluin2(
        rd2_i,
        imm_ext_i,
        aluin2_i,
        op2
    );

    ALU u_alu(
        clk,
        rst,
        op1,
        op2,
        alusel_i,
        aluout_o
    );

    assign cwd_ex = cregwd_i;
    assign we_ex = regwe_i;
    assign wd_ex = (cregwd_i==`alu)?aluout_o:0;
    assign wa_ex = (cregwa_i==`rd)?rd_i:rt_i;

endmodule