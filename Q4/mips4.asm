.text
#line 2 is just for test and is equal to 01010 "1100" 23ta0
#addi $s1, $zero, 1442840577
#line 4 is for test too and is equal to 010101010101 "0011" 16ta0
#addi $s0, $zero, 1431502848

andi $s2, $s0, 983040 #and s0 with 12ta0 "1111" 16ta0 for discarding bit 17 to 20
sll $s2, $s2, 7 #then I shift the result of line 6, 7 bit to left to move bit 17 to 20, to bit 23 to 27
andi $s1, $s1, 4169138175 #then I and s1 with 5ta1 "0000" 22ta1 to remove bit 23 to 27
or $s1, $s1, $s2 #then I or s1 and s2 which s2 is result of line 7 to put bit 17 to 20 of s0, to bit 23 to 27 of s1

#line 12 until 14 is for test to see the result which with data in line 2 and 4, the result is 01010 "0011" 23ta0 which is true
#addi $v0, $zero, 1
#add $a0, $s1, $zero
#syscall