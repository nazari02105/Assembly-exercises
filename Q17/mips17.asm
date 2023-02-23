.text
main:
addi $s0,$zero,0 #start
addi $s1,$zero,0 #end
addi $s2,$zero,0 #min
addi $s3,$zero,10 #max
addi $s4,$zero,0 #size
la $s7,TheQu #address
loop:
# print messages
li $v0,4 # syscall for print string
la $a0,I # load string address
syscall
li $v0,4 # syscall for print string
la $a0,D # load string address
syscall
li $v0,4 # syscall for print string
la $a0,P # load string address
syscall
li $v0,4 # syscall for print string
la $a0,Exit # load string address
syscall
li $v0,4 # syscall for print string
la $a0,Choice # load string address
syscall
# get user input
li $v0, 12 # syscall for get user input
syscall
move $t0,$v0 # move user input to t0
bne $t0,'I',IPrime # if it is not I jump to IPrime
bne $s4,$s3,yes # check if queue is full or not yes means yes it is full and no means no it is not full
li $v0,4 # syscall for print string
la $a0,Full # load string address
syscall
j continue # jump to continue
yes:	
# get user number 
li $v0,4 # syscall for print string
la $a0,Input # load string address
syscall	
li $v0, 5 # syscall to read integer
syscall
move $a1,$v0 # move use input to a1
jal insert # call insert function
j continue # jump to continiue
IPrime:
bne $t0,'D',DPrime
bne $s4,$zero,no # if qu is empty so we should print the error string
li $v0,4 # syscall for print string
la $a0,Empty # load string address
syscall
j continue # jump to continiues
no:
jal delete # call delete function
j continue # jump to continiue
DPrime:
bne $t0,'P',PPrime
jal print # call print function
j continue # jump to continiue
PPrime:
bne $t0,'X',XPrime
j theMainExit # exit loop
j continue # jump to continiue
XPrime:
li $v0,4 # syscall for print string
la $a0,Invalid # valid message error
syscall
continue:	
j loop #jump to loop
theMainExit:
li $v0,10 # syscall for end of program
syscall	
print:
addi $t3,$zero,0 #counter of loop
addi $t4,$s1,0 # t4 = s1
LPrint:
beq $t3,$s4,endOfLoop
addi $t2,$zero,4 # t2 = 4
mul $t2,$t2,$t4 # pointer to last element of queue
add $t2,$t2,$s7 # t2 is s1 element of our qu
# formatting result:
li $v0,4 #syscall for printing 
la $a0,BackSlashN # load address of string
syscall
lw $a0,0($t2) #a0 is s1 member of our qu
li $v0,1 # syscall to print integer
syscall
addi $t4,$t4,-1 # t4 = t4 - 1
addi $t3,$t3,1	 # t3 = t3 + 1
j LPrint
endOfLoop:
# formatting result:
li $v0,4 #syscall for printing 
la $a0,BackSlashN # load address of string
syscall
jr $ra # return 
delete:
addi $t2,$zero,4 # t2 = 4
mul $t2,$t2,$s1 # pointer to last element of queue
add $t2,$t2,$s7 # t2 is s1 element of our qu
#printing
li $v0,4 #syscall for printing 
la $a0,BackSlashN # load address of string
syscall
# print removed number
lw $a0,0($t2) # load word of deleted word
li $v0,1 # syscall to print integer
syscall
li $v0,4 #syscall for printing 
la $a0,BackSlashN # load address of string
syscall
sw $s0,0($t2) # s1'th member of qu is equal to s0
addi $s1,$s1,-1 # s1 = s1 -1
addi $s4,$s4,-1 # size = size - 1
jr $ra # return
insert:
bne $s4,$zero,hasNum
addi $t2,$zero,4
mul $t2,$t2,$s1 # pointer to last element of queue
add $t2,$t2,$s7 # t2 is s1'th element of our qu
sw  $a1,0($t2) # store in queue
addi $s4,$s4,1 # size  = size + 1
j endInsertion
hasNum:
addi $t9,$zero,0 #counter of loop
addi $t4,$s1,0
right:
beq $t9,$s4,endRight
addi $t2,$zero,4
mul $t2,$t2,$t4 # pointer to last element of queue
add $t2,$t2,$s7 # t2 is s1'th element of qu
lw $t3,0($t2) # t3 is s1'th element of our qu
sw $t3,4($t2) # the s1+1'th element of our qu is t3
addi $t4,$t4,-1
addi $t9,$t9,1	
j right
endRight:
addi $s4,$s4,1 # size = size + 1
addi $s1,$s1,1 # s1 = s1 + 1
sw $a1,0($s7) # last element of qu is equal to user input
endInsertion:
jr $ra		
.data
I: .asciiz "I: Insert a new number in the queue\n"
D: .asciiz "D: Delete a number from the queue\n"
P: .asciiz "P: Print all numbers of the queue\n"
Exit: .asciiz "X: Exit\n"
Choice: .asciiz "Please enter your choice:\n"
Input: .asciiz  "\nput your number: \n"
Invalid: .asciiz "we don't have this here\n"
BackSlashN: .asciiz "\n"
Full: .asciiz "\nqueue is full\n"
Empty: .asciiz "\nqueue is empty\n"
TheQu: .word 0,0,0,0,0,0,0,0,0,0
UserInput: .space 1