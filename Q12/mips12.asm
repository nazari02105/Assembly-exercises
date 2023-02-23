.text

addi $s0, $zero, 5 #this is an example
add $a0, $zero, $s0 #here I put example as argument for function
jal number #and here I call function
j Next


number:
add $t4, $zero, $a0 # t4 = a0 actually this is fix during the funtion
add $t0, $zero, $a0 # t0 = a0 but I decreament this every step
add $t1, $zero, $zero #first counter t1 = 0
add $t5, $zero, $zero #second counter t5 = 0
Loop:
slti $t2, $t0, 1 # if (t0 < 1) then t2 = 1 else t2 = 0
bne $t2, $zero, Exit # if t2 != 0 (t2 == 1) then we should finish the loop

div $t4, $t0 # here I check if t4 % t0 == 0 or not
mfhi $t3 # t3 is remaining of t4/t0
bne $t3, 0, NotZero # if t3 != 0 then I jump to NotZero label

addi $t1, $t1, 1 #here I increament the first counter

addi $t6, $t4, 1 #here I calculate N+1
addi $t7, $t0, 1 #hre I calculate di+1
div $t6, $t7 #and here I calculate t6 % t7 or N+1 % di+1
mfhi $t3 #and this is the remaining
bne $t3, 0, NotZero #if the remaining is not zero so we should not increament the second counter
addi $t5, $t5, 1 #else we should increament the second counter

NotZero:
addi $t0, $t0, -1 # and here I decreament t0 while t0 > 0
j Loop
Exit:
add $v0, $zero, $t1 # and here I put first counter to v0 as return value
add $v1, $zero, $t5 # and here I put second counter to v1 as return value
jr $ra


Next:
add $s0, $v0, $zero # s0 = v0
add $s1, $v1, $zero #s1 = v1

bne $s0, $s1, NotEqual #if s0 != s1 so we should print "adad dovvom nist :("
la $a0, str2 #load address str2 to a0
addi $v0, $0, 4 # syscall to print string
syscall #print
j mainExit

NotEqual:
la $a0, str1 #load aaddress str1 to a0
addi $v0, $0, 4 #syscall to print string
syscall #print

mainExit:




.data
     str1: .asciiz    "adad dovvom nist :("
     str2: .asciiz    "adad dovvom hast :)"
