
with open('D:\\PipelineCPU\\test\\1imem.txt','r') as ins:
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
    
