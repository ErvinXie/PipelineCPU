`include "Marco.v"

module Br (
    input [31:0] pc,
    input [25:0] instr_index,
    input [15:0] offset,
    input [31:0] RD1, //rs
    input [31:0] RD2,
    input [3:0] CB,
    output [31:0] newPC
);

wire [31:0] npc;
assign npc = pc + 4;

wire [31:0] j_out;
assign j_out = {
    pc[31:28],
    instr_index,
    2'b00
};

wire [31:0] branch;
wire [31:0] extend_offset;
assign target_offset = {
    {14{offset[15]}},
    {offset, 2'b00}
};
assign branch = pc + target_offset;

wire [31:0] beq_out;
assign beq_out =
                (RD1 == RD2) ? branch :
                npc;

wire [31:0] bne_out;
assign bne_out = 
                (RD1 == RD2) ? npc :
                branch;

wire [31:0] blez_out;
assign blez_out = 
                (RD1 <= 32'b0) ? branch :
                npc;

wire [31:0] bgtz_out;
assign bgtz_out = 
                (RD1 > 32'b0) ? branch :
                npc;

assign newPC = 
                (CB == `none) ? npc :
                (CB == `j_br) ? j_out :
                (CB == `beq_br) ? beq_out :
                (CB == `bne_br) ? bne_out :
                (CB == `blez_br) ? blez_out :
                (CB == `bgtz_br) ? bgtz_out :
                npc;
    
endmodule