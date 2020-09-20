module CPU(
    input clk,
    input rst
);
    // FI
    reg[31:0] pc;
    wire[31:0] inst;
    wire[31:0] inst_o,pc_o;
    Imem u_imem(
        clk,
        rst,
        pc,
        inst
    );
    FI_ID fiid(
        clk,
        rst,
        pc,
        inst,
        pc_o,
        inst_o
    );

    //ID

    InstDecode u_instdecode(
        clk,
        rst,
        inst_o,

    );



    







endmodule
