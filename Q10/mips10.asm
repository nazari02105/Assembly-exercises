#line 2 and 3 is for getting integer input
addi $v0, $zero, 5 #v0 = 5
syscall
add $s0, $v0, $zero # s0 = v0
add $s1, $zero, $zero #s1 = 0 and actually it is counter

Loop: 	slt $t0, $s1, $s0 #line 7 and 8 is for checking if counter is equal to N or not
	beq $t0, $zero, Next #if counter is equal to N so we need to go te next step
	addi $s1, $s1, 1 #s1 = s1 + 1 and here we increment our counter
	#line 11 and 12 is for getting input
	addi $v0, $zero, 5 #v0 = 5
	syscall
	#line 14 and 15 is for moving stack pointer and store the number is stack
	addi $sp,$sp,-4 #sp = sp - 4
	sw $v0, 0($sp)
	j Loop #we countinue loop

Next:	#because we should print number from begging to end, in line 19, 20, 21 I move back stack pointer to the first number
	addi $s1, $s1, -1 #s1 = s1 - 1
	sll $s1, $s1, 2 # s1 = s1 * 4
	add $sp, $sp, $s1 #sp = sp + s1
Print:	slti $t0, $s1, 0 #in line 22 and 23 I check if stack pointer is pointing to last number or not
	bne $t0, $zero, Exit
	
	#here I load word and print it
	lw $s2,0($sp)
	addi $v0, $zero, 1 # v0 = 1
	add $a0, $s2, $zero
	syscall
	
	#move stack pointer down
	addi $s1, $s1, -4 #s1 = s1 - 4
	addi $sp, $sp, -4 #sp = sp - 4
	j Print
	
	
	
Exit: