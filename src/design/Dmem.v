`timescale 1ns / 1ps
`include "Marco.v"
module Dmem(input clk,
            input rst,
            input we,
            input[1:0] memlen,
            input[31:0] daddr,
            input[31:0] wdata,
            output[31:0] rdata);
    
    reg[7:0] mem[`DMEM_SIZE-1:0];
    
    wire[`DMEM_ADDR_WIDTH-1:0] addr;
    assign addr  = daddr[`DMEM_ADDR_WIDTH-1:0];
    
    assign rdata =  (memlen==`word)?{mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}:
                    (memlen==`byte)?{24'b0,mem[addr]}:
                    (memlen==`half)?{16'b0,mem[addr+1],mem[addr]}:
                    32'b0;
    
    always @(posedge clk)begin
        if (we)begin
            mem[addr] <= wdata[7:0];
            mem[addr+1] <= wdata[15:8];
            mem[addr+2] <= wdata[23:16];
            mem[addr+3] <= wdata[31:24];
        end
    end
    initial begin
         $readmemh("D:/ErvinCPU/test/dmem.txt",mem);
    end
    
    
endmodule
