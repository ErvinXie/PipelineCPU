`timescale 1ns / 1ps
`include "Marco.v"
module Dmem(input clk,
            input rst,
            input we,
            input[2:0] memlen,
            input[31:0] waddr,
            input[31:0] wdata,
            output[31:0] rdata);
    
    reg[7:0] mem[`DMEM_SIZE-1:0];
    
    wire[`DMEM_ADDR_WIDTH-1:0] addr;
    assign addr  = waddr[`DMEM_ADDR_WIDTH-1:0];
    
    assign rdata =  (memlen==`lw_me)?{mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}:
                    (memlen==`lb_me)?{24'hffffff&{24{mem[addr][7]}},mem[addr]}:
                    (memlen==`lbu_me)?{24'b0,mem[addr]}:
                    (memlen==`lh_me)?{16'hffff &{16{mem[addr+1][7]}},mem[addr+1],mem[addr]}:
                    32'b0;
    
    always @(posedge clk)begin
        if (we)begin
            if(memlen==`sb_me)begin
                mem[addr] <= wdata[7:0];
            end
                
            if(memlen==`sh_me)begin
                mem[addr] <= wdata[7:0];
                mem[addr+1] <= wdata[15:8];
            end
            if(memlen==`sw_me)begin
                mem[addr] <= wdata[7:0];
                mem[addr+1] <= wdata[15:8];
                mem[addr+2] <= wdata[23:16];
                mem[addr+3] <= wdata[31:24];
            end
        end
    end
    initial begin
         $readmemh("D:/PipelineCPU/test/dmem.txt",mem);
    end
    
    
endmodule
