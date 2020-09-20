import xlrd
import math
wb = xlrd.open_workbook('D:/PipelineCPU/doc/truth-table.xlsx')

tt = wb.sheet_by_index(0)

print(u"sheet %s 共 %d 行 %d 列" % (tt.name, tt.nrows, tt.ncols))

tabledata={}
for i in range(1,tt.nrows):
    temp ={}
    for j in range(1,tt.ncols):
        temp[tt.cell_value(0,j)] = tt.cell_value(i,j)
    tabledata[tt.cell_value(i,0)] = temp
# print(tabledata)

width = {}
def control_line(idx,f):
    name = tt.cell_value(0,idx)
    cnt = 0
    cs = {}
    for i in range(1,tt.nrows):
        s =  tt.cell_value(i,idx)
        if s!='x' and s not in cs:
            cs[s] = cnt
            cnt+=1

    if 'on' in cs:
        cs['on'] = 1
        cs['off']  = 0

    f.write(f'\n//{name} \n')
    for i in cs:
        f.write(f'`define {i} {cs[i]}\n')

    width[name] = [int( math.log2(cnt-1))+1,idx]
    



with open('D:/PipelineCPU/src/design/Marco.v','w+') as f:
    f.write('`include "ASettings.v"\n\n')
    inst = {'reserved':0}
    for i in range(1,tt.nrows):
        inst[tt.cell_value(i,0)+'_inst'] = i    
    
    f.write('//Instructions \n')
    for i in inst:
        f.write(f'`define {i} {inst[i]}\n')

    f.write('\n//general\n')
    f.write('`define off 0\n')
    f.write('`define on 1\n')
    f.write('`define x 0\n')
    for i in range(4,tt.ncols):
        control_line(i,f)

print(width)
with open('D:/PipelineCPU/src/design/Ctrl.v','w+') as f:
    f.write('`include "Marco.v"\n')
    f.write('module Ctrl(\ninput clk,\ninput rst,\ninput[5:0] opcode,\ninput[5:0] func,\ninput[4:0] rt')
    for cname in width:
        f.write(f',\noutput[{width[cname][0]-1}:0] {cname}')
    f.write(');\n\n\n')
    inst_width = int(math.log2(inst.__len__()-1))+1
    f.write(f'    wire[{inst_width-1}:0] inst_type;\n')
    f.write(f'    assign inst_type = \n')
    opc={}
    func={}
    regimm = {}
    for i in range(1,tt.nrows):
        if tt.cell_value(i,1)=='000000':
            func[tt.cell_value(i,2)] = tt.cell_value(i,0)+'_inst'
        elif tt.cell_value(i,1)=='000001':
            regimm[tt.cell_value(i,3)] = tt.cell_value(i,0)+'_inst'
        else:
            opc[tt.cell_value(i,1)] = tt.cell_value(i,0)+'_inst'
    for op in opc:
        f.write(f'        (opcode==6\'b{op})?`{opc[op]}:\n')
    
    f.write('        (opcode==6\'b000001)?(\n')
    for r in regimm:
        f.write(f'            (rt==5\'b{r})?`{regimm[r]}:\n')
    
    f.write('            `reserved):\n')

    f.write('        (opcode==6\'b000000)?(\n')
    for fun in func:
        f.write(f'            (func==6\'b{fun})?`{func[fun]}:\n')
    
    f.write('            `reserved\n        ):`reserved;\n\n')
    

    for cname in width:
        f.write(f'        assign {cname} = \n')
        for ins in tabledata:
            f.write(f'        (inst_type==`{ins+"_inst"})?`{tabledata[ins][cname]}:\n')

        f.write('        0;\n\n')

    f.write('endmodule')





    pass





