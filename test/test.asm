.data 
x:

.text
main:
    la $t1,x
    li $t0,-1
    sw $t0,($t1)
    sh $t0,4($t1)
    sb $t0,8($t1)
    li $t3,3
    lw $t2,($t1)
    li $t0,1
    li $t1,10
    li $t2,0
loop:
    add $t0,$t0,$t0
    addi $t2,$t2,1
    beq $t1,$t2,exit
    nop
    j loop
    nop
exit:
    sub $t1,$t2,$t0
    
