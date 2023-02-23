.text
#these two lines are just examples
addi $a0, $zero, 78 # a0 = 78
addi $a1, $zero, 91 # a1 = 91
#here I just called the function
jal leaf_example
#then I put result in s0
add $s0, $v0, $zero
#and here after function I just print the result
addi $v0, $zero, 1
add $a0, $s0, $zero
syscall
#and here I finish the program
j Exit

leaf_example:
	add $t0, $a1, $zero # t0 = $a1
	sub $t0, $t0, $a0 # t0 = t0 - a0 = a1 - a0 = argumant1 - argument0
	srl $t1, $t0, 31 # then I shift (a1-a0), 31 bit to right to have only last bit of t0 in t1
	addi $t1, $t1, -1 # t1 -= 1
	and $t2, $t1, $a0 # t2 = t1 & a0
	nor $t1, $t1, $t1 # t1 = ~t1 = t1 nor t1
	and $t3, $t1, $a1 # t3 = t1 & a1
	add $v0, $t2, $t3 # v0 = t2 + t3
	
	jr $ra
	
Exit:
