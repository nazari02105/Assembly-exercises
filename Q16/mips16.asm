.text
	la $a0, inputFileName # to store user input to inputFileName
	addi $a1, $zero, 128 # for syscall
	addi $v0, $zero, 8 # for syscall
	syscall
	add $s7, $a0, $zero  # put user input to s7
	
    	la $s0, inputFileName # to get address of inputFileName

	# for deleting \n from the end of input string
	inputLoop:
    		lb   $s1, 0($s0) # load byte of first character
    		beq  $s1, $zero, inputEnd # if it is zero it meands that we are at the end of file

    		addi $s0, $s0, 1 # increament counter
    		j inputLoop

	inputEnd:
		sb $zero, 0($s0) # store zero in last bit
		addi $s0, $s0, -1
		sb $zero, 0($s0) # store zero in one before last bit
		
			
	
	
	la $a0, outputFileName # to store user input to outputFileName
	addi $a1, $zero, 128 # for syscall
	addi $v0, $zero, 8 # for syscall
	syscall
	add $s6, $a0, $zero # put user input to s6
	
    	la $s0, outputFileName # to get address of outputFileName
	
	# for deleting \n from the end of input string
	outputLoop:
    		lb   $s1, 0($s0) # load byte of first character
    		beq  $s1, $zero, outputEnd # if it is zero it meands that we are at the end of file

    		addi $s0, $s0, 1 # increament counter
    		j outputLoop

	outputEnd:
		sb $zero, 0($s0) # store zero in last bit
		addi $s0, $s0, -1
		sb $zero, 0($s0) # store zero in one before last bit



	
	li $v0,13           	# open_file syscall code = 13
    	la $a0, inputFileName     	# get the file name
    	li $a1,0           	# file flag = read (0)
    	syscall
    	move $t0,$v0        	# save the file descriptor. $t0 = file
    	
    	slt $s7, $t0, $zero # if file descriptor is under zero it means that this file does not exists
    	bne $s7, $zero, doesNotExists # so we jump to the end of script and print that your file does not exists
	
	#read the file
	li $v0, 14		# read_file syscall code = 14
	move $a0, $t0		# file descriptor
	la $a1, fileWords  	# The buffer that holds the string of the WHOLE file
	la $a2, 2048		# hardcoded buffer length
	syscall
	
	#Close the file
    	li $v0, 16         		# close_file syscall code
    	move $a0,$t0      		# file descriptor to close
    	syscall
    	
    	
    	
    	
    	#getting length of string
    	la $s0, fileWords

	loop:
    		lb   $s1, 0($s0) # load first byte to s1
    		beq  $s1, $zero, end # if it is zero it means that we are at the end of file

    		addi $s0, $s0, 1 # increament the length
    		j loop

	end:

		la $s1, fileWords # load fileWords in s1
		sub $s3, $s0, $s1 #$t3 now contains the length of the string
    	
    	
    	
    	la $t9, toWrite # load toWrite to t9
    	la $t8, fileWords # load fileWords to t8
    	addi $s5, $zero, 0 # s5 = 0
    	addi $s7, $zero, 0 # s7 = 0
    	
    	loop2:
    	beq $s5, $s3, next # if s5 is equal to s3 it means that we are at the end of string
    	
    	lb $s4, 0($t8) # load first byte to s4
    	beq $s4, 'a', increament # if this character is 'a' we should delete it
    	beq $s4, 'e', increament # if this character is 'e' we should delete it
    	beq $s4, 'i', increament # if this character is 'i' we should delete it
    	beq $s4, 'o', increament # if this character is 'o' we should delete it
    	beq $s4, 'u', increament # if this character is 'u' we should delete it
    	
    	lb $s4, 0($t8) # load first byte of input file content to s4
    	sb $s4, 0($t9) # store it to end of output content
    	addi $t9, $t9, 1 # move pointer
    	j continue
    	
    	increament:
    	addi $s7, $s7, 1 # increament s7
    	
    	continue:
    	addi $t8, $t8, 1 # move pointer
    	addi $s5, $s5, 1 # move pointer
    	j loop2
    	
    	
    	
    	
    	
    	next:
    	
    	
    	#open file 
    	li $v0,13           	# open_file syscall code = 13
    	la $a0,outputFileName     	# get the file name
    	li $a1,1           	# file flag = write (1)
    	syscall
    	move $t1,$v0        	# save the file descriptor. $s0 = file
    	
    	#Write the file
    	li $v0,15		# write_file syscall code = 15
    	move $a0,$t1		# file descriptor
    	la $a1,toWrite		# the string that will be written
    	addi $a2, $s3, 0		# length of the toWrite string
    	syscall
    	
	#MUST CLOSE FILE IN ORDER TO UPDATE THE FILE
    	li $v0,16         		# close_file syscall code
    	move $a0,$t1      		# file descriptor to close
    	syscall
    	
    	la $a0, numberOfDeletedChar # for printing
	addi $v0, $zero, 4 # for syscall
	syscall
	
	add $a0, $s7, $zero # for printing number of deleted chars
	addi $v0, $zero, 1 # for syscall
	syscall
    	
    	j mainEnd



	doesNotExists:
	la $a0, notExists # for printing does not exists statement
	addi $v0, $zero, 4 # for syscall
	syscall
	
	
	mainEnd:
	
	
	
.data
toWrite: .space 2048
inputFileName: .space 128
outputFileName: .space 128
fileWords: .space 2048
notExists: .asciiz "input file does not exists"
numberOfDeletedChar: .asciiz "number of deleted characters: "
