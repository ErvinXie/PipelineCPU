.data

valW:	.word	2062324371
valH:	.half	11722
valB:	.byte	-23

.text 
addi $1, $0, 10
addi $2, $0, -20
addi $3, $0, 20
add $4, $1, $2
addu $5, $1, $3
addiu $6, $5, 30
# 1=10 2=-20 3=20
# 4=-10 5=30 6=60

sub $7, $4, $5
subu $8, $3, $1
# 7=-30 8=10

addi $9, $0, 1
addi $10, $0, 7
# 9=0x00000001 10=0x00000007
and $11, $9, $10
# 11=0x00000001
or $12, $9, $10
# 12=0x00000007

andi $13, $10, 9
# 13=0x00000001
ori $14, $10, 9
# 14=15
xor $15, $9, $10
# 15=6
xori $16, $10, 6
# 16=1

nor $17, $9, $10
# 17=0xfffffff8

slt $18, $2, $1
# 18=1
slti $19, $2, -30
# 19=1
sltu $20, $3, $1
# 20=0

sll $21, $13, 3
# 21=8
srl $22, $21, 2
# 22=2
sra $23, $2, 2
# 23=-5

addi $1, $0, 3
addi $2, $0, 2

sllv $21, $13, $1
srlv $22, $21, $2
# 21=8 22=2

j a
nop
addi $24, $1, 1
a:
addi $24, $1, 2

add $1, $1, $0
add $2, $1, $0

beq $1, $2, b
nop
addi $25, $24, 1
b:
addi $25, $24, 2

bne $1, $2, c
nop
addi $26, $1, 2
j d
nop

c:
addi $26, $1, 3
d:
addi $3, $0, -10

blez $3, e
nop
addi $3, $3, 10
e:
addi $3, $3, 100

bgtz $3, f
nop
addi $3, $3, 200
f:
addi $3, $3, 20

bltz $0, g
nop
addi $3, $3, 1
j h
nop
g:
addi $3, $3, 2
h:
bgez $0 i
nop
addi $3, $3, 400
i:
addi $3, $3, 40

la $1, valW
lw $27, 0($1)
addi $27, $27, 1
sw $27, valW

la $1, valH
lh $28, 0($1)
addi $28, $28, 2
sh $28, valH

la $1, valB
lb $29, 0($1)
addi $29, $29, -1
sb $29, 0($1)

lbu $30, 0($1)
addi $30, $30, 12

lui $31, 100

