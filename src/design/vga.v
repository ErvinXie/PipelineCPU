`define hsize 320
`define vsize 240
`define totalsize 76800
`define scale 2
`define addr_width 17

module vga(
    output [3:0] R,
    output [3:0] G,
    output [3:0] B,
    output reg hs,
    output reg vs,
    input rclk,
    input rst,

    input we,
    input[9:0] haddr,
    input[9:0] vaddr,
    input[11:0] wdata
    );
    
    reg[`addr_width-1:0] addra;
    wire[`addr_width-1:0] addrb;
    wire[11:0] doutb;
    wire wea;
    assign wea = we;
    bvram u_bvram(
        .addra(addra),
        .clka(rclk),
        .dina(wdata),
        .ena(1'b1),
        .wea(wea),
        .addrb(addrb),
        .clkb( rclk),
        .doutb(doutb),
        .enb(1'b1)
    );

    // integer i=0;
    // integer j=0;
    // reg[10:0] qo,re;
    // always @(negedge rst) begin
    //     for(i=0;i<`totalsize;i=i+1)begin
    //         qo = i/`hsize;
    //         re = i%`hsize;
    //         vram[i] = {qo[3:0],re[3:0],~qo[3:0]};
    //     end
    // end
    
    // always@(posedge rclk)begin
    //     if(we)begin
    //         vram[vaddr*`hsize+haddr] <= wdata;
    //     end
    // end 
    
    always@(posedge rclk)begin
        addra<=vaddr*`hsize+haddr;
    end 

    wire clk;
    reg[1:0] clkcnt;
    always @(posedge rclk or negedge rst)begin
        if (!rst) 
            clkcnt <= 0;
        else
        clkcnt<= clkcnt+1;
    end 
    assign clk = clkcnt==0;

    reg[9:0]hcnt,vcnt;

    always @ (posedge clk or negedge rst)begin
        if(!rst) 
            hcnt <= 10'b0;
        else if(hcnt == 10'd799) 
            hcnt <= 10'b0;
        else 
            hcnt <= hcnt+1'b1;
    end
    always @ (posedge clk or negedge rst)begin
        if(!rst) 
            vcnt <= 10'b0;
        else if(vcnt == 10'd524) 
            vcnt <= 10'b0;
        else if(hcnt == 10'd799) 
            vcnt <= vcnt+1'b1;
    end 
  
    always @(posedge clk or negedge rst) begin
        if (!rst) 
            hs <= 1'b1;
        else if (hcnt == 10'd0) 
            hs <=1'b0;
        else if (hcnt == 10'd96) 
            hs <= 1'b1;
    end

    always @(posedge clk or negedge rst) begin
        if (!rst) 
            vs <= 1'b1;
        else if (vcnt == 10'd0) 
            vs <=1'b0;
        else if (vcnt == 10'd2) 
            vs <= 1'b1;
    end


    wire valid;
    assign valid = (hcnt > 142) && (hcnt < 783) && (vcnt > 30) && (vcnt < 511);

    wire[9:0] x_pos,y_pos;
    assign x_pos = hcnt - 143;
    assign y_pos = vcnt -31;
  
    
    reg[11:0] RGB; 

    assign R = RGB[11:8];
    assign G = RGB[7:4];
    assign B = RGB[3:0];

    assign addrb = y_pos/`scale*`hsize+x_pos/`scale;
    
    
    always @(posedge clk or negedge rst) begin
      
        if (!rst) begin
      // reset
            RGB <= 12'hfff;
        end
        else if(valid)begin
            
            RGB <= doutb;
        end else
            RGB <= 12'b0000_0000_0000;

    end
endmodule