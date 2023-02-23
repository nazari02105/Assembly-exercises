.text
addi $t1, $zero, 10 #t1 = 10
addi $t2, $zero, 3 #t2 = 3

#3*10 = 3*8 + 3*2 and 8 = 2^3 and 2 = 2^1
sll $t3, $t2, 3 #t3 = 3*8
sll $t4, $t2, 1 #t4 = 3*2

add $t5, $t1, $t3 #t5 = t1 + t3
add $t5, $t5, $t4 #t5 = t5 + t4

#then I print them
addi $v0, $zero, 1
add $a0, $t5, $zero
syscall