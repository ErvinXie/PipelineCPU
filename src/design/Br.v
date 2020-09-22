`include "Marco.v"

module Br (
    input [31:0] pc,
    input [25:0] instr_index,
    input [15:0] offset,
    input [31:0] RD1, //rs
    input [31:0] RD2,
    input [3:0] CB,
    output [31:0] newPC,
    output [31:0] ra
);

wire [31:0] npc;
assign npc = pc + 8;

wire [31:0] j_out;
assign j_out = {
    pc[31:28],
    instr_index,
    2'b00
};

wire [31:0] branch;
wire [31:0] target_offset;
assign target_offset = {
    {14{offset[15]}},offset, 2'b00
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

wire [31:0] bltz_out;
assign bltz_out = 
                (RD1 < 32'b0) ? branch :
                npc;

wire [31:0] bgez_out;
assign bgez_out = 
                (RD1 >= 32'b0) ? branch :
                npc;

wire [31:0] jal_out;
assign jal_out = j_out;

wire [31:0] jr_out;
assign jr_out = RD1;


assign newPC = 
                (CB == `none) ? npc :
                (CB == `j_br) ? j_out :
                (CB == `beq_br) ? beq_out :
                (CB == `bne_br) ? bne_out :
                (CB == `blez_br) ? blez_out :
                (CB == `bgtz_br) ? bgtz_out :
                (CB == `bltz_br) ? bltz_out :
                (CB == `bgez_br) ? bgez_out :
                (CB == `jal_br) ? jal_out :
                (CB == `jr_br) ? jr_out :
                npc;

wire[31:0] jal_pc;
assign jal_pc = pc + 8;


assign ra = 
            (CB == `jal_br) ? jal_pc :
            32'b0;

endmodule