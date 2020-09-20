`timescale 1ns / 1ps

module RegFile(input clk,
               input rst,
               input we,
               input[4:0] r1_addr,
               input[4:0] r2_addr,
               input[4:0] w_addr,
               output [31:0] r1_data,
               output [31:0] r2_data,
               input [31:0] w_data,
               input [31:0] w_ra,
               output[31:0] r_ra
               );

    reg[31:0] regs[31:0];
    assign r1_data = regs[r1_addr];
    assign r2_data = regs[r2_addr];
    assign r_ra = regs[31];

    integer i = 0;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for(i = 0;i < 32;i = i+1)
                regs[i] <= 32'b0;
        end
        // for register $0
        else if (we) begin
            if (w_addr != 4'b0)begin
                regs[w_addr] <= w_data;
            end
            if (w_addr!=31)begin
                regs[31] <= w_ra;
            end
        end
    end
endmodule
