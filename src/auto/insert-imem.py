
with open('D:\\PipelineCPU\\test\\imem.txt','r') as ins:
    lines=ins.readlines()
# print(lines)


with open('D:\\PipelineCPU\\src\\design\\imem-part1.txt','r') as p1:
    l1 = p1.readlines()

with open('D:\\PipelineCPU\\src\\design\\imem-part2.txt','r') as p2:
    l2 = p2.readlines()

imemsize = 1024
instmax = int(imemsize/4)
print(f'{lines.__len__()} Instructions, {instmax} max')

with open('D:\\PipelineCPU\\src\\design\\Imem.v','w+') as f:
    f.writelines(l1)
    f.write('\n\n')
    for i in range(instmax):
        # print(i)
        if i<lines.__len__():
            f.write(f'        mem[{i}]<=32\'h{lines[i][:-1]};\n')
        else:
            f.write(f'        mem[{i}]<=32\'h00000000;\n')
    f.writelines(l2)


with open('D:\\PipelineCPU\\test\\dmemraw.txt','r') as f:
    lines = f.readlines()

nlines=[]
for l in lines:      
    for i in range(4):  
        nlines.append(l[(3-i)*2:(3-i)*2+2]+'\n')
# print(nlines)

with open('D:\\PipelineCPU\\test\\dmem.txt','w+') as fn:
    fn.writelines(nlines)    

with open('D:\\PipelineCPU\\test\\dmem.txt','r') as ins:
    lines=ins.readlines()
# print(lines)


with open('D:\\PipelineCPU\\src\\design\\dmem-part1.txt','r') as p1:
    l1 = p1.readlines()

with open('D:\\PipelineCPU\\src\\design\\dmem-part2.txt','r') as p2:
    l2 = p2.readlines()

dmemsize = 256
instmax = dmemsize
print(f'{lines.__len__()} Data, {instmax} max')

with open('D:\\PipelineCPU\\src\\design\\Dmem.v','w+') as f:
    f.writelines(l1)
    f.write('\n\n')
    for i in range(instmax):
        # print(i)
        if i<lines.__len__():
            f.write(f'        mem[{i}]<=8\'h{lines[i][:-1]};\n')
        else:
            f.write(f'        mem[{i}]<=8\'h00;\n')
    f.writelines(l2)