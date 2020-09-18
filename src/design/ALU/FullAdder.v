`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/09/09 15:01:55
// Design Name:
// Module Name: full_adder
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////




module FullAdder(input[31:0] a,
                  input[31:0] b,
                  input cin,
                  output cout,output[31:0] s);
    
    wire[8:0] c;
    assign c[0] = cin;
    assign cout = c[8];

    genvar i;
    generate 
        for (i=0;i<8;i=i+1)
        begin
            para4_full_adder add(
                .a(a[i*4+3:i*4]),
                .b(b[i*4+3:i*4]),
                .cin(c[i]),
                .cout(c[i+1]),
                .s(s[i*4+3:i*4])
            );
        end
    endgenerate


endmodule
    
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/09/09 16:51:47
// Design Name:
// Module Name: para4_full_adder
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module para4_full_adder(input[3:0] a,
                  input[3:0] b,
                  input cin,
                  output cout,
                  output[3:0] s);
    
    wire[3:0] p,g;
    wire[4:0] c;
    
    genvar i;
    generate
    for(i = 0; i<4; i = i+1) 
    begin
        assign p[i] = a[i]^b[i];
        assign g[i] = a[i]&b[i];
        assign s[i] = p[i]^c[i];
    end
    endgenerate
    assign c[0] = cin;
    assign c[1] = g[0] | (c[0]&p[0]);
    assign c[2] = g[1] | (g[0]&p[1]) | (c[0]&(&p[1:0]));
    assign c[3] = g[2] | (g[1]&p[2]) | (g[0]&(&p[2:1])) | (c[0]&(&p[2:0]));
    assign c[4] = g[3] | (g[2]&p[3]) | (g[1]&(&p[3:2])) | (g[0]&(&p[3:1])) | (c[0]&(&p[3:0]));
    assign cout = c[4];

endmodule
    


