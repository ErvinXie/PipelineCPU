`include"Marco.v"

module VisMem(
    input clk,
    input rst,

    input[0:0] cregwa_i,
    input[1:0] cregwd_i,
    input[0:0] regwe_i,
    input[2:0] memlen_i,
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
    output[31:0] memrd_o,

    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output hs,
    output vs,

    output reg[7:0]  led

);
    wire[31:0] memrd;
    wire[31:0] addr,wdata;


    assign addr = aluout_i;
    assign wdata = rd2_i;
    assign ramwe = memwe_i&&(addr[31:16]==16'h1001);

    Dmem u_deme(
        clk,
        rst,
        ramwe,
        memlen_i,
        aluout_i,
        wdata,
        memrd
    );

    wire vramwe = memwe_i&&(addr[31:16]==16'h0007);
    // vaddr[31:22] haddr[21:12]  r[11:8] g[7:4] b[3:0]
    vga u_vga(
        R,
        G,
        B,
        hs,
        vs,
        clk,
        rst,

        vramwe,
        wdata[21:12],
        wdata[31:22],
        wdata[11:0]
    );

   
    always@(posedge clk or negedge rst)begin
        if(!rst)begin
            led<=8'b0;
        end 
        else if(addr[31:16]==16'h0008&&memwe_i)begin
            led<=wdata[7:0];
        end
    end

    assign cregwa_o = cregwa_i;
    assign cregwd_o = cregwd_i;
    assign regwe_o = regwe_i;
    assign rt_o = rt_i;
    assign rd_o = rd_i;
    assign aluout_o = aluout_i;
    assign memrd_o = memrd;
                    

    assign we_me = regwe_i;
    assign wa_me = (cregwa_i==`rd)?rd_i:rt_i;
    assign wd_me = (cregwd_i==`memrd)?memrd_o:
                   (cregwd_i==`alu)?aluout_i:
                   0;
    
  

endmodule