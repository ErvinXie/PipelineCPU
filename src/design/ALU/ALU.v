`timescale 1ns/1ps
`include "../Marco.v"


module ALU(
    input clk,
    input rst,
    input[31:0] a,
    input[31:0] b,
    input[`ALU_SELECTION_WIDTH-1:0] s,
    output[31:0] c

);
    

    wire add_cout;
    wire[31:0] add_out;
    FullAdder u_full_adder(
        .a(a),
        .b(b),
        .cin(0),
        .cout(add_cout),
        .s(add_out)
    );

    wire sub_cout;
    wire[31:0] sub_out;
    FullAdder u_full_adder_sub(
        .a(a),
        .b(~b+1),
        .cin(0),
        .cout(sub_cout),
        .s(sub_out)
    );


    wire[31:0] or_out;
    assign or_out = a | b;

    wire[31:0] xor_out;
    assign xor_out = a ^ b;

    wire[31:0] and_out;
    assign and_out = a & b;

    wire[31:0] sll_out;
    assign sll_out = b << a;

    wire[31:0] srl_out;
    assign srl_out = b >> a;

    wire[31:0] sra_out;
    assign sra_out = b >>>a;

    wire[31:0] nor_out;
    assign nor_out = ~ (a | b);

    wire[31:0] lt_out;
    assign lt_out = a < b ? 32'b1 : 32'b0;
    
    assign c =  
                (s==`add_op) ? add_out :
                (s==`sub_op) ? sub_out :
                (s==`and_op) ? and_out :
                (s==`or_op) ? or_out :
                (s==`xor_op) ? xor_out :
                (s==`sl_op) ? sll_out :
                (s==`srl_op) ? srl_out :
                (s==`sra_op) ? sra_out :
                (s==`nor_op) ? nor_out :
                (s==`lt_op) ? lt_out :
                (s==`ltu_op) ? lt_out :
                8'b0;

    



endmodule
