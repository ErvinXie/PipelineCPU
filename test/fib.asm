.data 
	array: .word 0:10

.text
main:
	li $t1,1
	li $t2,1
	li  $t4,0
	li $t5, 10
	la  $t6,array
loop:
	add		$t0, $t1, $t2		# $t0 = $t1 + $t2
	move 	$t2, $t1		# $t2 = $t1
	move 	$t1, $t0		# $t1 = $01
	sw		$t1, 0($t6)		
	addiu   $t4,$t4,1
	addiu   $t6,$t6,4
	beq		$t4, $t5, exit	# if $t4 == 5t1 then target
	nop
	j		loop				# jump to loop
	nop
exit:
	lui $s0,8
	sw  $t0,($s0)

