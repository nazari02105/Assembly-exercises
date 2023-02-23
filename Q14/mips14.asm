.text

addi $s0, $zero, 10 # this is a for example
addi $s1, $zero, 12 # this is b for axample
addi $s5, $zero, -1 # this is result ( 0 == false && 1 == true)

la $a0, String # I get an 12 bit space to get input from user
addi $a1, $zero, 10 # for syscall
addi $v0, $zero, 8 #  for syscall
syscall

lb $s2, 0($a0) # first character is in s2
lb $s3, 1($a0) # second character is in s3
lb $s4, 2($a0) # third character is in s4

beq $s2, 'a', LeftOneIsA # I check if s2 == 'a' then I jump to leftOneIsA label
j LeftOneIsB # else I jump to leftOneIsB label



LeftOneIsA:
beq $s3, '>', AGreaterThanB # if s3 == '>' I jump to AGreaterThanB label
beq $s3, '=', AEqualToB # if s3 == '=' I jump to AEqualToB label
beq $s3, '<', ASmallerThanB # if s3 == '<' I jump to ASmallerThanB label

LeftOneIsB:
beq $s3, '>', ASmallerThanB # if s3 == '>' I jump to ASmallerThanB label
beq $s3, '=', AEqualToB # if s3 == '=' I jump to AEqualToB label
beq $s3, '<', AGreaterThanB # if s3 == '<' I jump to AGreaterThanB label

ASmallerThanB:
slt $s6, $s0, $s1 # if s0 < s1 then s6 = 1
bne $s6, $zero, TheTrue # if s6 != 0 then jump to TheTrue
j TheFalse # else jump to TheFalse
AEqualToB:
beq $s0, $s1, TheTrue # if s0 == s1 then jump to TheTrue
j TheFalse #else jump to TheFalse
AGreaterThanB:
slt $s6, $s1, $s0 # if s1 < s0  then s6 = 1
bne $s6, $zero, TheTrue # if s6 != 0 then jump to TheTrue
beq $s0, $s1, TheFalse # if s0 == s1 then jump to TheFalse
j TheFalse # else jump to TheFalse

TheTrue:
la $a0, True # load true string
addi $v0, $zero, 4 # for syscall
syscall
j Exit # jump to Exit
TheFalse:
la $a0, False # load false string
addi $v0, $zero, 4 # for syscall
syscall
j Exit # jump to Exit

Exit:


.data

String: .space 12
True: .asciiz "true"
False: .asciiz "false"
