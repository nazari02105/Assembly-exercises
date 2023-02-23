.data

addi $s0, $zero, 8932890 #forexample it is address of our array
addi $s1, $zero, 100 #forexample it is size of our array

add $a0, $s0, $zero # we put start of array to a0
add $a1, $s1, $zero # we put size of array in a1
jal reverse # calling function
j exit

reverse:
add $t0, $a0, $zero #start of array
addi $t6, $zero, 4 # t6 = 4
mult $a1, $t6 
mflo $t6 # t6 = t6 * a1(size of array)
add $t1, $a0, $t6 #end of array 
Loop:
slt $t3, $t1, $t0 # if t1 < t0 or end of array < start of array then t3 = 1
bne $t3, $zero, Break # if t3 != 0 or t3 == 1 then we reversed array
lw $t4, 0($t0) # put first word to t4
lw $t5, 0($t1) # plut last word to t5
sw $t4, 0($t1) # put first word to end of the array
sw $t5, 0($t0) # put last word to first of the array
addi $t1, $t1, -4 # from end of array we move one word back
addi $t0, $t0, 4 # from start of array we move one word forward
j Loop

Break:
jr $ra

exit: