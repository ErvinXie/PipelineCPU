.data
gamestatus: .word 0
block1: .word 100,100,40,20
block2: .word 150,150 50,25

sp:

.text
main:
	la $sp,sp
	
	lui $t0,0x0008
	li $t1,1
	sw $t1,($t0)
	
wait:
	blt $fp,100,wait
	nop
	
gameloop:

	move $t7,$fp
	andi $t7,511
	
	jal showBG
	nop


	
	j gameloop
	nop
	
	jal exit
	nop
	




showBG:
	sw $ra,($sp)
	addiu $sp,$sp,4

showBGLoopStart:
 	li $s2,320 # xlen
 	li $s3,240 # ylen
 
 	
 	li $s0,0
showBGLoop1:
 	li $s1,0
showBGLoop2:
 	add $v0,$s0,$0
 	add $v1,$s1,$0
 
 	bge $s1,$t7,showBGGround
 	nop
 
 	li $a0,10
 	li $a1,11
 	li $a2,13
 	j showBGPixel
 	nop
showBGGround:
 	li $a2,7
 	li $a1,5
 	li $a0,5 #color
 
showBGPixel:
 	jal show
 	nop
 
 	addi $s1,$s1,1
 	bne $s1,$s3,showBGLoop2
 	nop
 
 	addi $s0,$s0,1
 	bne $s0,$s2,showBGLoop1
 	nop
 
showBGEnd:
 	subu $sp,$sp,4
 	lw $gp,($sp)
 	jr $gp
 	nop


# a0:r, a1:g a2:b  v0:x v1:y
show:	
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
	lui $a2,0x0007
	sw $a3,($a2)
	jr $ra
	nop
exit:
	lui $t0,0x0008
	li $t1,255
	sw $t1,($t0)
	nop
