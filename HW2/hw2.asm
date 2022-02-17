.data 
buffer: .space 256
file: .asciiz "D:input.txt"

.text
main:
	jal openReadFromFile
	
	la $a0, buffer
	jal alterString
	li $v0, 10      # Finish the Program
	syscall
	
alterString:
	la $s0, ($a0) # Set temporary register to first string adress

	# Save caller return ad
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $s1, $zero, 0 # loop counter variable i
	stringIterator:
		add $t1, $s0, $s1 # index of char in string
		lb $t2, ($t1)
		beqz $t2, endIterator # String end condition
		
		# Check if number
		li $t3, '0'
		blt $t2, $t3, print
		li $t3, '9'
		bgt $t2, $t3, print
		
	

		
		
	print:	add $a0, $zero, $t2 # Set Argument 0 character value for syscall
		jal printChar
		
	next:	addi $s1, $s1, 1 # loop counter increment
		j stringIterator
	endIterator:
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
printChar:
	li $v0, 11
	syscall
	jr $ra
	
openReadFromFile:
 	li   $v0, 13          # system call for open file
	la   $a0, file      # input file name
	li   $a1, 0           # flag for reading
	syscall               # open a file 
	move $s0, $v0
	
	li   $v0, 14 # Read File Operator

	# Function arguments
	move $a0, $s0
	la   $a1, buffer
	li   $a2,  256
	syscall
	
	jr $ra
