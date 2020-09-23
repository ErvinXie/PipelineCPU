import xlrd
import math
wb = xlrd.open_workbook('D:/PipelineCPU/doc/pipeline-variables.xlsx')

tt = wb.sheet_by_index(0)

print(u"sheet %s 共 %d 行 %d 列" % (tt.name, tt.nrows, tt.ncols))

tabledata={}
for i in range(1,tt.nrows):
    temp ={}
    for j in range(1,tt.ncols):
        if tt.cell_value(i,j)=='':
            temp[tt.cell_value(0,j)] = 0
        else:
            temp[tt.cell_value(0,j)] = int(tt.cell_value(i,j))
    tabledata[tt.cell_value(i,0)] = temp
stage = ['FI','ID','EX','MEM','WB']
print(tabledata)

with open('D:\\PipelineCPU\\src\\design\\MiddleLayer.v','w+') as f:
    for i in range(stage.__len__()-1):
        print(stage[i],stage[i+1])
        f.write(f'module {stage[i]}_{stage[i+1]}(\n    input clk,\n    input rst,\n    input pause')
        for var in tabledata:
            if tabledata[var][stage[i]]==1 and tabledata[var][stage[i+1]]==1:
                f.write(f',\n    input[{tabledata[var]["width"]-1}:0] {var}_i')
                f.write(f',\n    output[{tabledata[var]["width"]-1}:0] {var}_o')
        f.write('\n);\n\n')
        f.write('    wire[31:0] oe;\n    assign oe = ~{32{pause}};\n')
        for var in tabledata:
            if tabledata[var][stage[i]]==1 and tabledata[var][stage[i+1]]==1:
                f.write(f'    reg[{tabledata[var]["width"]-1}:0] {var};\n')
        f.write('\n    always@(posedge clk or negedge rst)begin\n')
        f.write('        if(!rst)begin\n')
        for var in tabledata:
            if tabledata[var][stage[i]]==1 and tabledata[var][stage[i+1]]==1:
                f.write(f'            {var} <= 0;\n')
        f.write('        end\n')
        f.write('        else if(pause==0)begin\n')

        for var in tabledata:
            if tabledata[var][stage[i]]==1 and tabledata[var][stage[i+1]]==1:
                f.write(f'            {var} <= {var}_i;\n')
        f.write('        end\n    end\n')

        
        for var in tabledata:
            if tabledata[var][stage[i]]==1 and tabledata[var][stage[i+1]]==1:
                if stage[i]=='ID':
                    f.write(f'    assign {var}_o = {var} & oe;\n')
                else:
                    f.write(f'    assign {var}_o = {var};\n')

        f.write('\nendmodule\n\n')




