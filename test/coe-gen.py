
from PIL import Image
im = Image.open('D:\\PipelineCPU\\test\\testimg.jpg')
rhsize = 640
rvsize = 480
scale = 2
hsize = int(rhsize/scale)
vsize = int(rvsize/scale)
im = im.resize((hsize,vsize),Image.BILINEAR)

rgb_im = im.convert('RGB')
# print(rgb_im.getpixel((160,120)))

with open('D:\\PipelineCPU\\test\\vram.coe','w+') as f:
    f.write('memory_initialization_radix=16;\n')
    f.write('memory_initialization_vector=\n')
    for i in range(vsize):
        for j in range(hsize):
            rgb = rgb_im.getpixel((j,i))
            hrgb = [
                hex(int(rgb[k]/16))[2:]
                for k in range(3)
            ]
          
            f.write(f'{hrgb[0]}{hrgb[1]}{hrgb[2]},\n')