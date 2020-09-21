`include"Marco.v"

module WriteBack(
    input clk,
    input rst,
    input[0:0] cregwa_i,
    
    input[1:0] cregwd_i,
    
    input[0:0] regwe_i,
    
    input[4:0] rt_i,
    
    input[4:0] rd_i,
    
    input[31:0] aluout_i,
    
    input[31:0] memrd_i,
    
    output we_wb,
    output[4:0] wa_wb,
    output[31:0] wd_wb,

    output[0:0] we,
    output[4:0] wa,
    output[31:0] wd
    
);

    assign we_wb = regwe_i;
    assign wa_wb = (cregwa_i==`rd)?rd_i:rt_i;
    assign wd_wb = (cregwd_i==`memrd)?memrd_i:
                   (cregwd_i==`alu)?aluout_i:
                   0;


    assign we = regwe_i;
    mux2#(5) u_wamux(
        rd_i,
        rt_i,
        cregwa_i,
        wa
    );

    mux4 u_wdmux(
        aluout_i,
        memrd_i,
        0,
        0,
        cregwd_i,
        wd
    );



endmodule