`timescale 1ns/1ps

module cpu_test();
    reg clk;
    reg rst;

    initial begin
        rst = 1;
        #1;
        rst = 0;
        #9
        rst = 1;
    end

    always begin
        clk = 1;
        #10;
        clk = 0;
        #10;
    end
    CPU cpu(clk,rst);



endmodule