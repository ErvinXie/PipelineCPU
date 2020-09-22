.text	
main:
	li $t1,4
	li $t2,1
	jal	add
	nop
	j exit


add: 
	add $t0,$t1,$t2
	jr	$ra
	nop
	
exit:
	nop