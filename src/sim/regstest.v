`timescale 1ns/1ps

module test();


    reg[7:0] a,b,c,d;
    reg wa,wb,wc,wd;
    reg clk,rst;
    wire [7:0] change; 

    always @(posedge clk)begin
        if (wa) begin
            a<=change;
        end
        if (wb) begin
            b<=a&{8{wa}};
        end
         if (wc) begin
             c<=b&{8{wb}};
        end
         if (wd) begin
            d<=c&{8{wc}};
        end
    end
    integer i;
    
    initial begin
        i = 0;
        wa = 1;
        wb = 1;
        wc = 1;
        wd = 1;
        #200;
        wa = 0;
        wb = 0;

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