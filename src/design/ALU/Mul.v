module Mul(
    input[31:0] a,
    input[31:0] b,
    output[31:0] hi,
    output[31:0] lo
);
    wire[63:0] temp;
    assign temp[0] = a[0]&b[0];

    genvar i;
    genvar j;
    generate 
        for (i=1;i<32;i=i+1)begin
            for(j=0;j<=i;j=j+1)begin
                
            end
        end
    endgenerate

endmodule

module FA(
    input a,
    input b,
    input cin,
    output cout,
    output s
);
    assign s = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule