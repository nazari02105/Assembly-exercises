.text
mtc1 $zero, $f31 #f31 as zero for float



addi $v0, $zero, 5 # for syscall
syscall
add $s0, $v0, $zero #s0 is the number of numbers

mul $s1, $s0, 4 #number of bytes

addi $v0, $zero, 9 # for syscall
add $a0, $s1, $zero # for syscall
syscall




add $s7, $v0, $zero #s7 now is the begginig of our array
add $s6, $s7, $zero # s6 = s7 because I wnat to keep s7 fix and move s6 instead
mtc1 $zero, $f1 # will be sum of numbers
add $s1, $zero, $zero # our counter
Loop:
	beq $s1, $s0, Next # if the counter is equal to number of numbers then break the loop
	
	addi $v0, $zero, 6 # for syscall
	syscall

	add.s $f1, $f1, $f0 # add numbers to sum
	
	swc1 $f0, 0($s6) # for store word
	addi $s6, $s6, 4 # for moving pointer
	
	addi $s1, $s1, 1 # increment conter
	j Loop
	
	
Next:
	la $a0, average # for printing the sentence
	addi $v0, $zero, 4 # for syscall
	syscall
	
	mtc1 $s0, $f30 # for moving value of f30 to s0
	cvt.s.w $f30, $f30 # for moving value of f30 to s0
	div.s $f12, $f1, $f30 # for calculating average
	addi $v0, $zero, 2 # for syscall
	syscall
	add.s $f20, $f12, $f31 #I have average in f20
	
	
	
mtc1 $zero, $f19 #sum
add.s $f6, $f7, $f31 # f6 = f7
add $s1, $zero, $zero #counter = 0
Loop2:
	beq $s1, $s0, Next2 # if the counter is equal to number of numbers then break the loop

	lwc1 $f10, 0($s6) # load word from our main array
	addi $s6, $s6, 4 # move the pointer
	
	sub.s $f5, $f10, $f20 # each number minus average
	mul.s $f5, $f5, $f5 # square of line 67
	
	add.s $f19, $f19, $f5 # add result of line 68 to main sum
	
	addi $s1, $s1, 1 #increament counter
	j Loop2
	
	
Next2:
	la $a0, sqrtOfVariance # for printing the sentence
	addi $v0, $zero, 4 # for syscall
	syscall
	
	mtc1 $s0, $f30 # for moving f30 value to s0
	cvt.s.w $f30, $f30 # for moving f30 value to s0
	div.s $f12, $f19, $f30 # divide the sum by number of numbers
	add.s $f21, $f12, $f31 #I have sqrt of variance in f21
	sqrt.s $f21, $f21 # sqrt of f21
	add.s $f12, $f21, $f31 # for printing
	addi $v0, $zero, 2 # for syscall
	syscall
	
	
	
add $s6, $s7, $zero # s6 = beggining of the array
add $s1, $zero, $zero #counter
Loop3:
	beq $s1, $s0, Next3 # if the counter is equal to number of numbers then break the loop

	lwc1 $f10, 0($s6) # for loading word to array (our float number)
	
	
	sub.s $f5, $f10, $f20 # calculating (x - mean)/???????? ?????????
	div.s $f5, $f5, $f21 # calculating (x - mean)/???????? ?????????
	swc1 $f5, 0($s6) # for storing word in array
	
	
	addi $s6, $s6, 4 # move pointer
	
	addi $s1, $s1, 1 # increament counter
	j Loop3
	
	
Next3:
	

.data
average: .asciiz "the average is: "
sqrtOfVariance: .asciiz "\nthe sqrt of variance is: "