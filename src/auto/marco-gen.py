import xlrd
import math
wb = xlrd.open_workbook('D:/PipelineCPU/doc/truth-table.xlsx')

tt = wb.sheet_by_index(0)

print(u"sheet %s 共 %d 行 %d 列" % (tt.name, tt.nrows, tt.ncols))

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

    width[name] = int( math.log2(cnt-1))+1
    



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
    for i in range(3,tt.ncols):
        control_line(i,f)

print(width)
with open('D:/PipelineCPU/src/design/Ctrl.v','w+') as f:
    f.write('`include "Marco.v"\n')
    f.write('module Ctrl(\ninput clk,\ninput rst,\ninput[5:0] opcode,\ninput[5:0] func')
    for cname in width:
        f.write(f',\noutput[{width[cname]-1}:0] {cname}')


    f.write(');\n\n\n')

    inst_width = int(math.log2(inst.__len__()-1))+1
    f.write(f'    wire[{inst_width-1}:0] inst_type;\n')

    f.write(f'    assign inst_type = \n')
    opc={}
    func={}
    for i in range(1,tt.nrows):
        if tt.cell_value(i,1)=='000000':
            func[tt.cell_value(i,2)] = tt.cell_value(i,0)+'_inst'
        else:
            opc[tt.cell_value(i,1)] = tt.cell_value(i,0)+'_inst'
    for op in opc:
        f.write(f'        (opcode==6\'b{op})?`{opc[op]}:\n')
    f.write('        (opcode==6\'b000000)?(\n')
    for fun in func:
        f.write(f'            (func==6\'b{fun})?`{func[fun]}:\n')
    


    f.write('            `reserved\n        ):`reserved;\n\n')

    f.write('endmodule')
    pass





