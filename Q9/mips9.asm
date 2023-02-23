.text
#this line is just an example
addi $s0, $zero, 8
add $a0, $zero, $s0 # here I just put input to a0 as argument
# in number function I calculate number of array members to allocate right number of bytes
jal number
j Next





number:
add $t4, $zero, $a0 # t4 = a0 actually this is fix during the funtion
add $t0, $zero, $a0 # t0 = a0 but I decreament this every step
add $t1, $zero, $zero # t1 = 0 and this is counter
Loop:
slti $t2, $t0, 1 # if (t0 < 1) then t2 = 1 else t2 = 0
bne $t2, $zero, Exit # if t2 != 0 (t2 == 1) then we should finish the loop

addi $t3, $zero, 2 # t3 = 2
div $t0, $t3 # here I check if t0 is even or not
mfhi $t3 # this is the remaining of t0/t3
bne $t3, 0, NotZero # if the number is odd then I jump to NotZero label

addi $t3, $zero, 2 #t3 = 2
div $t4, $t0 # here I check if t4 % t0 == 0 or not
mfhi $t3 # t3 is remaining of t4/t0
bne $t3, 0, NotZero # if t3 != 0 then I jump to NotZero label

addi $t1, $t1, 1 # here I increament the counter
NotZero:
addi $t0, $t0, -1 # and here I decreament t0 while t0 > 0
j Loop
Exit:
add $v0, $zero, $t1 # I put result in v0
jr $ra





Next:
add $s1, $v0, $zero # I put result of number function in s1
addi $s2, $zero, 4 # s2 = 4
mult $s1, $s2 # I multiply result of number funtion to 4 to get number of bytes
mflo $s2

# in lines 50 to 52 I allocated $s2 bytes from heap memory
addi $v0, $zero, 9
add $a0, $zero, $s2
syscall

add $a1, $s0, $zero #a1 = s0
addi $a0, $v0, 0 #a0 = v0 = start of array
jal Put # in put function I put the questions answer in array
j MainEnd

Put:
add $t4, $zero, $a1 # t4 = a0 actually this is fix during the funtion
add $t0, $zero, $a1 # t0 = a0 but I decreament this every step
Loop2:
slti $t2, $t0, 1 # if (t0 < 1) then t2 = 1 else t2 = 0
bne $t2, $zero, Exit2 # if t2 != 0 (t2 == 1) then we should finish the loop

addi $t3, $zero, 2 # t3 = 2
div $t0, $t3 # here I check if t4 % t0 == 0 or not
mfhi $t3 # this is the remaining of t0/t3
bne $t3, 0, NotZero2 # if the number is odd then I jump to NotZero label

addi $t3, $zero, 2
div $t4, $t0 # here I check if t4 % t0 == 0 or not
mfhi $t3 # t3 is remaining of t4/t0
bne $t3, 0, NotZero2 # if t3 != 0 then I jump to NotZero label

sw $t0, 0($a0) # and here I store number in array
addi $a0, $a0, 4 # and here I move pointer to next word

NotZero2:
addi $t0, $t0, -1 # and here I decreament t0 while t0 > 0
j Loop2
Exit2:
jr $ra


MainEnd:
