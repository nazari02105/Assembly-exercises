# Ali Nazari 99102401

.text
add $s7, $zero, $zero # this is our sum

firstLoop:
addi $v0, $zero, 12
syscall # get character
add $s0, $v0, $zero # s0 = v0
beq $s0, 10, outerFirstLoop # when enter pushed we shoud finish program
la $s1, table # s1 = first address of table

secondLoop:
lw $s2, 0($s1) # this is first word of table
beq $s2, $s0, isInTable # if it is equal to s0 it means the character is in table
beq $s2, 0, isNotInTable # else we reached zero it means we dont have this character in table
j outerSecondLoop # jump

isInTable:
addi $s1, $s1, 4 # we move one word forward
lw $s2, 0($s1) # we get that word in s2
addi $s1, $s1, 4 # we move one word forward
add $s7, $s7, $s2 # we sum that with our main sum
j nextRound # jump

isNotInTable:
la $a0, string # we print the notice
addi $v0, $zero, 4 # for syscall
syscall
j nextRound # jump

outerSecondLoop:
addi $s1, $s1, 8 # we move table pointer two words
j secondLoop # jump

nextRound:
j firstLoop #jump

outerFirstLoop:
addi $v0, $zero, 1 # for syscall
add $a0, $zero, $s7 # for syscall
syscall
				
.data
table:	.word 32,0,1575,1,1576,2,1580,3,1583,4,1607,5,1608,6,1586,7,1581,8,1591,9,
		1740,10,1705,20,1604,30,1605,40,1606,50,1587,60,1593,70,1601,80,1589,90,
		1602,100,1585,200,1588,300,1578,400,1579,500,1582,600,1584,700,1590,800,1592,900
		1594,1000,1670,3,1711,20,1662,2,1648,7,0,0
	.align 2	# align on word boundary
string: .asciiz "enter a valid character\n"
