module CPU(
    input clk,
    input rst
);
    // FI
    reg[31:0] pc;
    wire[31:0] inst;
    wire[31:0] inst_o,pc_o;
    Imem u_imem(
        clk,
        rst,
        pc,
        inst
    );
    wire pause;
    FI_ID fiid(
        clk,
        rst,
        pause,
        pc,
        inst,
        pc_o,
        inst_o
    );

    //ID

    wire[1:0] cregwd_ex;
    wire[4:0] ex_rt;

    wire we_ex;
    wire[4:0] wa_ex;
    wire[31:0] wd_ex;   
    wire we_me;
    wire[4:0] wa_me;
    wire[31:0] wd_me;   
    wire we_wb;
    wire[4:0] wa_wb;
    wire[31:0] wd_wb;

    wire[4:0] WB_regwa;
    wire[31:0] WB_regwd;
    

    wire[31:0] newPC_ID_o;
    wire[0:0] cregwa_ID_o;
    wire[1:0] cregwd_ID_o;
    wire[0:0] regwe_ID_o;
    wire[1:0] aluin1_ID_o;
    wire[0:0] aluin2_ID_o;
    wire[3:0] alusel_ID_o;
    wire[1:0] memlen_ID_o;
    wire[0:0] memwe_ID_o;
    wire[31:0] imm_ext_ID_o;
    wire[31:0] sa_ext_ID_o;
    wire[31:0] rd1_ID_o;
    wire[31:0] rd2_ID_o;
    wire[4:0] rt_ID_o;
    wire[4:0] rd_ID_o;

    InstDecode u_instdecode(
        clk,
        rst,
        inst_o,
        pc_o,

        cregwd_ex,

        we_ex,
        wa_ex,
        wd_ex,

        we_me,
        wa_me,
        wd_me,

        we_wb,
        wa_wb,
        wd_wb,

        pause,

        newPC_ID_o,
        cregwa_ID_o,
        cregwd_ID_o,
        regwe_ID_o,
        aluin1_ID_o,
        aluin2_ID_o,
        alusel_ID_o,
        memlen_ID_o,
        memwe_ID_o,
        imm_ext_ID_o,
        sa_ext_ID_o,
        rd1_ID_o,
        rd2_ID_o,
        rt_ID_o,
        rd_ID_o
    );

    wire[31:0] newPC_EX_i;

    wire[0:0] cregwa_EX_i;
    wire[1:0] cregwd_EX_i;
    wire[0:0] regwe_EX_i;
    wire[1:0] aluin1_EX_i;
    wire[0:0] aluin2_EX_i;
    wire[3:0] alusel_EX_i;
    wire[1:0] memlen_EX_i;
    wire[0:0] memwe_EX_i;
    wire[31:0] imm_ext_EX_i;
    wire[31:0] sa_ext_EX_i;
    wire[31:0] rd1_EX_i;
    wire[31:0] rd2_EX_i;
    wire[4:0] rt_EX_i;
    wire[4:0] rd_EX_i;
    

    ID_EX idex(
        clk,
        rst,
        pause,
        cregwa_ID_o,
        cregwa_EX_i,
        
        cregwd_ID_o,
        cregwd_EX_i,

        regwe_ID_o,
        regwe_EX_i,

        aluin1_ID_o,
        aluin1_EX_i,

        aluin2_ID_o,
        aluin2_EX_i,

        alusel_ID_o,
        alusel_EX_i,

        memlen_ID_o,
        memlen_EX_i,

        memwe_ID_o,
        memwe_EX_i,

        imm_ext_ID_o,
        imm_ext_EX_i,

        sa_ext_ID_o,
        sa_ext_EX_i,

        rd1_ID_o,
        rd1_EX_i,

        rd2_ID_o,
        rd2_EX_i,

        rt_ID_o,
        rt_EX_i,

        rd_ID_o,
        rd_EX_i

    );


    wire[0:0] cregwa_EX_o;
    wire[1:0] cregwd_EX_o;
    wire[0:0] regwe_EX_o;
    wire[1:0] memlen_EX_o;
    wire[0:0] memwe_EX_o;
    wire[31:0] rd2_EX_o;
    wire[4:0] rt_EX_o;
    wire[4:0] rd_EX_o;
    wire[31:0] aluout_EX_o;

    Execute u_execute(
        clk,
        rst,

        cregwa_EX_i,
        cregwd_EX_i,
        regwe_EX_i,
        aluin1_EX_i,
        aluin2_EX_i,
        alusel_EX_i,
        memlen_EX_i,
        memwe_EX_i,
        imm_ext_EX_i,
        sa_ext_EX_i,
        rd1_EX_i,
        rd2_EX_i,
        rt_EX_i,
        rd_EX_i,


        cregwd_ex,
        we_ex,
        wa_ex,
        wd_ex,
        cregwa_EX_o,
        cregwd_EX_o,
        regwe_EX_o,
        memlen_EX_o,
        memwe_EX_o,
        rd2_EX_o,
        rt_EX_o,
        rd_EX_o,
        aluout_EX_o
        
    );

    wire[0:0] cregwa_MEM_i;
    
    wire[1:0] cregwd_MEM_i;
    
    wire[0:0] regwe_MEM_i;
    
    wire[1:0] memlen_MEM_i;
    
    wire[0:0] memwe_MEM_i;
    
    wire[31:0] rd2_MEM_i;
    
    wire[4:0] rt_MEM_i;
    
    wire[4:0] rd_MEM_i;
    
    wire[31:0] aluout_MEM_i;

    EX_MEM exmem(
        clk,
        rst,
        0,
        cregwa_EX_o,
        cregwa_MEM_i,

        cregwd_EX_o,
        cregwd_MEM_i,

        regwe_EX_o,
        regwe_MEM_i,

        memlen_EX_o,
        memlen_MEM_i,

        memwe_EX_o,
        memwe_MEM_i,

        rd2_EX_o,
        rd2_MEM_i,

        rt_EX_o,
        rt_MEM_i,

        rd_EX_o,
        rd_MEM_i,

        aluout_EX_o,
        aluout_MEM_i,    
    );

    wire[0:0] cregwa_MEM_o;
    wire[1:0] cregwd_MEM_o;
    wire[0:0] regwe_MEM_o;
    wire[4:0] rt_MEM_o;
    wire[4:0] rd_MEM_o;
    wire[31:0] aluout_MEM_o;
    wire[31:0] memrd_MEM_o;

    VisMem u_vismem(
        clk,
        rst,
        cregwa_MEM_i,
        cregwd_MEM_i,
        regwe_MEM_i,
        memlen_MEM_i,
        memwe_MEM_i,
        rd2_MEM_i,
        rt_MEM_i,
        rd_MEM_i,
        aluout_MEM_i,

        we_me,
        wa_me,
        wd_me,

        cregwa_MEM_o,
        cregwd_MEM_o,
        regwe_MEM_o,
        rt_MEM_o,
        rd_MEM_o,
        aluout_MEM_o,
        memrd_MEM_o,

    );

    wire[0:0] cregwa_WB_i;
    wire[1:0] cregwd_WB_i;
    wire[0:0] regwe_WB_i;
    wire[4:0] rt_WB_i;
    wire[4:0] rd_WB_i;
    wire[31:0] aluout_WB_i;
    wire[31:0] memrd_WB_i;

    MEM_WB memwb(
        clk,
        rst,
        0,
        cregwa_MEM_o,
        cregwa_WB_i,

        cregwd_MEM_o,
        cregwd_WB_i,

        regwe_MEM_o,
        regwe_WB_i,

        rt_MEM_o,
        rt_WB_i,

        rd_MEM_o,
        rd_WB_i,

        aluout_MEM_o,
        aluout_WB_i,

        memrd_MEM_o,
        memrd_WB_i

    );

    WriteBack u_writeback(
        clk,
        rst,
        cregwa_WB_i,
        cregwd_WB_i,
        regwe_WB_i,
        rt_WB_i,
        rd_WB_i,
        aluout_WB_i,
        memrd_WB_i,

        we_wb,
        wa_wb,
        wd_wb,

        WB_regwa,
        WB_regwd

    );




    







endmodule
