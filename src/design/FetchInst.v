
module FetchInst(
    input clk,
    input rst,
    input[31:0] npc,
    output reg[31:0] pc,
    output[31:0] inst
);  
    
    Imem u_imem(
        clk,
        rst,
        pc,
        inst
    );

    always@(posedge clk) begin
        pc <= npc;
    end
    


endmodule