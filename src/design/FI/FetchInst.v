
module FetchInst(
    input clk,
    input rst
);
    wire[31:0] pc,inst;
    Imem u_imem(
        clk,
        rst,
        pc,
        inst
    );
    


endmodule