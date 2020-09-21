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
    add $t0,$t3,$t2
