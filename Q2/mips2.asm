#Ali Nazari 99102401

.text
addi $s7, $zero, 1 # I have number 1 in s7 just for first few lines
checkFirst:
la $a0, string1
addi $v0, $zero, 4 # for syscall
syscall
addi $v0, $zero, 5 # for syscall
syscall
slt $s6, $v0, $s7 # check if input number is below one or not
beq $s6, $zero, ok1 # if it is not below 1 so we move forward
la $a0, string9 # else we print sentence
addi $v0, $zero, 4
syscall
j checkFirst # and jump to the begininigs
ok1:
add $s0, $v0, $zero
mul $a0, $s0, 4
addi $v0, $zero, 9
syscall
add $s2, $v0, $zero # s0 daraje chand jomlee aval ast va s2 addresse shoroe zarib haye an

checkSecond:
la $a0, string2
addi $v0, $zero, 4# for syscall
syscall
addi $v0, $zero, 5# for syscall
syscall
slt $s6, $v0, $s7# check if input number is below one or not
beq $s6, $zero, ok2# if it is not below 1 so we move forward
la $a0, string9# else we print sentence
addi $v0, $zero, 4
syscall
j checkSecond# and jump to the begininigs
ok2:
add $s1, $v0, $zero
mul $a0, $s1, 4
addi $v0, $zero, 9
syscall
add $s3, $v0, $zero # s1 daraje chand jomlee dovom ast va s3 addresse shoroe zarib haye an

la $a0, string3 
addi $v0, $zero, 4 #for syscall
syscall
add $s4, $zero, $zero # counter
add $s5, $s2, $zero # addresse shoroe zarib haye avali
loop1: # in this loop I get zarib haye moadele aval
beq $s4, $s0, exit1
addi $v0, $zero, 5
syscall
sw $v0, 0($s5)
addi $s5, $s5, 4
addi $s4, $s4, 1
j loop1
exit1:

la $a0, string4
addi $v0, $zero, 4 # for syscall
syscall
add $s4, $zero, $zero # counter
add $s5, $s3, $zero # addresse shoroe zarib haye dovomi
loop2: # in this loop I get zarib haye moadele dovom
beq $s4, $s1, exit2
addi $v0, $zero, 5
syscall
sw $v0, 0($s5)
addi $s5, $s5, 4
addi $s4, $s4, 1
j loop2
exit2:

add $a0, $s0, $zero # I put enteries to $a 
add $a1, $s1, $zero
add $a2, $s2, $zero
add $a3, $s3, $zero
jal function1 # call function
j finish # jump

function1:
add $t5, $a0, $a1 # t5 is sum of daraje avali + daraje dovomi
mul $t5, $t5, 4 # mul 4 to get its bytes
add $t9, $zero, $a0 # not to lose $a0
add $a0, $t5, $zero
addi $v0, $zero, 9 # for syscall
syscall
add $t5, $v0, $zero # t5 zarib har x ba daraje motafavet ast
add $a0, $t9, $zero # not to lose $a0

addi $t6, $zero, 0 # iteratore chand jomleyee aval
loop3:
beq $t6, $a0, exit3 # if we reached end of chand jomleyee aval, jump to exit3
addi $t7, $a3, 0 # t7 is begining of chand jomleyee dovom zaribs
addi $t8, $zero, 0 # iteratore chand jomleyee dovom
loop4:
beq $t8, $a1, exit4 # if we reached end of chand jomleyee dovom, jump to exit3
lw $t0, 0($t7) # load word of chand jomleyee dovom
lw $t1, 0($a2) # load word of chand jomleyee aval
# putting every thing in stack t0-t9 a0-a3 ra
addi $sp, $sp, -60
sw $t0, 0($sp)
addi $sp, $sp, 4
sw $t1, 0($sp)
addi $sp, $sp, 4
sw $t2, 0($sp)
addi $sp, $sp, 4
sw $t3, 0($sp)
addi $sp, $sp, 4
sw $t4, 0($sp)
addi $sp, $sp, 4
sw $t5, 0($sp)
addi $sp, $sp, 4
sw $t6, 0($sp)
addi $sp, $sp, 4
sw $t7, 0($sp)
addi $sp, $sp, 4
sw $t8, 0($sp)
addi $sp, $sp, 4
sw $t9, 0($sp)
addi $sp, $sp, 4
sw $a0, 0($sp)
addi $sp, $sp, 4
sw $a1, 0($sp)
addi $sp, $sp, 4
sw $a2, 0($sp)
addi $sp, $sp, 4
sw $a3, 0($sp)
addi $sp, $sp, 4
sw $ra, 0($sp)
addi $sp, $sp, 4

# calling function 2 for checking mult overflow
add $a0, $t0, $zero # input1
add $a1, $t1, $zero # input2
jal function2

# get every thing back from stack
addi $sp, $sp, -60
lw $t0, 0($sp)
addi $sp, $sp, 4
lw $t1, 0($sp)
addi $sp, $sp, 4
lw $t2, 0($sp)
addi $sp, $sp, 4
lw $t3, 0($sp)
addi $sp, $sp, 4
lw $t4, 0($sp)
addi $sp, $sp, 4
lw $t5, 0($sp)
addi $sp, $sp, 4
lw $t6, 0($sp)
addi $sp, $sp, 4
lw $t7, 0($sp)
addi $sp, $sp, 4
lw $t8, 0($sp)
addi $sp, $sp, 4
lw $t9, 0($sp)
addi $sp, $sp, 4
lw $a0, 0($sp)
addi $sp, $sp, 4
lw $a1, 0($sp)
addi $sp, $sp, 4
lw $a2, 0($sp)
addi $sp, $sp, 4
lw $a3, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4

bne $v0, -1, dorost # if v0 is equal to -1 maybe it is incorrect
# I said maybe because maybe our zaribs are 1 and -1 and in this case v0 is eather -1 but it is not overflow
mflo $s7 # I get lo register to check up line case
beq $s7, -1, dorost # if line 171 condition is true it means we dont have overflow so we jump to dorost label again
addi $t3, $zero, -1 # else we put -1 to v0
j exit5 # jump

dorost:
add $t2, $v0, $zero # we put mult answer to t2
#
add $t3, $t6, $t8 # sum of iterator chand jomleyee aval and iterator chand jomleyee dovom
addi $t3, $t3, 1 # I increament it because I want tavan not index in array
mul $t3, $t3, 4 # I mult $t3 and 4 to get its byte
add $t5, $t5, $t3 # inja pointer zaribhaye chand jomleyee dovom ra harkat midaham ta be an tavan beresam
lw $t4, 0($t5) # I load line 184 stuff in t4
add $t4, $t4, $t2 # I add new amount to that
sw $t4, 0($t5) # I put it back to array
sub $t5, $t5, $t3 # I moved line 183 pointer, back to its first word
addi $t8, $t8, 1 # I move iterator araye zarib haye chand jomleyee dovom
addi $t7, $t7, 4 # I move pointere araye zarib haye chand jomleyee dovom
j loop4 # jump to loop4
exit4:
addi $t6, $t6, 1 # I move iterator araye zarib haye chand jomleyee aval
addi $a2, $a2, 4 # I move pointere araye zarib haye chand jomleyee aval
j loop3 # jump to loop3
exit3:
add $t0, $a0, $a1 # t0 is sum of daraje avali + daraje dovomi
add $t3, $t0, $zero # t3 is sum of daraje avali + daraje dovomi
addi $t0, $t0, -1 # t0 is sum of daraje avali + daraje dovomi - 1
mul $t0, $t0, 4 # I want to get last word of result array to pass it to v0
# dar vaghee in haman daraje chand jomleyee hasel ast ke dar v0 bayad begozarim
# dar zemn man in mozoee ke zarib X ba balatarin daraje ra 0 begozarad inja handle karde am
add $t1, $t5, $t0 # I put pointer of result array to last word and put the address in t1
lw $t2, 0($t1) # load its word
loop5:
bne $t2, $zero, exit5 # if it is not zero it means it is our result to put in v0 so we break the loop
addi $t1, $t1, -4 # move pointer back
addi $t3, $t3, -1 # move counter back
lw $t2, 0($t1) # load previous word to t2
j loop5 # jump
exit5:
add $v0, $t3, $zero # answer of function
add $v1, $t5, $zero # and this is result array
jr $ra # finish function


function2:
add $t0, $a0, $zero
add $t1, $a1, $zero
mult $t0, $t1 # mult t0 and t1
mfhi $t3
mflo $t4
beq $t3, $zero, jump1 # if mfhi is zero it means we have no overflow
beq $t3, -1, jump1 # or if it is -1 it means one of t0 or t1 is negative and we dont have overflow again
j jump2 # else we have overflow
jump1:
add $v0, $t4, $zero # I put result in v0 to give it back to prevous function
j nextStatement
jump2:
addi $v0, $zero, -1 # and when we have overflow, I put -1 to v0
nextStatement:
jr $ra



finish:
add $t9, $s0, $s1 #sum of daraje avali + daraje dovomi
beq $v0, -1, problem # if v0 is -1 it means we have problem so we print its sentence
add $s0, $v0, $zero # I put result in s0
la $a0, string5 # print string 5 statement
addi $v0, $zero, 4
syscall
addi $v0, $zero, 1
add $a0, $s0, $zero # print a0 which is daraje chand jomleyee hasel
syscall
la $a0, string7 # print string 7 statement
addi $v0, $zero, 4
syscall
addi $v0, $zero, 1 # print result
add $a0, $t9, $zero
syscall
la $a0, string8 # print string 8 statement
addi $v0, $zero, 4
syscall
add $s7, $t9, $zero #sum of daraje avali + daraje dovomi
add $s6, $zero, $zero #s6 = 0
loop10: # this loop is for printing zarib har X az X, X^2, X^3, X^4, ..., X^n
beq $s6, $s7, exit10 # if we reach to the end we break the loop
lw $s5, 0($v1) # load word
addi $v0, $zero, 1 #print it
add $a0, $s5, $zero
syscall
addi $v1, $v1, 4 # move pointer of array
la $a0, spaceX #pring space
addi $v0, $zero, 4
syscall
addi $s6, $s6, 1 # increament counter
j loop10 # jump
exit10:
j mainFinish # jump
problem:
la $a0, string6 # for printing 'an error aquered'
addi $v0, $zero, 4
syscall # for printint
mainFinish:


.data
string1: .asciiz "daraje chand jomlee aval ra vared konid\n"
string2: .asciiz "daraje chand jomlee dovom ra vared konid\n"
string3: .asciiz "zarib haye chand jomlee aval ra vared konid\n"
string4: .asciiz "zarib haye chand jomlee dovom ra vared konid\n"
string5: .asciiz "chand jomleyee daraje : "
string6: .asciiz "a problem aqured "
string7: .asciiz "\nzarib x ta x^"
string8: .asciiz " be tartib "
string9: .asciiz "no negative\n"
spaceX: .asciiz " "
