.text
main:
    li $t0,8
    li $t1,1
	li $t2,2
    li $t3,3
	li $t4,4
    li $t5,5
	li $t6,6
    li $t7,7
    sub $t0,$t6,$t2
    sll $t1,$t0,10
    srl $t2,$t0,10
    
    sub $t0,$t2,$t6
    sra $t3,$t0,10
    srl $t4,$t0,10
