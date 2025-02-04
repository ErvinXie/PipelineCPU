`timescale 1ns / 1ps
`include "Marco.v"

module RegFile(
    input clk,
    input rst,
    input we,
    input[4:0] r1_addr,
    input[4:0] r2_addr,
    input[4:0] w_addr,

    output [31:0] r1_data,
    output [31:0] r2_data,

    input [31:0] w_data,
    input[1:0] cregwd_ex,

    output pause,

    input we_ex,
    input[4:0] wa_ex,
    input[31:0] wd_ex,   
    input we_me,
    input[4:0] wa_me,
    input[31:0] wd_me,   
    input we_wb,
    input[4:0] wa_wb,
    input[31:0] wd_wb,

    input ra_we,
    input[31:0] br_ra_w

);

    reg[31:0] regs[31:0];

//  Pause
    assign pause = (cregwd_ex==`memrd)&&(we_ex==1)&&(
        r1_addr == wa_ex||r2_addr == wa_ex
    );

//  Forwarding
    assign r1_data = (we_ex==1&&wa_ex==r1_addr)?wd_ex:
                     (we_me==1&&wa_me==r1_addr)?wd_me:
                     (we_wb==1&&wa_wb==r1_addr)?wd_wb:
                     regs[r1_addr];

    assign r2_data = (we_ex==1&&wa_ex==r2_addr)?wd_ex:
                     (we_me==1&&wa_me==r2_addr)?wd_me:
                     (we_wb==1&&wa_wb==r2_addr)?wd_wb:
                     regs[r2_addr];



    integer i = 0;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for(i = 0;i < 32;i = i+1)
                regs[i] <= 32'b0;
        end
        // for register $0
        else if (we) begin
            if (w_addr != 5'b0&&w_addr!=5'd31)begin
                regs[w_addr] <= w_data;
            end
            if(ra_we)
                regs[31]<=br_ra_w;
            
            regs[30]<=regs[30]+1;
        end
    end
endmodule
