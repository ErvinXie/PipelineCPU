`include"Marco.v"

module VisMem(
    input clk,
    input rst,

    input[0:0] cregwa_i,
  
    input[1:0] cregwd_i,

    input[0:0] regwe_i,
   
    input[1:0] memlen_i,

    input[0:0] memwe_i,
  
    input[31:0] rd2_i,
 
    input[4:0] rt_i,
 
    input[4:0] rd_i,

    input[31:0] aluout_i,

    output we_me,
    output[4:0] wa_me,
    output[31:0] wd_me,

    
    output[0:0] cregwa_o,
    
    output[1:0] cregwd_o,
    
    output[0:0] regwe_o,
    
    output[4:0] rt_o,
    
    output[4:0] rd_o,
    
    output[31:0] aluout_o,
    
    output[31:0] memrd_o

);
    assign cregwa_o = cregwa_i;
    assign cregwd_o = cregwd_i;
    assign regwe_o = regwe_i;
    assign rt_o = rt_i;
    assign rd_o = rd_i;
    assign aluout_o = aluout_i;


    assign we_me = regwe_i;
    assign wa_me = (cregwa_i==`rd)?rd_i:rt_i;
    assign wd_me = (cregwd_i==`memrd)?memrd_o:0;


    Dmem u_deme(
        clk,
        rst,
        memwe_i,
        memlen_i,
        aluout_i,
        rd2_i,
        memrd_o
    );




endmodule