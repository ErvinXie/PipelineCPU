`timescale 1ns/1ps

module test();


    reg[7:0] a,b,c,d;
    reg clk,rst;
    wire [7:0] change; 

    always @(posedge clk)begin
        a<=change;
        b<=a;
        c<=b;
        d<=c;
    end
    integer i;
    
    initial begin
        i = 0;
    end

    assign change = i;
    always begin
        i = i+1;
        #11;
        

    end

    always begin
        clk = 1;
        #10;
        clk = 0;
        #10;
    end



endmodule