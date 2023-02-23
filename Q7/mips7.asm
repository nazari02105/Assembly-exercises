.text
addi $s0, $zero, 35 #this is the main number
addi $s1, $zero, 0 #this is counter or the answer
Loop: 	slti $t0, $s0, 2 #if s0 < 2 then t0 = 1
	bne $t0, $zero, Exit #if t0 != 0 then the answer is ready and we can print it
	addi $s1, $s1, 1 #if t0 == 0 then we add 1 to our counter or answer
	srl $s0, $s0, 1 #and we shift s0 one to right
	j Loop #and we do this until s0 >= 2

Exit:	#then I print them
	addi $v0, $zero, 1
	add $a0, $s1, $zero
	syscall