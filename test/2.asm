.data
a:

.text
main:
	lui $t8,0x0007
	lui $t9,0x0008
	#la $t8,a
	li $s0,320
	li $s1,240

	li $s2,0
loop1:
	li $s3,0
loop2: 
	
	move $v0,$s2	
	move $v1,$s3
	move $a0,$s2
	
	move $a0, $v0
	move $a1, $v1
	move $a2, $v0
	neg $a2,$a2
	
	jal color
	nop
	
	sw $a3,($t8)
	sw $a3,($t9)
	addiu $s3,$s3,1 
	
	bne $s3,$s1,loop2
	nop
	
	addiu $s2,$s2,1 
	
	bne $s2,$s0,loop1
	nop
	
	j exit
	nop
	
	
	
color:	
	andi $a0,0x00000000f
	sll $a0,$a0,8
	andi $a1,0x00000000f
	sll $a1,$a1,4
	andi $a2,0x00000000f
	andi $v0,0x0000003ff
	sll $v0,$v0,12
	andi $v1,0x0000003ff
	sll $v1,$v1,22
	or $v0,$v0,$v1
	or $a0,$a0,$a1
	or $a3,$a0,$v0
	or $a3,$a3,$a2
	jr $ra
	nop
	
exit:
	nop
	

