.data
gamestatus: .word 0
block1: .word 100,100,40,20,13,10,5
block2: .word 150,150 50,25,12,3,14

sp:

.text
main:
	la $sp,sp
	
	lui $t0,0x0008
	li $t1,1
	sw $t1,($t0)
	
gameloop:

	#jal showBG
	#nop

	 la $t0,block1
	 jal showBlock
	 nop
	 
	 lui $t0,0x0008
	 li $t1,16
	 sw $t1,($t0)
	
	 la $t0,block2
	 jal showBlock
	 nop
	
	
	lui $t0,0x0008
	li $t1,8
	sw $t1,($t0)
	

	j gameloop
	nop
	
	jal exit
	nop
	

#v0:x v1:y a0:xlen a1:ylen
showBlock:

	sw $ra,($sp)
	addiu $sp,$sp,4
	
	 lw $v0,($t0)
	 lw $v1,4($t0)
	 lw $a0,8($t0)
	 lw $a1,12($t0)

showBlockLoopStart:
	
	add $s2,$a0,$v0 # x end
	add $s3,$a1,$v1 # y end
	
	move $s0,$v0 #x start
	move $t1,$v1 #x start


showBlockLoop1:
	move $s1,$t1
showBlockLoop2:
	

	move $v0,$s0
	move $v1,$s1
	
	 lw $a0,16($t0)
	 lw $a1,20($t0)
	 lw $a2,24($t0)
	
	
	jal show
	nop
	
	addi $s1,$s1,1
	bne $s1,$s3,showBlockLoop2
	nop
	
	addi $s0,$s0,1
	
	bne $s0,$s2,showBlockLoop1
	nop
showBlockLoopEnd:
	lui $t0,0x0008
	li $t1,4
	sw $t1,($t0)
	
	subu $sp,$sp,4
	lw $gp,($sp)
	jr $gp
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
 
 	bge $s1,$s4,showBGGround
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
	nop
