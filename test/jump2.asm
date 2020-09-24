.data
gamestatus: .word 0


sp:

.text
main:
	la $sp,sp
	
	
gameloop:
	
	
	jal showBG
	nop

	li $v0,0
	li $v1,0
	jal showDragon
	nop
	
	srl $v0,$fp,26
	addi $v0,$v0,100
	li $v1,20
	li $a0,50
	jal showBlock
	nop
	


showBG:
	sw $ra,($sp)
	addiu $sp,$sp,4

showBGLoopStart:
	li $s2,320 # xlen
	li $s3,240 # ylen
	srl $s4,$s3,1
	li $s0,0
showBGLoop1:
	li $s1,0
showBGLoop2:
	add $v0,$s0,$0
	add $v1,$s1,$0
	
	blt $s1,$s4,showBGGround
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
	
showBlockLoopEnd:
	subu $sp,$sp,4
	lw $gp,($sp)
	jr $gp
	nop

#v0:x v1:ylen a0:xlen
showBlock:
	sw $ra,($sp)
	addiu $sp,$sp,4

showBlockLoopStart:
	move $s2,$a0 # xlen
	move $s3,$v1 # ylen
	addi $t0,$v0,40 #x start
	li $t1,120 #y start
	sub $t1,$t1,$v1
	li $s0,0
showBlockLoop1:
	li $s1,0
showBlockLoop2:
	add $v0,$s0,$t0 #pixel x
	add $v1,$s1,$t1 #pixel y
	li $a0,15 #color
	
	jal show
	nop
	
	addi $s1,$s1,1
	bne $s1,$s3,showBlockLoop2
	nop
	
	addi $s0,$s0,1
	bne $s0,$s2,showBlockLoop1
	nop
showBGLoopEnd:
	subu $sp,$sp,4
	lw $gp,($sp)
	jr $gp
	nop

#v0:x v1:y
showDragon: 
	sw $ra,($sp)
	addiu $sp,$sp,4
	
	move $t0,$v0
	move $t1,$v1
	
	
showDragonLoopStart:
	
	li $s2,20
	li $s3,40
	li $s0,0
showDragonLoop1:
	li $s1,0
showDragonLoop2:
	add $v0,$s0,40
	add $v1,$s1,80
	li $a2,15
	jal show
	nop
	addi $s1,$s1,1
	bne $s1,$s3,showDragonLoop2
	nop
	addi $s0,$s0,1
	bne $s0,$s2,showDragonLoop1
	nop
showDragonLoopEnd:
	subu $sp,$sp,4
	lw $gp,($sp)
	jr $gp
	

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
	nop
