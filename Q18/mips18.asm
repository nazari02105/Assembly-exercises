.text

leaf_example:
first_step:
  addi $t0, $zero, 0 # static int a = 0
  addi $t9, $zero, 2 # t9 = 2
  div $t0, $t9
  mfhi $t8 # this is a % 2
  beq $t8, $zero, add_part # if the false part execute
  # now we should calculate this a += a / 2
  div $t2, $t0, $t9 # t2 = a / 2
  add $t0, $t0, $t2 # a += a / 2
  j last_step
add_part:
  addi $t0, $t0, 3 # a += 3
last_step:
  la $t1, first_step # this is address of first_step
  lw $t1, 0($t1) # we wnat just first 32 bit or 4 byte which is first statement
  # clean first 16 bit
  andi $t1, $t1, 65535 # this is 16 ta 0 16 ta 1
  
  add $t7, $zero, $zero
  loop:
  	beq $t7, 16, break_loop
  	sll $t1, $t1, 1
  	addi $t7, $t7, 1
  	j loop
  	
  break_loop:
  # after loop t1 is 16 ta 1 16 ta 0
  
  or $t1, $t1, $t0 # replace statement
  # and at last, self modify the function
  la $t2, first_step
  sw $t1, 0($t2)
  jr $ra
