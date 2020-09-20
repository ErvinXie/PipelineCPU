module FI_ID(
    input clk,
    input rst,
    input pause,
    input[31:0] pc_i,
    input[31:0] inst_i,
    output[31:0] pc_o,
    output[31:0] inst_o
);
    reg[31:0] pc,inst;
    wire[31:0] oe;
    assign oe = ~{32{pause}};
    always@(posedge clk)begin
        if(pause==0)begin
            pc<=pc_i;
            inst<=inst_i;
        end 
    end
    assign pc_o = pc & oe;
    assign inst_o = inst & oe;

endmodule