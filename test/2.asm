.data

valW:	.word	2062324371
valH:	.half	11722
valB:	.byte	-23

.text 
addi $2, $0, -20
addi $3, $0, 20
add $4, $2, $3
addu $5, $2, $3
addiu $6, $2, 30


sub $7, $4, $5
subu $8, $3, $2

addi $2, $0, 1
addi $3, $0, 7

and $11, $2, $3

or $12, $2, $3


andi $13, $3, 9

ori $14, $3, 9

xor $15, $2, $3

xori $16, $3, 6


nor $17, $2, $3


slt $18, $2, $3

slti $19, $2, -30

sltu $20, $3, $2


sll $21, $13, 3

srl $22, $21, 2

sra $23, $2, 2


addi $2, $0, 3
addi $3, $0, 2

sllv $21, $13, $2
srlv $22, $21, $3


j a
nop
addi $24, $2, 1
a:
addi $24, $2, 2

add $2, $2, $0
add $3, $2, $0

beq $2, $3, b
nop
addi $25, $24, 1
b:
addi $25, $24, 2

bne $2, $3, c
nop
addi $26, $2, 2
j d
nop

c:
addi $26, $2, 3
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


la $2, valW
lw $3, 0($2)
addi $27, $27, 1
sw $27, valW

la $2, valH
lh $9, 0($2)
addi $9, $9, 2
sh $9, valH

la $2, valB
lb $10, 0($2)
addi $10, $10, -1
sb $10, 0($2)

lbu $3, 0($2)
addi $3, $3, 12

lui $2, 100

