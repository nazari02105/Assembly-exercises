.text
	# (99102401)16 == (2567971841)10 == (10011001000100000010010000000001)2
	# second 16 bit == (1001100100010000)2 = (-26352)10 so I load it in a register
	addi $s0, $zero, -26352
	sll $s0, $s0, 16 # left shift this 16 bit
	# first 16 bit == (0010010000000001)2 = (9217)10 so I add it to main number
	ori $s0, $s0, 9217
	addi $v0, $zero, 1 # for printing
	# every four bit of binary == every bit of hex
	addi $s4, $zero, 28 # to start first four byte
	Loop:
	
	slt $s5, $s4, $zero # to check if s4 which is at first 28 is less than 0 or not
	bne $s5, $zero, Exit # if s4 is less than 0 we should break the loop
	srlv $a0, $s0, $s4 # to shift s0 to right (s4) bytes
	andi $a0, $a0, 15 # 15 == 1111 in binary so we get first 4 bit
	syscall # to print the result
	addi $s4, $s4, -4 # to decrease amount of shift four every 4 bit
	
	j Loop
	
	
	Exit:
