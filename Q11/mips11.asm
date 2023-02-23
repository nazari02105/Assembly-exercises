.text
#first I will get n from user
addi $v0, $zero, 5
syscall
add $s0, $v0, $zero #n
#then I will get x from user
addi $v0, $zero, 5
syscall
add $s1, $v0, $zero #x

#then I want to calculate 3x + 5 and x - 1 outside of the function
addi $s2, $zero, 3 # s2 = 3
mult $s1, $s2
mflo $s3 # s3 = 3x
addi $s3, $s3, 5 # s3 = 3x + 5
addi $s4, $s1, -1 # s4 = x - 1

#then I will pass arguments
add $a0, $s0, $zero # a0 = n
add $a1, $s1, $zero # a1 = x
add $a2, $s3, $zero # a2 = 3x + 5
add $a3, $s4, $zero # a3 = x - 1
#then I will call the function
jal recursive
#after function I will go to exit label and print the result
j exit


recursive:
#first I check n == 1
beq $a0, 1, one
#then I check n == 2
beq $a0, 2, two

# then I move stack pointer 8 bytes to store ra and n in stack
addi $sp, $sp, -8
sw $a0, 0($sp)
sw $ra, 4($sp)
# then I want to call F(n-1)
addi $a0, $a0, -1
jal recursive
#after that I restore main n to a0 and store result of F(n-1) in stack
lw $a0, 0($sp)
sw $v0, 0($sp)
#then I want to call F(n-1)
addi $a0, $a0, -2
jal recursive
#then I put (x-1)F(n-2) in $t0 and v0 in this place is result of F(n-2)
mul $t0, $a3, $v0
#then I load result of F(n-1) in $t1
lw $t1, 0($sp)
#then I move stack pointer 4 bytes
addi $sp, $sp, 4
# here v0 = F(n-1) + (x-1)F(n-2)
add $v0, $t0, $t1
#at last I load ra to $ra to return to caller function
lw $ra, 0($sp)
addi $sp, $sp, 4
j endOfFunction

one:
#in this case we should just return 2 as F(1) =  1
addi $v0, $zero, 2
j endOfFunction

two:
#in this case we should just return 3x + 5 which I calculate is before calling function and it is in $a2
add $v0, $zero, $a2
j endOfFunction

endOfFunction:
#and here at last we return to caller function
jr $ra


exit:
#here I just print the result of question
add $a0, $zero, $v0
addi $v0, $zero, 1
syscall